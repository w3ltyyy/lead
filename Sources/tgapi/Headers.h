#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Logger/Logger.h"
#import "Constants.h"

@interface TLParser : NSObject
+ (NSData *)handleResponse:(NSData *)data functionID:(NSNumber *)ios;
+ (void)addDeletedId:(int32_t)msgId;
+ (void)addDeletedId:(int32_t)msgId channelId:(int64_t)channelId;
+ (void)loadPersistedIds;
+ (NSNumber *)getMessageId:(id)item;
+ (NSNumber *)getMessageIdFromNode:(id)node;
+ (NSString *)getDebugDumpFromNode:(id)node;
+ (BOOL)isDeletedMessageNode:(id)node;
+ (BOOL)isEdited:(NSNumber *)msgId;
+ (BOOL)isEditedMessageNode:(id)node;
+ (NSString *)editKeyForNode:(id)node;
+ (NSString *)peerTagForNode:(id)node;
+ (NSArray *)editHistoryForKey:(NSString *)key;
+ (void)observeMessageTextFromNode:(id)node;
+ (NSArray *)editHistoryForMessageId:(NSNumber *)msgId;
+ (BOOL)wantsPatching;
+ (BOOL)diagEnabled;
+ (void)diagLog:(NSString *)line;
+ (void)diagResponse:(int32_t)functionID inLength:(NSInteger)inLength patched:(BOOL)patched result:(id)result;
+ (void)diagNode:(id)node;
+ (void)diagClear;
+ (NSString *)diagLogPath;
+ (NSInteger)diagLogSize;
+ (NSData *)stripAntiSelfDestruct:(NSData *)data;
+ (BOOL)isMessageSelfDestructing:(NSNumber *)msgId;
+ (BOOL)isMessageSelfDestructing:(NSNumber *)msgId channelId:(int64_t)channelId;
+ (BOOL)isSelfDestructingMessageNode:(id)node;
+ (NSData *)transformVideoToVoiceSendMedia:(NSData *)data duration:(NSNumber *)duration;
+ (NSData *)transformAudioToVoiceSendMedia:(NSData *)data;
+ (NSNumber *)channelKindFromController:(id)controller;
+ (NSDictionary *)compatCounters;
@property (class, nonatomic, copy) NSString *sharedNotesPath;
+ (void)bridgeWriteSettings;
+ (BOOL)bridgeLoadSettings;
+ (void)bridgeTakeHandoff;
+ (void)bridgeNotePatched;
+ (NSDictionary *)bridgeExtensionStatus;
@end

@interface MTRpcError : NSObject
- (id)initWithErrorCode:(int)code errorDescription:(id)desc;
@property (nonatomic, strong, readonly) NSString *errorDescription;
@end

@interface MTRequestResponseInfo : NSObject
- (id)initWithNetworkType:(int)a  timestamp:(CGFloat)b  duration:(CGFloat)c;
@end

@interface MTRequest : NSObject
@property (nonatomic, strong) NSNumber *functionID;
@property (nonatomic, strong) NSData *fakeData;
@property (nonatomic, strong) NSData *fakePayload;
@property (nonatomic, strong) NSData *payload;
@property (nonatomic, copy) void (^completed)(id boxedResponse, MTRequestResponseInfo *info, MTRpcError *error);
@property (nonatomic, strong, readonly) id (^responseParser)(NSData *);
@property (nonatomic, copy) id metadata;
@property (nonatomic, copy) id shortMetadata;
- (void)setPayload:(NSData *)payload metadata:(id)metadata shortMetadata:(id)shortMetadata responseParser:(id (^)(NSData *))responseParser;
@end

@interface MTRequestMessageService : NSObject
- (void)addRequest:(MTRequest *)request;
@end

// Function Handlers
#ifdef __cplusplus
extern "C" {
#endif
void handleOnlineStatus(MTRequest *request, NSData *payload);
void handleSetTyping(MTRequest *request, NSData *payload);
void handleMessageReadReceipt(MTRequest *request, NSData *payload);
void handleDiscussionReadReceipt(MTRequest *request, NSData *payload);
void handleStoriesReadReceipt(MTRequest *request, NSData *payload);
void handleStoriesIncrementViews(MTRequest *request, NSData *payload);
void handleEncryptedReadReceipt(MTRequest *request, NSData *payload);
void handleEncryptedTyping(MTRequest *request, NSData *payload);
void handleGetSponsoredMessages(MTRequest *request, NSData *payload);
void handleGetSponsoredPeers(MTRequest *request, NSData *payload);
void handleChannelsReadReceipt(MTRequest *request, NSData *payload);
void handleSendScreenshotNotification(MTRequest *request, NSData *payload);
void handleReadMessageContents(MTRequest *request, NSData *payload);
void handleChannelsReadMessageContents(MTRequest *request, NSData *payload);
void handleForwardMessages(MTRequest *request, NSData *payload);
void handleOwnDeletion(NSData *payload);
NSData *decompressGzip(const void *input, size_t inputLen);
NSString *LeadSharedNotesPath(void);
BOOL LeadSendRawRequest(NSData *payload, void (^done)(NSData *result, NSString *error));
NSArray<NSString *> *LeadSendTargetPeerKeys(NSData *payload);
NSArray<NSData *> *LeadTakePendingReads(NSArray<NSString *> *peerKeys);
NSString *LeadPeerKey(NSString *kind, long long peerId);
NSArray<NSString *> *LeadGhostAliasesForRawPeerId(long long rawPeerId);
BOOL LeadIsGhostPeerEnabledForKeys(NSArray<NSString *> *keys);
BOOL LeadIsGhostPeerEnabledForRawPeerId(long long rawPeerId);
void LeadSetGhostPeerEnabled(NSString *primaryKey, NSArray<NSString *> *aliases,
                             NSString *title, BOOL enabled);
NSArray<NSDictionary *> *LeadGhostPeerRecords(void);
void LeadRemoveGhostPeer(NSString *primaryKey);
#ifdef __cplusplus
}
#endif
