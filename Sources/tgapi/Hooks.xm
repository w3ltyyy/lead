#import "Headers.h"
#include <zlib.h>

// Forward declaration — defined later in this file, used inside hooked_block
static NSData *neutralizePayload(NSData *data, BOOL antiRevoke, BOOL antiEdit, BOOL saveRestricted);

#define kChannelsReadHistory -871347913

%hook MTRequest
%property (nonatomic, strong) NSData *fakeData;
%property (nonatomic, strong) NSNumber *functionID;

- (void)setPayload:(NSData *)payload metadata:(id)metadata shortMetadata:(id)shortMetadata responseParser:(id (^)(NSData *))responseParser {
	
	// Extract Function id 
	int32_t functionID;
	[payload getBytes:&functionID length:4];
	self.functionID = [NSNumber numberWithInt:functionID];
	
	id(^hooked_block)(NSData *) = ^(NSData *inputData) {
		NSNumber *functionIDNumber = [NSNumber numberWithUnsignedInt:functionID];
		NSData *parsed = [TLParser handleResponse:inputData functionID:functionIDNumber];
		NSData *toUse = parsed ?: inputData;

		// Strip noforwards from request responses (messages.getHistory, etc.)
		// so the save/forward button appears for newly fetched restricted messages.
		if ([[NSUserDefaults standardUserDefaults] boolForKey:kDisableForwardRestriction]) {
			NSData *cleared = neutralizePayload(toUse, NO, NO, YES);
			if (cleared) toUse = cleared;
		}

		return responseParser(toUse);
	};
	
	switch (functionID) {
		case kAccountUpdateOnlineStatus:
		   handleOnlineStatus(self, payload);
		   break;
		case kMessagesSetTypingAction:
		   handleSetTyping(self, payload);
		   break;
		case kMessagesReadHistory:
		   handleMessageReadReceipt(self, payload);
		   break;
		case kStoriesReadStories:
		   handleStoriesReadReceipt(self, payload);
		   break;
		case kGetSponsoredMessages:
		   handleGetSponsoredMessages(self, payload);
		   break;
		case kChannelsReadHistory:
		   handleChannelsReadReceipt(self, payload);
		   break;
		case kSendScreenshotNotification:
		   handleSendScreenshotNotification(self, payload);
		   break;
		case kMessagesReadMessageContents:
		   handleReadMessageContents(self, payload);
		   break;
		default:
		   break;
		   
	}
	
	if ([[NSUserDefaults standardUserDefaults] boolForKey:kDisableForwardRestriction]) {
		%orig(payload, metadata, shortMetadata, hooked_block);
	} else {
		%orig(payload, metadata, shortMetadata, responseParser);
	}
}

%end


// Manager which handles requests
%hook MTRequestMessageService

- (void)addRequest:(MTRequest *)request {
    if (request.fakeData) {
        @try {
             if (request.completed) {
                 NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];

                 MTRequestResponseInfo *info = [[%c(MTRequestResponseInfo) alloc] initWithNetworkType:1 
					     timestamp:currentTime 
						  duration:0.045
					   ];
					
					id result = request.responseParser(request.fakeData);
					request.completed(result, info, nil);
             }
         } @catch (NSException *exception) {
             customLog2(@"Exception in MTRequestMessageService hook: %@", exception);
         }
        return;
    }
    %orig;
}

%end


// ============================================================
// Screenshot Protection Bypass
// Telegram overlays a hidden UITextField with secureTextEntry=YES
// which causes iOS to black out the screen during screenshots.
// We hook setSecureTextEntry: and _setSecureContents: to prevent this.
// ============================================================

%hook UITextField

- (void)setSecureTextEntry:(BOOL)enabled {
    if (enabled && [[NSUserDefaults standardUserDefaults] boolForKey:kDisableScreenshotNotification]) {
        %orig(NO);
        return;
    }
    %orig;
}

%end

%hook UIView

// iOS 16+ uses _setSecureContents: instead of UITextField trick
- (void)_setSecureContents:(BOOL)secure {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kDisableScreenshotNotification]) {
        return; // noop — allow screenshots
    }
    %orig;
}

%end

// ============================================================
// Anti-Revoke: block incoming delete-message updates from server.
// Strategy: Replace the update constructor word with an unknown
// dummy value (0x00000001) so Telegram discards the entire update.
// Zeroing IDs is unreliable — killing the constructor is definitive.
//
// updateDeleteMessages       constructor: -1576161051 (0xA20DB722)
// updateDeleteChannelMessages constructor: -1020437742 (0xC37521C9)
// ============================================================

#define kUpdateDeleteMessages        -1576161051
#define kUpdateDeleteChannelMessages -1020437742

#define kUpdateEditMessage           -469536605
#define kUpdateEditChannelMessage     457813544

#define kMessageConstructor          -356721331
#define kChatConstructor              1103884886
#define kChannelConstructor           1954681982

#define kVectorConstructor            481674261

// Dummy constructor Telegram will not recognize — causes update to be silently skipped
#define kDummyConstructor             0x00000001

// gzip_packed#3072cfa1 — Telegram wraps large updates in gzip to save bandwidth
#define kGzipPackedCtor               ((int32_t)0x3072CFA1)

// ============================================================
// decompressGzip — inflate a raw gzip/zlib byte stream.
// Returns decompressed NSData, or nil on failure.
// ============================================================
static NSData *decompressGzip(const void *input, size_t inputLen) {
    if (!input || inputLen < 2) return nil;

    z_stream strm;
    memset(&strm, 0, sizeof(strm));
    strm.next_in  = (Bytef *)input;
    strm.avail_in = (uInt)inputLen;

    // 47 = 15+32: auto-detect gzip or zlib header
    if (inflateInit2(&strm, 47) != Z_OK) return nil;

    NSMutableData *result = [NSMutableData dataWithCapacity:inputLen * 4];
    uint8_t buf[65536];
    int ret;
    do {
        strm.next_out  = buf;
        strm.avail_out = sizeof(buf);
        ret = inflate(&strm, Z_NO_FLUSH);
        if (ret < 0 && ret != Z_BUF_ERROR) { inflateEnd(&strm); return nil; }
        NSUInteger produced = sizeof(buf) - strm.avail_out;
        if (produced > 0) [result appendBytes:buf length:produced];
    } while (ret != Z_STREAM_END && strm.avail_in > 0);

    inflateEnd(&strm);
    return (result.length > 0) ? result : nil;
}

static NSData *neutralizePayload(NSData *data, BOOL antiRevoke, BOOL antiEdit, BOOL saveRestricted) {
    if (!data || data.length < 8) return nil;

    // Handle gzip_packed: Telegram compresses large updates to save bandwidth.
    // Decompress, patch inside, return the raw (uncompressed) data so MtProtoKit
    // can still parse it — it accepts raw TL objects regardless of prior compression.
    {
        int32_t top4 = 0;
        memcpy(&top4, data.bytes, 4);
        if (top4 == kGzipPackedCtor && data.length >= 8) {
            const uint8_t *b   = (const uint8_t *)data.bytes;
            uint32_t offset    = 4;
            uint32_t gzipLen   = 0;
            uint8_t  first     = b[offset];
            if (first < 0xFE) {
                gzipLen = first;
                offset += 1;
            } else if (first == 0xFE && data.length > offset + 3) {
                gzipLen = (uint32_t)b[offset+1]
                        | ((uint32_t)b[offset+2] << 8)
                        | ((uint32_t)b[offset+3] << 16);
                offset += 4;
            }
            if (gzipLen > 0 && offset + gzipLen <= data.length) {
                NSData *inner    = decompressGzip(b + offset, gzipLen);
                NSData *patched  = neutralizePayload(inner, antiRevoke, antiEdit, saveRestricted);
                // Return the raw decompressed+patched TL — MtProtoKit handles it fine
                return patched ? patched : nil;
            }
        }
    }

    if (data.length < 16) return nil;

    BOOL modified = NO;
    NSMutableData *mData = [NSMutableData dataWithData:data];
    uint8_t *bytes = (uint8_t *)mData.mutableBytes;
    NSUInteger len = mData.length;

    int32_t top_w = 0;
    memcpy(&top_w, bytes, 4);
    // DO NOT scan file blobs (upload.file, upload.cdnFile, etc.) to prevent false positives in binary media.
    if (top_w == 157948117 || top_w == -242427324 || top_w == -1449145777 || top_w == 568808380 || top_w == -290921362) {
        return nil;
    }
    
    for (NSUInteger i = 0; i + 8 <= len; i += 4) {
        int32_t w = 0;
        memcpy(&w, bytes + i, 4);
        
        // 1. Anti-Revoke: updateDeleteMessages#a20db722
        // Layout: [ctor:4][vecCtor:4][count N:4][id1..idN each 4B][pts:4][ptsCount:4]
        // Strategy: zero the count and slide pts/ptsCount up → Telegram parses
        // "delete 0 messages", advances pts normally → no parse failure, no re-fetch.
        if (antiRevoke && w == kUpdateDeleteMessages && i + 16 <= len) {
            int32_t vec = 0;
            memcpy(&vec, bytes + i + 4, 4);
            if (vec == kVectorConstructor) {
                int32_t count = 0;
                memcpy(&count, bytes + i + 8, 4);
                if (count > 0 && count <= 65536) {
                    NSUInteger ptsOff = i + 12 + (NSUInteger)count * 4;
                    if (ptsOff + 8 <= len) {
                        int32_t pts = 0, ptsCnt = 0;
                        memcpy(&pts,    bytes + ptsOff,     4);
                        memcpy(&ptsCnt, bytes + ptsOff + 4, 4);
                        int32_t zero = 0;
                        memcpy(bytes + i + 8,  &zero,   4);
                        memcpy(bytes + i + 12, &pts,    4);
                        memcpy(bytes + i + 16, &ptsCnt, 4);
                        modified = YES;
                    }
                }
            }
        }
        // Anti-Revoke: updateDeleteChannelMessages#c37521c9
        // Layout: [ctor:4][channelId:8][vecCtor:4][count N:4][ids][pts:4][ptsCount:4]
        else if (antiRevoke && w == kUpdateDeleteChannelMessages && i + 24 <= len) {
            int32_t vec = 0;
            memcpy(&vec, bytes + i + 12, 4);
            if (vec == kVectorConstructor) {
                int32_t count = 0;
                memcpy(&count, bytes + i + 16, 4);
                if (count > 0 && count <= 65536) {
                    NSUInteger ptsOff = i + 20 + (NSUInteger)count * 4;
                    if (ptsOff + 8 <= len) {
                        int32_t pts = 0, ptsCnt = 0;
                        memcpy(&pts,    bytes + ptsOff,     4);
                        memcpy(&ptsCnt, bytes + ptsOff + 4, 4);
                        int32_t zero = 0;
                        memcpy(bytes + i + 16, &zero,   4);
                        memcpy(bytes + i + 20, &pts,    4);
                        memcpy(bytes + i + 24, &ptsCnt, 4);
                        modified = YES;
                    }
                }
            }
        }
        
        // 3. Save Restricted Media — clear `noforwards` flag in message/channel/chat objects
        if (saveRestricted) {
            if (w == kMessageConstructor && i + 12 <= len) {
                int32_t flags = 0;
                memcpy(&flags, bytes + i + 4, 4);
                int32_t mask = (1 << 26); // noforwards bit
                if (flags & mask) {
                    flags &= ~mask;
                    memcpy(bytes + i + 4, &flags, 4);
                    modified = YES;
                }
            }
            else if (w == kChannelConstructor && i + 12 <= len) {
                int32_t flags = 0;
                memcpy(&flags, bytes + i + 4, 4);
                int32_t mask = (1 << 27);
                if (flags & mask) {
                    flags &= ~mask;
                    memcpy(bytes + i + 4, &flags, 4);
                    modified = YES;
                }
            }
            else if (w == kChatConstructor && i + 12 <= len) {
                int32_t flags = 0;
                memcpy(&flags, bytes + i + 4, 4);
                int32_t mask = (1 << 25);
                if (flags & mask) {
                    flags &= ~mask;
                    memcpy(bytes + i + 4, &flags, 4);
                    modified = YES;
                }
            }
        }
    }
    
    return modified ? mData : nil;
}

// ============================================================
// MTProto.parseMessage: receives raw TL bytes BEFORE the Swift
// API layer parses them into objects. This is the correct hook
// point for push updates (deleteMessages, editMessage, noforwards)
// because by the time MTIncomingMessage is created the body is
// already a pre-parsed ObjC/Swift object — not NSData.
// ============================================================
%hook MTProto

- (id)parseMessage:(NSData *)data {
    if (data && data.length >= 4) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        BOOL antiRevoke    = [defaults boolForKey:kAntiRevoke];
        BOOL antiEdit      = [defaults boolForKey:kAntiEdit];
        BOOL saveRestricted = [defaults boolForKey:kDisableForwardRestriction];

        if (antiRevoke || antiEdit || saveRestricted) {
            NSData *modified = neutralizePayload(data, antiRevoke, antiEdit, saveRestricted);
            if (modified) {
                return %orig(modified);
            }
        }
    }
    return %orig;
}

%end
