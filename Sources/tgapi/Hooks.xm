#import "Headers.h"
#include <zlib.h>

// Forward declaration — defined later in this file, used inside hooked_block
static NSData *neutralizePayload(NSData *data, BOOL antiRevoke,
                                 BOOL antiSelfDestruct, BOOL antiAutoDelete);
static NSData *stripIosRestrictionRules(NSData *data);

#define kChannelsReadHistory -871347913

static BOOL LeadComputeIsNotificationExtensionProcess(void) {
  NSBundle *bundle = [NSBundle mainBundle];
  NSString *bundleId = bundle.bundleIdentifier ?: @"";
  NSString *processName = [NSProcessInfo processInfo].processName ?: @"";
  NSString *executableName = bundle.executablePath.lastPathComponent ?: @"";
  NSDictionary *extensionInfo = bundle.infoDictionary[@"NSExtension"];
  NSString *extensionPoint = extensionInfo[@"NSExtensionPointIdentifier"] ?: @"";

  NSString *identity =
      [[NSString stringWithFormat:@"%@ %@ %@ %@", bundleId, processName,
                                    executableName, extensionPoint]
          lowercaseString];

  return [identity containsString:@"notificationservice"] ||
         [identity containsString:@"notificationcontent"] ||
         [identity containsString:@"com.apple.usernotifications.service"];
}

// Called on every request and every incoming message — compute once.
static BOOL LeadIsNotificationExtensionProcess(void) {
  static BOOL result;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    result = LeadComputeIsNotificationExtensionProcess();
  });
  return result;
}

// Read receipts Lead itself re-sends for "Read on reply" carry this metadata,
// so the Ghost handlers let them through instead of blocking them again.
static NSString *const kLeadReadOnReplyMarker = @"LeadReadOnReply";

// Requests seen by the MtProtoKit hooks. Telegram's Rust engine (Debug menu)
// bypasses MtProtoKit entirely; zero traffic after launch means Lead is blind.
static long long sLeadNetworkRequests = 0;
static CFAbsoluteTime sLeadLoadTime = 0;

extern "C" long long LeadNetworkHookActivity(void) {
  return sLeadNetworkRequests;
}

// First line of a shared diagnostics log: versions and the switches that matter.
extern "C" NSString *LeadSideloadFixSummary(void);

extern "C" NSString *LeadDiagStateLine(void) {
  NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
  NSDictionary *info = NSBundle.mainBundle.infoDictionary;
  return [NSString stringWithFormat:@"STATE tg=%@(%@) ios=%@ requests=%lld uptime=%.0fs saveProtected=%d antiSelfDestruct=%d antiRevoke=%d antiEdit=%d",
      info[@"CFBundleShortVersionString"], info[@"CFBundleVersion"], UIDevice.currentDevice.systemVersion,
      sLeadNetworkRequests, CFAbsoluteTimeGetCurrent() - sLeadLoadTime,
      [d boolForKey:kDisableForwardRestriction], [d boolForKey:kAntiSelfDestruct], [d boolForKey:kAntiRevoke], [d boolForKey:kAntiEdit]];
}

// Second line of a shared log: the signature and the app group fix (SideloadFix.m).
extern "C" NSString *LeadDiagSignLine(void) {
  NSArray *plugins = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:NSBundle.mainBundle.builtInPlugInsPath error:nil] ?: @[];
  NSString *nse = @"none";
  for (NSString *plugin in plugins) {
    if (![plugin.lowercaseString containsString:@"notificationservice"]) continue;
    // Is Lead (or any dylib) wired into the extension's own binary?
    NSString *appex = [NSBundle.mainBundle.builtInPlugInsPath stringByAppendingPathComponent:plugin];
    NSBundle *bundle = [NSBundle bundleWithPath:appex];
    NSData *binary = bundle.executablePath ? [NSData dataWithContentsOfFile:bundle.executablePath options:NSDataReadingMappedIfSafe error:nil] : nil;
    NSRange head = NSMakeRange(0, MIN(binary.length, (NSUInteger)(1 << 20)));
    BOOL hasLead = binary && ([binary rangeOfData:[@"Lead.dylib" dataUsingEncoding:NSUTF8StringEncoding] options:0 range:head].location != NSNotFound ||
                              [binary rangeOfData:[@"lead.dylib" dataUsingEncoding:NSUTF8StringEncoding] options:0 range:head].location != NSNotFound);
    // The extension's own entitlements sit as an XML plist in its code signature.
    NSString *nseGroups = @"?";
    NSData *open = [@"<?xml" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *close = [@"</plist>" dataUsingEncoding:NSUTF8StringEncoding];
    NSRange search = NSMakeRange(0, binary.length);
    while (binary && search.length > 0) {
      NSRange start = [binary rangeOfData:open options:0 range:search];
      if (start.location == NSNotFound) break;
      NSRange end = [binary rangeOfData:close options:0 range:NSMakeRange(start.location, binary.length - start.location)];
      if (end.location == NSNotFound) break;
      NSData *xml = [binary subdataWithRange:NSMakeRange(start.location, NSMaxRange(end) - start.location)];
      NSDictionary *plist = [NSPropertyListSerialization propertyListWithData:xml options:0 format:NULL error:nil];
      if ([plist isKindOfClass:[NSDictionary class]] &&
          (plist[@"application-identifier"] || plist[@"com.apple.application-identifier"] ||
           plist[@"keychain-access-groups"] || plist[@"com.apple.security.application-groups"])) {
        id groups = plist[@"com.apple.security.application-groups"];
        nseGroups = [groups isKindOfClass:[NSArray class]] ? [groups componentsJoinedByString:@","] : @"";
        break;
      }
      search = NSMakeRange(NSMaxRange(end), binary.length - NSMaxRange(end));
    }
    nse = [NSString stringWithFormat:@"%@ leadInjected=%d nseGroups=[%@]", plugin, hasLead, nseGroups];
  }
  return [NSString stringWithFormat:@"%@ nse=%@", LeadSideloadFixSummary(), nse];
}

extern "C" double LeadTweakUptime(void) {
  return sLeadLoadTime > 0 ? CFAbsoluteTimeGetCurrent() - sLeadLoadTime : 0;
}

static BOOL LeadIsSendFunction(int32_t functionID) {
  return functionID == kMessagesSendMessage || functionID == kMessagesSendMedia ||
         functionID == kMessagesSendMultiMedia || functionID == kMessagesSendInlineBotResult ||
         functionID == kMessagesForwardMessages;
}

// Hooks are installed only in the main app (see %ctor): the notification
// service extension has a tight memory budget and must stay untouched, or iOS
// falls back to the server's generic "You have a new message" text.
%group NetworkHooks

%hook MTRequest
%property(nonatomic, strong) NSData *fakeData;
%property(nonatomic, strong) NSData *fakePayload;
%property(nonatomic, strong) NSNumber *functionID;

- (void)setPayload:(NSData *)payload
          metadata:(id)metadata
     shortMetadata:(id)shortMetadata
    responseParser:(id (^)(NSData *))responseParser {

  if (LeadIsNotificationExtensionProcess()) {
    %orig(payload, metadata, shortMetadata, responseParser);
    return;
  }

  if (!payload || payload.length < 4 || [metadata isEqual:kLeadReadOnReplyMarker]) {
    %orig(payload, metadata, shortMetadata, responseParser);
    return;
  }

  // Extract Function id
  int32_t functionID;
  [payload getBytes:&functionID length:4];
  self.functionID = [NSNumber numberWithInt:functionID];

  id (^hooked_block)(NSData *) = ^(NSData *inputData) {
    NSNumber *functionIDNumber = [NSNumber numberWithUnsignedInt:functionID];
    NSData *parsed =
        [TLParser handleResponse:inputData functionID:functionIDNumber];
    NSData *toUse = parsed ?: inputData;

    // Strip noforwards from request responses (messages.getHistory, etc.)
    // so the save/forward button appears for newly fetched restricted messages.
    //
    // Also patch anti-revoke/anti-self-destruct here, not just in
    // MTProto.parseMessage: below. Channels/supergroups catch up via the
    // channels.getDifference RPC (response constructor
    // updates.channelDifference, which embeds updateDeleteChannelMessages in
    // other_updates) far more often than 1:1 chats do, since their update
    // volume causes more pts gaps after backgrounding. That RPC response
    // arrives here, not through the live parseMessage: hook, so without this
    // the deletion goes through unpatched — this was why anti-revoke appeared
    // to only work in private chats and not in groups/channels.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL antiRevoke = [defaults boolForKey:kAntiRevoke];
    BOOL antiSelfDestruct = [defaults boolForKey:kAntiSelfDestruct];
    BOOL antiAutoDelete = [defaults boolForKey:kAntiAutoDelete];
    if (antiRevoke || antiSelfDestruct || antiAutoDelete ||
        [defaults boolForKey:kDisableForwardRestriction]) {
      NSData *cleared = neutralizePayload(toUse, antiRevoke, antiSelfDestruct, antiAutoDelete);
      if (cleared)
        toUse = cleared;
    }
    if ([defaults boolForKey:kShowIosRestricted]) {
      NSData *unrestricted = stripIosRestrictionRules(toUse);
      if (unrestricted)
        toUse = unrestricted;
    }

    id result = responseParser(toUse);
    if ([TLParser diagEnabled]) {
      [TLParser diagResponse:functionID inLength:(NSInteger)inputData.length patched:toUse != inputData result:result];
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
  case kMessagesReadDiscussion:
    handleDiscussionReadReceipt(self, payload);
    break;
  case kStoriesReadStories:
    handleStoriesReadReceipt(self, payload);
    break;
  case kGetSponsoredMessages:
  case kGetSponsoredMessagesLegacy:
    handleGetSponsoredMessages(self, payload);
    break;
  case kGetSponsoredPeers:
    handleGetSponsoredPeers(self, payload);
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
  case kChannelsReadMessageContents:
    handleChannelsReadMessageContents(self, payload);
    break;
  case kMessagesForwardMessages:
    handleForwardMessages(self, payload);
    break;
  case kMessagesDeleteMessages:
  case kChannelsDeleteMessages:
    handleOwnDeletion(payload);
    break;
  case kMessagesSendMedia:
    if ([[NSUserDefaults standardUserDefaults]
            boolForKey:kVideoToVoicePreviewEnabled]) {
      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
      NSNumber *duration =
          [defaults objectForKey:kVideoToVoiceLastDuration];
      NSData *voicePayload =
          [TLParser transformVideoToVoiceSendMedia:payload duration:duration];
      if (voicePayload) {
        self.fakePayload = voicePayload;
        [defaults setBool:NO forKey:kVideoToVoicePreviewEnabled];
        [defaults removeObjectForKey:kVideoToVoiceLastDuration];
        [defaults synchronize];
        dispatch_async(dispatch_get_main_queue(), ^{
          [[NSNotificationCenter defaultCenter]
              postNotificationName:@"LeadVideoToVoiceDidFinishSend"
                            object:nil];
        });
      }
    } else if ([[NSUserDefaults standardUserDefaults] boolForKey:kSendAsVoice]) {
      NSData *voicePayload = [TLParser transformAudioToVoiceSendMedia:payload];
      if (voicePayload) {
        self.fakePayload = voicePayload;
      }
    }
    break;
  case kMessagesGetDocumentByHash:
    // A hash hit makes Telegram resend the existing document instead of uploading,
    // which skips the sendMedia rewrite above — force a fresh upload.
    if ([[NSUserDefaults standardUserDefaults]
            boolForKey:kVideoToVoicePreviewEnabled] ||
        [[NSUserDefaults standardUserDefaults] boolForKey:kSendAsVoice]) {
      NSMutableData *emptyDocument = [NSMutableData data];
      int32_t constructor = 922273905; // documentEmpty#36f8c871
      int64_t documentId = 0;
      [emptyDocument appendBytes:&constructor length:sizeof(constructor)];
      [emptyDocument appendBytes:&documentId length:sizeof(documentId)];
      self.fakeData = emptyDocument;
    }
    break;
  default:
    break;
  }

  if (self.fakePayload) {
    payload = self.fakePayload;
  }

  %orig(payload, metadata, shortMetadata, responseParser ? hooked_block : responseParser);
}

%end

        // Manager which handles requests
        %hook MTRequestMessageService

    - (void)addRequest : (MTRequest *)request {
  if (LeadIsNotificationExtensionProcess()) {
    %orig;
    return;
  }

  sLeadNetworkRequests++;

  // Read on reply: a send into a chat releases the read receipts Ghost Mode held for it.
  if (!request.fakeData && LeadIsSendFunction(request.functionID.intValue) &&
      [[NSUserDefaults standardUserDefaults] boolForKey:kGhostReadOnReply]) {
    for (NSData *readPayload in LeadTakePendingReads(LeadSendTargetPeerKeys(request.payload))) {
      MTRequest *read = [[%c(MTRequest) alloc] init];
      [read setPayload:readPayload
              metadata:kLeadReadOnReplyMarker
         shortMetadata:kLeadReadOnReplyMarker
        responseParser:^id(NSData *data) {
          return data ?: [NSData data];
        }];
      read.completed = ^(__unused id result, __unused MTRequestResponseInfo *info, __unused MTRpcError *error) {};
      %orig(read);
    }
  }

  if (request.fakeData) {
    @try {
      if (request.completed) {
        NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];

        MTRequestResponseInfo *info = [[%c(MTRequestResponseInfo)
            alloc] initWithNetworkType:1 timestamp:currentTime duration:0.045];

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

    - (void)setSecureTextEntry : (BOOL)enabled {
  if (enabled && [[NSUserDefaults standardUserDefaults]
                     boolForKey:kDisableScreenshotNotification]) {
    %orig(NO);
    return;
  }
  %orig;
}

%end

        %hook UIView

    // iOS 16+ uses _setSecureContents: instead of UITextField trick
    - (void)_setSecureContents : (BOOL)secure {
  if ([[NSUserDefaults standardUserDefaults]
          boolForKey:kDisableScreenshotNotification]) {
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

#define kUpdateDeleteMessages -1576161051
#define kUpdateDeleteChannelMessages -1020437742

#define kVectorConstructor 481674261

// Dummy constructor Telegram will not recognize — causes update to be silently
// skipped
#define kDummyConstructor 0x00000001

// gzip_packed#3072cfa1 — Telegram wraps large updates in gzip to save bandwidth
#define kGzipPackedCtor ((int32_t)0x3072CFA1)

    // ============================================================
    // decompressGzip — inflate a raw gzip/zlib byte stream.
    // Returns decompressed NSData, or nil on failure.
    // ============================================================

    static NSData *neutralizePayload(NSData *data, BOOL antiRevoke,
                                     BOOL antiSelfDestruct, BOOL antiAutoDelete) {
  if (!data || data.length < 8)
    return nil;

  // Handle gzip_packed: Telegram compresses large updates to save bandwidth.
  // Decompress, patch inside, return the raw (uncompressed) data so MtProtoKit
  // can still parse it — it accepts raw TL objects regardless of prior
  // compression.
  {
    int32_t top4 = 0;
    memcpy(&top4, data.bytes, 4);
    if (top4 == kGzipPackedCtor && data.length >= 8) {
      const uint8_t *b = (const uint8_t *)data.bytes;
      uint32_t offset = 4;
      uint32_t gzipLen = 0;
      uint8_t first = b[offset];
      if (first < 0xFE) {
        gzipLen = first;
        offset += 1;
      } else if (first == 0xFE && data.length > offset + 3) {
        gzipLen = (uint32_t)b[offset + 1] | ((uint32_t)b[offset + 2] << 8) |
                  ((uint32_t)b[offset + 3] << 16);
        offset += 4;
      }
      if (gzipLen > 0 && offset + gzipLen <= data.length) {
        NSData *inner = decompressGzip(b + offset, gzipLen);
        NSData *patched = neutralizePayload(inner, antiRevoke,
                                            antiSelfDestruct, antiAutoDelete);
        // Return the raw decompressed+patched TL — MtProtoKit handles it fine
        return patched ? patched : nil;
      }
    }
  }

  if (data.length < 16)
    return nil;

  BOOL modified = NO;
  NSMutableData *mData = [NSMutableData dataWithData:data];
  uint8_t *bytes = (uint8_t *)mData.mutableBytes;
  NSUInteger len = mData.length;

  int32_t top_w = 0;
  memcpy(&top_w, bytes, 4);
  // DO NOT scan file blobs (upload.file, upload.cdnFile, etc.) to prevent false
  // positives in binary media.
  if (top_w == 157948117 || top_w == -242427324 || top_w == -1449145777 ||
      top_w == 568808380 || top_w == -290921362) {
    return nil;
  }

  for (NSUInteger i = 0; i + 8 <= len; i += 4) {
    int32_t w = 0;
    memcpy(&w, bytes + i, 4);

    // 1. Anti-Revoke & Anti-Self-Destruct: updateDeleteMessages#A20DB0E5
    // Layout: [ctor:4][vecCtor:4][count
    // N:4][id1:4]...[idN:4][pts:4][ptsCount:4] Fix: zero ALL message IDs (keep
    // count=N, pts, ptsCount intact). Telegram processes "delete messages
    // [0,0,...]" — ID 0 never exists → no-op. TL structure is completely
    // preserved, no parse failure, no re-fetch.
    if ((antiRevoke || antiSelfDestruct || antiAutoDelete) && w == kUpdateDeleteMessages &&
        i + 12 <= len) {
      int32_t vec = 0;
      memcpy(&vec, bytes + i + 4, 4);
      if (vec == kVectorConstructor) {
        int32_t count = 0;
        memcpy(&count, bytes + i + 8, 4);
        if (count > 0 && count <= 65536) {
          NSUInteger idsEnd = i + 12 + (NSUInteger)count * 4;
          if (idsEnd <= len) {
            NSMutableArray *deletedIdsArr = [NSMutableArray array];
            for (int32_t k = 0; k < count; k++) {
              int32_t origId = 0;
              memcpy(&origId, bytes + i + 12 + k * 4, 4);
              [NSClassFromString(@"TLParser") addDeletedId:origId];
              [deletedIdsArr addObject:@(origId)];
            }
            if (antiRevoke || antiAutoDelete) {
              if (deletedIdsArr.count > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                  [[NSNotificationCenter defaultCenter]
                      postNotificationName:@"LeadMessageDeletedRealtime"
                                    object:nil
                                  userInfo:@{@"ids" : deletedIdsArr}];
                });
              }
              memset(bytes + i + 12, 0, (NSUInteger)count * 4);
              modified = YES;
            } else if (antiSelfDestruct) {
              for (int32_t k = 0; k < count; k++) {
                int32_t origId = 0;
                memcpy(&origId, bytes + i + 12 + k * 4, 4);
                if ([NSClassFromString(@"TLParser")
                        isMessageSelfDestructing:@(origId)]) {
                  int32_t zero = 0;
                  memcpy(bytes + i + 12 + k * 4, &zero, 4);
                  modified = YES;
                }
              }
            }
          }
        }
      }
    }
    // updateDeleteChannelMessages#C37521C9
    // Layout: [ctor:4][channelId:8][vecCtor:4][count:4][ids][pts:4][ptsCount:4]
    else if ((antiRevoke || antiSelfDestruct || antiAutoDelete) &&
             w == kUpdateDeleteChannelMessages && i + 20 <= len) {
      int32_t vec = 0;
      memcpy(&vec, bytes + i + 12, 4);
      if (vec == kVectorConstructor) {
        int32_t count = 0;
        memcpy(&count, bytes + i + 16, 4);
        if (count > 0 && count <= 65536) {
          NSUInteger idsEnd = i + 20 + (NSUInteger)count * 4;
          if (idsEnd <= len) {
            NSMutableArray *deletedIdsArr = [NSMutableArray array];
            int64_t channelId = 0;
            memcpy(&channelId, bytes + i + 4, 8);
            for (int32_t k = 0; k < count; k++) {
              int32_t origId = 0;
              memcpy(&origId, bytes + i + 20 + k * 4, 4);
              [NSClassFromString(@"TLParser") addDeletedId:origId channelId:channelId];
              [deletedIdsArr addObject:@(origId)];
            }
            if (antiRevoke || antiAutoDelete) {
              if (deletedIdsArr.count > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                  [[NSNotificationCenter defaultCenter]
                      postNotificationName:@"LeadMessageDeletedRealtime"
                                    object:nil
                                  userInfo:@{@"ids" : deletedIdsArr}];
                });
              }
              memset(bytes + i + 20, 0, (NSUInteger)count * 4);
              modified = YES;
            } else if (antiSelfDestruct) {
              for (int32_t k = 0; k < count; k++) {
                int32_t origId = 0;
                memcpy(&origId, bytes + i + 20 + k * 4, 4);
                if ([NSClassFromString(@"TLParser")
                        isMessageSelfDestructing:@(origId)]) {
                  int32_t zero = 0;
                  memcpy(bytes + i + 20 + k * 4, &zero, 4);
                  modified = YES;
                }
              }
            }
          }
        }
      }
    }
  }

  return modified ? mData : nil;
}

// ============================================================
// stripIosRestrictionRules — «Show App Store-blocked chats».
// Telegram marks some channels / users / messages with
// restrictionReason{platform:"ios", ...} (App Store Guideline 1.1); the
// same content opens on web / Android / desktop. Every client based on
// Telegram-iOS hides a peer or message when a rule's platform is "all" or
// "ios". Rewriting the first letter of an "ios…" platform string ("ios" →
// "xos") keeps the TL length and layout intact, so the object parses
// normally but the rule no longer targets this client. Rules for "all"
// platforms (legal takedowns) are untouched.
// Layout: [ctor:4][len:1][platform bytes][pad] [reason] [text]
// ============================================================
static NSData *stripIosRestrictionRules(NSData *data) {
  if (!data || data.length < 12)
    return nil;

  int32_t top4 = 0;
  memcpy(&top4, data.bytes, 4);
  if (top4 == kGzipPackedCtor) {
    const uint8_t *b = (const uint8_t *)data.bytes;
    uint32_t offset = 4;
    uint32_t gzipLen = 0;
    uint8_t first = b[offset];
    if (first < 0xFE) {
      gzipLen = first;
      offset += 1;
    } else if (first == 0xFE && data.length > offset + 3) {
      gzipLen = (uint32_t)b[offset + 1] | ((uint32_t)b[offset + 2] << 8) |
                ((uint32_t)b[offset + 3] << 16);
      offset += 4;
    }
    if (gzipLen > 0 && offset + gzipLen <= data.length) {
      NSData *inner = decompressGzip(b + offset, gzipLen);
      return inner ? stripIosRestrictionRules(inner) : nil;
    }
    return nil;
  }

  // Never touch file blobs (upload.file, upload.cdnFile, ...).
  if (top4 == 157948117 || top4 == -242427324 || top4 == -1449145777 ||
      top4 == 568808380 || top4 == -290921362) {
    return nil;
  }

  NSMutableData *mData = nil;
  const uint8_t *bytes = (const uint8_t *)data.bytes;
  NSUInteger len = data.length;
  for (NSUInteger i = 0; i + 8 <= len; i += 4) {
    int32_t w = 0;
    memcpy(&w, bytes + i, 4);
    if (w != kRestrictionReasonCtor)
      continue;
    uint8_t strLen = bytes[i + 4];
    if (strLen < 3 || strLen >= 0xFE || i + 5 + strLen > len)
      continue;
    if (bytes[i + 5] == 'i' && bytes[i + 6] == 'o' && bytes[i + 7] == 's') {
      if (!mData)
        mData = [NSMutableData dataWithData:data];
      ((uint8_t *)mData.mutableBytes)[i + 5] = 'x';
    }
  }
  return mData;
}

// ============================================================
// MTProto.parseMessage: receives raw TL bytes BEFORE the Swift
// API layer parses them into objects. This is the correct hook
// point for push updates (deleteMessages, editMessage, noforwards)
// because by the time MTIncomingMessage is created the body is
// already a pre-parsed ObjC/Swift object — not NSData.
// ============================================================
%hook MTProto

    - (id)parseMessage : (NSData *)data {
  if (LeadIsNotificationExtensionProcess()) {
    return %orig;
  }

  if (data && data.length >= 4) {
    int32_t ctor = 0;
    memcpy(&ctor, data.bytes, 4);
    // customLog2(@"[Lead] parseMessage: len=%lu ctor=0x%08X", (unsigned
    // long)data.length, (uint32_t)ctor);

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL antiRevoke = [defaults boolForKey:kAntiRevoke];
    BOOL antiSelfDestruct = [defaults boolForKey:kAntiSelfDestruct];
    BOOL antiAutoDelete = [defaults boolForKey:kAntiAutoDelete];
    BOOL modified = NO;

    if (antiRevoke || antiSelfDestruct || antiAutoDelete) {
      NSData *modifiedData = neutralizePayload(
          data, antiRevoke, antiSelfDestruct, antiAutoDelete);
      if (modifiedData) {
        data = modifiedData;
        modified = YES;
      }
    }

    // Live updates go through the same TLParser pass as RPC responses: TTL,
    // edit history, noforwards (a new message in a protected channel carries the
    // channel again, which re-locked it), stories, promo. Patching is in place
    // and reserializes byte-for-byte, so pts and sequence numbers are untouched.
    if ([TLParser wantsPatching]) {
      NSData *uncompressed = data;
      int32_t top4 = 0;
      memcpy(&top4, data.bytes, 4);
      if (top4 == kGzipPackedCtor && data.length >= 8) {
        const uint8_t *b = (const uint8_t *)data.bytes;
        uint32_t offset = 4;
        uint32_t gzipLen = 0;
        uint8_t first = b[offset];
        if (first < 0xFE) {
          gzipLen = first;
          offset += 1;
        } else if (first == 0xFE && data.length > offset + 3) {
          gzipLen = (uint32_t)b[offset + 1] | ((uint32_t)b[offset + 2] << 8) |
                    ((uint32_t)b[offset + 3] << 16);
          offset += 4;
        }
        if (gzipLen > 0 && offset + gzipLen <= data.length) {
          NSData *inner = decompressGzip(b + offset, gzipLen);
          if (inner)
            uncompressed = inner;
        }
      }

      NSData *strippedData =
          [NSClassFromString(@"TLParser") stripAntiSelfDestruct:uncompressed];
      if (strippedData) {
        customLog2(@"[Lead] parseMessage: PATCHED UPDATE PAYLOAD");
        if ([TLParser diagEnabled]) {
          [TLParser diagLog:[NSString stringWithFormat:@"UPDATE patched len=%lu", (unsigned long)uncompressed.length]];
        }
        data = strippedData;
        modified = YES;
      }
    }

    // Chats / users / messages arriving in live updates carry the same
    // restriction rules — patch them too, or the next update would hide the
    // channel again. Only a byte inside a string changes; lengths and pts
    // are untouched.
    if ([defaults boolForKey:kShowIosRestricted]) {
      NSData *unrestricted = stripIosRestrictionRules(data);
      if (unrestricted) {
        data = unrestricted;
        modified = YES;
      }
    }

    if (modified) {
      return %orig(data);
    }
  }
  return %orig;
}

%end

%end // NetworkHooks


    %ctor {
  if (LeadIsNotificationExtensionProcess()) {
    return;
  }

  sLeadLoadTime = CFAbsoluteTimeGetCurrent();
  %init(NetworkHooks);

  // Load persisted deleted-message IDs from UserDefaults into memory on launch.
  [TLParser loadPersistedIds];

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    if ([TLParser diagEnabled]) {
      [TLParser diagLog:LeadDiagStateLine()];
      [TLParser diagLog:LeadDiagSignLine()];
    }
  });
}
