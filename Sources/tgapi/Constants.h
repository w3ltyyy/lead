#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kAccountUpdateOnlineStatus 1713919532
#define kMessagesSetTypingAction 1486110434
#define kMessagesReadHistory 238054714
// messages.readDiscussion#f731a9f4 — read receipt for comment threads / topics
#define kMessagesReadDiscussion -147740172
#define kStoriesReadStories -1521034552
// stories.incrementStoryViews#b2028afb — sent instead of readStories for stories opened from a profile
#define kStoriesIncrementViews -1308456197
// Secret chats: messages.readEncryptedHistory#7f4b690a, messages.setEncryptedTyping#791451ed
#define kMessagesReadEncryptedHistory 2135648522
#define kMessagesSetEncryptedTyping 2031374829
#define kGetSponsoredMessages 1030547536
#define kGetSponsoredMessagesLegacy -1680673735
#define kGetSponsoredPeers -1228356717
#define kSendScreenshotNotification -1589618665
// messages.readMessageContents#36a73f77 — sent when TTL/disappearing media is
// opened
#define kMessagesReadMessageContents 916930423
// upload.getFile#be5335be / upload.getCdnFile#395f69da — file chunk downloads
#define kUploadGetFile      -1101843010
#define kUploadGetCdnFile   962554330

#define kActionIDTyping 381645902           // .sendMessageTypingAction
#define kActionIDRecordingVideo -1584933265 // .sendMessageRecordVideoAction
#define kActionIDUploadingVideo -378127636  // .sendMessageUploadVideoAction
#define kActionIDRecordingAudio -718310409  // .sendMessageRecordAudioAction
#define kActionIDUploadingVoice -212740181  // .sendMessageUploadAudioAction
#define kActionIDUploadingPhoto -774682074  // .sendMessageUploadPhotoAction
#define kActionIDUploadingFile -1441998364  // .sendMessageUploadDocumentAction
#define kActionIDChoosingLocation 393186209 // .sendMessageGeoLocationAction
#define kActionIDChoosingContact 1653390447 // .sendMessageChooseContactAction
#define kActionIDPlayingGame -580219064     // .sendMessageGamePlayAction
#define kActionIDRecordingRoundVideo                                           \
  -1997373508                                   // .sendMessageRecordRoundAction
#define kActionIDUploadingRoundVideo 608050278  // .sendMessageUploadRoundAction
#define kActionIDSpeakingInGroupCall -651419003 // .speakingInGroupCallAction
#define kActionIDReserverHistoryImport                                         \
  -606432698                                 // .sendMessageHistoryImportAction
#define kActionIDChoosingSticker -1336228175 // .sendMessageChooseStickerAction
#define kActionIDEmojiInteraction 630664139  // .sendMessageEmojiInteraction
#define kActionIDEmojiAcknowledgement                                          \
  -1234857938 // .sendMessageEmojiInteractionSeen

#define kGhostModeEnabled @"LeadGhostModeEnabled"
#define kGhostDetailsToggle @"LeadGhostDetailsToggle"
#define kGhostPeerRecords @"LeadGhostPeerRecords"
#define kGhostPeerKeys @"LeadGhostPeerKeys"
#define kDisableOnlineStatus @"disableOnlineStatus"

#define kDisableTypingStatus @"disableTypingStatus"
#define kDisableRecordingVideoStatus @"disableRecordingVideoStatus"
#define kDisableUploadingVideoStatus @"disableUploadingVideoStatus"
#define kDisableRecordingVoiceStatus @"disableRecordingVoiceStatus"
#define kDisableUploadingVoiceStatus @"disableUploadingVoiceStatus"
#define kDisableUploadingPhotoStatus @"disableUploadingPhotoStatus"
#define kDisableUploadingFileStatus @"disableUploadingFileStatus"
#define kDisableChoosingLocationStatus @"disableChoosingLocationStatus"
#define kDisableChoosingContactStatus @"disableChoosingContactStatus"
#define kDisablePlayingGameStatus @"disablePlayingGameStatus"
#define kDisableRecordingRoundVideoStatus @"disableRecordingRoundVideoStatus"
#define kDisableUploadingRoundVideoStatus @"disableUploadingRoundVideoStatus"
#define kDisableSpeakingInGroupCallStatus @"disableSpeakingInGroupCallStatus"
#define kDisableChoosingStickerStatus @"disableChoosingStickerStatus"
#define kDisableEmojiInteractionStatus @"disableEmojiInteractionStatus"
#define kDisableEmojiAcknowledgementStatus @"disableEmojiAcknowledgementStatus"

#define kDisableMessageReadReceipt @"disableMessageReadReceipt"
#define kDisableStoriesReadReceipt @"disableStoriesReadReceipt"
#define kDisableScreenshotNotification @"disableScreenshotNotification"
// Ghost Mode: hold blocked read receipts per chat and send them when you reply there.
#define kGhostReadOnReply @"LeadGhostReadOnReply"
// Ghost Mode: don't tell senders their voice / round messages were played.
#define kGhostKeepVoiceUnread @"LeadGhostKeepVoiceUnread"
// Forward without the "Forwarded from" header (drop_author) by default.
#define kForwardDropAuthor @"LeadForwardDropAuthor"
// Keep stories their author deleted (anti-revoke for stories).
#define kSaveDeletedStories @"LeadSaveDeletedStories"
// In-app banner when Anti-Revoke catches a deletion.
#define kDeletionBanner @"LeadDeletionBanner"
// Log name / username / photo changes of people you talk to.
#define kProfileChangesLog @"LeadProfileChangesLog"
// Profile button with the peer's ID and estimated registration date.
#define kShowPeerInfo @"LeadShowPeerInfo"

// FIX: was incorrectly mapped to "disableOnlineStatus" — now has its own key
#define kDisableAllAds @"disableAllAds"
#define kDisableForwardRestriction @"disableForwardRestriction"
#define kLeadDiagnostics @"LeadDiagnostics"
// account.setContentSettings: the switch Telegram only shows when 18+ content is already on.
#define kSensitiveContent @"LeadSensitiveContent"
#define kAccountGetContentSettings -1952756306 // account.getContentSettings#8b9b4dae
#define kAccountSetContentSettings -1250643605 // account.setContentSettings#b574b16b
// Name shown for this device in Active Sessions.
#define kFakeDeviceEnabled @"LeadFakeDeviceEnabled"
#define kFakeDeviceName @"LeadFakeDeviceName"
// TL layers Lead's parser understands (Sources/tgapi/api_sources).
#define kLeadApiLayerMin 232
#define kLeadApiLayerMax 233
// Hide the proxy sponsor channel and PSA banners from help.getPromoData.
#define kHideProxyPromo @"LeadHideProxyPromo"

// Anti-features
#define kAntiRevoke @"LeadAntiRevoke"
#define kAntiEdit @"LeadAntiEdit"
#define kAntiSelfDestruct @"LeadAntiSelfDestruct"
#define kAntiAutoDelete @"LeadAntiAutoDelete"
#define kConfirmCalls @"LeadConfirmCalls"
#define kHideStories @"LeadHideStories"
#define kDownloadStories @"LeadDownloadStories"
// Hide "dissapearing message" label on TTL messages
#define kHideTTLLabel @"LeadHideTTLLabel"

#define FAKE_LOCATION_ENABLED_KEY @"LeadFakeLocation"
#define FAKE_LATITUDE_KEY @"LeadSavedLatitude"
#define FAKE_LONGITUDE_KEY @"LeadSavedLongitude"

#define FILE_PICKER_FIX_KEY @"LeadFixFilePicker"
#define FILE_PICKER_PATH @"LeadFileFixUsingSomeUglyHacks"

// Download speed boost: 0 = off, 1 = medium (512KB/8 parts), 2 = maximum (1MB/12 parts)
#define kDownloadSpeedBoost @"LeadDownloadSpeedBoost"

// Send audio/video files as voice messages
#define kSendAsVoice @"LeadSendAsVoice"
#define kVideoToVoicePreviewEnabled @"LeadVideoToVoicePreviewEnabled"
#define kVideoToVoiceLastDuration @"LeadVideoToVoiceLastDuration"
#define kMessagesSendMedia 53536639 // messages.sendMedia#330e77f
#define kMessagesSendMessage -17526942        // messages.sendMessage#fef48f62
#define kMessagesSendMultiMedia 469278068     // messages.sendMultiMedia#1bf89d74
#define kMessagesSendInlineBotResult -1060145594 // messages.sendInlineBotResult#c0cf7646
#define kMessagesForwardMessages 326126204    // messages.forwardMessages#13704a7c
#define kUpdatesGetDifference 432207715      // updates.getDifference#19c2f763
#define kHelpGetPromoData -1063816159         // help.getPromoData#c0977421
#define kChannelsReadMessageContents -357180360 // channels.readMessageContents#eab5dc38
#define kMessagesDeleteMessages -443640366     // messages.deleteMessages#e58e95d2
#define kChannelsDeleteMessages -2067661490    // channels.deleteMessages#84c1fd4e
#define kMessagesGetDocumentByHash -1309538785

// Visual-only Telegram Stars balance
#define kVisualStarsEnabled @"LeadVisualStarsEnabled"
#define kVisualStarsAmount @"LeadVisualStarsAmount"

// Show chats / posts that Telegram hides on iOS only (App Store Review Guideline 1.1).
#define kShowIosRestricted @"LeadShowIosRestricted"
// restrictionReason#d072acb4 platform:string reason:string text:string
#define kRestrictionReasonCtor ((int32_t)0xD072ACB4)
