#import "Headers.h"

#define kChannelsReadHistory -871347913

%hook MTRequest
%property (nonatomic, strong) NSData *fakeData;
%property (nonatomic, strong) NSNumber *functionID;

- (void)setPayload:(NSData *)payload metadata:(id)metadata shortMetadata:(id)shortMetadata responseParser:(id (^)(NSData *))responseParser {
	
	// Extract Function id 
	int32_t functionID;
	[payload getBytes:&functionID length:4];
	self.functionID = [NSNumber numberWithInt:functionID];
	
	//customLog(@"Function id: %d", functionID);
	
	id(^hooked_block)(NSData *) = ^(NSData *inputData) {
		NSNumber *functionIDNumber = [NSNumber numberWithUnsignedInt:functionID];
		NSData *fuck = [TLParser handleResponse:inputData functionID:functionIDNumber];
		id result;
		if (fuck) {
			result = responseParser(fuck);
		} else {
			result = responseParser(inputData);
		}
		return result;
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
		default:
		   break;
		   
	}
	
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"disableForwardRestriction"]) {
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
// Anti-Revoke: block incoming delete-message updates from server
// updateDeleteMessages       constructor: -1576161051 (0xA20DB722)
// updateDeleteChannelMessages constructor: -1020437742 (0xC37521C9)
// ============================================================

#define kUpdateDeleteMessages        -1576161051
#define kUpdateDeleteChannelMessages -1020437742
// ============================================================
// Anti-Revoke: Neutralize delete-message updates in-place
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

static NSData *neutralizePayload(NSData *data, BOOL antiRevoke, BOOL antiEdit, BOOL saveRestricted) {
    if (!data || data.length < 16) return nil;
    
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
    
    for (NSUInteger i = 0; i + 12 <= len; i += 4) {
        int32_t w = 0;
        memcpy(&w, bytes + i, 4);
        
        // 1. Anti-Revoke
        if (antiRevoke) {
            if (w == kUpdateDeleteMessages) {
                int32_t vec = 0;
                memcpy(&vec, bytes + i + 4, 4);
                if (vec == kVectorConstructor) {
                    int32_t count = 0;
                    memcpy(&count, bytes + i + 8, 4);
                    if (count > 0 && count < 10000 && i + 12 + count * 4 <= len) {
                        memset(bytes + i + 12, 0, count * 4);
                        modified = YES;
                    }
                }
            } 
            else if (w == kUpdateDeleteChannelMessages && i + 20 <= len) {
                int32_t vec = 0;
                memcpy(&vec, bytes + i + 12, 4);
                if (vec == kVectorConstructor) {
                    int32_t count = 0;
                    memcpy(&count, bytes + i + 16, 4);
                    if (count > 0 && count < 10000 && i + 20 + count * 4 <= len) {
                        memset(bytes + i + 20, 0, count * 4);
                        modified = YES;
                    }
                }
            }
        }
        
        // 2. Anti-Edit
        if (antiEdit) {
            if (w == kUpdateEditMessage || w == kUpdateEditChannelMessage) {
                if (i + 16 <= len) {
                    int32_t msgCons = 0;
                    memcpy(&msgCons, bytes + i + 4, 4);
                    if (msgCons == kMessageConstructor) {
                        int32_t zero = 0;
                        memcpy(bytes + i + 12, &zero, 4);
                        modified = YES;
                    }
                }
            }
        }
        
        // 3. Save Restricted Media (clear `noforwards`)
        if (saveRestricted) {
            if (w == kMessageConstructor) {
                if (i + 12 <= len) {
                    int32_t flags = 0;
                    memcpy(&flags, bytes + i + 4, 4);
                    int32_t mask = (1 << 26);
                    if (flags & mask) {
                        flags &= ~mask;
                        memcpy(bytes + i + 4, &flags, 4);
                        modified = YES;
                    }
                }
            }
            else if (w == kChannelConstructor) {
                if (i + 12 <= len) {
                    int32_t flags = 0;
                    memcpy(&flags, bytes + i + 4, 4);
                    int32_t mask = (1 << 27);
                    if (flags & mask) {
                        flags &= ~mask;
                        memcpy(bytes + i + 4, &flags, 4);
                        modified = YES;
                    }
                }
            }
            else if (w == kChatConstructor) {
                if (i + 12 <= len) {
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
    }
    
    return modified ? mData : nil;
}

%hook MTIncomingMessage

- (instancetype)initWithMessageId:(int64_t)messageId seqNo:(int32_t)seqNo authKeyId:(int64_t)authKeyId sessionId:(int64_t)sessionId salt:(int64_t)salt timestamp:(NSTimeInterval)timestamp size:(NSInteger)size body:(id)body {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL antiRevoke = [defaults boolForKey:@"TGExtraAntiRevoke"];
    BOOL antiEdit = [defaults boolForKey:@"TGExtraAntiEdit"];
    BOOL saveRestricted = [defaults boolForKey:@"disableForwardRestriction"];
    
    if (antiRevoke || antiEdit || saveRestricted) {
        if ([body isKindOfClass:[NSData class]]) {
            NSData *neutralized = neutralizePayload((NSData *)body, antiRevoke, antiEdit, saveRestricted);
            if (neutralized) {
                body = neutralized; // Pass the mutated NSData to original initializer
            }
        }
    }
    
    return %orig(messageId, seqNo, authKeyId, sessionId, salt, timestamp, size, body);
}

%end

