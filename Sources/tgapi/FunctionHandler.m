#import "Headers.h"
#import <objc/message.h>

NSData *boolTrue() {
    uint8_t bytes[] = {0xB5, 0x75, 0x72, 0x99}; // boolTrue#997275b5
    return [NSData dataWithBytes:bytes length:sizeof(bytes)];
}

NSData *boolFalse() {
    uint8_t bytes[] = {0x37, 0x97, 0x79, 0xBC}; // boolFalse#bc799737
    return [NSData dataWithBytes:bytes length:sizeof(bytes)];
}

NSString *LeadPeerKey(NSString *kind, long long peerId) {
	if (kind.length == 0 || peerId == 0) return nil;
	return [NSString stringWithFormat:@"%@:%lld", kind, peerId];
}

static NSArray<NSString *> *singlePeerKey(NSString *kind, long long peerId) {
	NSString *key = LeadPeerKey(kind, peerId);
	return key ? @[key] : @[];
}

static NSMutableArray<NSDictionary *> *mutableGhostRecords(void) {
	NSArray *saved = [[NSUserDefaults standardUserDefaults] arrayForKey:kGhostPeerRecords];
	NSMutableArray *records = [NSMutableArray array];
	for (id item in saved) {
		if ([item isKindOfClass:[NSDictionary class]]) {
			[records addObject:item];
		}
	}
	return records;
}

static void persistGhostRecords(NSArray<NSDictionary *> *records) {
	NSMutableSet *keys = [NSMutableSet set];
	for (NSDictionary *record in records) {
		for (NSString *key in record[@"aliases"]) {
			if ([key isKindOfClass:[NSString class]]) [keys addObject:key];
		}
		NSString *primary = record[@"key"];
		if ([primary isKindOfClass:[NSString class]]) [keys addObject:primary];
	}
	[[NSUserDefaults standardUserDefaults] setObject:records forKey:kGhostPeerRecords];
	[[NSUserDefaults standardUserDefaults] setObject:keys.allObjects forKey:kGhostPeerKeys];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

NSArray<NSDictionary *> *LeadGhostPeerRecords(void) {
	return mutableGhostRecords();
}

BOOL LeadIsGhostPeerEnabledForKeys(NSArray<NSString *> *keys) {
	if (keys.count == 0) return NO;
	NSArray *saved = [[NSUserDefaults standardUserDefaults] arrayForKey:kGhostPeerKeys];
	NSSet *enabled = [NSSet setWithArray:saved ?: @[]];
	for (NSString *key in keys) {
		if ([enabled containsObject:key]) return YES;
	}
	return NO;
}

void LeadSetGhostPeerEnabled(NSString *primaryKey, NSArray<NSString *> *aliases,
                             NSString *title, BOOL enabled) {
	if (primaryKey.length == 0) return;
	NSMutableOrderedSet *aliasSet = [NSMutableOrderedSet orderedSet];
	[aliasSet addObject:primaryKey];
	for (NSString *alias in aliases) {
		if ([alias isKindOfClass:[NSString class]] && alias.length > 0) {
			[aliasSet addObject:alias];
		}
	}

	NSMutableArray *records = mutableGhostRecords();
	NSUInteger existingIndex = NSNotFound;
	for (NSUInteger i = 0; i < records.count; i++) {
		if ([records[i][@"key"] isEqualToString:primaryKey]) {
			existingIndex = i;
			break;
		}
	}

	if (enabled) {
		NSDictionary *record = @{
			@"key": primaryKey,
			@"aliases": aliasSet.array,
			@"title": title.length > 0 ? title : primaryKey
		};
		if (existingIndex == NSNotFound) {
			[records addObject:record];
		} else {
			records[existingIndex] = record;
		}
	} else if (existingIndex != NSNotFound) {
		[records removeObjectAtIndex:existingIndex];
	}
	persistGhostRecords(records);
}

void LeadRemoveGhostPeer(NSString *primaryKey) {
	LeadSetGhostPeerEnabled(primaryKey, nil, nil, NO);
}

static BOOL readInt32At(NSData *data, int *offset, int32_t *outValue) {
	if (*offset < 0 || (NSUInteger)(*offset + 4) > data.length) return NO;
	[data getBytes:outValue range:NSMakeRange(*offset, 4)];
	*offset += 4;
	return YES;
}

static BOOL readInt64At(NSData *data, int *offset, int64_t *outValue) {
	if (*offset < 0 || (NSUInteger)(*offset + 8) > data.length) return NO;
	[data getBytes:outValue range:NSMakeRange(*offset, 8)];
	*offset += 8;
	return YES;
}

NSArray<NSString *> *LeadGhostAliasesForRawPeerId(long long rawPeerId) {
	if (rawPeerId == 0) return @[];
	NSMutableArray *aliases = [NSMutableArray arrayWithObject:LeadPeerKey(@"peer", rawPeerId)];
	uint64_t data = (uint64_t)rawPeerId;
	uint64_t namespaceBits = (data >> 32) & 0x7;
	uint64_t idLowBits = data & 0xffffffff;
	uint64_t offsetIdHighBits = (data >> 35) & 0xffffffff;
	uint64_t idHighBits = offsetIdHighBits << 32;
	long long peerId = (long long)(idHighBits | idLowBits);

	if (namespaceBits == 0) {
		[aliases addObject:LeadPeerKey(@"user", peerId)];
	} else if (namespaceBits == 1) {
		[aliases addObject:LeadPeerKey(@"chat", peerId)];
	} else if (namespaceBits == 2) {
		[aliases addObject:LeadPeerKey(@"channel", peerId)];
	}
	return aliases;
}

BOOL LeadIsGhostPeerEnabledForRawPeerId(long long rawPeerId) {
	return LeadIsGhostPeerEnabledForKeys(LeadGhostAliasesForRawPeerId(rawPeerId));
}

static NSArray<NSString *> *readInputPeerKeys(NSData *data, int *offset) {
	#define InputPeerEmpty 2134579434
	#define InputPeerSelf 2107670217
	#define InputPeerChat 900291769
	#define InputPeerUser -571955892
	#define InputPeerChannel 666680316
	#define InputPeerUserFromChannel -1468331492
	#define InputPeerChannelFromMessage -1121318848

	int32_t peerConstructorID = 0;
	if (!readInt32At(data, offset, &peerConstructorID)) return @[];

	int64_t peerId = 0;
	switch (peerConstructorID) {
		case InputPeerEmpty:
		case InputPeerSelf:
		    return @[];
		case InputPeerChat:
		    if (!readInt64At(data, offset, &peerId)) return @[];
			return singlePeerKey(@"chat", peerId);
		case InputPeerUser:
		    if (!readInt64At(data, offset, &peerId)) return @[];
		    *offset += 8;
			return singlePeerKey(@"user", peerId);
		case InputPeerChannel:
		    if (!readInt64At(data, offset, &peerId)) return @[];
		    *offset += 8;
			return singlePeerKey(@"channel", peerId);
		case InputPeerUserFromChannel:
		    readInputPeerKeys(data, offset);
		    *offset += 4;
		    if (!readInt64At(data, offset, &peerId)) return @[];
			return singlePeerKey(@"user", peerId);
		case InputPeerChannelFromMessage:
		    readInputPeerKeys(data, offset);
		    *offset += 4;
		    if (!readInt64At(data, offset, &peerId)) return @[];
			return singlePeerKey(@"channel", peerId);
		default:
		    return @[];
	}
}

static NSArray<NSString *> *readInputChannelKeys(NSData *data, int *offset) {
	#define InputChannel -212145112
	#define InputChannelEmpty -292807034
	#define InputChannelFromMessage 1536380829

	int32_t channelConstructorID = 0;
	if (!readInt32At(data, offset, &channelConstructorID)) return @[];

	int64_t channelId = 0;
	switch (channelConstructorID) {
		case InputChannel:
			if (!readInt64At(data, offset, &channelId)) return @[];
			*offset += 8;
			return singlePeerKey(@"channel", channelId);
		case InputChannelFromMessage:
			readInputPeerKeys(data, offset);
			*offset += 4;
			if (!readInt64At(data, offset, &channelId)) return @[];
			return singlePeerKey(@"channel", channelId);
		case InputChannelEmpty:
		default:
			return @[];
	}
}

#pragma mark - Read on reply

// Latest blocked read receipt per chat (messages.readHistory / channels.readHistory /
// messages.readDiscussion payloads), released when you send something into that chat.
static NSMutableDictionary<NSString *, NSMutableArray<NSData *> *> *sPendingReads;

static void rememberPendingRead(NSArray<NSString *> *peerKeys, NSData *payload, int32_t functionID) {
	NSString *key = peerKeys.firstObject;
	if (key.length == 0 || payload.length < 8) return;
	if (![[NSUserDefaults standardUserDefaults] boolForKey:kGhostReadOnReply]) return;
	@synchronized ([NSUserDefaults class]) {
		if (!sPendingReads) sPendingReads = [NSMutableDictionary dictionary];
		NSMutableArray<NSData *> *list = sPendingReads[key] ?: [NSMutableArray array];
		// One payload per method: a newer read of the same kind covers the older max_id.
		for (NSInteger i = (NSInteger)list.count - 1; i >= 0; i--) {
			int32_t existing = 0;
			[list[i] getBytes:&existing length:4];
			if (existing == functionID) [list removeObjectAtIndex:i];
		}
		[list addObject:payload];
		sPendingReads[key] = list;
	}
}

NSArray<NSData *> *LeadTakePendingReads(NSArray<NSString *> *peerKeys) {
	NSMutableArray *result = [NSMutableArray array];
	@synchronized ([NSUserDefaults class]) {
		for (NSString *key in peerKeys) {
			NSArray *list = sPendingReads[key];
			if (list.count) [result addObjectsFromArray:list];
			[sPendingReads removeObjectForKey:key];
		}
	}
	return result;
}

// Target chat of an outgoing send: every send method starts with flags + peer,
// forwardMessages carries the destination after from_peer and two vectors.
NSArray<NSString *> *LeadSendTargetPeerKeys(NSData *payload) {
	if (payload.length < 12) return @[];
	int32_t functionID = 0;
	[payload getBytes:&functionID length:4];
	int offset = 8;
	if (functionID != kMessagesForwardMessages) {
		return readInputPeerKeys(payload, &offset);
	}
	readInputPeerKeys(payload, &offset); // from_peer
	for (int vector = 0; vector < 2; vector++) {
		int32_t ctor = 0, count = 0;
		if (!readInt32At(payload, &offset, &ctor) || !readInt32At(payload, &offset, &count)) return @[];
		if (count < 0 || count > 1000) return @[];
		offset += count * (vector == 0 ? 4 : 8); // id: Vector<int>, random_id: Vector<long>
	}
	return readInputPeerKeys(payload, &offset);
}

static BOOL shouldBypassGhostForPeer(NSArray<NSString *> *peerKeys) {
	return LeadIsGhostPeerEnabledForKeys(peerKeys);
}

static BOOL shouldApplyGlobalGhost(NSString *featureKey,
                                   NSArray<NSString *> *peerKeys) {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey:kGhostModeEnabled] &&
	       [defaults boolForKey:featureKey] &&
	       !shouldBypassGhostForPeer(peerKeys);
}

// Handlers
void handleOnlineStatus(MTRequest *request, NSData *payload) {
	if (![[NSUserDefaults standardUserDefaults] boolForKey:kGhostModeEnabled]) return;
	if (![[NSUserDefaults standardUserDefaults] boolForKey:kDisableOnlineStatus]) return;
	if (payload.length < 8) return;
		
	NSData *isOfflineData = [payload subdataWithRange:NSMakeRange(payload.length - 4, 4)];
	uint32_t isOffline = 0;
	[isOfflineData getBytes:&isOffline length:4];
		
	if (isOffline == 3162085175) { // Online (BOOL false)
		NSMutableData *offlinePayload = [payload mutableCopy];
		uint8_t offline[] = {0xB5, 0x75, 0x72, 0x99}; // boolTrue#997275b5
		[offlinePayload replaceBytesInRange:NSMakeRange(payload.length - 4, 4)
		                           withBytes:offline
		                              length:sizeof(offline)];
		request.fakePayload = offlinePayload;
	}
		
}

void handleSetTyping(MTRequest *request, NSData *payload) {
	int offset = 0; 
	offset += 4; // Skip First 4 Bytes of constructor id;
	int32_t flags = 0;
	if (payload.length < 8) return;
	[payload getBytes:&flags range:NSMakeRange(offset, 4)];
	offset += 4;
	
	NSArray<NSString *> *peerKeys = readInputPeerKeys(payload, &offset);
	
	if ((flags & (1 << 0)) != 0) {
		offset += 4; // Topic id
	}
	
	int32_t actionID = 0;
	if (!readInt32At(payload, &offset, &actionID)) return;
	
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	bool shouldBlockAction = false;
	
	//customLog(@"Handle Set Typing action : %d actionData:%@", actionID, [payload description]);
	switch (actionID) {
		case kActionIDTyping:
		shouldBlockAction = shouldApplyGlobalGhost(kDisableTypingStatus, peerKeys);
		  break;
		case kActionIDRecordingVideo:
		  shouldBlockAction = shouldApplyGlobalGhost(kDisableRecordingVideoStatus, peerKeys);
		  break;
		case kActionIDUploadingVideo:
		  shouldBlockAction = shouldApplyGlobalGhost(kDisableUploadingVideoStatus, peerKeys);
		  break;
		case kActionIDRecordingAudio:
		  shouldBlockAction = shouldApplyGlobalGhost(kDisableRecordingVoiceStatus, peerKeys);
		  break;
		case kActionIDUploadingVoice:
		  shouldBlockAction = shouldApplyGlobalGhost(kDisableUploadingVoiceStatus, peerKeys);
		  break;
		case kActionIDUploadingPhoto:
		  shouldBlockAction = shouldApplyGlobalGhost(kDisableUploadingPhotoStatus, peerKeys);
		  break;
		case kActionIDUploadingFile:
		  shouldBlockAction = shouldApplyGlobalGhost(kDisableUploadingFileStatus, peerKeys);
		  break;
		case kActionIDChoosingLocation:
		  shouldBlockAction = shouldApplyGlobalGhost(kDisableChoosingLocationStatus, peerKeys);
		  break;
		case kActionIDChoosingContact:
		  shouldBlockAction = shouldApplyGlobalGhost(kDisableChoosingContactStatus, peerKeys);
		  break;
		case kActionIDPlayingGame:
		  shouldBlockAction = shouldApplyGlobalGhost(kDisablePlayingGameStatus, peerKeys);
		  break;
		case kActionIDRecordingRoundVideo:
		  shouldBlockAction = shouldApplyGlobalGhost(kDisableRecordingRoundVideoStatus, peerKeys);
		  break;
		case kActionIDUploadingRoundVideo:
		  shouldBlockAction = shouldApplyGlobalGhost(kDisableUploadingRoundVideoStatus, peerKeys);
		  break;
		case kActionIDSpeakingInGroupCall:
		  shouldBlockAction = shouldApplyGlobalGhost(kDisableSpeakingInGroupCallStatus, peerKeys);
		  break;
		case kActionIDReserverHistoryImport:
		  shouldBlockAction = [defaults boolForKey:kGhostModeEnabled] &&
		                      [defaults boolForKey:@"reserverHistroyImport"] &&
		                      !shouldBypassGhostForPeer(peerKeys);
		  break;
		case kActionIDChoosingSticker:
		  shouldBlockAction = shouldApplyGlobalGhost(kDisableChoosingStickerStatus, peerKeys);
		  break;
		case kActionIDEmojiInteraction:
		  shouldBlockAction = shouldApplyGlobalGhost(kDisableEmojiInteractionStatus, peerKeys);
		  break;
		case kActionIDEmojiAcknowledgement:
		  shouldBlockAction = shouldApplyGlobalGhost(kDisableEmojiAcknowledgementStatus, peerKeys);
		  break;
	}
	
	if (shouldBlockAction) {
		request.fakeData = boolTrue();
	}
}

void handleMessageReadReceipt(MTRequest *request, NSData *payload) {
	int offset = 4;
	NSArray<NSString *> *peerKeys = readInputPeerKeys(payload, &offset);
	if (shouldApplyGlobalGhost(kDisableMessageReadReceipt, peerKeys)) {
		rememberPendingRead(peerKeys, payload, kMessagesReadHistory);
		 uint8_t header[] = {0x85, 0x91, 0xD1, 0x84}; // messages.affectedMessages#84d19185
		 int32_t pts = 0;
		 int32_t pts_count = 0;
		 
		 NSMutableData *data = [NSMutableData data];
		 [data appendBytes:&header length:sizeof(header)];
		 [data appendBytes:&pts length:sizeof(pts)];
		 [data appendBytes:&pts_count length:sizeof(pts_count)];
	
		request.fakeData = data;
	}
}

// messages.readDiscussion peer:InputPeer msg_id:int read_max_id:int -> Bool
void handleDiscussionReadReceipt(MTRequest *request, NSData *payload) {
	int offset = 4;
	NSArray<NSString *> *peerKeys = readInputPeerKeys(payload, &offset);
	if (shouldApplyGlobalGhost(kDisableMessageReadReceipt, peerKeys)) {
		rememberPendingRead(peerKeys, payload, kMessagesReadDiscussion);
		request.fakeData = boolTrue();
	}
}

void handleStoriesReadReceipt(MTRequest *request, NSData *payload) {
	int offset = 4;
	NSArray<NSString *> *peerKeys = readInputPeerKeys(payload, &offset);
	if (shouldApplyGlobalGhost(kDisableStoriesReadReceipt, peerKeys)) {
		
		uint8_t vectorID[] = {0x15, 0xC4, 0xB5, 0x1C}; // vector#1cb5c415
		int32_t count = 0;  
		
		NSMutableData *data = [NSMutableData data];
		[data appendBytes:&vectorID length:sizeof(vectorID)];
		[data appendBytes:&count length:sizeof(count)];
	
		request.fakeData = data;
	}
}

// Stories opened from a profile mark themselves seen with this call instead of
// stories.readStories, and it's what puts you on the author's viewers list.
void handleStoriesIncrementViews(MTRequest *request, NSData *payload) {
	int offset = 4;
	NSArray<NSString *> *peerKeys = readInputPeerKeys(payload, &offset);
	if (shouldApplyGlobalGhost(kDisableStoriesReadReceipt, peerKeys)) {
		request.fakeData = boolTrue();
	}
}

// Secret chats carry only an encrypted chat id, so exceptions can't apply here.
void handleEncryptedReadReceipt(MTRequest *request, NSData *payload) {
	if (shouldApplyGlobalGhost(kDisableMessageReadReceipt, @[])) {
		request.fakeData = boolTrue();
	}
}

void handleEncryptedTyping(MTRequest *request, NSData *payload) {
	if (shouldApplyGlobalGhost(kDisableTypingStatus, @[])) {
		request.fakeData = boolTrue();
	}
}

void handleGetSponsoredMessages(MTRequest *request, NSData *payload) {
	if ([[NSUserDefaults standardUserDefaults] boolForKey:kDisableAllAds]) {
		
		uint8_t header[] = {0x0F, 0X49, 0X39, 0X18}; // messages.sponsoredMessagesEmpty#1839490f
		request.fakeData = [NSData dataWithBytes:header length:sizeof(header)];
	}
}

void handleGetSponsoredPeers(MTRequest *request, NSData *payload) {
	if ([[NSUserDefaults standardUserDefaults] boolForKey:kDisableAllAds]) {
		int32_t constructor = -365775695; // contacts.sponsoredPeersEmpty
		request.fakeData = [NSData dataWithBytes:&constructor length:sizeof(constructor)];
	}
}

void handleChannelsReadReceipt(MTRequest *request, NSData *payload) {
	int offset = 4;
	NSArray<NSString *> *peerKeys = readInputChannelKeys(payload, &offset);
	if (shouldApplyGlobalGhost(kDisableMessageReadReceipt, peerKeys)) {
		rememberPendingRead(peerKeys, payload, -871347913); // channels.readHistory
		request.fakeData = boolTrue();
	}
}

void handleSendScreenshotNotification(MTRequest *request, NSData *payload) {
	if ([[NSUserDefaults standardUserDefaults] boolForKey:kDisableScreenshotNotification]) {
		request.fakeData = boolTrue();
	}
}

// Anti-Self-Destruct: intercept messages.readMessageContents
// This call tells the server a TTL/disappearing message was opened.
// Blocking it prevents the server from starting the deletion timer.
// The media can be viewed locally without triggering server-side expiry.
// It's also what tells the sender a voice or round message was played, hence the
// Ghost option. The call carries only message ids, so exceptions can't apply.
void handleReadMessageContents(MTRequest *request, NSData *payload) {
	if ([[NSUserDefaults standardUserDefaults] boolForKey:kAntiSelfDestruct] ||
	    shouldApplyGlobalGhost(kGhostKeepVoiceUnread, @[])) {
		// Return a fake messages.affectedMessages with pts=0, pts_count=0
		// so the client thinks the request succeeded but nothing actually happens
		uint8_t header[] = {0x85, 0x91, 0xD1, 0x84}; // messages.affectedMessages#84d19185
		int32_t pts = 0;
		int32_t pts_count = 0;

		NSMutableData *data = [NSMutableData data];
		[data appendBytes:&header length:sizeof(header)];
		[data appendBytes:&pts length:sizeof(pts)];
		[data appendBytes:&pts_count length:sizeof(pts_count)];

		request.fakeData = data;
	}
}

// channels.readMessageContents channel:InputChannel id:Vector<int> -> Bool
void handleChannelsReadMessageContents(MTRequest *request, NSData *payload) {
	int offset = 4;
	NSArray<NSString *> *peerKeys = readInputChannelKeys(payload, &offset);
	if (shouldApplyGlobalGhost(kGhostKeepVoiceUnread, peerKeys)) {
		request.fakeData = boolTrue();
	}
}

// messages.forwardMessages: set drop_author (flags.11) so the copy has no "Forwarded from".
void handleForwardMessages(MTRequest *request, NSData *payload) {
	if (![[NSUserDefaults standardUserDefaults] boolForKey:kForwardDropAuthor] || payload.length < 8) return;
	int32_t flags = 0;
	[payload getBytes:&flags range:NSMakeRange(4, 4)];
	if (flags & (1 << 11)) return;
	flags |= (1 << 11);
	NSMutableData *patched = [payload mutableCopy];
	[patched replaceBytesInRange:NSMakeRange(4, 4) withBytes:&flags];
	request.fakePayload = patched;
}

// Ids this device deletes itself, so the deletion banner and log skip them.
void handleOwnDeletion(NSData *payload) {
	int32_t functionID = 0;
	[payload getBytes:&functionID length:4];
	int offset = functionID == kChannelsDeleteMessages ? 4 : 8;
	if (functionID == kChannelsDeleteMessages) readInputChannelKeys(payload, &offset);
	int32_t vectorCtor = 0, count = 0;
	if (!readInt32At(payload, &offset, &vectorCtor) || !readInt32At(payload, &offset, &count) || count <= 0 || count > 1000) return;
	NSMutableArray *ids = [NSMutableArray array];
	for (int32_t i = 0; i < count; i++) {
		int32_t messageId = 0;
		if (!readInt32At(payload, &offset, &messageId)) break;
		[ids addObject:@(messageId)];
	}
	Class parser = NSClassFromString(@"TLParser");
	SEL selector = NSSelectorFromString(@"noteOwnDeletion:");
	if ([parser respondsToSelector:selector]) {
		((void (*)(id, SEL, NSArray *))objc_msgSend)(parser, selector, ids);
	}
}
