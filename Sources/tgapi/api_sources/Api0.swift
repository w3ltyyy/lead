
enum Api {
    enum account {}
    enum auth {}
    enum channels {}
    enum chatlists {}
    enum communities {}
    enum contacts {}
    enum help {}
    enum messages {}
    enum payments {}
    enum phone {}
    enum premium {}
    enum stats {}
    enum stories {}
    enum updates {}
    enum users {}
    enum wallet {}
    enum functions {
        enum messages {}
    }
}

fileprivate let parsers: [Int32 : (BufferReader) -> Any?] = {
    var dict: [Int32 : (BufferReader) -> Any?] = [:]
    dict[-1471112230] = { return $0.readInt32() }
    dict[570911930] = { return $0.readInt64() }
    dict[571523412] = { return $0.readDouble() }
    dict[0x0929C32F] = { return parseInt256($0) }
    dict[-1255641564] = { return parseString($0) }
    dict[822231244] = { return Api.AuctionBidLevel.parse_auctionBidLevel($0) }
    dict[-2124403385] = { return Api.AutoSaveException.parse_autoSaveException($0) }
    dict[-934791986] = { return Api.AutoSaveSettings.parse_autoSaveSettings($0) }
    dict[1527845466] = { return Api.BaseTheme.parse_baseThemeArctic($0) }
    dict[-1012849566] = { return Api.BaseTheme.parse_baseThemeClassic($0) }
    dict[-69724536] = { return Api.BaseTheme.parse_baseThemeDay($0) }
    dict[-1212997976] = { return Api.BaseTheme.parse_baseThemeNight($0) }
    dict[1834973166] = { return Api.BaseTheme.parse_baseThemeTinted($0) }
    dict[1821253126] = { return Api.Birthday.parse_birthday($0) }
    dict[-1132882121] = { return Api.Bool.parse_boolFalse($0) }
    dict[-1720552011] = { return Api.Bool.parse_boolTrue($0) }
    dict[1262359766] = { return Api.Boost.parse_boost($0) }
    dict[-1778593322] = { return Api.BotApp.parse_botApp($0) }
    dict[1571189943] = { return Api.BotApp.parse_botAppNotModified($0) }
    dict[-912582320] = { return Api.BotAppSettings.parse_botAppSettings($0) }
    dict[-1892371723] = { return Api.BotBusinessConnection.parse_botBusinessConnection($0) }
    dict[-1739401518] = { return Api.BotCommand.parse_botCommand($0) }
    dict[1300890265] = { return Api.BotInfo.parse_botInfo($0) }
    dict[-944407322] = { return Api.BotMenuButton.parse_botMenuButton($0) }
    dict[1113113093] = { return Api.BotMenuButton.parse_botMenuButtonCommands($0) }
    dict[1966318984] = { return Api.BotMenuButton.parse_botMenuButtonDefault($0) }
    dict[-147976487] = { return Api.BotVerification.parse_botVerification($0) }
    dict[-1591021569] = { return Api.BotVerifierSettings.parse_botVerifierSettings($0) }
    dict[-283809188] = { return Api.BusinessAwayMessage.parse_businessAwayMessage($0) }
    dict[-910564679] = { return Api.BusinessAwayMessageSchedule.parse_businessAwayMessageScheduleAlways($0) }
    dict[-867328308] = { return Api.BusinessAwayMessageSchedule.parse_businessAwayMessageScheduleCustom($0) }
    dict[-1007487743] = { return Api.BusinessAwayMessageSchedule.parse_businessAwayMessageScheduleOutsideWorkHours($0) }
    dict[-1604170505] = { return Api.BusinessBotRights.parse_businessBotRights($0) }
    dict[-1263638929] = { return Api.BusinessChatLink.parse_businessChatLink($0) }
    dict[-451302485] = { return Api.BusinessGreetingMessage.parse_businessGreetingMessage($0) }
    dict[1510606445] = { return Api.BusinessIntro.parse_businessIntro($0) }
    dict[-1403249929] = { return Api.BusinessLocation.parse_businessLocation($0) }
    dict[554733559] = { return Api.BusinessRecipients.parse_businessRecipients($0) }
    dict[302717625] = { return Api.BusinessWeeklyOpen.parse_businessWeeklyOpen($0) }
    dict[-1936543592] = { return Api.BusinessWorkHours.parse_businessWorkHours($0) }
    dict[-908226327] = { return Api.ButtonType.parse_buttonTypeDefault($0) }
    dict[-1678843584] = { return Api.ButtonType.parse_buttonTypeRequestGeoLocation($0) }
    dict[1331208759] = { return Api.ButtonType.parse_buttonTypeRequestPeer($0) }
    dict[-549636359] = { return Api.ButtonType.parse_buttonTypeRequestPhone($0) }
    dict[-1429209212] = { return Api.ButtonType.parse_buttonTypeRequestPoll($0) }
    dict[-1072014982] = { return Api.ButtonType.parse_buttonTypeSimpleWebView($0) }
    dict[1071802622] = { return Api.ButtonType.parse_inputButtonTypeRequestPeer($0) }
    dict[531458253] = { return Api.ChannelAdminLogEvent.parse_channelAdminLogEvent($0) }
    dict[1427671598] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionChangeAbout($0) }
    dict[-1102180616] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionChangeAvailableReactions($0) }
    dict[1051328177] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionChangeEmojiStatus($0) }
    dict[1188577451] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionChangeEmojiStickerSet($0) }
    dict[1855199800] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionChangeHistoryTTL($0) }
    dict[84703944] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionChangeLinkedChat($0) }
    dict[241923758] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionChangeLocation($0) }
    dict[1469507456] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionChangePeerColor($0) }
    dict[1129042607] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionChangePhoto($0) }
    dict[1581742885] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionChangeProfilePeerColor($0) }
    dict[-1312568665] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionChangeStickerSet($0) }
    dict[-421545947] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionChangeTitle($0) }
    dict[1783299128] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionChangeUsername($0) }
    dict[-263212119] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionChangeUsernames($0) }
    dict[834362706] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionChangeWallpaper($0) }
    dict[1483767080] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionCreateTopic($0) }
    dict[771095562] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionDefaultBannedRights($0) }
    dict[1121994683] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionDeleteMessage($0) }
    dict[-1374254839] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionDeleteTopic($0) }
    dict[-610299584] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionDiscardGroupCall($0) }
    dict[1889215493] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionEditMessage($0) }
    dict[-261103096] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionEditTopic($0) }
    dict[1515256996] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionExportedInviteDelete($0) }
    dict[-384910503] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionExportedInviteEdit($0) }
    dict[1091179342] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionExportedInviteRevoke($0) }
    dict[1476834540] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionParticipantEditRank($0) }
    dict[-484690728] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionParticipantInvite($0) }
    dict[405815507] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionParticipantJoin($0) }
    dict[-23084712] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionParticipantJoinByInvite($0) }
    dict[-1347021750] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionParticipantJoinByRequest($0) }
    dict[-124291086] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionParticipantLeave($0) }
    dict[-115071790] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionParticipantMute($0) }
    dict[1684286899] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionParticipantSubExtend($0) }
    dict[-714643696] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionParticipantToggleAdmin($0) }
    dict[-422036098] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionParticipantToggleBan($0) }
    dict[-431740480] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionParticipantUnmute($0) }
    dict[1048537159] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionParticipantVolume($0) }
    dict[1569535291] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionPinTopic($0) }
    dict[663693416] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionSendMessage($0) }
    dict[589338437] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionStartGroupCall($0) }
    dict[-1895328189] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionStopPoll($0) }
    dict[1693675004] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionToggleAntiSpam($0) }
    dict[-988285058] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionToggleAutotranslation($0) }
    dict[46949251] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionToggleForum($0) }
    dict[1456906823] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionToggleGroupCallSetting($0) }
    dict[460916654] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionToggleInvites($0) }
    dict[-886388890] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionToggleNoForwards($0) }
    dict[1599903217] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionTogglePreHistoryHidden($0) }
    dict[1621597305] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionToggleSignatureProfiles($0) }
    dict[648939889] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionToggleSignatures($0) }
    dict[1401984889] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionToggleSlowMode($0) }
    dict[-370660328] = { return Api.ChannelAdminLogEventAction.parse_channelAdminLogEventActionUpdatePinned($0) }
    dict[547062491] = { return Api.ChannelLocation.parse_channelLocation($0) }
    dict[-1078612597] = { return Api.ChannelLocation.parse_channelLocationEmpty($0) }
    dict[466961494] = { return Api.ChannelParticipant.parse_channelParticipant($0) }
    dict[885242707] = { return Api.ChannelParticipant.parse_channelParticipantAdmin($0) }
    dict[-705647215] = { return Api.ChannelParticipant.parse_channelParticipantBanned($0) }
    dict[803602899] = { return Api.ChannelParticipant.parse_channelParticipantCreator($0) }
    dict[453242886] = { return Api.ChannelParticipant.parse_channelParticipantLeft($0) }
    dict[-1454929382] = { return Api.ChannelParticipant.parse_channelParticipantSelf($0) }
    dict[2060538432] = { return Api.Chat.parse_channel($0) }
    dict[399807445] = { return Api.Chat.parse_channelForbidden($0) }
    dict[1103884886] = { return Api.Chat.parse_chat($0) }
    dict[693512293] = { return Api.Chat.parse_chatEmpty($0) }
    dict[1704108455] = { return Api.Chat.parse_chatForbidden($0) }
    dict[1710221652] = { return Api.Chat.parse_community($0) }
    dict[-46343496] = { return Api.Chat.parse_communityForbidden($0) }
    dict[1605510357] = { return Api.ChatAdminRights.parse_chatAdminRights($0) }
    dict[-1626209256] = { return Api.ChatBannedRights.parse_chatBannedRights($0) }
    dict[-993731264] = { return Api.ChatFull.parse_channelFull($0) }
    dict[640893467] = { return Api.ChatFull.parse_chatFull($0) }
    dict[-877157113] = { return Api.ChatFull.parse_communityFull($0) }
    dict[1553807106] = { return Api.ChatInvite.parse_chatInvite($0) }
    dict[1516793212] = { return Api.ChatInvite.parse_chatInviteAlready($0) }
    dict[1634294960] = { return Api.ChatInvite.parse_chatInvitePeek($0) }
    dict[954703838] = { return Api.ChatParticipant.parse_chatParticipant($0) }
    dict[56677842] = { return Api.ChatParticipant.parse_chatParticipantAdmin($0) }
    dict[-503814216] = { return Api.ChatParticipant.parse_chatParticipantCreator($0) }
    dict[1018991608] = { return Api.ChatParticipants.parse_chatParticipants($0) }
    dict[-2023500831] = { return Api.ChatParticipants.parse_chatParticipantsForbidden($0) }
    dict[476978193] = { return Api.ChatPhoto.parse_chatPhoto($0) }
    dict[935395612] = { return Api.ChatPhoto.parse_chatPhotoEmpty($0) }
    dict[1385335754] = { return Api.ChatReactions.parse_chatReactionsAll($0) }
    dict[-352570692] = { return Api.ChatReactions.parse_chatReactionsNone($0) }
    dict[1713193015] = { return Api.ChatReactions.parse_chatReactionsSome($0) }
    dict[-1008731132] = { return Api.ChatTheme.parse_chatTheme($0) }
    dict[878246344] = { return Api.ChatTheme.parse_chatThemeUniqueGift($0) }
    dict[1981030077] = { return Api.CommunityPeer.parse_communityPeer($0) }
    dict[2078997125] = { return Api.CommunityPeerRequest.parse_communityPeerRequest($0) }
    dict[2104790276] = { return Api.DataJSON.parse_dataJSON($0) }
    dict[414687501] = { return Api.DcOption.parse_dcOption($0) }
    dict[-58066957] = { return Api.Dialog.parse_dialog($0) }
    dict[-141948557] = { return Api.Dialog.parse_dialogCommunity($0) }
    dict[1908216652] = { return Api.Dialog.parse_dialogFolder($0) }
    dict[-1438177711] = { return Api.DialogFilter.parse_dialogFilter($0) }
    dict[-1772913705] = { return Api.DialogFilter.parse_dialogFilterChatlist($0) }
    dict[909284270] = { return Api.DialogFilter.parse_dialogFilterDefault($0) }
    dict[-445792507] = { return Api.DialogPeer.parse_dialogPeer($0) }
    dict[795199716] = { return Api.DialogPeer.parse_dialogPeerCommunity($0) }
    dict[1363483106] = { return Api.DialogPeer.parse_dialogPeerFolder($0) }
    dict[1911715524] = { return Api.DisallowedGiftsSettings.parse_disallowedGiftsSettings($0) }
    dict[-1881881384] = { return Api.Document.parse_document($0) }
    dict[922273905] = { return Api.Document.parse_documentEmpty($0) }
    dict[297109817] = { return Api.DocumentAttribute.parse_documentAttributeAnimated($0) }
    dict[-1739392570] = { return Api.DocumentAttribute.parse_documentAttributeAudio($0) }
    dict[-48981863] = { return Api.DocumentAttribute.parse_documentAttributeCustomEmoji($0) }
    dict[358154344] = { return Api.DocumentAttribute.parse_documentAttributeFilename($0) }
    dict[-1744710921] = { return Api.DocumentAttribute.parse_documentAttributeHasStickers($0) }
    dict[1815593308] = { return Api.DocumentAttribute.parse_documentAttributeImageSize($0) }
    dict[1662637586] = { return Api.DocumentAttribute.parse_documentAttributeSticker($0) }
    dict[1137015880] = { return Api.DocumentAttribute.parse_documentAttributeVideo($0) }
    dict[1627271828] = { return Api.DraftMessage.parse_draftMessage($0) }
    dict[453805082] = { return Api.DraftMessage.parse_draftMessageEmpty($0) }
    dict[-402717046] = { return Api.EmojiStatus.parse_emojiStatus($0) }
    dict[1904500795] = { return Api.EmojiStatus.parse_emojiStatusCollectible($0) }
    dict[769727150] = { return Api.EmojiStatus.parse_emojiStatusEmpty($0) }
    dict[118758847] = { return Api.EmojiStatus.parse_inputEmojiStatusCollectible($0) }
    dict[1643173063] = { return Api.EncryptedChat.parse_encryptedChat($0) }
    dict[505183301] = { return Api.EncryptedChat.parse_encryptedChatDiscarded($0) }
    dict[-1417756512] = { return Api.EncryptedChat.parse_encryptedChatEmpty($0) }
    dict[1223809356] = { return Api.EncryptedChat.parse_encryptedChatRequested($0) }
    dict[1722964307] = { return Api.EncryptedChat.parse_encryptedChatWaiting($0) }
    dict[-1476358952] = { return Api.EncryptedFile.parse_encryptedFile($0) }
    dict[-1038136962] = { return Api.EncryptedFile.parse_encryptedFileEmpty($0) }
    dict[-317144808] = { return Api.EncryptedMessage.parse_encryptedMessage($0) }
    dict[594758406] = { return Api.EncryptedMessage.parse_encryptedMessageService($0) }
    dict[-584597783] = { return Api.EphemeralMessage.parse_ephemeralMessage($0) }
    dict[-1574126186] = { return Api.ExportedChatInvite.parse_chatInviteExported($0) }
    dict[-317687113] = { return Api.ExportedChatInvite.parse_chatInvitePublicJoinRequests($0) }
    dict[206668204] = { return Api.ExportedChatlistInvite.parse_exportedChatlistInvite($0) }
    dict[-1197736753] = { return Api.FactCheck.parse_factCheck($0) }
    dict[-11252123] = { return Api.Folder.parse_folder($0) }
    dict[-373643672] = { return Api.FolderPeer.parse_folderPeer($0) }
    dict[-52766699] = { return Api.ForumTopic.parse_forumTopic($0) }
    dict[37687451] = { return Api.ForumTopic.parse_forumTopicDeleted($0) }
    dict[-394605632] = { return Api.FoundStory.parse_foundStory($0) }
    dict[-1107729093] = { return Api.Game.parse_game($0) }
    dict[-1297942941] = { return Api.GeoPoint.parse_geoPoint($0) }
    dict[286776671] = { return Api.GeoPoint.parse_geoPointEmpty($0) }
    dict[-565420653] = { return Api.GeoPointAddress.parse_geoPointAddress($0) }
    dict[-273500649] = { return Api.GroupCall.parse_groupCall($0) }
    dict[2004925620] = { return Api.GroupCall.parse_groupCallDiscarded($0) }
    dict[-297595771] = { return Api.GroupCallDonor.parse_groupCallDonor($0) }
    dict[445316222] = { return Api.GroupCallMessage.parse_groupCallMessage($0) }
    dict[708691884] = { return Api.GroupCallParticipant.parse_groupCallParticipant($0) }
    dict[1735736008] = { return Api.GroupCallParticipantVideo.parse_groupCallParticipantVideo($0) }
    dict[-592373577] = { return Api.GroupCallParticipantVideoSourceGroup.parse_groupCallParticipantVideoSourceGroup($0) }
    dict[1220204453] = { return Api.InlineButtonType.parse_inlineButtonTypeBuy($0) }
    dict[693484600] = { return Api.InlineButtonType.parse_inlineButtonTypeCallback($0) }
    dict[-1273154958] = { return Api.InlineButtonType.parse_inlineButtonTypeCopy($0) }
    dict[-1539808867] = { return Api.InlineButtonType.parse_inlineButtonTypeDisabled($0) }
    dict[1557360797] = { return Api.InlineButtonType.parse_inlineButtonTypeGame($0) }
    dict[-1820901387] = { return Api.InlineButtonType.parse_inlineButtonTypeSwitchInline($0) }
    dict[-324732716] = { return Api.InlineButtonType.parse_inlineButtonTypeUrl($0) }
    dict[-1076875870] = { return Api.InlineButtonType.parse_inlineButtonTypeUrlAuth($0) }
    dict[1067663311] = { return Api.InlineButtonType.parse_inlineButtonTypeUserProfile($0) }
    dict[1003140532] = { return Api.InlineButtonType.parse_inlineButtonTypeWebView($0) }
    dict[-1721647948] = { return Api.InlineButtonType.parse_inputInlineButtonTypeUrlAuth($0) }
    dict[1408487002] = { return Api.InlineButtonType.parse_inputInlineButtonTypeUserProfile($0) }
    dict[238759180] = { return Api.InlineQueryPeerType.parse_inlineQueryPeerTypeBotPM($0) }
    dict[1664413338] = { return Api.InlineQueryPeerType.parse_inlineQueryPeerTypeBroadcast($0) }
    dict[-681130742] = { return Api.InlineQueryPeerType.parse_inlineQueryPeerTypeChat($0) }
    dict[1589952067] = { return Api.InlineQueryPeerType.parse_inlineQueryPeerTypeMegagroup($0) }
    dict[-2093215828] = { return Api.InlineQueryPeerType.parse_inlineQueryPeerTypePM($0) }
    dict[813821341] = { return Api.InlineQueryPeerType.parse_inlineQueryPeerTypeSameBotPM($0) }
    dict[-1995686519] = { return Api.InputBotInlineMessageID.parse_inputBotInlineMessageID($0) }
    dict[-1227287081] = { return Api.InputBotInlineMessageID.parse_inputBotInlineMessageID64($0) }
    dict[-212145112] = { return Api.InputChannel.parse_inputChannel($0) }
    dict[-292807034] = { return Api.InputChannel.parse_inputChannelEmpty($0) }
    dict[1536380829] = { return Api.InputChannel.parse_inputChannelFromMessage($0) }
    dict[448771445] = { return Api.InputDocument.parse_inputDocument($0) }
    dict[1928391342] = { return Api.InputDocument.parse_inputDocumentEmpty($0) }
    dict[-181407105] = { return Api.InputFile.parse_inputFile($0) }
    dict[-95482955] = { return Api.InputFile.parse_inputFileBig($0) }
    dict[1658620744] = { return Api.InputFile.parse_inputFileStoryDocument($0) }
    dict[53231223] = { return Api.InputGame.parse_inputGameID($0) }
    dict[-1020139510] = { return Api.InputGame.parse_inputGameShortName($0) }
    dict[1210199983] = { return Api.InputGeoPoint.parse_inputGeoPoint($0) }
    dict[-457104426] = { return Api.InputGeoPoint.parse_inputGeoPointEmpty($0) }
    dict[-659913713] = { return Api.InputGroupCall.parse_inputGroupCall($0) }
    dict[-1945083841] = { return Api.InputGroupCall.parse_inputGroupCallInviteMessage($0) }
    dict[-33127873] = { return Api.InputGroupCall.parse_inputGroupCallSlug($0) }
    dict[-122978821] = { return Api.InputMedia.parse_inputMediaContact($0) }
    dict[-428884101] = { return Api.InputMedia.parse_inputMediaDice($0) }
    dict[-1468646731] = { return Api.InputMedia.parse_inputMediaDocument($0) }
    dict[2006319353] = { return Api.InputMedia.parse_inputMediaDocumentExternal($0) }
    dict[-1771768449] = { return Api.InputMedia.parse_inputMediaEmpty($0) }
    dict[-750828557] = { return Api.InputMedia.parse_inputMediaGame($0) }
    dict[-1759532989] = { return Api.InputMedia.parse_inputMediaGeoLive($0) }
    dict[-104578748] = { return Api.InputMedia.parse_inputMediaGeoPoint($0) }
    dict[1080028941] = { return Api.InputMedia.parse_inputMediaInvoice($0) }
    dict[-1005571194] = { return Api.InputMedia.parse_inputMediaPaidMedia($0) }
    dict[-475053004] = { return Api.InputMedia.parse_inputMediaPhoto($0) }
    dict[-440664550] = { return Api.InputMedia.parse_inputMediaPhotoExternal($0) }
    dict[-2009448184] = { return Api.InputMedia.parse_inputMediaPoll($0) }
    dict[-207018934] = { return Api.InputMedia.parse_inputMediaStakeDice($0) }
    dict[-1979852936] = { return Api.InputMedia.parse_inputMediaStory($0) }
    dict[-1614454818] = { return Api.InputMedia.parse_inputMediaTodo($0) }
    dict[58495792] = { return Api.InputMedia.parse_inputMediaUploadedDocument($0) }
    dict[2105767386] = { return Api.InputMedia.parse_inputMediaUploadedPhoto($0) }
    dict[-1052959727] = { return Api.InputMedia.parse_inputMediaVenue($0) }
    dict[-1038383031] = { return Api.InputMedia.parse_inputMediaWebPage($0) }
    dict[1157021774] = { return Api.InputMedia.parse_inputMediaWidget($0) }
    dict[2089114805] = { return Api.InputMedia.parse_inputMediaWidgetId($0) }
    dict[666680316] = { return Api.InputPeer.parse_inputPeerChannel($0) }
    dict[-1121318848] = { return Api.InputPeer.parse_inputPeerChannelFromMessage($0) }
    dict[900291769] = { return Api.InputPeer.parse_inputPeerChat($0) }
    dict[2134579434] = { return Api.InputPeer.parse_inputPeerEmpty($0) }
    dict[2107670217] = { return Api.InputPeer.parse_inputPeerSelf($0) }
    dict[-571955892] = { return Api.InputPeer.parse_inputPeerUser($0) }
    dict[-1468331492] = { return Api.InputPeer.parse_inputPeerUserFromMessage($0) }
    dict[1001634122] = { return Api.InputPhoto.parse_inputPhoto($0) }
    dict[483901197] = { return Api.InputPhoto.parse_inputPhotoEmpty($0) }
    dict[609840449] = { return Api.InputQuickReplyShortcut.parse_inputQuickReplyShortcut($0) }
    dict[18418929] = { return Api.InputQuickReplyShortcut.parse_inputQuickReplyShortcutId($0) }
    dict[1092204894] = { return Api.InputReplyTo.parse_inputReplyToEphemeralMessage($0) }
    dict[1975627120] = { return Api.InputReplyTo.parse_inputReplyToMessage($0) }
    dict[1775660101] = { return Api.InputReplyTo.parse_inputReplyToMonoForum($0) }
    dict[1484862010] = { return Api.InputReplyTo.parse_inputReplyToStory($0) }
    dict[-2094522947] = { return Api.InputRichFile.parse_inputRichFileDocument($0) }
    dict[-1694473685] = { return Api.InputRichFile.parse_inputRichFilePhoto($0) }
    dict[-456898052] = { return Api.InputRichMessage.parse_inputRichMessage($0) }
    dict[-624196758] = { return Api.InputRichMessage.parse_inputRichMessageHTML($0) }
    dict[4937516] = { return Api.InputRichMessage.parse_inputRichMessageMarkdown($0) }
    dict[-251549057] = { return Api.InputSavedStarGift.parse_inputSavedStarGiftChat($0) }
    dict[545636920] = { return Api.InputSavedStarGift.parse_inputSavedStarGiftSlug($0) }
    dict[1764202389] = { return Api.InputSavedStarGift.parse_inputSavedStarGiftUser($0) }
    dict[42402760] = { return Api.InputStickerSet.parse_inputStickerSetAnimatedEmoji($0) }
    dict[215889721] = { return Api.InputStickerSet.parse_inputStickerSetAnimatedEmojiAnimations($0) }
    dict[-427863538] = { return Api.InputStickerSet.parse_inputStickerSetDice($0) }
    dict[1232373075] = { return Api.InputStickerSet.parse_inputStickerSetEmojiChannelDefaultStatuses($0) }
    dict[701560302] = { return Api.InputStickerSet.parse_inputStickerSetEmojiDefaultStatuses($0) }
    dict[1153562857] = { return Api.InputStickerSet.parse_inputStickerSetEmojiDefaultTopicIcons($0) }
    dict[80008398] = { return Api.InputStickerSet.parse_inputStickerSetEmojiGenericAnimations($0) }
    dict[-4838507] = { return Api.InputStickerSet.parse_inputStickerSetEmpty($0) }
    dict[-1645763991] = { return Api.InputStickerSet.parse_inputStickerSetID($0) }
    dict[-930399486] = { return Api.InputStickerSet.parse_inputStickerSetPremiumGifts($0) }
    dict[-2044933984] = { return Api.InputStickerSet.parse_inputStickerSetShortName($0) }
    dict[485912992] = { return Api.InputStickerSet.parse_inputStickerSetTonGifts($0) }
    dict[-233744186] = { return Api.InputUser.parse_inputUser($0) }
    dict[-1182234929] = { return Api.InputUser.parse_inputUserEmpty($0) }
    dict[497305826] = { return Api.InputUser.parse_inputUserFromMessage($0) }
    dict[-138301121] = { return Api.InputUser.parse_inputUserSelf($0) }
    dict[-1678949555] = { return Api.InputWebDocument.parse_inputWebDocument($0) }
    dict[77522308] = { return Api.Invoice.parse_invoice($0) }
    dict[-1374344599] = { return Api.JoinChatBotResult.parse_joinChatBotResultApproved($0) }
    dict[251265428] = { return Api.JoinChatBotResult.parse_joinChatBotResultDeclined($0) }
    dict[-1734105024] = { return Api.JoinChatBotResult.parse_joinChatBotResultQueued($0) }
    dict[-689719277] = { return Api.JoinChatBotResult.parse_joinChatBotResultWebView($0) }
    dict[795322159] = { return Api.KeyboardButton.parse_keyboardButton($0) }
    dict[2002815875] = { return Api.KeyboardButtonRow.parse_keyboardButtonRow($0) }
    dict[1339896880] = { return Api.KeyboardButtonStyle.parse_keyboardButtonStyle($0) }
    dict[297902882] = { return Api.KeyboardInlineButton.parse_keyboardInlineButton($0) }
    dict[423758582] = { return Api.KeyboardInlineButtonRow.parse_keyboardInlineButtonRow($0) }
    dict[-886477832] = { return Api.LabeledPrice.parse_labeledPrice($0) }
    dict[-209337866] = { return Api.LangPackDifference.parse_langPackDifference($0) }
    dict[-892239370] = { return Api.LangPackString.parse_langPackString($0) }
    dict[695856818] = { return Api.LangPackString.parse_langPackStringDeleted($0) }
    dict[1816636575] = { return Api.LangPackString.parse_langPackStringPluralized($0) }
    dict[-1361650766] = { return Api.MaskCoords.parse_maskCoords($0) }
    dict[577893055] = { return Api.MediaArea.parse_inputMediaAreaChannelPost($0) }
    dict[-1300094593] = { return Api.MediaArea.parse_inputMediaAreaVenue($0) }
    dict[1996756655] = { return Api.MediaArea.parse_mediaAreaChannelPost($0) }
    dict[-891992787] = { return Api.MediaArea.parse_mediaAreaGeoPoint($0) }
    dict[1468491885] = { return Api.MediaArea.parse_mediaAreaStarGift($0) }
    dict[340088945] = { return Api.MediaArea.parse_mediaAreaSuggestedReaction($0) }
    dict[926421125] = { return Api.MediaArea.parse_mediaAreaUrl($0) }
    dict[-1098720356] = { return Api.MediaArea.parse_mediaAreaVenue($0) }
    dict[1235637404] = { return Api.MediaArea.parse_mediaAreaWeather($0) }
    dict[-808853502] = { return Api.MediaAreaCoordinates.parse_mediaAreaCoordinates($0) }
    dict[1979759059] = { return Api.Message.parse_message($0) }
    dict[-1868117372] = { return Api.Message.parse_messageEmpty($0) }
    dict[2055212554] = { return Api.Message.parse_messageService($0) }
    dict[-872240531] = { return Api.MessageAction.parse_messageActionBoostApply($0) }
    dict[-988359047] = { return Api.MessageAction.parse_messageActionBotAllowed($0) }
    dict[1562426088] = { return Api.MessageAction.parse_messageActionChangeCommunity($0) }
    dict[-511160261] = { return Api.MessageAction.parse_messageActionChangeCreator($0) }
    dict[-1781355374] = { return Api.MessageAction.parse_messageActionChannelCreate($0) }
    dict[-365344535] = { return Api.MessageAction.parse_messageActionChannelMigrateFrom($0) }
    dict[365886720] = { return Api.MessageAction.parse_messageActionChatAddUser($0) }
    dict[-1119368275] = { return Api.MessageAction.parse_messageActionChatCreate($0) }
    dict[-1780220945] = { return Api.MessageAction.parse_messageActionChatDeletePhoto($0) }
    dict[-1539362612] = { return Api.MessageAction.parse_messageActionChatDeleteUser($0) }
    dict[2144015272] = { return Api.MessageAction.parse_messageActionChatEditPhoto($0) }
    dict[-1247687078] = { return Api.MessageAction.parse_messageActionChatEditTitle($0) }
    dict[51520707] = { return Api.MessageAction.parse_messageActionChatJoinedByLink($0) }
    dict[-339958837] = { return Api.MessageAction.parse_messageActionChatJoinedByRequest($0) }
    dict[1250688640] = { return Api.MessageAction.parse_messageActionChatJoinedViaCommunity($0) }
    dict[-519864430] = { return Api.MessageAction.parse_messageActionChatMigrateTo($0) }
    dict[805187450] = { return Api.MessageAction.parse_messageActionConferenceCall($0) }
    dict[-202219658] = { return Api.MessageAction.parse_messageActionContactSignUp($0) }
    dict[-85549226] = { return Api.MessageAction.parse_messageActionCustomAction($0) }
    dict[-1230047312] = { return Api.MessageAction.parse_messageActionEmpty($0) }
    dict[-1834538890] = { return Api.MessageAction.parse_messageActionGameScore($0) }
    dict[-1730095465] = { return Api.MessageAction.parse_messageActionGeoProximityReached($0) }
    dict[834962247] = { return Api.MessageAction.parse_messageActionGiftCode($0) }
    dict[1223234306] = { return Api.MessageAction.parse_messageActionGiftPremium($0) }
    dict[1171632161] = { return Api.MessageAction.parse_messageActionGiftStars($0) }
    dict[-1465661799] = { return Api.MessageAction.parse_messageActionGiftTon($0) }
    dict[-1475391004] = { return Api.MessageAction.parse_messageActionGiveawayLaunch($0) }
    dict[-2015170219] = { return Api.MessageAction.parse_messageActionGiveawayResults($0) }
    dict[-1825969613] = { return Api.MessageAction.parse_messageActionGramTransfer($0) }
    dict[2047704898] = { return Api.MessageAction.parse_messageActionGroupCall($0) }
    dict[-1281329567] = { return Api.MessageAction.parse_messageActionGroupCallScheduled($0) }
    dict[-1615153660] = { return Api.MessageAction.parse_messageActionHistoryClear($0) }
    dict[1345295095] = { return Api.MessageAction.parse_messageActionInviteToGroupCall($0) }
    dict[375414334] = { return Api.MessageAction.parse_messageActionManagedBotCreated($0) }
    dict[-1333866363] = { return Api.MessageAction.parse_messageActionNewCreatorPending($0) }
    dict[1042781114] = { return Api.MessageAction.parse_messageActionNoForwardsRequest($0) }
    dict[-1082301070] = { return Api.MessageAction.parse_messageActionNoForwardsToggle($0) }
    dict[-1043140154] = { return Api.MessageAction.parse_messageActionNoPaidMessagesTokenUsed($0) }
    dict[-2068281992] = { return Api.MessageAction.parse_messageActionPaidMessagesPrice($0) }
    dict[-1407246387] = { return Api.MessageAction.parse_messageActionPaidMessagesRefunded($0) }
    dict[1102307842] = { return Api.MessageAction.parse_messageActionPaymentRefunded($0) }
    dict[-970673810] = { return Api.MessageAction.parse_messageActionPaymentSent($0) }
    dict[-6288180] = { return Api.MessageAction.parse_messageActionPaymentSentMe($0) }
    dict[-2132731265] = { return Api.MessageAction.parse_messageActionPhoneCall($0) }
    dict[-1799538451] = { return Api.MessageAction.parse_messageActionPinMessage($0) }
    dict[-1650340500] = { return Api.MessageAction.parse_messageActionPollAppendAnswer($0) }
    dict[966161628] = { return Api.MessageAction.parse_messageActionPollDeleteAnswer($0) }
    dict[-1341372510] = { return Api.MessageAction.parse_messageActionPrizeStars($0) }
    dict[827428507] = { return Api.MessageAction.parse_messageActionRequestedPeer($0) }
    dict[-1816979384] = { return Api.MessageAction.parse_messageActionRequestedPeerSentMe($0) }
    dict[1200788123] = { return Api.MessageAction.parse_messageActionScreenshotTaken($0) }
    dict[-648257196] = { return Api.MessageAction.parse_messageActionSecureValuesSent($0) }
    dict[455635795] = { return Api.MessageAction.parse_messageActionSecureValuesSentMe($0) }
    dict[-1189364422] = { return Api.MessageAction.parse_messageActionSetChatTheme($0) }
    dict[1348510708] = { return Api.MessageAction.parse_messageActionSetChatWallPaper($0) }
    dict[1007897979] = { return Api.MessageAction.parse_messageActionSetMessagesTTL($0) }
    dict[-366202413] = { return Api.MessageAction.parse_messageActionStarGift($0) }
    dict[2000845012] = { return Api.MessageAction.parse_messageActionStarGiftPurchaseOffer($0) }
    dict[1940760427] = { return Api.MessageAction.parse_messageActionStarGiftPurchaseOfferDeclined($0) }
    dict[2115768711] = { return Api.MessageAction.parse_messageActionStarGiftUnique($0) }
    dict[747579941] = { return Api.MessageAction.parse_messageActionSuggestBirthday($0) }
    dict[1474192222] = { return Api.MessageAction.parse_messageActionSuggestProfilePhoto($0) }
    dict[-293988970] = { return Api.MessageAction.parse_messageActionSuggestedPostApproval($0) }
    dict[1777932024] = { return Api.MessageAction.parse_messageActionSuggestedPostRefund($0) }
    dict[-1780625559] = { return Api.MessageAction.parse_messageActionSuggestedPostSuccess($0) }
    dict[-940721021] = { return Api.MessageAction.parse_messageActionTodoAppendTasks($0) }
    dict[-864265079] = { return Api.MessageAction.parse_messageActionTodoCompletions($0) }
    dict[228168278] = { return Api.MessageAction.parse_messageActionTopicCreate($0) }
    dict[-1064024032] = { return Api.MessageAction.parse_messageActionTopicEdit($0) }
    dict[1773716671] = { return Api.MessageAction.parse_messageActionWalletTonConnectRequest($0) }
    dict[-1262252875] = { return Api.MessageAction.parse_messageActionWebViewDataSent($0) }
    dict[1205698681] = { return Api.MessageAction.parse_messageActionWebViewDataSentMe($0) }
    dict[546203849] = { return Api.MessageEntity.parse_inputMessageEntityMentionName($0) }
    dict[1981704948] = { return Api.MessageEntity.parse_messageEntityBankCard($0) }
    dict[-238245204] = { return Api.MessageEntity.parse_messageEntityBlockquote($0) }
    dict[-1117713463] = { return Api.MessageEntity.parse_messageEntityBold($0) }
    dict[1827637959] = { return Api.MessageEntity.parse_messageEntityBotCommand($0) }
    dict[1280209983] = { return Api.MessageEntity.parse_messageEntityCashtag($0) }
    dict[681706865] = { return Api.MessageEntity.parse_messageEntityCode($0) }
    dict[-925956616] = { return Api.MessageEntity.parse_messageEntityCustomEmoji($0) }
    dict[106086853] = { return Api.MessageEntity.parse_messageEntityDiffDelete($0) }
    dict[1903653142] = { return Api.MessageEntity.parse_messageEntityDiffInsert($0) }
    dict[-960371289] = { return Api.MessageEntity.parse_messageEntityDiffReplace($0) }
    dict[1692693954] = { return Api.MessageEntity.parse_messageEntityEmail($0) }
    dict[-1874147385] = { return Api.MessageEntity.parse_messageEntityFormattedDate($0) }
    dict[1868782349] = { return Api.MessageEntity.parse_messageEntityHashtag($0) }
    dict[-2106619040] = { return Api.MessageEntity.parse_messageEntityItalic($0) }
    dict[-100378723] = { return Api.MessageEntity.parse_messageEntityMention($0) }
    dict[-595914432] = { return Api.MessageEntity.parse_messageEntityMentionName($0) }
    dict[-1687559349] = { return Api.MessageEntity.parse_messageEntityPhone($0) }
    dict[1938967520] = { return Api.MessageEntity.parse_messageEntityPre($0) }
    dict[852137487] = { return Api.MessageEntity.parse_messageEntitySpoiler($0) }
    dict[-1090087980] = { return Api.MessageEntity.parse_messageEntityStrike($0) }
    dict[1990644519] = { return Api.MessageEntity.parse_messageEntityTextUrl($0) }
    dict[-39075891] = { return Api.MessageEntity.parse_messageEntityTonAddress($0) }
    dict[-1672577397] = { return Api.MessageEntity.parse_messageEntityUnderline($0) }
    dict[-1148011883] = { return Api.MessageEntity.parse_messageEntityUnknown($0) }
    dict[1859134776] = { return Api.MessageEntity.parse_messageEntityUrl($0) }
    dict[-297296796] = { return Api.MessageExtendedMedia.parse_messageExtendedMedia($0) }
    dict[-1386050360] = { return Api.MessageExtendedMedia.parse_messageExtendedMediaPreview($0) }
    dict[1313731771] = { return Api.MessageFwdHeader.parse_messageFwdHeader($0) }
    dict[1882335561] = { return Api.MessageMedia.parse_messageMediaContact($0) }
    dict[147581959] = { return Api.MessageMedia.parse_messageMediaDice($0) }
    dict[1389939929] = { return Api.MessageMedia.parse_messageMediaDocument($0) }
    dict[1038967584] = { return Api.MessageMedia.parse_messageMediaEmpty($0) }
    dict[-38694904] = { return Api.MessageMedia.parse_messageMediaGame($0) }
    dict[1457575028] = { return Api.MessageMedia.parse_messageMediaGeo($0) }
    dict[-1186937242] = { return Api.MessageMedia.parse_messageMediaGeoLive($0) }
    dict[-1442366485] = { return Api.MessageMedia.parse_messageMediaGiveaway($0) }
    dict[-827703647] = { return Api.MessageMedia.parse_messageMediaGiveawayResults($0) }
    dict[-156940077] = { return Api.MessageMedia.parse_messageMediaInvoice($0) }
    dict[-1467669359] = { return Api.MessageMedia.parse_messageMediaPaidMedia($0) }
    dict[-501814429] = { return Api.MessageMedia.parse_messageMediaPhoto($0) }
    dict[2000637542] = { return Api.MessageMedia.parse_messageMediaPoll($0) }
    dict[1758159491] = { return Api.MessageMedia.parse_messageMediaStory($0) }
    dict[-1974226924] = { return Api.MessageMedia.parse_messageMediaToDo($0) }
    dict[-1618676578] = { return Api.MessageMedia.parse_messageMediaUnsupported($0) }
    dict[784356159] = { return Api.MessageMedia.parse_messageMediaVenue($0) }
    dict[-899896439] = { return Api.MessageMedia.parse_messageMediaVideoStream($0) }
    dict[-571405253] = { return Api.MessageMedia.parse_messageMediaWebPage($0) }
    dict[574157332] = { return Api.MessageMedia.parse_messageMediaWidget($0) }
    dict[-1938180548] = { return Api.MessagePeerReaction.parse_messagePeerReaction($0) }
    dict[-1228133028] = { return Api.MessagePeerVote.parse_messagePeerVote($0) }
    dict[1959634180] = { return Api.MessagePeerVote.parse_messagePeerVoteInputOption($0) }
    dict[1177089766] = { return Api.MessagePeerVote.parse_messagePeerVoteMultiple($0) }
    dict[171155211] = { return Api.MessageReactions.parse_messageReactions($0) }
    dict[1269016922] = { return Api.MessageReactor.parse_messageReactor($0) }
    dict[-2083123262] = { return Api.MessageReplies.parse_messageReplies($0) }
    dict[-575296651] = { return Api.MessageReplyHeader.parse_messageReplyHeader($0) }
    dict[240843065] = { return Api.MessageReplyHeader.parse_messageReplyStoryHeader($0) }
    dict[1163625789] = { return Api.MessageViews.parse_messageViews($0) }
    dict[-1001897636] = { return Api.MyBoost.parse_myBoost($0) }
    dict[-1746354498] = { return Api.NotificationSound.parse_notificationSoundDefault($0) }
    dict[-2096391452] = { return Api.NotificationSound.parse_notificationSoundLocal($0) }
    dict[1863070943] = { return Api.NotificationSound.parse_notificationSoundNone($0) }
    dict[-9666487] = { return Api.NotificationSound.parse_notificationSoundRingtone($0) }
    dict[-703403793] = { return Api.NotifyPeer.parse_notifyBroadcasts($0) }
    dict[-1073230141] = { return Api.NotifyPeer.parse_notifyChats($0) }
    dict[-1103664743] = { return Api.NotifyPeer.parse_notifyCommunity($0) }
    dict[577659656] = { return Api.NotifyPeer.parse_notifyForumTopic($0) }
    dict[-1613493288] = { return Api.NotifyPeer.parse_notifyPeer($0) }
    dict[-1261946036] = { return Api.NotifyPeer.parse_notifyUsers($0) }
    dict[-1738178803] = { return Api.Page.parse_page($0) }
    dict[1464557951] = { return Api.PageBlock.parse_inputPageBlockMap($0) }
    dict[-837994576] = { return Api.PageBlock.parse_pageBlockAnchor($0) }
    dict[-2143067670] = { return Api.PageBlock.parse_pageBlockAudio($0) }
    dict[-1162877472] = { return Api.PageBlock.parse_pageBlockAuthorDate($0) }
    dict[1724999435] = { return Api.PageBlock.parse_pageBlockBlockquote($0) }
    dict[242108356] = { return Api.PageBlock.parse_pageBlockBlockquoteBlocks($0) }
    dict[1835270936] = { return Api.PageBlock.parse_pageBlockButtonRow($0) }
    dict[-283684427] = { return Api.PageBlock.parse_pageBlockChannel($0) }
    dict[1705048653] = { return Api.PageBlock.parse_pageBlockCollage($0) }
    dict[972174080] = { return Api.PageBlock.parse_pageBlockCover($0) }
    dict[1987480557] = { return Api.PageBlock.parse_pageBlockDetails($0) }
    dict[-618614392] = { return Api.PageBlock.parse_pageBlockDivider($0) }
    dict[955923363] = { return Api.PageBlock.parse_pageBlockDocument($0) }
    dict[-1468953147] = { return Api.PageBlock.parse_pageBlockEmbed($0) }
    dict[-229005301] = { return Api.PageBlock.parse_pageBlockEmbedPost($0) }
    dict[1216809369] = { return Api.PageBlock.parse_pageBlockFooter($0) }
    dict[-1076861716] = { return Api.PageBlock.parse_pageBlockHeader($0) }
    dict[-1157691601] = { return Api.PageBlock.parse_pageBlockHeading1($0) }
    dict[158018284] = { return Api.PageBlock.parse_pageBlockHeading2($0) }
    dict[1743204781] = { return Api.PageBlock.parse_pageBlockHeading3($0) }
    dict[-1254983893] = { return Api.PageBlock.parse_pageBlockHeading4($0) }
    dict[-608277398] = { return Api.PageBlock.parse_pageBlockHeading5($0) }
    dict[1747599785] = { return Api.PageBlock.parse_pageBlockHeading6($0) }
    dict[504660880] = { return Api.PageBlock.parse_pageBlockKicker($0) }
    dict[-454524911] = { return Api.PageBlock.parse_pageBlockList($0) }
    dict[-1538310410] = { return Api.PageBlock.parse_pageBlockMap($0) }
    dict[1493699616] = { return Api.PageBlock.parse_pageBlockMath($0) }
    dict[534181569] = { return Api.PageBlock.parse_pageBlockOrderedList($0) }
    dict[1182402406] = { return Api.PageBlock.parse_pageBlockParagraph($0) }
    dict[391759200] = { return Api.PageBlock.parse_pageBlockPhoto($0) }
    dict[-1066346178] = { return Api.PageBlock.parse_pageBlockPreformatted($0) }
    dict[1329878739] = { return Api.PageBlock.parse_pageBlockPullquote($0) }
    dict[370236054] = { return Api.PageBlock.parse_pageBlockRelatedArticles($0) }
    dict[52401552] = { return Api.PageBlock.parse_pageBlockSlideshow($0) }
    dict[-248793375] = { return Api.PageBlock.parse_pageBlockSubheader($0) }
    dict[-1879401953] = { return Api.PageBlock.parse_pageBlockSubtitle($0) }
    dict[-1085412734] = { return Api.PageBlock.parse_pageBlockTable($0) }
    dict[1009361890] = { return Api.PageBlock.parse_pageBlockThinking($0) }
    dict[1890305021] = { return Api.PageBlock.parse_pageBlockTitle($0) }
    dict[324435594] = { return Api.PageBlock.parse_pageBlockUnsupported($0) }
    dict[2089805750] = { return Api.PageBlock.parse_pageBlockVideo($0) }
    dict[1764381832] = { return Api.PageButton.parse_pageButton($0) }
    dict[1869903447] = { return Api.PageCaption.parse_pageCaption($0) }
    dict[1674209194] = { return Api.PageListItem.parse_pageListItemBlocks($0) }
    dict[794323004] = { return Api.PageListItem.parse_pageListItemText($0) }
    dict[-1879910928] = { return Api.PageListOrderedItem.parse_pageListOrderedItemBlocks($0) }
    dict[352522633] = { return Api.PageListOrderedItem.parse_pageListOrderedItemText($0) }
    dict[-1282352120] = { return Api.PageRelatedArticle.parse_pageRelatedArticle($0) }
    dict[878078826] = { return Api.PageTableCell.parse_pageTableCell($0) }
    dict[-524237339] = { return Api.PageTableRow.parse_pageTableRow($0) }
    dict[520887001] = { return Api.PaidReactionPrivacy.parse_paidReactionPrivacyAnonymous($0) }
    dict[543872158] = { return Api.PaidReactionPrivacy.parse_paidReactionPrivacyDefault($0) }
    dict[-596837136] = { return Api.PaidReactionPrivacy.parse_paidReactionPrivacyPeer($0) }
    dict[-368917890] = { return Api.PaymentCharge.parse_paymentCharge($0) }
    dict[-1868808300] = { return Api.PaymentRequestedInfo.parse_paymentRequestedInfo($0) }
    dict[-1566230754] = { return Api.Peer.parse_peerChannel($0) }
    dict[918946202] = { return Api.Peer.parse_peerChat($0) }
    dict[1498486562] = { return Api.Peer.parse_peerUser($0) }
    dict[-386039788] = { return Api.PeerBlocked.parse_peerBlocked($0) }
    dict[-1192589655] = { return Api.PeerColor.parse_inputPeerColorCollectible($0) }
    dict[-1253352753] = { return Api.PeerColor.parse_peerColor($0) }
    dict[-1178573926] = { return Api.PeerColor.parse_peerColorCollectible($0) }
    dict[-901375139] = { return Api.PeerLocated.parse_peerLocated($0) }
    dict[-118740917] = { return Api.PeerLocated.parse_peerSelfLocated($0) }
    dict[-1721619444] = { return Api.PeerNotifySettings.parse_peerNotifySettings($0) }
    dict[-193510921] = { return Api.PeerSettings.parse_peerSettings($0) }
    dict[-1707742823] = { return Api.PeerStories.parse_peerStories($0) }
    dict[-404214254] = { return Api.PendingSuggestion.parse_pendingSuggestion($0) }
    dict[810769141] = { return Api.PhoneCall.parse_phoneCall($0) }
    dict[912311057] = { return Api.PhoneCall.parse_phoneCallAccepted($0) }
    dict[1355435489] = { return Api.PhoneCall.parse_phoneCallDiscarded($0) }
    dict[1399245077] = { return Api.PhoneCall.parse_phoneCallEmpty($0) }
    dict[347139340] = { return Api.PhoneCall.parse_phoneCallRequested($0) }
    dict[-987599081] = { return Api.PhoneCall.parse_phoneCallWaiting($0) }
    dict[-84416311] = { return Api.PhoneCallDiscardReason.parse_phoneCallDiscardReasonBusy($0) }
    dict[-527056480] = { return Api.PhoneCallDiscardReason.parse_phoneCallDiscardReasonDisconnect($0) }
    dict[1471006352] = { return Api.PhoneCallDiscardReason.parse_phoneCallDiscardReasonHangup($0) }
    dict[-1615072777] = { return Api.PhoneCallDiscardReason.parse_phoneCallDiscardReasonMigrateConferenceCall($0) }
    dict[-2048646399] = { return Api.PhoneCallDiscardReason.parse_phoneCallDiscardReasonMissed($0) }
    dict[-58224696] = { return Api.PhoneCallProtocol.parse_phoneCallProtocol($0) }
    dict[-1665063993] = { return Api.PhoneConnection.parse_phoneConnection($0) }
    dict[1667228533] = { return Api.PhoneConnection.parse_phoneConnectionWebrtc($0) }
    dict[-82216347] = { return Api.Photo.parse_photo($0) }
    dict[590459437] = { return Api.Photo.parse_photoEmpty($0) }
    dict[35527382] = { return Api.PhotoSize.parse_photoCachedSize($0) }
    dict[-668906175] = { return Api.PhotoSize.parse_photoPathSize($0) }
    dict[1976012384] = { return Api.PhotoSize.parse_photoSize($0) }
    dict[236446268] = { return Api.PhotoSize.parse_photoSizeEmpty($0) }
    dict[-96535659] = { return Api.PhotoSize.parse_photoSizeProgressive($0) }
    dict[-525288402] = { return Api.PhotoSize.parse_photoStrippedSize($0) }
    dict[-1771164225] = { return Api.Poll.parse_poll($0) }
    dict[429911446] = { return Api.PollAnswer.parse_inputPollAnswer($0) }
    dict[1266514026] = { return Api.PollAnswer.parse_pollAnswer($0) }
    dict[910500618] = { return Api.PollAnswerVoters.parse_pollAnswerVoters($0) }
    dict[-1166298786] = { return Api.PollResults.parse_pollResults($0) }
    dict[512535275] = { return Api.PostAddress.parse_postAddress($0) }
    dict[-1534675103] = { return Api.PrivacyKey.parse_privacyKeyAbout($0) }
    dict[1124062251] = { return Api.PrivacyKey.parse_privacyKeyAddedByPhone($0) }
    dict[536913176] = { return Api.PrivacyKey.parse_privacyKeyBirthday($0) }
    dict[1343122938] = { return Api.PrivacyKey.parse_privacyKeyChatInvite($0) }
    dict[1777096355] = { return Api.PrivacyKey.parse_privacyKeyForwards($0) }
    dict[399722706] = { return Api.PrivacyKey.parse_privacyKeyNoPaidMessages($0) }
    dict[1030105979] = { return Api.PrivacyKey.parse_privacyKeyPhoneCall($0) }
    dict[-778378131] = { return Api.PrivacyKey.parse_privacyKeyPhoneNumber($0) }
    dict[961092808] = { return Api.PrivacyKey.parse_privacyKeyPhoneP2P($0) }
    dict[-1777000467] = { return Api.PrivacyKey.parse_privacyKeyProfilePhoto($0) }
    dict[-8759525] = { return Api.PrivacyKey.parse_privacyKeySavedMusic($0) }
    dict[749010424] = { return Api.PrivacyKey.parse_privacyKeyStarGiftsAutoSave($0) }
    dict[-1137792208] = { return Api.PrivacyKey.parse_privacyKeyStatusTimestamp($0) }
    dict[110621716] = { return Api.PrivacyKey.parse_privacyKeyVoiceMessages($0) }
    dict[1698855810] = { return Api.PrivacyRule.parse_privacyValueAllowAll($0) }
    dict[558242653] = { return Api.PrivacyRule.parse_privacyValueAllowBots($0) }
    dict[1796427406] = { return Api.PrivacyRule.parse_privacyValueAllowChatParticipants($0) }
    dict[-135735141] = { return Api.PrivacyRule.parse_privacyValueAllowCloseFriends($0) }
    dict[-123988] = { return Api.PrivacyRule.parse_privacyValueAllowContacts($0) }
    dict[-320241333] = { return Api.PrivacyRule.parse_privacyValueAllowPremium($0) }
    dict[-1198497870] = { return Api.PrivacyRule.parse_privacyValueAllowUsers($0) }
    dict[-1955338397] = { return Api.PrivacyRule.parse_privacyValueDisallowAll($0) }
    dict[-156895185] = { return Api.PrivacyRule.parse_privacyValueDisallowBots($0) }
    dict[1103656293] = { return Api.PrivacyRule.parse_privacyValueDisallowChatParticipants($0) }
    dict[-125240806] = { return Api.PrivacyRule.parse_privacyValueDisallowContacts($0) }
    dict[-463335103] = { return Api.PrivacyRule.parse_privacyValueDisallowUsers($0) }
    dict[-1422681088] = { return Api.ProfileTab.parse_profileTabFiles($0) }
    dict[-1564412267] = { return Api.ProfileTab.parse_profileTabGifs($0) }
    dict[1296815210] = { return Api.ProfileTab.parse_profileTabGifts($0) }
    dict[-748329831] = { return Api.ProfileTab.parse_profileTabLinks($0) }
    dict[1925597525] = { return Api.ProfileTab.parse_profileTabMedia($0) }
    dict[-1624780178] = { return Api.ProfileTab.parse_profileTabMusic($0) }
    dict[-1181952362] = { return Api.ProfileTab.parse_profileTabPosts($0) }
    dict[-461960914] = { return Api.ProfileTab.parse_profileTabVoice($0) }
    dict[32685898] = { return Api.PublicForward.parse_publicForwardMessage($0) }
    dict[-302797360] = { return Api.PublicForward.parse_publicForwardStory($0) }
    dict[110563371] = { return Api.QuickReply.parse_quickReply($0) }
    dict[-1992950669] = { return Api.Reaction.parse_reactionCustomEmoji($0) }
    dict[455247544] = { return Api.Reaction.parse_reactionEmoji($0) }
    dict[2046153753] = { return Api.Reaction.parse_reactionEmpty($0) }
    dict[1379771627] = { return Api.Reaction.parse_reactionPaid($0) }
    dict[-1546531968] = { return Api.ReactionCount.parse_reactionCount($0) }
    dict[-1294306862] = { return Api.RecentMeUrl.parse_recentMeUrlChat($0) }
    dict[-347535331] = { return Api.RecentMeUrl.parse_recentMeUrlChatInvite($0) }
    dict[-1140172836] = { return Api.RecentMeUrl.parse_recentMeUrlStickerSet($0) }
    dict[1189204285] = { return Api.RecentMeUrl.parse_recentMeUrlUnknown($0) }
    dict[-1188296222] = { return Api.RecentMeUrl.parse_recentMeUrlUser($0) }
    dict[1897752877] = { return Api.RecentStory.parse_recentStory($0) }
    dict[-1297000592] = { return Api.ReplyMarkup.parse_replyInlineMarkup($0) }
    dict[-2035021048] = { return Api.ReplyMarkup.parse_replyKeyboardForceReply($0) }
    dict[-1606526075] = { return Api.ReplyMarkup.parse_replyKeyboardHide($0) }
    dict[-2049074735] = { return Api.ReplyMarkup.parse_replyKeyboardMarkup($0) }
    dict[865857388] = { return Api.RequestPeerType.parse_requestPeerTypeBroadcast($0) }
    dict[-906990053] = { return Api.RequestPeerType.parse_requestPeerTypeChat($0) }
    dict[1048699000] = { return Api.RequestPeerType.parse_requestPeerTypeCreateBot($0) }
    dict[1597737472] = { return Api.RequestPeerType.parse_requestPeerTypeUser($0) }
    dict[-1952185372] = { return Api.RequestedPeer.parse_requestedPeerChannel($0) }
    dict[1929860175] = { return Api.RequestedPeer.parse_requestedPeerChat($0) }
    dict[-701500310] = { return Api.RequestedPeer.parse_requestedPeerUser($0) }
    dict[-797791052] = { return Api.RestrictionReason.parse_restrictionReason($0) }
    dict[63312061] = { return Api.RichButtonStyle.parse_richButtonStyle($0) }
    dict[-1158439541] = { return Api.RichMessage.parse_richMessage($0) }
    dict[894777186] = { return Api.RichText.parse_textAnchor($0) }
    dict[-984177571] = { return Api.RichText.parse_textAutoEmail($0) }
    dict[616720265] = { return Api.RichText.parse_textAutoPhone($0) }
    dict[-1402305622] = { return Api.RichText.parse_textAutoUrl($0) }
    dict[-1185513171] = { return Api.RichText.parse_textBankCard($0) }
    dict[1730456516] = { return Api.RichText.parse_textBold($0) }
    dict[50276819] = { return Api.RichText.parse_textBotCommand($0) }
    dict[-1345872682] = { return Api.RichText.parse_textButton($0) }
    dict[2073958401] = { return Api.RichText.parse_textCashtag($0) }
    dict[2120376535] = { return Api.RichText.parse_textConcat($0) }
    dict[-1570679104] = { return Api.RichText.parse_textCustomEmoji($0) }
    dict[-1514906069] = { return Api.RichText.parse_textDate($0) }
    dict[-1769551024] = { return Api.RichText.parse_textDiff($0) }
    dict[-564523562] = { return Api.RichText.parse_textEmail($0) }
    dict[-599948721] = { return Api.RichText.parse_textEmpty($0) }
    dict[1816074681] = { return Api.RichText.parse_textFixed($0) }
    dict[1368728810] = { return Api.RichText.parse_textHashtag($0) }
    dict[136105807] = { return Api.RichText.parse_textImage($0) }
    dict[-653089380] = { return Api.RichText.parse_textItalic($0) }
    dict[55281185] = { return Api.RichText.parse_textMarked($0) }
    dict[-1657885545] = { return Api.RichText.parse_textMath($0) }
    dict[-853225660] = { return Api.RichText.parse_textMention($0) }
    dict[27917308] = { return Api.RichText.parse_textMentionName($0) }
    dict[483104362] = { return Api.RichText.parse_textPhone($0) }
    dict[1950782688] = { return Api.RichText.parse_textPlain($0) }
    dict[1277844834] = { return Api.RichText.parse_textSpoiler($0) }
    dict[-1678197867] = { return Api.RichText.parse_textStrike($0) }
    dict[-311786236] = { return Api.RichText.parse_textSubscript($0) }
    dict[-939827711] = { return Api.RichText.parse_textSuperscript($0) }
    dict[1020437354] = { return Api.RichText.parse_textTonAddress($0) }
    dict[-1054465340] = { return Api.RichText.parse_textUnderline($0) }
    dict[1009288385] = { return Api.RichText.parse_textUrl($0) }
    dict[1681948327] = { return Api.SavedDialog.parse_monoForumDialog($0) }
    dict[-1115174036] = { return Api.SavedDialog.parse_savedDialog($0) }
    dict[1105150972] = { return Api.SavedStarGift.parse_savedStarGift($0) }
    dict[1040931690] = { return Api.SearchPostsFlood.parse_searchPostsFlood($0) }
    dict[-911191137] = { return Api.SearchResultsCalendarPeriod.parse_searchResultsCalendarPeriod($0) }
    dict[871426631] = { return Api.SecureCredentialsEncrypted.parse_secureCredentialsEncrypted($0) }
    dict[-1964327229] = { return Api.SecureData.parse_secureData($0) }
    dict[2097791614] = { return Api.SecureFile.parse_secureFile($0) }
    dict[1679398724] = { return Api.SecureFile.parse_secureFileEmpty($0) }
    dict[569137759] = { return Api.SecurePlainData.parse_securePlainEmail($0) }
    dict[2103482845] = { return Api.SecurePlainData.parse_securePlainPhone($0) }
    dict[411017418] = { return Api.SecureValue.parse_secureValue($0) }
    dict[-874308058] = { return Api.SecureValueType.parse_secureValueTypeAddress($0) }
    dict[-1995211763] = { return Api.SecureValueType.parse_secureValueTypeBankStatement($0) }
    dict[115615172] = { return Api.SecureValueType.parse_secureValueTypeDriverLicense($0) }
    dict[-1908627474] = { return Api.SecureValueType.parse_secureValueTypeEmail($0) }
    dict[-1596951477] = { return Api.SecureValueType.parse_secureValueTypeIdentityCard($0) }
    dict[-1717268701] = { return Api.SecureValueType.parse_secureValueTypeInternalPassport($0) }
    dict[1034709504] = { return Api.SecureValueType.parse_secureValueTypePassport($0) }
    dict[-1713143702] = { return Api.SecureValueType.parse_secureValueTypePassportRegistration($0) }
    dict[-1658158621] = { return Api.SecureValueType.parse_secureValueTypePersonalDetails($0) }
    dict[-1289704741] = { return Api.SecureValueType.parse_secureValueTypePhone($0) }
    dict[-1954007928] = { return Api.SecureValueType.parse_secureValueTypeRentalAgreement($0) }
    dict[-368907213] = { return Api.SecureValueType.parse_secureValueTypeTemporaryRegistration($0) }
    dict[-63531698] = { return Api.SecureValueType.parse_secureValueTypeUtilityBill($0) }
    dict[-1206095820] = { return Api.SendAsPeer.parse_sendAsPeer($0) }
    dict[-1455962178] = { return Api.SendMessageAction.parse_inputSendMessageRichMessageDraftAction($0) }
    dict[-44119819] = { return Api.SendMessageAction.parse_sendMessageCancelAction($0) }
    dict[1653390447] = { return Api.SendMessageAction.parse_sendMessageChooseContactAction($0) }
    dict[-1336228175] = { return Api.SendMessageAction.parse_sendMessageChooseStickerAction($0) }
    dict[630664139] = { return Api.SendMessageAction.parse_sendMessageEmojiInteraction($0) }
    dict[-1234857938] = { return Api.SendMessageAction.parse_sendMessageEmojiInteractionSeen($0) }
    dict[-580219064] = { return Api.SendMessageAction.parse_sendMessageGamePlayAction($0) }
    dict[393186209] = { return Api.SendMessageAction.parse_sendMessageGeoLocationAction($0) }
    dict[-606432698] = { return Api.SendMessageAction.parse_sendMessageHistoryImportAction($0) }
    dict[-718310409] = { return Api.SendMessageAction.parse_sendMessageRecordAudioAction($0) }
    dict[-1997373508] = { return Api.SendMessageAction.parse_sendMessageRecordRoundAction($0) }
    dict[-1584933265] = { return Api.SendMessageAction.parse_sendMessageRecordVideoAction($0) }
    dict[1381386387] = { return Api.SendMessageAction.parse_sendMessageRichMessageDraftAction($0) }
    dict[-67566928] = { return Api.SendMessageAction.parse_sendMessageStopDraftAction($0) }
    dict[909162586] = { return Api.SendMessageAction.parse_sendMessageTextDraftAction($0) }
    dict[381645902] = { return Api.SendMessageAction.parse_sendMessageTypingAction($0) }
    dict[-212740181] = { return Api.SendMessageAction.parse_sendMessageUploadAudioAction($0) }
    dict[-1441998364] = { return Api.SendMessageAction.parse_sendMessageUploadDocumentAction($0) }
    dict[-774682074] = { return Api.SendMessageAction.parse_sendMessageUploadPhotoAction($0) }
    dict[608050278] = { return Api.SendMessageAction.parse_sendMessageUploadRoundAction($0) }
    dict[-378127636] = { return Api.SendMessageAction.parse_sendMessageUploadVideoAction($0) }
    dict[-651419003] = { return Api.SendMessageAction.parse_speakingInGroupCallAction($0) }
    dict[1069099867] = { return Api.ShareTheme.parse_inputShareThemeGift($0) }
    dict[-1783830449] = { return Api.ShareTheme.parse_shareThemeDefault($0) }
    dict[1689466081] = { return Api.ShareTheme.parse_shareThemeEmojiBackdrop($0) }
    dict[-336796051] = { return Api.ShareTheme.parse_shareThemeGift($0) }
    dict[2109703795] = { return Api.SponsoredMessage.parse_sponsoredMessage($0) }
    dict[-963180333] = { return Api.SponsoredPeer.parse_sponsoredPeer($0) }
    dict[825922887] = { return Api.StarGift.parse_starGift($0) }
    dict[-2047825459] = { return Api.StarGift.parse_starGiftUnique($0) }
    dict[-753154979] = { return Api.StarGiftActiveAuctionState.parse_starGiftActiveAuctionState($0) }
    dict[-1624963868] = { return Api.StarGiftAttribute.parse_starGiftAttributeBackdrop($0) }
    dict[1448235490] = { return Api.StarGiftAttribute.parse_starGiftAttributeModel($0) }
    dict[-524291476] = { return Api.StarGiftAttribute.parse_starGiftAttributeOriginalDetails($0) }
    dict[1315997162] = { return Api.StarGiftAttribute.parse_starGiftAttributePattern($0) }
    dict[783398488] = { return Api.StarGiftAttributeCounter.parse_starGiftAttributeCounter($0) }
    dict[520210263] = { return Api.StarGiftAttributeId.parse_starGiftAttributeIdBackdrop($0) }
    dict[1219145276] = { return Api.StarGiftAttributeId.parse_starGiftAttributeIdModel($0) }
    dict[1242965043] = { return Api.StarGiftAttributeId.parse_starGiftAttributeIdPattern($0) }
    dict[910391095] = { return Api.StarGiftAttributeRarity.parse_starGiftAttributeRarity($0) }
    dict[2029777832] = { return Api.StarGiftAttributeRarity.parse_starGiftAttributeRarityEpic($0) }
    dict[-822614104] = { return Api.StarGiftAttributeRarity.parse_starGiftAttributeRarityLegendary($0) }
    dict[-259174037] = { return Api.StarGiftAttributeRarity.parse_starGiftAttributeRarityRare($0) }
    dict[-607231095] = { return Api.StarGiftAttributeRarity.parse_starGiftAttributeRarityUncommon($0) }
    dict[1118831432] = { return Api.StarGiftAuctionAcquiredGift.parse_starGiftAuctionAcquiredGift($0) }
    dict[984483112] = { return Api.StarGiftAuctionRound.parse_starGiftAuctionRound($0) }
    dict[178266597] = { return Api.StarGiftAuctionRound.parse_starGiftAuctionRoundExtendable($0) }
    dict[1998212710] = { return Api.StarGiftAuctionState.parse_starGiftAuctionState($0) }
    dict[-1758614593] = { return Api.StarGiftAuctionState.parse_starGiftAuctionStateFinished($0) }
    dict[-30197422] = { return Api.StarGiftAuctionState.parse_starGiftAuctionStateNotModified($0) }
    dict[787403204] = { return Api.StarGiftAuctionUserState.parse_starGiftAuctionUserState($0) }
    dict[-1342872680] = { return Api.StarGiftBackground.parse_starGiftBackground($0) }
    dict[-586389774] = { return Api.StarRefProgram.parse_starRefProgram($0) }
    dict[-1145654109] = { return Api.StarsAmount.parse_starsAmount($0) }
    dict[1957618656] = { return Api.StarsAmount.parse_starsTonAmount($0) }
    dict[453922567] = { return Api.StarsRating.parse_starsRating($0) }
    dict[-21080943] = { return Api.StarsRevenueStatus.parse_starsRevenueStatus($0) }
    dict[779004698] = { return Api.StarsSubscription.parse_starsSubscription($0) }
    dict[88173912] = { return Api.StarsSubscriptionPricing.parse_starsSubscriptionPricing($0) }
    dict[325426864] = { return Api.StarsTransaction.parse_starsTransaction($0) }
    dict[-670195363] = { return Api.StarsTransactionPeer.parse_starsTransactionPeer($0) }
    dict[-110658899] = { return Api.StarsTransactionPeer.parse_starsTransactionPeerAPI($0) }
    dict[1617438738] = { return Api.StarsTransactionPeer.parse_starsTransactionPeerAds($0) }
    dict[-1269320843] = { return Api.StarsTransactionPeer.parse_starsTransactionPeerAppStore($0) }
    dict[-382740222] = { return Api.StarsTransactionPeer.parse_starsTransactionPeerFragment($0) }
    dict[2069236235] = { return Api.StarsTransactionPeer.parse_starsTransactionPeerPlayMarket($0) }
    dict[621656824] = { return Api.StarsTransactionPeer.parse_starsTransactionPeerPremiumBot($0) }
    dict[-1779253276] = { return Api.StarsTransactionPeer.parse_starsTransactionPeerUnsupported($0) }
    dict[-50416996] = { return Api.StickerKeyword.parse_stickerKeyword($0) }
    dict[313694676] = { return Api.StickerPack.parse_stickerPack($0) }
    dict[768691932] = { return Api.StickerSet.parse_stickerSet($0) }
    dict[1678812626] = { return Api.StickerSetCovered.parse_stickerSetCovered($0) }
    dict[1087454222] = { return Api.StickerSetCovered.parse_stickerSetFullCovered($0) }
    dict[872932635] = { return Api.StickerSetCovered.parse_stickerSetMultiCovered($0) }
    dict[2008112412] = { return Api.StickerSetCovered.parse_stickerSetNoCovered($0) }
    dict[1898850301] = { return Api.StoriesStealthMode.parse_storiesStealthMode($0) }
    dict[-1205411504] = { return Api.StoryFwdHeader.parse_storyFwdHeader($0) }
    dict[379894076] = { return Api.StoryItem.parse_storyItem($0) }
    dict[1374088783] = { return Api.StoryItem.parse_storyItemDeleted($0) }
    dict[-5388013] = { return Api.StoryItem.parse_storyItemSkipped($0) }
    dict[1620104917] = { return Api.StoryReaction.parse_storyReaction($0) }
    dict[-1146411453] = { return Api.StoryReaction.parse_storyReactionPublicForward($0) }
    dict[-808644845] = { return Api.StoryReaction.parse_storyReactionPublicRepost($0) }
    dict[-1329730875] = { return Api.StoryView.parse_storyView($0) }
    dict[-1870436597] = { return Api.StoryView.parse_storyViewPublicForward($0) }
    dict[-1116418231] = { return Api.StoryView.parse_storyViewPublicRepost($0) }
    dict[-1923523370] = { return Api.StoryViews.parse_storyViews($0) }
    dict[244201445] = { return Api.SuggestedPost.parse_suggestedPost($0) }
    dict[1964978502] = { return Api.TextWithEntities.parse_textWithEntities($0) }
    dict[-1609668650] = { return Api.Theme.parse_theme($0) }
    dict[-94849324] = { return Api.ThemeSettings.parse_themeSettings($0) }
    dict[572241380] = { return Api.TodoCompletion.parse_todoCompletion($0) }
    dict[-878074577] = { return Api.TodoItem.parse_todoItem($0) }
    dict[1236871718] = { return Api.TodoList.parse_todoList($0) }
    dict[304255588] = { return Api.TonConnectManifest.parse_tonConnectManifest($0) }
    dict[308631238] = { return Api.TonConnectSession.parse_tonConnectSession($0) }
    dict[-305282981] = { return Api.TopPeer.parse_topPeer($0) }
    dict[-39945236] = { return Api.TopPeerCategory.parse_topPeerCategoryBotsApp($0) }
    dict[1814361053] = { return Api.TopPeerCategory.parse_topPeerCategoryBotsGuestChat($0) }
    dict[344356834] = { return Api.TopPeerCategory.parse_topPeerCategoryBotsInline($0) }
    dict[-1419371685] = { return Api.TopPeerCategory.parse_topPeerCategoryBotsPM($0) }
    dict[371037736] = { return Api.TopPeerCategory.parse_topPeerCategoryChannels($0) }
    dict[104314861] = { return Api.TopPeerCategory.parse_topPeerCategoryCorrespondents($0) }
    dict[-68239120] = { return Api.TopPeerCategory.parse_topPeerCategoryForwardChats($0) }
    dict[-1472172887] = { return Api.TopPeerCategory.parse_topPeerCategoryForwardUsers($0) }
    dict[-1122524854] = { return Api.TopPeerCategory.parse_topPeerCategoryGroups($0) }
    dict[511092620] = { return Api.TopPeerCategory.parse_topPeerCategoryPhoneCalls($0) }
    dict[-75283823] = { return Api.TopPeerCategoryPeers.parse_topPeerCategoryPeers($0) }
    dict[-1945136645] = { return Api.Update.parse_updateAiComposeTones($0) }
    dict[397910539] = { return Api.Update.parse_updateAttachMenuBots($0) }
    dict[-335171433] = { return Api.Update.parse_updateAutoSaveSettings($0) }
    dict[-1964652166] = { return Api.Update.parse_updateBotBusinessConnect($0) }
    dict[-1177566067] = { return Api.Update.parse_updateBotCallbackQuery($0) }
    dict[-1873947492] = { return Api.Update.parse_updateBotChatBoost($0) }
    dict[2092125561] = { return Api.Update.parse_updateBotChatInviteRequester($0) }
    dict[1299263278] = { return Api.Update.parse_updateBotCommands($0) }
    dict[-1607821266] = { return Api.Update.parse_updateBotDeleteBusinessMessage($0) }
    dict[132077692] = { return Api.Update.parse_updateBotEditBusinessMessage($0) }
    dict[-841742019] = { return Api.Update.parse_updateBotGuestChatQuery($0) }
    dict[1232025500] = { return Api.Update.parse_updateBotInlineQuery($0) }
    dict[317794823] = { return Api.Update.parse_updateBotInlineSend($0) }
    dict[347625491] = { return Api.Update.parse_updateBotMenuButton($0) }
    dict[-1407069234] = { return Api.Update.parse_updateBotMessageReaction($0) }
    dict[164329305] = { return Api.Update.parse_updateBotMessageReactions($0) }
    dict[-1646578564] = { return Api.Update.parse_updateBotNewBusinessMessage($0) }
    dict[-1934976362] = { return Api.Update.parse_updateBotPrecheckoutQuery($0) }
    dict[675009298] = { return Api.Update.parse_updateBotPurchasedPaidMedia($0) }
    dict[-1246823043] = { return Api.Update.parse_updateBotShippingQuery($0) }
    dict[1812827683] = { return Api.Update.parse_updateBotStarsSubscription($0) }
    dict[-997782967] = { return Api.Update.parse_updateBotStopped($0) }
    dict[-2095595325] = { return Api.Update.parse_updateBotWebhookJSON($0) }
    dict[-1684914010] = { return Api.Update.parse_updateBotWebhookJSONQuery($0) }
    dict[-91635977] = { return Api.Update.parse_updateBotWidgetCopyQuery($0) }
    dict[-1284243864] = { return Api.Update.parse_updateBotWidgetQuery($0) }
    dict[513998247] = { return Api.Update.parse_updateBusinessBotCallbackQuery($0) }
    dict[1666927625] = { return Api.Update.parse_updateChannel($0) }
    dict[-1304443240] = { return Api.Update.parse_updateChannelAvailableMessages($0) }
    dict[-761649164] = { return Api.Update.parse_updateChannelMessageForwards($0) }
    dict[-232346616] = { return Api.Update.parse_updateChannelMessageViews($0) }
    dict[-1738720581] = { return Api.Update.parse_updateChannelParticipant($0) }
    dict[636691703] = { return Api.Update.parse_updateChannelReadMessagesContents($0) }
    dict[277713951] = { return Api.Update.parse_updateChannelTooLong($0) }
    dict[-1937192669] = { return Api.Update.parse_updateChannelUserTyping($0) }
    dict[129403168] = { return Api.Update.parse_updateChannelViewForumAsMessages($0) }
    dict[791390623] = { return Api.Update.parse_updateChannelWebPage($0) }
    dict[-124097970] = { return Api.Update.parse_updateChat($0) }
    dict[1421875280] = { return Api.Update.parse_updateChatDefaultBannedRights($0) }
    dict[-796432838] = { return Api.Update.parse_updateChatParticipant($0) }
    dict[1037718609] = { return Api.Update.parse_updateChatParticipantAdd($0) }
    dict[-674602590] = { return Api.Update.parse_updateChatParticipantAdmin($0) }
    dict[-483443337] = { return Api.Update.parse_updateChatParticipantDelete($0) }
    dict[-1115461703] = { return Api.Update.parse_updateChatParticipantRank($0) }
    dict[125178264] = { return Api.Update.parse_updateChatParticipants($0) }
    dict[-2092401936] = { return Api.Update.parse_updateChatUserTyping($0) }
    dict[-1574314746] = { return Api.Update.parse_updateConfig($0) }
    dict[1887741886] = { return Api.Update.parse_updateContactsReset($0) }
    dict[-1906403213] = { return Api.Update.parse_updateDcOptions($0) }
    dict[-1020437742] = { return Api.Update.parse_updateDeleteChannelMessages($0) }
    dict[1457257720] = { return Api.Update.parse_updateDeleteEphemeralMessages($0) }
    dict[1048963372] = { return Api.Update.parse_updateDeleteGroupCallMessages($0) }
    dict[-1576161051] = { return Api.Update.parse_updateDeleteMessages($0) }
    dict[1407644140] = { return Api.Update.parse_updateDeleteQuickReply($0) }
    dict[1450174413] = { return Api.Update.parse_updateDeleteQuickReplyMessages($0) }
    dict[-223929981] = { return Api.Update.parse_updateDeleteScheduledMessages($0) }
    dict[654302845] = { return Api.Update.parse_updateDialogFilter($0) }
    dict[-1512627963] = { return Api.Update.parse_updateDialogFilterOrder($0) }
    dict[889491791] = { return Api.Update.parse_updateDialogFilters($0) }
    dict[1852826908] = { return Api.Update.parse_updateDialogPinned($0) }
    dict[-1235684802] = { return Api.Update.parse_updateDialogUnreadMark($0) }
    dict[-302247650] = { return Api.Update.parse_updateDraftMessage($0) }
    dict[457133559] = { return Api.Update.parse_updateEditChannelMessage($0) }
    dict[1270583041] = { return Api.Update.parse_updateEditEphemeralMessage($0) }
    dict[593913436] = { return Api.Update.parse_updateEditForumTopic($0) }
    dict[-469536605] = { return Api.Update.parse_updateEditMessage($0) }
    dict[-73640838] = { return Api.Update.parse_updateEmojiGameInfo($0) }
    dict[386986326] = { return Api.Update.parse_updateEncryptedChatTyping($0) }
    dict[956179895] = { return Api.Update.parse_updateEncryptedMessagesRead($0) }
    dict[-1264392051] = { return Api.Update.parse_updateEncryption($0) }
    dict[2081454550] = { return Api.Update.parse_updateEphemeralBotCallbackQuery($0) }
    dict[-451831443] = { return Api.Update.parse_updateFavedStickers($0) }
    dict[422972864] = { return Api.Update.parse_updateFolderPeers($0) }
    dict[-2027964103] = { return Api.Update.parse_updateGeoLiveViewed($0) }
    dict[-1658710304] = { return Api.Update.parse_updateGroupCall($0) }
    dict[-1535694705] = { return Api.Update.parse_updateGroupCallChainBlocks($0) }
    dict[192428418] = { return Api.Update.parse_updateGroupCallConnection($0) }
    dict[-917002394] = { return Api.Update.parse_updateGroupCallEncryptedMessage($0) }
    dict[-667783411] = { return Api.Update.parse_updateGroupCallMessage($0) }
    dict[-219423922] = { return Api.Update.parse_updateGroupCallParticipants($0) }
    dict[1763610706] = { return Api.Update.parse_updateInlineBotCallbackQuery($0) }
    dict[-1510965752] = { return Api.Update.parse_updateInlineBotWidgetQuery($0) }
    dict[-1112768912] = { return Api.Update.parse_updateJoinChatWebViewDecision($0) }
    dict[1442983757] = { return Api.Update.parse_updateLangPack($0) }
    dict[1180041828] = { return Api.Update.parse_updateLangPackTooLong($0) }
    dict[1448076945] = { return Api.Update.parse_updateLoginToken($0) }
    dict[1216408986] = { return Api.Update.parse_updateManagedBot($0) }
    dict[-710666460] = { return Api.Update.parse_updateMessageExtendedMedia($0) }
    dict[1318109142] = { return Api.Update.parse_updateMessageID($0) }
    dict[-699641301] = { return Api.Update.parse_updateMessagePoll($0) }
    dict[1989799956] = { return Api.Update.parse_updateMessagePollVote($0) }
    dict[506035194] = { return Api.Update.parse_updateMessageReactions($0) }
    dict[-1146062627] = { return Api.Update.parse_updateMessageWidgetData($0) }
    dict[-1618924792] = { return Api.Update.parse_updateMonoForumNoPaidException($0) }
    dict[-2030252155] = { return Api.Update.parse_updateMoveStickerSetToTop($0) }
    dict[-1991136273] = { return Api.Update.parse_updateNewAuthorization($0) }
    dict[-1306491994] = { return Api.Update.parse_updateNewBotConnection($0) }
    dict[1656358105] = { return Api.Update.parse_updateNewChannelMessage($0) }
    dict[314359194] = { return Api.Update.parse_updateNewEncryptedMessage($0) }
    dict[549239713] = { return Api.Update.parse_updateNewEphemeralMessage($0) }
    dict[522914557] = { return Api.Update.parse_updateNewMessage($0) }
    dict[-180508905] = { return Api.Update.parse_updateNewQuickReply($0) }
    dict[967122427] = { return Api.Update.parse_updateNewScheduledMessage($0) }
    dict[1753886890] = { return Api.Update.parse_updateNewStickerSet($0) }
    dict[405070859] = { return Api.Update.parse_updateNewStoryReaction($0) }
    dict[-1094555409] = { return Api.Update.parse_updateNotifySettings($0) }
    dict[-1955438642] = { return Api.Update.parse_updatePaidReactionPrivacy($0) }
    dict[-337610926] = { return Api.Update.parse_updatePeerBlocked($0) }
    dict[-1147422299] = { return Api.Update.parse_updatePeerHistoryTTL($0) }
    dict[-1263546448] = { return Api.Update.parse_updatePeerLocated($0) }
    dict[1786671974] = { return Api.Update.parse_updatePeerSettings($0) }
    dict[-1371598819] = { return Api.Update.parse_updatePeerWallpaper($0) }
    dict[1885586395] = { return Api.Update.parse_updatePendingJoinRequests($0) }
    dict[-1425052898] = { return Api.Update.parse_updatePhoneCall($0) }
    dict[643940105] = { return Api.Update.parse_updatePhoneCallSignalingData($0) }
    dict[1538885128] = { return Api.Update.parse_updatePinnedChannelMessages($0) }
    dict[-99664734] = { return Api.Update.parse_updatePinnedDialogs($0) }
    dict[1748708434] = { return Api.Update.parse_updatePinnedForumTopic($0) }
    dict[-554613808] = { return Api.Update.parse_updatePinnedForumTopics($0) }
    dict[-309990731] = { return Api.Update.parse_updatePinnedMessages($0) }
    dict[1751942566] = { return Api.Update.parse_updatePinnedSavedDialogs($0) }
    dict[-298113238] = { return Api.Update.parse_updatePrivacy($0) }
    dict[861169551] = { return Api.Update.parse_updatePtsChanged($0) }
    dict[-112784718] = { return Api.Update.parse_updateQuickReplies($0) }
    dict[1040518415] = { return Api.Update.parse_updateQuickReplyMessage($0) }
    dict[-693004986] = { return Api.Update.parse_updateReadChannelDiscussionInbox($0) }
    dict[1767677564] = { return Api.Update.parse_updateReadChannelDiscussionOutbox($0) }
    dict[-1842450928] = { return Api.Update.parse_updateReadChannelInbox($0) }
    dict[-1218471511] = { return Api.Update.parse_updateReadChannelOutbox($0) }
    dict[-78886548] = { return Api.Update.parse_updateReadFeaturedEmojiStickers($0) }
    dict[1461528386] = { return Api.Update.parse_updateReadFeaturedStickers($0) }
    dict[-1635468135] = { return Api.Update.parse_updateReadHistoryInbox($0) }
    dict[791617983] = { return Api.Update.parse_updateReadHistoryOutbox($0) }
    dict[-131960447] = { return Api.Update.parse_updateReadMessagesContents($0) }
    dict[2008081266] = { return Api.Update.parse_updateReadMonoForumInbox($0) }
    dict[-1532521610] = { return Api.Update.parse_updateReadMonoForumOutbox($0) }
    dict[-145845461] = { return Api.Update.parse_updateReadStories($0) }
    dict[821314523] = { return Api.Update.parse_updateRecentEmojiStatuses($0) }
    dict[1870160884] = { return Api.Update.parse_updateRecentReactions($0) }
    dict[-1706939360] = { return Api.Update.parse_updateRecentStickers($0) }
    dict[-1364222348] = { return Api.Update.parse_updateSavedDialogPinned($0) }
    dict[-1821035490] = { return Api.Update.parse_updateSavedGifs($0) }
    dict[969307186] = { return Api.Update.parse_updateSavedReactionTags($0) }
    dict[1960361625] = { return Api.Update.parse_updateSavedRingtones($0) }
    dict[1347068303] = { return Api.Update.parse_updateSentPhoneCode($0) }
    dict[2103604867] = { return Api.Update.parse_updateSentStoryReaction($0) }
    dict[-1320989366] = { return Api.Update.parse_updateSentWalletTransaction($0) }
    dict[-337352679] = { return Api.Update.parse_updateServiceNotification($0) }
    dict[-245208620] = { return Api.Update.parse_updateSmsJob($0) }
    dict[1222788802] = { return Api.Update.parse_updateStarGiftAuctionState($0) }
    dict[-598150370] = { return Api.Update.parse_updateStarGiftAuctionUserState($0) }
    dict[-1408818108] = { return Api.Update.parse_updateStarGiftCraftFail($0) }
    dict[1317053305] = { return Api.Update.parse_updateStarsBalance($0) }
    dict[-1518030823] = { return Api.Update.parse_updateStarsRevenueStatus($0) }
    dict[834816008] = { return Api.Update.parse_updateStickerSets($0) }
    dict[196268545] = { return Api.Update.parse_updateStickerSetsOrder($0) }
    dict[738741697] = { return Api.Update.parse_updateStoriesStealthMode($0) }
    dict[1974712216] = { return Api.Update.parse_updateStory($0) }
    dict[468923833] = { return Api.Update.parse_updateStoryID($0) }
    dict[-2112423005] = { return Api.Update.parse_updateTheme($0) }
    dict[8703322] = { return Api.Update.parse_updateTranscribedAudio($0) }
    dict[1934372475] = { return Api.Update.parse_updateTranscribedAudioFile($0) }
    dict[542282808] = { return Api.Update.parse_updateUser($0) }
    dict[674706841] = { return Api.Update.parse_updateUserEmojiStatus($0) }
    dict[-1484486364] = { return Api.Update.parse_updateUserName($0) }
    dict[88680979] = { return Api.Update.parse_updateUserPhone($0) }
    dict[-440534818] = { return Api.Update.parse_updateUserStatus($0) }
    dict[706199388] = { return Api.Update.parse_updateUserTyping($0) }
    dict[-1464984404] = { return Api.Update.parse_updateWalletGaslessInfo($0) }
    dict[1791226538] = { return Api.Update.parse_updateWalletState($0) }
    dict[-772898407] = { return Api.Update.parse_updateWalletTonConnectPendingDisconnect($0) }
    dict[1352896014] = { return Api.Update.parse_updateWalletTonConnectSession($0) }
    dict[335872721] = { return Api.Update.parse_updateWebBrowserException($0) }
    dict[-1013306658] = { return Api.Update.parse_updateWebBrowserSettings($0) }
    dict[2139689491] = { return Api.Update.parse_updateWebPage($0) }
    dict[361936797] = { return Api.Update.parse_updateWebViewResultSent($0) }
    dict[2027216577] = { return Api.Updates.parse_updateShort($0) }
    dict[1299050149] = { return Api.Updates.parse_updateShortChatMessage($0) }
    dict[826001400] = { return Api.Updates.parse_updateShortMessage($0) }
    dict[-1877614335] = { return Api.Updates.parse_updateShortSentMessage($0) }
    dict[1957577280] = { return Api.Updates.parse_updates($0) }
    dict[1918567619] = { return Api.Updates.parse_updatesCombined($0) }
    dict[-484987010] = { return Api.Updates.parse_updatesTooLong($0) }
    dict[-1313289085] = { return Api.User.parse_user($0) }
    dict[-742634630] = { return Api.User.parse_userEmpty($0) }
    dict[-1190384899] = { return Api.UserFull.parse_userFull($0) }
    dict[-2100168954] = { return Api.UserProfilePhoto.parse_userProfilePhoto($0) }
    dict[1326562017] = { return Api.UserProfilePhoto.parse_userProfilePhotoEmpty($0) }
    dict[164646985] = { return Api.UserStatus.parse_userStatusEmpty($0) }
    dict[1703516023] = { return Api.UserStatus.parse_userStatusLastMonth($0) }
    dict[1410997530] = { return Api.UserStatus.parse_userStatusLastWeek($0) }
    dict[9203775] = { return Api.UserStatus.parse_userStatusOffline($0) }
    dict[-306628279] = { return Api.UserStatus.parse_userStatusOnline($0) }
    dict[2065268168] = { return Api.UserStatus.parse_userStatusRecently($0) }
    dict[1162684215] = { return Api.UserWallet.parse_userWallet($0) }
    dict[-1274595769] = { return Api.Username.parse_username($0) }
    dict[-567037804] = { return Api.VideoSize.parse_videoSize($0) }
    dict[-128171716] = { return Api.VideoSize.parse_videoSizeEmojiMarkup($0) }
    dict[228623102] = { return Api.VideoSize.parse_videoSizeStickerMarkup($0) }
    dict[-1539849235] = { return Api.WallPaper.parse_wallPaper($0) }
    dict[-528465642] = { return Api.WallPaper.parse_wallPaperNoFile($0) }
    dict[925826256] = { return Api.WallPaperSettings.parse_wallPaperSettings($0) }
    dict[-1782238101] = { return Api.WalletState.parse_walletState($0) }
    dict[-1665551636] = { return Api.WalletState.parse_walletStateEmpty($0) }
    dict[-1792163517] = { return Api.WalletTransaction.parse_walletTransaction($0) }
    dict[103596476] = { return Api.WalletTransactionPeer.parse_walletTransactionPeerAddress($0) }
    dict[1424428081] = { return Api.WalletTransactionPeer.parse_walletTransactionPeerChannel($0) }
    dict[-443213714] = { return Api.WalletTransactionPeer.parse_walletTransactionPeerOnramp($0) }
    dict[-193817447] = { return Api.WalletTransactionPeer.parse_walletTransactionPeerTelegramGift($0) }
    dict[1921772890] = { return Api.WalletTransactionPeer.parse_walletTransactionPeerUnsupported($0) }
    dict[-722833299] = { return Api.WalletTransactionPeer.parse_walletTransactionPeerUser($0) }
    dict[475467473] = { return Api.WebDocument.parse_webDocument($0) }
    dict[-104284986] = { return Api.WebDocument.parse_webDocumentNoProxy($0) }
    dict[-1824741993] = { return Api.WebDomainException.parse_webDomainException($0) }
    dict[-392411726] = { return Api.WebPage.parse_webPage($0) }
    dict[555358088] = { return Api.WebPage.parse_webPageEmpty($0) }
    dict[1930545681] = { return Api.WebPage.parse_webPageNotModified($0) }
    dict[-1328464313] = { return Api.WebPage.parse_webPagePending($0) }
    dict[2005007896] = { return Api.WebPageAttribute.parse_webPageAttributeAiComposeTone($0) }
    dict[29770178] = { return Api.WebPageAttribute.parse_webPageAttributeStarGiftAuction($0) }
    dict[835375875] = { return Api.WebPageAttribute.parse_webPageAttributeStarGiftCollection($0) }
    dict[1355547603] = { return Api.WebPageAttribute.parse_webPageAttributeStickerSet($0) }
    dict[781501415] = { return Api.WebPageAttribute.parse_webPageAttributeStory($0) }
    dict[1421174295] = { return Api.WebPageAttribute.parse_webPageAttributeTheme($0) }
    dict[-814781000] = { return Api.WebPageAttribute.parse_webPageAttributeUniqueStarGift($0) }
    dict[383307531] = { return Api.WidgetQueryType.parse_widgetQueryTypeData($0) }
    dict[-12897356] = { return Api.WidgetQueryType.parse_widgetQueryTypeSentTransaction($0) }
    dict[421545948] = { return Api.WidgetQueryType.parse_widgetQueryTypeSignData($0) }
    dict[1279133341] = { return Api.account.AutoSaveSettings.parse_autoSaveSettings($0) }
    dict[-331111727] = { return Api.account.BusinessChatLinks.parse_businessChatLinks($0) }
    dict[-1106673293] = { return Api.account.ChatThemes.parse_chatThemes($0) }
    dict[-535699004] = { return Api.account.ChatThemes.parse_chatThemesNotModified($0) }
    dict[1352683077] = { return Api.account.PrivacyRules.parse_privacyRules($0) }
    dict[-1708937439] = { return Api.account.ResolvedBusinessChatLinks.parse_resolvedBusinessChatLinks($0) }
    dict[782418132] = { return Api.auth.Authorization.parse_authorization($0) }
    dict[1148485274] = { return Api.auth.Authorization.parse_authorizationSignUpRequired($0) }
    dict[1948046307] = { return Api.auth.CodeType.parse_codeTypeCall($0) }
    dict[577556219] = { return Api.auth.CodeType.parse_codeTypeFlashCall($0) }
    dict[116234636] = { return Api.auth.CodeType.parse_codeTypeFragmentSms($0) }
    dict[-702884114] = { return Api.auth.CodeType.parse_codeTypeMissedCall($0) }
    dict[1923290508] = { return Api.auth.CodeType.parse_codeTypeSms($0) }
    dict[1577067778] = { return Api.auth.SentCode.parse_sentCode($0) }
    dict[-125665601] = { return Api.auth.SentCode.parse_sentCodePaymentRequired($0) }
    dict[596704836] = { return Api.auth.SentCode.parse_sentCodeSuccess($0) }
    dict[1035688326] = { return Api.auth.SentCodeType.parse_sentCodeTypeApp($0) }
    dict[1398007207] = { return Api.auth.SentCodeType.parse_sentCodeTypeCall($0) }
    dict[-196020837] = { return Api.auth.SentCodeType.parse_sentCodeTypeEmailCode($0) }
    dict[10475318] = { return Api.auth.SentCodeType.parse_sentCodeTypeFirebaseSms($0) }
    dict[-1425815847] = { return Api.auth.SentCodeType.parse_sentCodeTypeFlashCall($0) }
    dict[-648651719] = { return Api.auth.SentCodeType.parse_sentCodeTypeFragmentSms($0) }
    dict[-2113903484] = { return Api.auth.SentCodeType.parse_sentCodeTypeMissedCall($0) }
    dict[-1521934870] = { return Api.auth.SentCodeType.parse_sentCodeTypeSetUpEmailRequired($0) }
    dict[-1073693790] = { return Api.auth.SentCodeType.parse_sentCodeTypeSms($0) }
    dict[-1284008785] = { return Api.auth.SentCodeType.parse_sentCodeTypeSmsPhrase($0) }
    dict[-1542017919] = { return Api.auth.SentCodeType.parse_sentCodeTypeSmsWord($0) }
    dict[-309659827] = { return Api.channels.AdminLogResults.parse_adminLogResults($0) }
    dict[-541588713] = { return Api.channels.ChannelParticipant.parse_channelParticipant($0) }
    dict[-1699676497] = { return Api.channels.ChannelParticipants.parse_channelParticipants($0) }
    dict[-266911767] = { return Api.channels.ChannelParticipants.parse_channelParticipantsNotModified($0) }
    dict[-191450938] = { return Api.channels.SendAsPeers.parse_sendAsPeers($0) }
    dict[-250687953] = { return Api.chatlists.ChatlistInvite.parse_chatlistInvite($0) }
    dict[-91752871] = { return Api.chatlists.ChatlistInvite.parse_chatlistInviteAlready($0) }
    dict[-1816295539] = { return Api.chatlists.ChatlistUpdates.parse_chatlistUpdates($0) }
    dict[279670215] = { return Api.chatlists.ExportedInvites.parse_exportedInvites($0) }
    dict[-1921494742] = { return Api.communities.ParticipantJoinedChats.parse_participantJoinedChats($0) }
    dict[574926765] = { return Api.communities.PeerLinkRequests.parse_peerLinkRequests($0) }
    dict[182326673] = { return Api.contacts.Blocked.parse_blocked($0) }
    dict[-513392236] = { return Api.contacts.Blocked.parse_blockedSlice($0) }
    dict[-1290580579] = { return Api.contacts.Found.parse_found($0) }
    dict[2131196633] = { return Api.contacts.ResolvedPeer.parse_resolvedPeer($0) }
    dict[-352114556] = { return Api.contacts.SponsoredPeers.parse_sponsoredPeers($0) }
    dict[-365775695] = { return Api.contacts.SponsoredPeers.parse_sponsoredPeersEmpty($0) }
    dict[1891070632] = { return Api.contacts.TopPeers.parse_topPeers($0) }
    dict[-1255369827] = { return Api.contacts.TopPeers.parse_topPeersDisabled($0) }
    dict[-567906571] = { return Api.contacts.TopPeers.parse_topPeersNotModified($0) }
    dict[145021050] = { return Api.help.PromoData.parse_promoData($0) }
    dict[-1728664459] = { return Api.help.PromoData.parse_promoDataEmpty($0) }
    dict[235081943] = { return Api.help.RecentMeUrls.parse_recentMeUrls($0) }
    dict[2013922064] = { return Api.help.TermsOfService.parse_termsOfService($0) }
    dict[-438840932] = { return Api.messages.ChatFull.parse_chatFull($0) }
    dict[1694474197] = { return Api.messages.Chats.parse_chats($0) }
    dict[-1663561404] = { return Api.messages.Chats.parse_chatsSlice($0) }
    dict[364538944] = { return Api.messages.Dialogs.parse_dialogs($0) }
    dict[-253500010] = { return Api.messages.Dialogs.parse_dialogsNotModified($0) }
    dict[1910543603] = { return Api.messages.Dialogs.parse_dialogsSlice($0) }
    dict[-1506535550] = { return Api.messages.DiscussionMessage.parse_discussionMessage($0) }
    dict[1155883043] = { return Api.messages.EmojiGameInfo.parse_emojiGameDiceInfo($0) }
    dict[1508266805] = { return Api.messages.EmojiGameInfo.parse_emojiGameUnavailable($0) }
    dict[-634726841] = { return Api.messages.EmojiGameOutcome.parse_emojiGameOutcome($0) }
    dict[913709011] = { return Api.messages.ForumTopics.parse_forumTopics($0) }
    dict[-1456996667] = { return Api.messages.InactiveChats.parse_inactiveChats($0) }
    dict[834488621] = { return Api.messages.MessageReactionsList.parse_messageReactionsList($0) }
    dict[-1228606141] = { return Api.messages.MessageViews.parse_messageViews($0) }
    dict[-948520370] = { return Api.messages.Messages.parse_channelMessages($0) }
    dict[494135274] = { return Api.messages.Messages.parse_messages($0) }
    dict[1951620897] = { return Api.messages.Messages.parse_messagesNotModified($0) }
    dict[1595959062] = { return Api.messages.Messages.parse_messagesSlice($0) }
    dict[863093588] = { return Api.messages.PeerDialogs.parse_peerDialogs($0) }
    dict[1753266509] = { return Api.messages.PeerSettings.parse_peerSettings($0) }
    dict[-963811691] = { return Api.messages.QuickReplies.parse_quickReplies($0) }
    dict[1603398491] = { return Api.messages.QuickReplies.parse_quickRepliesNotModified($0) }
    dict[-130358751] = { return Api.messages.SavedDialogs.parse_savedDialogs($0) }
    dict[-1071681560] = { return Api.messages.SavedDialogs.parse_savedDialogsNotModified($0) }
    dict[1153080793] = { return Api.messages.SavedDialogs.parse_savedDialogsSlice($0) }
    dict[343859772] = { return Api.messages.SearchResultsCalendar.parse_searchResultsCalendar($0) }
    dict[-2464403] = { return Api.messages.SponsoredMessages.parse_sponsoredMessages($0) }
    dict[406407439] = { return Api.messages.SponsoredMessages.parse_sponsoredMessagesEmpty($0) }
    dict[1846886166] = { return Api.messages.StickerSet.parse_stickerSet($0) }
    dict[-738646805] = { return Api.messages.StickerSet.parse_stickerSetNotModified($0) }
    dict[1218005070] = { return Api.messages.VotesList.parse_votesList($0) }
    dict[-44166467] = { return Api.messages.WebPage.parse_webPage($0) }
    dict[-1936029524] = { return Api.messages.WebPagePreview.parse_webPagePreview($0) }
    dict[-342343793] = { return Api.payments.CheckedGiftCode.parse_checkedGiftCode($0) }
    dict[-1803939105] = { return Api.payments.ResaleStarGifts.parse_resaleStarGifts($0) }
    dict[-1779201615] = { return Api.payments.SavedStarGifts.parse_savedStarGifts($0) }
    dict[-1359565892] = { return Api.payments.StarGiftActiveAuctions.parse_starGiftActiveAuctions($0) }
    dict[-617358640] = { return Api.payments.StarGiftActiveAuctions.parse_starGiftActiveAuctionsNotModified($0) }
    dict[2103169520] = { return Api.payments.StarGiftAuctionAcquiredGifts.parse_starGiftAuctionAcquiredGifts($0) }
    dict[1798960364] = { return Api.payments.StarGiftAuctionState.parse_starGiftAuctionState($0) }
    dict[785918357] = { return Api.payments.StarGifts.parse_starGifts($0) }
    dict[-1551326360] = { return Api.payments.StarGifts.parse_starGiftsNotModified($0) }
    dict[1822222573] = { return Api.payments.StarsStatus.parse_starsStatus($0) }
    dict[1097619176] = { return Api.payments.UniqueStarGift.parse_uniqueStarGift($0) }
    dict[-1636664659] = { return Api.phone.GroupCall.parse_groupCall($0) }
    dict[-1658995418] = { return Api.phone.GroupCallStars.parse_groupCallStars($0) }
    dict[-193506890] = { return Api.phone.GroupParticipants.parse_groupParticipants($0) }
    dict[-1343921601] = { return Api.phone.JoinAsPeers.parse_joinAsPeers($0) }
    dict[-1696454430] = { return Api.premium.MyBoosts.parse_myBoosts($0) }
    dict[-1828487648] = { return Api.stats.PublicForwards.parse_publicForwards($0) }
    dict[1862033025] = { return Api.stories.AllStories.parse_allStories($0) }
    dict[291044926] = { return Api.stories.AllStories.parse_allStoriesNotModified($0) }
    dict[-488736969] = { return Api.stories.FoundStories.parse_foundStories($0) }
    dict[-890861720] = { return Api.stories.PeerStories.parse_peerStories($0) }
    dict[1673780490] = { return Api.stories.Stories.parse_stories($0) }
    dict[-1436583780] = { return Api.stories.StoryReactionsList.parse_storyReactionsList($0) }
    dict[1507299269] = { return Api.stories.StoryViewsList.parse_storyViewsList($0) }
    dict[543450958] = { return Api.updates.ChannelDifference.parse_channelDifference($0) }
    dict[1041346555] = { return Api.updates.ChannelDifference.parse_channelDifferenceEmpty($0) }
    dict[-1531132162] = { return Api.updates.ChannelDifference.parse_channelDifferenceTooLong($0) }
    dict[16030880] = { return Api.updates.Difference.parse_difference($0) }
    dict[1567990072] = { return Api.updates.Difference.parse_differenceEmpty($0) }
    dict[-1459938943] = { return Api.updates.Difference.parse_differenceSlice($0) }
    dict[1258196845] = { return Api.updates.Difference.parse_differenceTooLong($0) }
    dict[-1519637954] = { return Api.updates.State.parse_state($0) }
    dict[997004590] = { return Api.users.UserFull.parse_userFull($0) }
    dict[-1898953807] = { return Api.wallet.Card.parse_card($0) }
    dict[-218035014] = { return Api.wallet.CardSticker.parse_cardSticker($0) }
    dict[1277096206] = { return Api.wallet.NftAttribute.parse_nftAttribute($0) }
    dict[389937907] = { return Api.wallet.NftItem.parse_nftItem($0) }
    dict[1126356389] = { return Api.wallet.Transactions.parse_transactions($0) }
    return dict
}()

extension Api {
    static func parse(_ buffer: Buffer) -> Any? {
        let reader = BufferReader(buffer)
        if let signature = reader.readInt32() {
            return parse(reader, signature: signature)
        }
        return nil
    }

    static func knowsSignature(_ signature: Int32) -> Swift.Bool {
        return parsers[signature] != nil
    }

    static func parse(_ reader: BufferReader, signature: Int32) -> Any? {
        if let parser = parsers[signature] {
            return parser(reader)
        } else {
            telegramApiLog("Type constructor \(String(UInt32(bitPattern: signature), radix: 16, uppercase: false)) not found")
            return nil
        }
    }

    static func parseVector<T>(_ reader: BufferReader, elementSignature: Int32, elementType: T.Type) -> [T]? {
        if let count = reader.readInt32() {
            var array = [T]()
            var i: Int32 = 0
            while i < count {
                var signature = elementSignature
                if elementSignature == 0 {
                    if let unboxedSignature = reader.readInt32() {
                        signature = unboxedSignature
                    } else {
                        return nil
                    }
                }
                if elementType == Buffer.self {
                    if let item = parseBytes(reader) as? T {
                        array.append(item)
                    } else {
                        return nil
                    }
                } else {
                    if let item = Api.parse(reader, signature: signature) as? T {
                        array.append(item)
                    } else {
                        return nil
                    }
                }
                i += 1
            }
            return array
        }
        return nil
    }
    static func serializeObject(_ object: Any, buffer: Buffer, boxed: Swift.Bool) {
        switch object {
        case let _1 as Api.AuctionBidLevel:
            _1.serialize(buffer, boxed)
        case let _1 as Api.AutoSaveException:
            _1.serialize(buffer, boxed)
        case let _1 as Api.AutoSaveSettings:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BaseTheme:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Birthday:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Bool:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Boost:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BotApp:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BotAppSettings:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BotBusinessConnection:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BotCommand:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BotInfo:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BotMenuButton:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BotVerification:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BotVerifierSettings:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BusinessAwayMessage:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BusinessAwayMessageSchedule:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BusinessBotRights:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BusinessChatLink:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BusinessGreetingMessage:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BusinessIntro:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BusinessLocation:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BusinessRecipients:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BusinessWeeklyOpen:
            _1.serialize(buffer, boxed)
        case let _1 as Api.BusinessWorkHours:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ButtonType:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ChannelAdminLogEvent:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ChannelAdminLogEventAction:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ChannelLocation:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ChannelParticipant:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Chat:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ChatAdminRights:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ChatBannedRights:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ChatFull:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ChatInvite:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ChatParticipant:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ChatParticipants:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ChatPhoto:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ChatReactions:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ChatTheme:
            _1.serialize(buffer, boxed)
        case let _1 as Api.CommunityPeer:
            _1.serialize(buffer, boxed)
        case let _1 as Api.CommunityPeerRequest:
            _1.serialize(buffer, boxed)
        case let _1 as Api.DataJSON:
            _1.serialize(buffer, boxed)
        case let _1 as Api.DcOption:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Dialog:
            _1.serialize(buffer, boxed)
        case let _1 as Api.DialogFilter:
            _1.serialize(buffer, boxed)
        case let _1 as Api.DialogPeer:
            _1.serialize(buffer, boxed)
        case let _1 as Api.DisallowedGiftsSettings:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Document:
            _1.serialize(buffer, boxed)
        case let _1 as Api.DocumentAttribute:
            _1.serialize(buffer, boxed)
        case let _1 as Api.DraftMessage:
            _1.serialize(buffer, boxed)
        case let _1 as Api.EmojiStatus:
            _1.serialize(buffer, boxed)
        case let _1 as Api.EncryptedChat:
            _1.serialize(buffer, boxed)
        case let _1 as Api.EncryptedFile:
            _1.serialize(buffer, boxed)
        case let _1 as Api.EncryptedMessage:
            _1.serialize(buffer, boxed)
        case let _1 as Api.EphemeralMessage:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ExportedChatInvite:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ExportedChatlistInvite:
            _1.serialize(buffer, boxed)
        case let _1 as Api.FactCheck:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Folder:
            _1.serialize(buffer, boxed)
        case let _1 as Api.FolderPeer:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ForumTopic:
            _1.serialize(buffer, boxed)
        case let _1 as Api.FoundStory:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Game:
            _1.serialize(buffer, boxed)
        case let _1 as Api.GeoPoint:
            _1.serialize(buffer, boxed)
        case let _1 as Api.GeoPointAddress:
            _1.serialize(buffer, boxed)
        case let _1 as Api.GroupCall:
            _1.serialize(buffer, boxed)
        case let _1 as Api.GroupCallDonor:
            _1.serialize(buffer, boxed)
        case let _1 as Api.GroupCallMessage:
            _1.serialize(buffer, boxed)
        case let _1 as Api.GroupCallParticipant:
            _1.serialize(buffer, boxed)
        case let _1 as Api.GroupCallParticipantVideo:
            _1.serialize(buffer, boxed)
        case let _1 as Api.GroupCallParticipantVideoSourceGroup:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InlineButtonType:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InlineQueryPeerType:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputBotInlineMessageID:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputChannel:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputDocument:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputFile:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputGame:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputGeoPoint:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputGroupCall:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputMedia:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputPeer:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputPhoto:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputQuickReplyShortcut:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputReplyTo:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputRichFile:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputRichMessage:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputSavedStarGift:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputStickerSet:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputUser:
            _1.serialize(buffer, boxed)
        case let _1 as Api.InputWebDocument:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Invoice:
            _1.serialize(buffer, boxed)
        case let _1 as Api.JoinChatBotResult:
            _1.serialize(buffer, boxed)
        case let _1 as Api.KeyboardButton:
            _1.serialize(buffer, boxed)
        case let _1 as Api.KeyboardButtonRow:
            _1.serialize(buffer, boxed)
        case let _1 as Api.KeyboardButtonStyle:
            _1.serialize(buffer, boxed)
        case let _1 as Api.KeyboardInlineButton:
            _1.serialize(buffer, boxed)
        case let _1 as Api.KeyboardInlineButtonRow:
            _1.serialize(buffer, boxed)
        case let _1 as Api.LabeledPrice:
            _1.serialize(buffer, boxed)
        case let _1 as Api.LangPackDifference:
            _1.serialize(buffer, boxed)
        case let _1 as Api.LangPackString:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MaskCoords:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MediaArea:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MediaAreaCoordinates:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Message:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MessageAction:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MessageEntity:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MessageExtendedMedia:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MessageFwdHeader:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MessageMedia:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MessagePeerReaction:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MessagePeerVote:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MessageReactions:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MessageReactor:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MessageReplies:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MessageReplyHeader:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MessageViews:
            _1.serialize(buffer, boxed)
        case let _1 as Api.MyBoost:
            _1.serialize(buffer, boxed)
        case let _1 as Api.NotificationSound:
            _1.serialize(buffer, boxed)
        case let _1 as Api.NotifyPeer:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Page:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PageBlock:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PageButton:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PageCaption:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PageListItem:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PageListOrderedItem:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PageRelatedArticle:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PageTableCell:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PageTableRow:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PaidReactionPrivacy:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PaymentCharge:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PaymentRequestedInfo:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Peer:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PeerBlocked:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PeerColor:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PeerLocated:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PeerNotifySettings:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PeerSettings:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PeerStories:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PendingSuggestion:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PhoneCall:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PhoneCallDiscardReason:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PhoneCallProtocol:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PhoneConnection:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Photo:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PhotoSize:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Poll:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PollAnswer:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PollAnswerVoters:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PollResults:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PostAddress:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PrivacyKey:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PrivacyRule:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ProfileTab:
            _1.serialize(buffer, boxed)
        case let _1 as Api.PublicForward:
            _1.serialize(buffer, boxed)
        case let _1 as Api.QuickReply:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Reaction:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ReactionCount:
            _1.serialize(buffer, boxed)
        case let _1 as Api.RecentMeUrl:
            _1.serialize(buffer, boxed)
        case let _1 as Api.RecentStory:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ReplyMarkup:
            _1.serialize(buffer, boxed)
        case let _1 as Api.RequestPeerType:
            _1.serialize(buffer, boxed)
        case let _1 as Api.RequestedPeer:
            _1.serialize(buffer, boxed)
        case let _1 as Api.RestrictionReason:
            _1.serialize(buffer, boxed)
        case let _1 as Api.RichButtonStyle:
            _1.serialize(buffer, boxed)
        case let _1 as Api.RichMessage:
            _1.serialize(buffer, boxed)
        case let _1 as Api.RichText:
            _1.serialize(buffer, boxed)
        case let _1 as Api.SavedDialog:
            _1.serialize(buffer, boxed)
        case let _1 as Api.SavedStarGift:
            _1.serialize(buffer, boxed)
        case let _1 as Api.SearchPostsFlood:
            _1.serialize(buffer, boxed)
        case let _1 as Api.SearchResultsCalendarPeriod:
            _1.serialize(buffer, boxed)
        case let _1 as Api.SecureCredentialsEncrypted:
            _1.serialize(buffer, boxed)
        case let _1 as Api.SecureData:
            _1.serialize(buffer, boxed)
        case let _1 as Api.SecureFile:
            _1.serialize(buffer, boxed)
        case let _1 as Api.SecurePlainData:
            _1.serialize(buffer, boxed)
        case let _1 as Api.SecureValue:
            _1.serialize(buffer, boxed)
        case let _1 as Api.SecureValueType:
            _1.serialize(buffer, boxed)
        case let _1 as Api.SendAsPeer:
            _1.serialize(buffer, boxed)
        case let _1 as Api.SendMessageAction:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ShareTheme:
            _1.serialize(buffer, boxed)
        case let _1 as Api.SponsoredMessage:
            _1.serialize(buffer, boxed)
        case let _1 as Api.SponsoredPeer:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarGift:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarGiftActiveAuctionState:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarGiftAttribute:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarGiftAttributeCounter:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarGiftAttributeId:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarGiftAttributeRarity:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarGiftAuctionAcquiredGift:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarGiftAuctionRound:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarGiftAuctionState:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarGiftAuctionUserState:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarGiftBackground:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarRefProgram:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarsAmount:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarsRating:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarsRevenueStatus:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarsSubscription:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarsSubscriptionPricing:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarsTransaction:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StarsTransactionPeer:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StickerKeyword:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StickerPack:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StickerSet:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StickerSetCovered:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StoriesStealthMode:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StoryFwdHeader:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StoryItem:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StoryReaction:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StoryView:
            _1.serialize(buffer, boxed)
        case let _1 as Api.StoryViews:
            _1.serialize(buffer, boxed)
        case let _1 as Api.SuggestedPost:
            _1.serialize(buffer, boxed)
        case let _1 as Api.TextWithEntities:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Theme:
            _1.serialize(buffer, boxed)
        case let _1 as Api.ThemeSettings:
            _1.serialize(buffer, boxed)
        case let _1 as Api.TodoCompletion:
            _1.serialize(buffer, boxed)
        case let _1 as Api.TodoItem:
            _1.serialize(buffer, boxed)
        case let _1 as Api.TodoList:
            _1.serialize(buffer, boxed)
        case let _1 as Api.TonConnectManifest:
            _1.serialize(buffer, boxed)
        case let _1 as Api.TonConnectSession:
            _1.serialize(buffer, boxed)
        case let _1 as Api.TopPeer:
            _1.serialize(buffer, boxed)
        case let _1 as Api.TopPeerCategory:
            _1.serialize(buffer, boxed)
        case let _1 as Api.TopPeerCategoryPeers:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Update:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Updates:
            _1.serialize(buffer, boxed)
        case let _1 as Api.User:
            _1.serialize(buffer, boxed)
        case let _1 as Api.UserFull:
            _1.serialize(buffer, boxed)
        case let _1 as Api.UserProfilePhoto:
            _1.serialize(buffer, boxed)
        case let _1 as Api.UserStatus:
            _1.serialize(buffer, boxed)
        case let _1 as Api.UserWallet:
            _1.serialize(buffer, boxed)
        case let _1 as Api.Username:
            _1.serialize(buffer, boxed)
        case let _1 as Api.VideoSize:
            _1.serialize(buffer, boxed)
        case let _1 as Api.WallPaper:
            _1.serialize(buffer, boxed)
        case let _1 as Api.WallPaperSettings:
            _1.serialize(buffer, boxed)
        case let _1 as Api.WalletState:
            _1.serialize(buffer, boxed)
        case let _1 as Api.WalletTransaction:
            _1.serialize(buffer, boxed)
        case let _1 as Api.WalletTransactionPeer:
            _1.serialize(buffer, boxed)
        case let _1 as Api.WebDocument:
            _1.serialize(buffer, boxed)
        case let _1 as Api.WebDomainException:
            _1.serialize(buffer, boxed)
        case let _1 as Api.WebPage:
            _1.serialize(buffer, boxed)
        case let _1 as Api.WebPageAttribute:
            _1.serialize(buffer, boxed)
        case let _1 as Api.WidgetQueryType:
            _1.serialize(buffer, boxed)
        case let _1 as Api.account.AutoSaveSettings:
            _1.serialize(buffer, boxed)
        case let _1 as Api.account.BusinessChatLinks:
            _1.serialize(buffer, boxed)
        case let _1 as Api.account.ChatThemes:
            _1.serialize(buffer, boxed)
        case let _1 as Api.account.PrivacyRules:
            _1.serialize(buffer, boxed)
        case let _1 as Api.account.ResolvedBusinessChatLinks:
            _1.serialize(buffer, boxed)
        case let _1 as Api.auth.Authorization:
            _1.serialize(buffer, boxed)
        case let _1 as Api.auth.CodeType:
            _1.serialize(buffer, boxed)
        case let _1 as Api.auth.SentCode:
            _1.serialize(buffer, boxed)
        case let _1 as Api.auth.SentCodeType:
            _1.serialize(buffer, boxed)
        case let _1 as Api.channels.AdminLogResults:
            _1.serialize(buffer, boxed)
        case let _1 as Api.channels.ChannelParticipant:
            _1.serialize(buffer, boxed)
        case let _1 as Api.channels.ChannelParticipants:
            _1.serialize(buffer, boxed)
        case let _1 as Api.channels.SendAsPeers:
            _1.serialize(buffer, boxed)
        case let _1 as Api.chatlists.ChatlistInvite:
            _1.serialize(buffer, boxed)
        case let _1 as Api.chatlists.ChatlistUpdates:
            _1.serialize(buffer, boxed)
        case let _1 as Api.chatlists.ExportedInvites:
            _1.serialize(buffer, boxed)
        case let _1 as Api.communities.ParticipantJoinedChats:
            _1.serialize(buffer, boxed)
        case let _1 as Api.communities.PeerLinkRequests:
            _1.serialize(buffer, boxed)
        case let _1 as Api.contacts.Blocked:
            _1.serialize(buffer, boxed)
        case let _1 as Api.contacts.Found:
            _1.serialize(buffer, boxed)
        case let _1 as Api.contacts.ResolvedPeer:
            _1.serialize(buffer, boxed)
        case let _1 as Api.contacts.SponsoredPeers:
            _1.serialize(buffer, boxed)
        case let _1 as Api.contacts.TopPeers:
            _1.serialize(buffer, boxed)
        case let _1 as Api.help.PromoData:
            _1.serialize(buffer, boxed)
        case let _1 as Api.help.RecentMeUrls:
            _1.serialize(buffer, boxed)
        case let _1 as Api.help.TermsOfService:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.ChatFull:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.Chats:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.Dialogs:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.DiscussionMessage:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.EmojiGameInfo:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.EmojiGameOutcome:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.ForumTopics:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.InactiveChats:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.MessageReactionsList:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.MessageViews:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.Messages:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.PeerDialogs:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.PeerSettings:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.QuickReplies:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.SavedDialogs:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.SearchResultsCalendar:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.SponsoredMessages:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.StickerSet:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.VotesList:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.WebPage:
            _1.serialize(buffer, boxed)
        case let _1 as Api.messages.WebPagePreview:
            _1.serialize(buffer, boxed)
        case let _1 as Api.payments.CheckedGiftCode:
            _1.serialize(buffer, boxed)
        case let _1 as Api.payments.ResaleStarGifts:
            _1.serialize(buffer, boxed)
        case let _1 as Api.payments.SavedStarGifts:
            _1.serialize(buffer, boxed)
        case let _1 as Api.payments.StarGiftActiveAuctions:
            _1.serialize(buffer, boxed)
        case let _1 as Api.payments.StarGiftAuctionAcquiredGifts:
            _1.serialize(buffer, boxed)
        case let _1 as Api.payments.StarGiftAuctionState:
            _1.serialize(buffer, boxed)
        case let _1 as Api.payments.StarGifts:
            _1.serialize(buffer, boxed)
        case let _1 as Api.payments.StarsStatus:
            _1.serialize(buffer, boxed)
        case let _1 as Api.payments.UniqueStarGift:
            _1.serialize(buffer, boxed)
        case let _1 as Api.phone.GroupCall:
            _1.serialize(buffer, boxed)
        case let _1 as Api.phone.GroupCallStars:
            _1.serialize(buffer, boxed)
        case let _1 as Api.phone.GroupParticipants:
            _1.serialize(buffer, boxed)
        case let _1 as Api.phone.JoinAsPeers:
            _1.serialize(buffer, boxed)
        case let _1 as Api.premium.MyBoosts:
            _1.serialize(buffer, boxed)
        case let _1 as Api.stats.PublicForwards:
            _1.serialize(buffer, boxed)
        case let _1 as Api.stories.AllStories:
            _1.serialize(buffer, boxed)
        case let _1 as Api.stories.FoundStories:
            _1.serialize(buffer, boxed)
        case let _1 as Api.stories.PeerStories:
            _1.serialize(buffer, boxed)
        case let _1 as Api.stories.Stories:
            _1.serialize(buffer, boxed)
        case let _1 as Api.stories.StoryReactionsList:
            _1.serialize(buffer, boxed)
        case let _1 as Api.stories.StoryViewsList:
            _1.serialize(buffer, boxed)
        case let _1 as Api.updates.ChannelDifference:
            _1.serialize(buffer, boxed)
        case let _1 as Api.updates.Difference:
            _1.serialize(buffer, boxed)
        case let _1 as Api.updates.State:
            _1.serialize(buffer, boxed)
        case let _1 as Api.users.UserFull:
            _1.serialize(buffer, boxed)
        case let _1 as Api.wallet.Card:
            _1.serialize(buffer, boxed)
        case let _1 as Api.wallet.CardSticker:
            _1.serialize(buffer, boxed)
        case let _1 as Api.wallet.NftAttribute:
            _1.serialize(buffer, boxed)
        case let _1 as Api.wallet.NftItem:
            _1.serialize(buffer, boxed)
        case let _1 as Api.wallet.Transactions:
            _1.serialize(buffer, boxed)
        default:
            break
        }
    }
}
