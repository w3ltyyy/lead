extension Api {
    indirect enum Update: TypeConstructorDescription {
        class Cons_updateBotBusinessConnect: TypeConstructorDescription {
            var connection: Api.BotBusinessConnection
            var qts: Int32
            init(connection: Api.BotBusinessConnection, qts: Int32) {
                self.connection = connection
                self.qts = qts
            }
        }
        class Cons_updateBotCallbackQuery: TypeConstructorDescription {
            var flags: Int32
            var queryId: Int64
            var userId: Int64
            var peer: Api.Peer
            var msgId: Int32
            var chatInstance: Int64
            var data: Buffer?
            var gameShortName: String?
            init(flags: Int32, queryId: Int64, userId: Int64, peer: Api.Peer, msgId: Int32, chatInstance: Int64, data: Buffer?, gameShortName: String?) {
                self.flags = flags
                self.queryId = queryId
                self.userId = userId
                self.peer = peer
                self.msgId = msgId
                self.chatInstance = chatInstance
                self.data = data
                self.gameShortName = gameShortName
            }
        }
        class Cons_updateBotChatBoost: TypeConstructorDescription {
            var peer: Api.Peer
            var boost: Api.Boost
            var qts: Int32
            init(peer: Api.Peer, boost: Api.Boost, qts: Int32) {
                self.peer = peer
                self.boost = boost
                self.qts = qts
            }
        }
        class Cons_updateBotChatInviteRequester: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var date: Int32
            var userId: Int64
            var about: String
            var invite: Api.ExportedChatInvite
            var qts: Int32
            var queryId: Int64?
            init(flags: Int32, peer: Api.Peer, date: Int32, userId: Int64, about: String, invite: Api.ExportedChatInvite, qts: Int32, queryId: Int64?) {
                self.flags = flags
                self.peer = peer
                self.date = date
                self.userId = userId
                self.about = about
                self.invite = invite
                self.qts = qts
                self.queryId = queryId
            }
        }
        class Cons_updateBotCommands: TypeConstructorDescription {
            var peer: Api.Peer
            var botId: Int64
            var commands: [Api.BotCommand]
            init(peer: Api.Peer, botId: Int64, commands: [Api.BotCommand]) {
                self.peer = peer
                self.botId = botId
                self.commands = commands
            }
        }
        class Cons_updateBotDeleteBusinessMessage: TypeConstructorDescription {
            var connectionId: String
            var peer: Api.Peer
            var messages: [Int32]
            var qts: Int32
            init(connectionId: String, peer: Api.Peer, messages: [Int32], qts: Int32) {
                self.connectionId = connectionId
                self.peer = peer
                self.messages = messages
                self.qts = qts
            }
        }
        class Cons_updateBotEditBusinessMessage: TypeConstructorDescription {
            var flags: Int32
            var connectionId: String
            var message: Api.Message
            var replyToMessage: Api.Message?
            var qts: Int32
            init(flags: Int32, connectionId: String, message: Api.Message, replyToMessage: Api.Message?, qts: Int32) {
                self.flags = flags
                self.connectionId = connectionId
                self.message = message
                self.replyToMessage = replyToMessage
                self.qts = qts
            }
        }
        class Cons_updateBotGuestChatQuery: TypeConstructorDescription {
            var flags: Int32
            var queryId: Int64
            var message: Api.Message
            var referenceMessages: [Api.Message]?
            var qts: Int32
            init(flags: Int32, queryId: Int64, message: Api.Message, referenceMessages: [Api.Message]?, qts: Int32) {
                self.flags = flags
                self.queryId = queryId
                self.message = message
                self.referenceMessages = referenceMessages
                self.qts = qts
            }
        }
        class Cons_updateBotInlineQuery: TypeConstructorDescription {
            var flags: Int32
            var queryId: Int64
            var userId: Int64
            var query: String
            var geo: Api.GeoPoint?
            var peerType: Api.InlineQueryPeerType?
            var offset: String
            init(flags: Int32, queryId: Int64, userId: Int64, query: String, geo: Api.GeoPoint?, peerType: Api.InlineQueryPeerType?, offset: String) {
                self.flags = flags
                self.queryId = queryId
                self.userId = userId
                self.query = query
                self.geo = geo
                self.peerType = peerType
                self.offset = offset
            }
        }
        class Cons_updateBotInlineSend: TypeConstructorDescription {
            var flags: Int32
            var userId: Int64
            var query: String
            var geo: Api.GeoPoint?
            var id: String
            var msgId: Api.InputBotInlineMessageID?
            init(flags: Int32, userId: Int64, query: String, geo: Api.GeoPoint?, id: String, msgId: Api.InputBotInlineMessageID?) {
                self.flags = flags
                self.userId = userId
                self.query = query
                self.geo = geo
                self.id = id
                self.msgId = msgId
            }
        }
        class Cons_updateBotMenuButton: TypeConstructorDescription {
            var botId: Int64
            var button: Api.BotMenuButton
            init(botId: Int64, button: Api.BotMenuButton) {
                self.botId = botId
                self.button = button
            }
        }
        class Cons_updateBotMessageReaction: TypeConstructorDescription {
            var peer: Api.Peer
            var msgId: Int32
            var date: Int32
            var actor: Api.Peer
            var oldReactions: [Api.Reaction]
            var newReactions: [Api.Reaction]
            var qts: Int32
            init(peer: Api.Peer, msgId: Int32, date: Int32, actor: Api.Peer, oldReactions: [Api.Reaction], newReactions: [Api.Reaction], qts: Int32) {
                self.peer = peer
                self.msgId = msgId
                self.date = date
                self.actor = actor
                self.oldReactions = oldReactions
                self.newReactions = newReactions
                self.qts = qts
            }
        }
        class Cons_updateBotMessageReactions: TypeConstructorDescription {
            var peer: Api.Peer
            var msgId: Int32
            var date: Int32
            var reactions: [Api.ReactionCount]
            var qts: Int32
            init(peer: Api.Peer, msgId: Int32, date: Int32, reactions: [Api.ReactionCount], qts: Int32) {
                self.peer = peer
                self.msgId = msgId
                self.date = date
                self.reactions = reactions
                self.qts = qts
            }
        }
        class Cons_updateBotNewBusinessMessage: TypeConstructorDescription {
            var flags: Int32
            var connectionId: String
            var message: Api.Message
            var replyToMessage: Api.Message?
            var qts: Int32
            init(flags: Int32, connectionId: String, message: Api.Message, replyToMessage: Api.Message?, qts: Int32) {
                self.flags = flags
                self.connectionId = connectionId
                self.message = message
                self.replyToMessage = replyToMessage
                self.qts = qts
            }
        }
        class Cons_updateBotPrecheckoutQuery: TypeConstructorDescription {
            var flags: Int32
            var queryId: Int64
            var userId: Int64
            var payload: Buffer
            var info: Api.PaymentRequestedInfo?
            var shippingOptionId: String?
            var currency: String
            var totalAmount: Int64
            init(flags: Int32, queryId: Int64, userId: Int64, payload: Buffer, info: Api.PaymentRequestedInfo?, shippingOptionId: String?, currency: String, totalAmount: Int64) {
                self.flags = flags
                self.queryId = queryId
                self.userId = userId
                self.payload = payload
                self.info = info
                self.shippingOptionId = shippingOptionId
                self.currency = currency
                self.totalAmount = totalAmount
            }
        }
        class Cons_updateBotPurchasedPaidMedia: TypeConstructorDescription {
            var userId: Int64
            var payload: String
            var qts: Int32
            init(userId: Int64, payload: String, qts: Int32) {
                self.userId = userId
                self.payload = payload
                self.qts = qts
            }
        }
        class Cons_updateBotShippingQuery: TypeConstructorDescription {
            var queryId: Int64
            var userId: Int64
            var payload: Buffer
            var shippingAddress: Api.PostAddress
            init(queryId: Int64, userId: Int64, payload: Buffer, shippingAddress: Api.PostAddress) {
                self.queryId = queryId
                self.userId = userId
                self.payload = payload
                self.shippingAddress = shippingAddress
            }
        }
        class Cons_updateBotStarsSubscription: TypeConstructorDescription {
            var flags: Int32
            var userId: Int64
            var payload: Buffer
            var qts: Int32
            init(flags: Int32, userId: Int64, payload: Buffer, qts: Int32) {
                self.flags = flags
                self.userId = userId
                self.payload = payload
                self.qts = qts
            }
        }
        class Cons_updateBotStopped: TypeConstructorDescription {
            var userId: Int64
            var date: Int32
            var stopped: Api.Bool
            var qts: Int32
            init(userId: Int64, date: Int32, stopped: Api.Bool, qts: Int32) {
                self.userId = userId
                self.date = date
                self.stopped = stopped
                self.qts = qts
            }
        }
        class Cons_updateBotWebhookJSON: TypeConstructorDescription {
            var data: Api.DataJSON
            init(data: Api.DataJSON) {
                self.data = data
            }
        }
        class Cons_updateBotWebhookJSONQuery: TypeConstructorDescription {
            var queryId: Int64
            var data: Api.DataJSON
            var timeout: Int32
            init(queryId: Int64, data: Api.DataJSON, timeout: Int32) {
                self.queryId = queryId
                self.data = data
                self.timeout = timeout
            }
        }
        class Cons_updateBotWidgetCopyQuery: TypeConstructorDescription {
            var flags: Int32
            var queryId: Int64
            var queryType: Api.WidgetQueryType
            var userId: Int64
            var data: Buffer
            var widgetId: Int64
            var walletCard: Api.wallet.Card?
            init(flags: Int32, queryId: Int64, queryType: Api.WidgetQueryType, userId: Int64, data: Buffer, widgetId: Int64, walletCard: Api.wallet.Card?) {
                self.flags = flags
                self.queryId = queryId
                self.queryType = queryType
                self.userId = userId
                self.data = data
                self.widgetId = widgetId
                self.walletCard = walletCard
            }
        }
        class Cons_updateBotWidgetQuery: TypeConstructorDescription {
            var flags: Int32
            var queryId: Int64
            var queryType: Api.WidgetQueryType
            var userId: Int64
            var peer: Api.Peer
            var msgId: Int32
            var chatInstance: Int64
            var chatType: String
            var data: Buffer
            var widgetId: Int64?
            var walletCard: Api.wallet.Card?
            init(flags: Int32, queryId: Int64, queryType: Api.WidgetQueryType, userId: Int64, peer: Api.Peer, msgId: Int32, chatInstance: Int64, chatType: String, data: Buffer, widgetId: Int64?, walletCard: Api.wallet.Card?) {
                self.flags = flags
                self.queryId = queryId
                self.queryType = queryType
                self.userId = userId
                self.peer = peer
                self.msgId = msgId
                self.chatInstance = chatInstance
                self.chatType = chatType
                self.data = data
                self.widgetId = widgetId
                self.walletCard = walletCard
            }
        }
        class Cons_updateBusinessBotCallbackQuery: TypeConstructorDescription {
            var flags: Int32
            var queryId: Int64
            var userId: Int64
            var connectionId: String
            var message: Api.Message
            var replyToMessage: Api.Message?
            var chatInstance: Int64
            var data: Buffer?
            init(flags: Int32, queryId: Int64, userId: Int64, connectionId: String, message: Api.Message, replyToMessage: Api.Message?, chatInstance: Int64, data: Buffer?) {
                self.flags = flags
                self.queryId = queryId
                self.userId = userId
                self.connectionId = connectionId
                self.message = message
                self.replyToMessage = replyToMessage
                self.chatInstance = chatInstance
                self.data = data
            }
        }
        class Cons_updateChannel: TypeConstructorDescription {
            var channelId: Int64
            init(channelId: Int64) {
                self.channelId = channelId
            }
        }
        class Cons_updateChannelAvailableMessages: TypeConstructorDescription {
            var channelId: Int64
            var availableMinId: Int32
            init(channelId: Int64, availableMinId: Int32) {
                self.channelId = channelId
                self.availableMinId = availableMinId
            }
        }
        class Cons_updateChannelMessageForwards: TypeConstructorDescription {
            var channelId: Int64
            var id: Int32
            var forwards: Int32
            init(channelId: Int64, id: Int32, forwards: Int32) {
                self.channelId = channelId
                self.id = id
                self.forwards = forwards
            }
        }
        class Cons_updateChannelMessageViews: TypeConstructorDescription {
            var channelId: Int64
            var id: Int32
            var views: Int32
            init(channelId: Int64, id: Int32, views: Int32) {
                self.channelId = channelId
                self.id = id
                self.views = views
            }
        }
        class Cons_updateChannelParticipant: TypeConstructorDescription {
            var flags: Int32
            var channelId: Int64
            var date: Int32
            var actorId: Int64
            var userId: Int64
            var prevParticipant: Api.ChannelParticipant?
            var newParticipant: Api.ChannelParticipant?
            var invite: Api.ExportedChatInvite?
            var qts: Int32
            init(flags: Int32, channelId: Int64, date: Int32, actorId: Int64, userId: Int64, prevParticipant: Api.ChannelParticipant?, newParticipant: Api.ChannelParticipant?, invite: Api.ExportedChatInvite?, qts: Int32) {
                self.flags = flags
                self.channelId = channelId
                self.date = date
                self.actorId = actorId
                self.userId = userId
                self.prevParticipant = prevParticipant
                self.newParticipant = newParticipant
                self.invite = invite
                self.qts = qts
            }
        }
        class Cons_updateChannelReadMessagesContents: TypeConstructorDescription {
            var flags: Int32
            var channelId: Int64
            var topMsgId: Int32?
            var savedPeerId: Api.Peer?
            var messages: [Int32]
            init(flags: Int32, channelId: Int64, topMsgId: Int32?, savedPeerId: Api.Peer?, messages: [Int32]) {
                self.flags = flags
                self.channelId = channelId
                self.topMsgId = topMsgId
                self.savedPeerId = savedPeerId
                self.messages = messages
            }
        }
        class Cons_updateChannelTooLong: TypeConstructorDescription {
            var flags: Int32
            var channelId: Int64
            var pts: Int32?
            init(flags: Int32, channelId: Int64, pts: Int32?) {
                self.flags = flags
                self.channelId = channelId
                self.pts = pts
            }
        }
        class Cons_updateChannelUserTyping: TypeConstructorDescription {
            var flags: Int32
            var channelId: Int64
            var topMsgId: Int32?
            var fromId: Api.Peer
            var action: Api.SendMessageAction
            init(flags: Int32, channelId: Int64, topMsgId: Int32?, fromId: Api.Peer, action: Api.SendMessageAction) {
                self.flags = flags
                self.channelId = channelId
                self.topMsgId = topMsgId
                self.fromId = fromId
                self.action = action
            }
        }
        class Cons_updateChannelViewForumAsMessages: TypeConstructorDescription {
            var channelId: Int64
            var enabled: Api.Bool
            init(channelId: Int64, enabled: Api.Bool) {
                self.channelId = channelId
                self.enabled = enabled
            }
        }
        class Cons_updateChannelWebPage: TypeConstructorDescription {
            var channelId: Int64
            var webpage: Api.WebPage
            var pts: Int32
            var ptsCount: Int32
            init(channelId: Int64, webpage: Api.WebPage, pts: Int32, ptsCount: Int32) {
                self.channelId = channelId
                self.webpage = webpage
                self.pts = pts
                self.ptsCount = ptsCount
            }
        }
        class Cons_updateChat: TypeConstructorDescription {
            var chatId: Int64
            init(chatId: Int64) {
                self.chatId = chatId
            }
        }
        class Cons_updateChatDefaultBannedRights: TypeConstructorDescription {
            var peer: Api.Peer
            var defaultBannedRights: Api.ChatBannedRights
            var version: Int32
            init(peer: Api.Peer, defaultBannedRights: Api.ChatBannedRights, version: Int32) {
                self.peer = peer
                self.defaultBannedRights = defaultBannedRights
                self.version = version
            }
        }
        class Cons_updateChatParticipant: TypeConstructorDescription {
            var flags: Int32
            var chatId: Int64
            var date: Int32
            var actorId: Int64
            var userId: Int64
            var prevParticipant: Api.ChatParticipant?
            var newParticipant: Api.ChatParticipant?
            var invite: Api.ExportedChatInvite?
            var qts: Int32
            init(flags: Int32, chatId: Int64, date: Int32, actorId: Int64, userId: Int64, prevParticipant: Api.ChatParticipant?, newParticipant: Api.ChatParticipant?, invite: Api.ExportedChatInvite?, qts: Int32) {
                self.flags = flags
                self.chatId = chatId
                self.date = date
                self.actorId = actorId
                self.userId = userId
                self.prevParticipant = prevParticipant
                self.newParticipant = newParticipant
                self.invite = invite
                self.qts = qts
            }
        }
        class Cons_updateChatParticipantAdd: TypeConstructorDescription {
            var chatId: Int64
            var userId: Int64
            var inviterId: Int64
            var date: Int32
            var version: Int32
            init(chatId: Int64, userId: Int64, inviterId: Int64, date: Int32, version: Int32) {
                self.chatId = chatId
                self.userId = userId
                self.inviterId = inviterId
                self.date = date
                self.version = version
            }
        }
        class Cons_updateChatParticipantAdmin: TypeConstructorDescription {
            var chatId: Int64
            var userId: Int64
            var isAdmin: Api.Bool
            var version: Int32
            init(chatId: Int64, userId: Int64, isAdmin: Api.Bool, version: Int32) {
                self.chatId = chatId
                self.userId = userId
                self.isAdmin = isAdmin
                self.version = version
            }
        }
        class Cons_updateChatParticipantDelete: TypeConstructorDescription {
            var chatId: Int64
            var userId: Int64
            var version: Int32
            init(chatId: Int64, userId: Int64, version: Int32) {
                self.chatId = chatId
                self.userId = userId
                self.version = version
            }
        }
        class Cons_updateChatParticipantRank: TypeConstructorDescription {
            var chatId: Int64
            var userId: Int64
            var rank: String
            var version: Int32
            init(chatId: Int64, userId: Int64, rank: String, version: Int32) {
                self.chatId = chatId
                self.userId = userId
                self.rank = rank
                self.version = version
            }
        }
        class Cons_updateChatParticipants: TypeConstructorDescription {
            var participants: Api.ChatParticipants
            init(participants: Api.ChatParticipants) {
                self.participants = participants
            }
        }
        class Cons_updateChatUserTyping: TypeConstructorDescription {
            var chatId: Int64
            var fromId: Api.Peer
            var action: Api.SendMessageAction
            init(chatId: Int64, fromId: Api.Peer, action: Api.SendMessageAction) {
                self.chatId = chatId
                self.fromId = fromId
                self.action = action
            }
        }
        class Cons_updateDcOptions: TypeConstructorDescription {
            var dcOptions: [Api.DcOption]
            init(dcOptions: [Api.DcOption]) {
                self.dcOptions = dcOptions
            }
        }
        class Cons_updateDeleteChannelMessages: TypeConstructorDescription {
            var channelId: Int64
            var messages: [Int32]
            var pts: Int32
            var ptsCount: Int32
            init(channelId: Int64, messages: [Int32], pts: Int32, ptsCount: Int32) {
                self.channelId = channelId
                self.messages = messages
                self.pts = pts
                self.ptsCount = ptsCount
            }
        }
        class Cons_updateDeleteEphemeralMessages: TypeConstructorDescription {
            var peer: Api.Peer
            var ids: [Int32]
            init(peer: Api.Peer, ids: [Int32]) {
                self.peer = peer
                self.ids = ids
            }
        }
        class Cons_updateDeleteGroupCallMessages: TypeConstructorDescription {
            var call: Api.InputGroupCall
            var messages: [Int32]
            init(call: Api.InputGroupCall, messages: [Int32]) {
                self.call = call
                self.messages = messages
            }
        }
        class Cons_updateDeleteMessages: TypeConstructorDescription {
            var messages: [Int32]
            var pts: Int32
            var ptsCount: Int32
            init(messages: [Int32], pts: Int32, ptsCount: Int32) {
                self.messages = messages
                self.pts = pts
                self.ptsCount = ptsCount
            }
        }
        class Cons_updateDeleteQuickReply: TypeConstructorDescription {
            var shortcutId: Int32
            init(shortcutId: Int32) {
                self.shortcutId = shortcutId
            }
        }
        class Cons_updateDeleteQuickReplyMessages: TypeConstructorDescription {
            var shortcutId: Int32
            var messages: [Int32]
            init(shortcutId: Int32, messages: [Int32]) {
                self.shortcutId = shortcutId
                self.messages = messages
            }
        }
        class Cons_updateDeleteScheduledMessages: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var messages: [Int32]
            var sentMessages: [Int32]?
            init(flags: Int32, peer: Api.Peer, messages: [Int32], sentMessages: [Int32]?) {
                self.flags = flags
                self.peer = peer
                self.messages = messages
                self.sentMessages = sentMessages
            }
        }
        class Cons_updateDialogFilter: TypeConstructorDescription {
            var flags: Int32
            var id: Int32
            var filter: Api.DialogFilter?
            init(flags: Int32, id: Int32, filter: Api.DialogFilter?) {
                self.flags = flags
                self.id = id
                self.filter = filter
            }
        }
        class Cons_updateDialogFilterOrder: TypeConstructorDescription {
            var order: [Int32]
            init(order: [Int32]) {
                self.order = order
            }
        }
        class Cons_updateDialogPinned: TypeConstructorDescription {
            var flags: Int32
            var folderId: Int32?
            var peer: Api.DialogPeer
            init(flags: Int32, folderId: Int32?, peer: Api.DialogPeer) {
                self.flags = flags
                self.folderId = folderId
                self.peer = peer
            }
        }
        class Cons_updateDialogUnreadMark: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.DialogPeer
            var savedPeerId: Api.Peer?
            init(flags: Int32, peer: Api.DialogPeer, savedPeerId: Api.Peer?) {
                self.flags = flags
                self.peer = peer
                self.savedPeerId = savedPeerId
            }
        }
        class Cons_updateDraftMessage: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var topMsgId: Int32?
            var savedPeerId: Api.Peer?
            var draft: Api.DraftMessage
            init(flags: Int32, peer: Api.Peer, topMsgId: Int32?, savedPeerId: Api.Peer?, draft: Api.DraftMessage) {
                self.flags = flags
                self.peer = peer
                self.topMsgId = topMsgId
                self.savedPeerId = savedPeerId
                self.draft = draft
            }
        }
        class Cons_updateEditChannelMessage: TypeConstructorDescription {
            var message: Api.Message
            var pts: Int32
            var ptsCount: Int32
            init(message: Api.Message, pts: Int32, ptsCount: Int32) {
                self.message = message
                self.pts = pts
                self.ptsCount = ptsCount
            }
        }
        class Cons_updateEditEphemeralMessage: TypeConstructorDescription {
            var message: Api.EphemeralMessage
            init(message: Api.EphemeralMessage) {
                self.message = message
            }
        }
        class Cons_updateEditForumTopic: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var topicId: Int32
            var title: String?
            var iconEmojiId: Int64?
            var closed: Api.Bool?
            var hidden: Api.Bool?
            init(flags: Int32, peer: Api.Peer, topicId: Int32, title: String?, iconEmojiId: Int64?, closed: Api.Bool?, hidden: Api.Bool?) {
                self.flags = flags
                self.peer = peer
                self.topicId = topicId
                self.title = title
                self.iconEmojiId = iconEmojiId
                self.closed = closed
                self.hidden = hidden
            }
        }
        class Cons_updateEditMessage: TypeConstructorDescription {
            var message: Api.Message
            var pts: Int32
            var ptsCount: Int32
            init(message: Api.Message, pts: Int32, ptsCount: Int32) {
                self.message = message
                self.pts = pts
                self.ptsCount = ptsCount
            }
        }
        class Cons_updateEmojiGameInfo: TypeConstructorDescription {
            var info: Api.messages.EmojiGameInfo
            init(info: Api.messages.EmojiGameInfo) {
                self.info = info
            }
        }
        class Cons_updateEncryptedChatTyping: TypeConstructorDescription {
            var chatId: Int32
            init(chatId: Int32) {
                self.chatId = chatId
            }
        }
        class Cons_updateEncryptedMessagesRead: TypeConstructorDescription {
            var chatId: Int32
            var maxDate: Int32
            var date: Int32
            init(chatId: Int32, maxDate: Int32, date: Int32) {
                self.chatId = chatId
                self.maxDate = maxDate
                self.date = date
            }
        }
        class Cons_updateEncryption: TypeConstructorDescription {
            var chat: Api.EncryptedChat
            var date: Int32
            init(chat: Api.EncryptedChat, date: Int32) {
                self.chat = chat
                self.date = date
            }
        }
        class Cons_updateEphemeralBotCallbackQuery: TypeConstructorDescription {
            var flags: Int32
            var queryId: Int64
            var userId: Int64
            var peer: Api.Peer?
            var msgId: Int32
            var data: Buffer
            var chatInstance: Int64?
            var message: Api.EphemeralMessage
            init(flags: Int32, queryId: Int64, userId: Int64, peer: Api.Peer?, msgId: Int32, data: Buffer, chatInstance: Int64?, message: Api.EphemeralMessage) {
                self.flags = flags
                self.queryId = queryId
                self.userId = userId
                self.peer = peer
                self.msgId = msgId
                self.data = data
                self.chatInstance = chatInstance
                self.message = message
            }
        }
        class Cons_updateFolderPeers: TypeConstructorDescription {
            var folderPeers: [Api.FolderPeer]
            var pts: Int32
            var ptsCount: Int32
            init(folderPeers: [Api.FolderPeer], pts: Int32, ptsCount: Int32) {
                self.folderPeers = folderPeers
                self.pts = pts
                self.ptsCount = ptsCount
            }
        }
        class Cons_updateGeoLiveViewed: TypeConstructorDescription {
            var peer: Api.Peer
            var msgId: Int32
            init(peer: Api.Peer, msgId: Int32) {
                self.peer = peer
                self.msgId = msgId
            }
        }
        class Cons_updateGroupCall: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer?
            var call: Api.GroupCall
            init(flags: Int32, peer: Api.Peer?, call: Api.GroupCall) {
                self.flags = flags
                self.peer = peer
                self.call = call
            }
        }
        class Cons_updateGroupCallChainBlocks: TypeConstructorDescription {
            var call: Api.InputGroupCall
            var subChainId: Int32
            var blocks: [Buffer]
            var nextOffset: Int32
            init(call: Api.InputGroupCall, subChainId: Int32, blocks: [Buffer], nextOffset: Int32) {
                self.call = call
                self.subChainId = subChainId
                self.blocks = blocks
                self.nextOffset = nextOffset
            }
        }
        class Cons_updateGroupCallConnection: TypeConstructorDescription {
            var flags: Int32
            var params: Api.DataJSON
            init(flags: Int32, params: Api.DataJSON) {
                self.flags = flags
                self.params = params
            }
        }
        class Cons_updateGroupCallEncryptedMessage: TypeConstructorDescription {
            var call: Api.InputGroupCall
            var fromId: Api.Peer
            var encryptedMessage: Buffer
            init(call: Api.InputGroupCall, fromId: Api.Peer, encryptedMessage: Buffer) {
                self.call = call
                self.fromId = fromId
                self.encryptedMessage = encryptedMessage
            }
        }
        class Cons_updateGroupCallMessage: TypeConstructorDescription {
            var call: Api.InputGroupCall
            var message: Api.GroupCallMessage
            init(call: Api.InputGroupCall, message: Api.GroupCallMessage) {
                self.call = call
                self.message = message
            }
        }
        class Cons_updateGroupCallParticipants: TypeConstructorDescription {
            var call: Api.InputGroupCall
            var participants: [Api.GroupCallParticipant]
            var version: Int32
            init(call: Api.InputGroupCall, participants: [Api.GroupCallParticipant], version: Int32) {
                self.call = call
                self.participants = participants
                self.version = version
            }
        }
        class Cons_updateInlineBotCallbackQuery: TypeConstructorDescription {
            var flags: Int32
            var queryId: Int64
            var userId: Int64
            var msgId: Api.InputBotInlineMessageID
            var chatInstance: Int64
            var data: Buffer?
            var gameShortName: String?
            init(flags: Int32, queryId: Int64, userId: Int64, msgId: Api.InputBotInlineMessageID, chatInstance: Int64, data: Buffer?, gameShortName: String?) {
                self.flags = flags
                self.queryId = queryId
                self.userId = userId
                self.msgId = msgId
                self.chatInstance = chatInstance
                self.data = data
                self.gameShortName = gameShortName
            }
        }
        class Cons_updateInlineBotWidgetQuery: TypeConstructorDescription {
            var flags: Int32
            var queryId: Int64
            var queryType: Api.WidgetQueryType
            var userId: Int64
            var inlineMessageId: Api.InputBotInlineMessageID
            var chatInstance: Int64
            var chatType: String
            var data: Buffer
            var widgetId: Int64?
            var walletCard: Api.wallet.Card?
            init(flags: Int32, queryId: Int64, queryType: Api.WidgetQueryType, userId: Int64, inlineMessageId: Api.InputBotInlineMessageID, chatInstance: Int64, chatType: String, data: Buffer, widgetId: Int64?, walletCard: Api.wallet.Card?) {
                self.flags = flags
                self.queryId = queryId
                self.queryType = queryType
                self.userId = userId
                self.inlineMessageId = inlineMessageId
                self.chatInstance = chatInstance
                self.chatType = chatType
                self.data = data
                self.widgetId = widgetId
                self.walletCard = walletCard
            }
        }
        class Cons_updateJoinChatWebViewDecision: TypeConstructorDescription {
            var peer: Api.Peer
            var queryId: Int64
            var result: Api.JoinChatBotResult
            init(peer: Api.Peer, queryId: Int64, result: Api.JoinChatBotResult) {
                self.peer = peer
                self.queryId = queryId
                self.result = result
            }
        }
        class Cons_updateLangPack: TypeConstructorDescription {
            var difference: Api.LangPackDifference
            init(difference: Api.LangPackDifference) {
                self.difference = difference
            }
        }
        class Cons_updateLangPackTooLong: TypeConstructorDescription {
            var langCode: String
            init(langCode: String) {
                self.langCode = langCode
            }
        }
        class Cons_updateManagedBot: TypeConstructorDescription {
            var userId: Int64
            var botId: Int64
            var qts: Int32
            init(userId: Int64, botId: Int64, qts: Int32) {
                self.userId = userId
                self.botId = botId
                self.qts = qts
            }
        }
        class Cons_updateMessageExtendedMedia: TypeConstructorDescription {
            var peer: Api.Peer
            var msgId: Int32
            var extendedMedia: [Api.MessageExtendedMedia]
            init(peer: Api.Peer, msgId: Int32, extendedMedia: [Api.MessageExtendedMedia]) {
                self.peer = peer
                self.msgId = msgId
                self.extendedMedia = extendedMedia
            }
        }
        class Cons_updateMessageID: TypeConstructorDescription {
            var id: Int32
            var randomId: Int64
            init(id: Int32, randomId: Int64) {
                self.id = id
                self.randomId = randomId
            }
        }
        class Cons_updateMessagePoll: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer?
            var msgId: Int32?
            var topMsgId: Int32?
            var pollId: Int64
            var poll: Api.Poll?
            var results: Api.PollResults
            init(flags: Int32, peer: Api.Peer?, msgId: Int32?, topMsgId: Int32?, pollId: Int64, poll: Api.Poll?, results: Api.PollResults) {
                self.flags = flags
                self.peer = peer
                self.msgId = msgId
                self.topMsgId = topMsgId
                self.pollId = pollId
                self.poll = poll
                self.results = results
            }
        }
        class Cons_updateMessagePollVote: TypeConstructorDescription {
            var pollId: Int64
            var peer: Api.Peer
            var options: [Buffer]
            var positions: [Int32]
            var qts: Int32
            init(pollId: Int64, peer: Api.Peer, options: [Buffer], positions: [Int32], qts: Int32) {
                self.pollId = pollId
                self.peer = peer
                self.options = options
                self.positions = positions
                self.qts = qts
            }
        }
        class Cons_updateMessageReactions: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var msgId: Int32
            var topMsgId: Int32?
            var savedPeerId: Api.Peer?
            var reactions: Api.MessageReactions
            init(flags: Int32, peer: Api.Peer, msgId: Int32, topMsgId: Int32?, savedPeerId: Api.Peer?, reactions: Api.MessageReactions) {
                self.flags = flags
                self.peer = peer
                self.msgId = msgId
                self.topMsgId = topMsgId
                self.savedPeerId = savedPeerId
                self.reactions = reactions
            }
        }
        class Cons_updateMessageWidgetData: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var msgId: Int32
            var publicData: String?
            var publicDataHash: Int64?
            var chatData: String?
            var pts: Int32
            var ptsCount: Int32
            init(flags: Int32, peer: Api.Peer, msgId: Int32, publicData: String?, publicDataHash: Int64?, chatData: String?, pts: Int32, ptsCount: Int32) {
                self.flags = flags
                self.peer = peer
                self.msgId = msgId
                self.publicData = publicData
                self.publicDataHash = publicDataHash
                self.chatData = chatData
                self.pts = pts
                self.ptsCount = ptsCount
            }
        }
        class Cons_updateMonoForumNoPaidException: TypeConstructorDescription {
            var flags: Int32
            var channelId: Int64
            var savedPeerId: Api.Peer
            init(flags: Int32, channelId: Int64, savedPeerId: Api.Peer) {
                self.flags = flags
                self.channelId = channelId
                self.savedPeerId = savedPeerId
            }
        }
        class Cons_updateMoveStickerSetToTop: TypeConstructorDescription {
            var flags: Int32
            var stickerset: Int64
            init(flags: Int32, stickerset: Int64) {
                self.flags = flags
                self.stickerset = stickerset
            }
        }
        class Cons_updateNewAuthorization: TypeConstructorDescription {
            var flags: Int32
            var hash: Int64
            var date: Int32?
            var device: String?
            var location: String?
            init(flags: Int32, hash: Int64, date: Int32?, device: String?, location: String?) {
                self.flags = flags
                self.hash = hash
                self.date = date
                self.device = device
                self.location = location
            }
        }
        class Cons_updateNewBotConnection: TypeConstructorDescription {
            var flags: Int32
            var botId: Int64
            var date: Int32?
            var device: String?
            var location: String?
            init(flags: Int32, botId: Int64, date: Int32?, device: String?, location: String?) {
                self.flags = flags
                self.botId = botId
                self.date = date
                self.device = device
                self.location = location
            }
        }
        class Cons_updateNewChannelMessage: TypeConstructorDescription {
            var message: Api.Message
            var pts: Int32
            var ptsCount: Int32
            init(message: Api.Message, pts: Int32, ptsCount: Int32) {
                self.message = message
                self.pts = pts
                self.ptsCount = ptsCount
            }
        }
        class Cons_updateNewEncryptedMessage: TypeConstructorDescription {
            var message: Api.EncryptedMessage
            var qts: Int32
            init(message: Api.EncryptedMessage, qts: Int32) {
                self.message = message
                self.qts = qts
            }
        }
        class Cons_updateNewEphemeralMessage: TypeConstructorDescription {
            var message: Api.EphemeralMessage
            init(message: Api.EphemeralMessage) {
                self.message = message
            }
        }
        class Cons_updateNewMessage: TypeConstructorDescription {
            var message: Api.Message
            var pts: Int32
            var ptsCount: Int32
            init(message: Api.Message, pts: Int32, ptsCount: Int32) {
                self.message = message
                self.pts = pts
                self.ptsCount = ptsCount
            }
        }
        class Cons_updateNewQuickReply: TypeConstructorDescription {
            var quickReply: Api.QuickReply
            init(quickReply: Api.QuickReply) {
                self.quickReply = quickReply
            }
        }
        class Cons_updateNewScheduledMessage: TypeConstructorDescription {
            var message: Api.Message
            init(message: Api.Message) {
                self.message = message
            }
        }
        class Cons_updateNewStickerSet: TypeConstructorDescription {
            var stickerset: Api.messages.StickerSet
            init(stickerset: Api.messages.StickerSet) {
                self.stickerset = stickerset
            }
        }
        class Cons_updateNewStoryReaction: TypeConstructorDescription {
            var storyId: Int32
            var peer: Api.Peer
            var reaction: Api.Reaction
            init(storyId: Int32, peer: Api.Peer, reaction: Api.Reaction) {
                self.storyId = storyId
                self.peer = peer
                self.reaction = reaction
            }
        }
        class Cons_updateNotifySettings: TypeConstructorDescription {
            var peer: Api.NotifyPeer
            var notifySettings: Api.PeerNotifySettings
            init(peer: Api.NotifyPeer, notifySettings: Api.PeerNotifySettings) {
                self.peer = peer
                self.notifySettings = notifySettings
            }
        }
        class Cons_updatePaidReactionPrivacy: TypeConstructorDescription {
            var `private`: Api.PaidReactionPrivacy
            init(`private`: Api.PaidReactionPrivacy) {
                self.`private` = `private`
            }
        }
        class Cons_updatePeerBlocked: TypeConstructorDescription {
            var flags: Int32
            var peerId: Api.Peer
            init(flags: Int32, peerId: Api.Peer) {
                self.flags = flags
                self.peerId = peerId
            }
        }
        class Cons_updatePeerHistoryTTL: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var ttlPeriod: Int32?
            init(flags: Int32, peer: Api.Peer, ttlPeriod: Int32?) {
                self.flags = flags
                self.peer = peer
                self.ttlPeriod = ttlPeriod
            }
        }
        class Cons_updatePeerLocated: TypeConstructorDescription {
            var peers: [Api.PeerLocated]
            init(peers: [Api.PeerLocated]) {
                self.peers = peers
            }
        }
        class Cons_updatePeerSettings: TypeConstructorDescription {
            var peer: Api.Peer
            var settings: Api.PeerSettings
            init(peer: Api.Peer, settings: Api.PeerSettings) {
                self.peer = peer
                self.settings = settings
            }
        }
        class Cons_updatePeerWallpaper: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var wallpaper: Api.WallPaper?
            init(flags: Int32, peer: Api.Peer, wallpaper: Api.WallPaper?) {
                self.flags = flags
                self.peer = peer
                self.wallpaper = wallpaper
            }
        }
        class Cons_updatePendingJoinRequests: TypeConstructorDescription {
            var peer: Api.Peer
            var requestsPending: Int32
            var recentRequesters: [Int64]
            init(peer: Api.Peer, requestsPending: Int32, recentRequesters: [Int64]) {
                self.peer = peer
                self.requestsPending = requestsPending
                self.recentRequesters = recentRequesters
            }
        }
        class Cons_updatePhoneCall: TypeConstructorDescription {
            var phoneCall: Api.PhoneCall
            init(phoneCall: Api.PhoneCall) {
                self.phoneCall = phoneCall
            }
        }
        class Cons_updatePhoneCallSignalingData: TypeConstructorDescription {
            var phoneCallId: Int64
            var data: Buffer
            init(phoneCallId: Int64, data: Buffer) {
                self.phoneCallId = phoneCallId
                self.data = data
            }
        }
        class Cons_updatePinnedChannelMessages: TypeConstructorDescription {
            var flags: Int32
            var channelId: Int64
            var messages: [Int32]
            var pts: Int32
            var ptsCount: Int32
            init(flags: Int32, channelId: Int64, messages: [Int32], pts: Int32, ptsCount: Int32) {
                self.flags = flags
                self.channelId = channelId
                self.messages = messages
                self.pts = pts
                self.ptsCount = ptsCount
            }
        }
        class Cons_updatePinnedDialogs: TypeConstructorDescription {
            var flags: Int32
            var folderId: Int32?
            var order: [Api.DialogPeer]?
            init(flags: Int32, folderId: Int32?, order: [Api.DialogPeer]?) {
                self.flags = flags
                self.folderId = folderId
                self.order = order
            }
        }
        class Cons_updatePinnedForumTopic: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var topicId: Int32
            init(flags: Int32, peer: Api.Peer, topicId: Int32) {
                self.flags = flags
                self.peer = peer
                self.topicId = topicId
            }
        }
        class Cons_updatePinnedForumTopics: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var order: [Int32]?
            init(flags: Int32, peer: Api.Peer, order: [Int32]?) {
                self.flags = flags
                self.peer = peer
                self.order = order
            }
        }
        class Cons_updatePinnedMessages: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var messages: [Int32]
            var pts: Int32
            var ptsCount: Int32
            init(flags: Int32, peer: Api.Peer, messages: [Int32], pts: Int32, ptsCount: Int32) {
                self.flags = flags
                self.peer = peer
                self.messages = messages
                self.pts = pts
                self.ptsCount = ptsCount
            }
        }
        class Cons_updatePinnedSavedDialogs: TypeConstructorDescription {
            var flags: Int32
            var order: [Api.DialogPeer]?
            init(flags: Int32, order: [Api.DialogPeer]?) {
                self.flags = flags
                self.order = order
            }
        }
        class Cons_updatePrivacy: TypeConstructorDescription {
            var key: Api.PrivacyKey
            var rules: [Api.PrivacyRule]
            init(key: Api.PrivacyKey, rules: [Api.PrivacyRule]) {
                self.key = key
                self.rules = rules
            }
        }
        class Cons_updateQuickReplies: TypeConstructorDescription {
            var quickReplies: [Api.QuickReply]
            init(quickReplies: [Api.QuickReply]) {
                self.quickReplies = quickReplies
            }
        }
        class Cons_updateQuickReplyMessage: TypeConstructorDescription {
            var message: Api.Message
            init(message: Api.Message) {
                self.message = message
            }
        }
        class Cons_updateReadChannelDiscussionInbox: TypeConstructorDescription {
            var flags: Int32
            var channelId: Int64
            var topMsgId: Int32
            var readMaxId: Int32
            var broadcastId: Int64?
            var broadcastPost: Int32?
            init(flags: Int32, channelId: Int64, topMsgId: Int32, readMaxId: Int32, broadcastId: Int64?, broadcastPost: Int32?) {
                self.flags = flags
                self.channelId = channelId
                self.topMsgId = topMsgId
                self.readMaxId = readMaxId
                self.broadcastId = broadcastId
                self.broadcastPost = broadcastPost
            }
        }
        class Cons_updateReadChannelDiscussionOutbox: TypeConstructorDescription {
            var channelId: Int64
            var topMsgId: Int32
            var readMaxId: Int32
            init(channelId: Int64, topMsgId: Int32, readMaxId: Int32) {
                self.channelId = channelId
                self.topMsgId = topMsgId
                self.readMaxId = readMaxId
            }
        }
        class Cons_updateReadChannelInbox: TypeConstructorDescription {
            var flags: Int32
            var folderId: Int32?
            var channelId: Int64
            var maxId: Int32
            var stillUnreadCount: Int32
            var pts: Int32
            init(flags: Int32, folderId: Int32?, channelId: Int64, maxId: Int32, stillUnreadCount: Int32, pts: Int32) {
                self.flags = flags
                self.folderId = folderId
                self.channelId = channelId
                self.maxId = maxId
                self.stillUnreadCount = stillUnreadCount
                self.pts = pts
            }
        }
        class Cons_updateReadChannelOutbox: TypeConstructorDescription {
            var channelId: Int64
            var maxId: Int32
            init(channelId: Int64, maxId: Int32) {
                self.channelId = channelId
                self.maxId = maxId
            }
        }
        class Cons_updateReadHistoryInbox: TypeConstructorDescription {
            var flags: Int32
            var folderId: Int32?
            var peer: Api.Peer
            var topMsgId: Int32?
            var maxId: Int32
            var stillUnreadCount: Int32
            var pts: Int32
            var ptsCount: Int32
            init(flags: Int32, folderId: Int32?, peer: Api.Peer, topMsgId: Int32?, maxId: Int32, stillUnreadCount: Int32, pts: Int32, ptsCount: Int32) {
                self.flags = flags
                self.folderId = folderId
                self.peer = peer
                self.topMsgId = topMsgId
                self.maxId = maxId
                self.stillUnreadCount = stillUnreadCount
                self.pts = pts
                self.ptsCount = ptsCount
            }
        }
        class Cons_updateReadHistoryOutbox: TypeConstructorDescription {
            var peer: Api.Peer
            var maxId: Int32
            var pts: Int32
            var ptsCount: Int32
            init(peer: Api.Peer, maxId: Int32, pts: Int32, ptsCount: Int32) {
                self.peer = peer
                self.maxId = maxId
                self.pts = pts
                self.ptsCount = ptsCount
            }
        }
        class Cons_updateReadMessagesContents: TypeConstructorDescription {
            var flags: Int32
            var messages: [Int32]
            var pts: Int32
            var ptsCount: Int32
            var date: Int32?
            init(flags: Int32, messages: [Int32], pts: Int32, ptsCount: Int32, date: Int32?) {
                self.flags = flags
                self.messages = messages
                self.pts = pts
                self.ptsCount = ptsCount
                self.date = date
            }
        }
        class Cons_updateReadMonoForumInbox: TypeConstructorDescription {
            var channelId: Int64
            var savedPeerId: Api.Peer
            var readMaxId: Int32
            init(channelId: Int64, savedPeerId: Api.Peer, readMaxId: Int32) {
                self.channelId = channelId
                self.savedPeerId = savedPeerId
                self.readMaxId = readMaxId
            }
        }
        class Cons_updateReadMonoForumOutbox: TypeConstructorDescription {
            var channelId: Int64
            var savedPeerId: Api.Peer
            var readMaxId: Int32
            init(channelId: Int64, savedPeerId: Api.Peer, readMaxId: Int32) {
                self.channelId = channelId
                self.savedPeerId = savedPeerId
                self.readMaxId = readMaxId
            }
        }
        class Cons_updateReadStories: TypeConstructorDescription {
            var peer: Api.Peer
            var maxId: Int32
            init(peer: Api.Peer, maxId: Int32) {
                self.peer = peer
                self.maxId = maxId
            }
        }
        class Cons_updateSavedDialogPinned: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.DialogPeer
            init(flags: Int32, peer: Api.DialogPeer) {
                self.flags = flags
                self.peer = peer
            }
        }
        class Cons_updateSentPhoneCode: TypeConstructorDescription {
            var sentCode: Api.auth.SentCode
            init(sentCode: Api.auth.SentCode) {
                self.sentCode = sentCode
            }
        }
        class Cons_updateSentStoryReaction: TypeConstructorDescription {
            var peer: Api.Peer
            var storyId: Int32
            var reaction: Api.Reaction
            init(peer: Api.Peer, storyId: Int32, reaction: Api.Reaction) {
                self.peer = peer
                self.storyId = storyId
                self.reaction = reaction
            }
        }
        class Cons_updateSentWalletTransaction: TypeConstructorDescription {
            var flags: Int32
            var msgHash: String
            var transaction: Api.WalletTransaction?
            init(flags: Int32, msgHash: String, transaction: Api.WalletTransaction?) {
                self.flags = flags
                self.msgHash = msgHash
                self.transaction = transaction
            }
        }
        class Cons_updateServiceNotification: TypeConstructorDescription {
            var flags: Int32
            var inboxDate: Int32?
            var type: String
            var message: String
            var media: Api.MessageMedia
            var entities: [Api.MessageEntity]
            init(flags: Int32, inboxDate: Int32?, type: String, message: String, media: Api.MessageMedia, entities: [Api.MessageEntity]) {
                self.flags = flags
                self.inboxDate = inboxDate
                self.type = type
                self.message = message
                self.media = media
                self.entities = entities
            }
        }
        class Cons_updateSmsJob: TypeConstructorDescription {
            var jobId: String
            init(jobId: String) {
                self.jobId = jobId
            }
        }
        class Cons_updateStarGiftAuctionState: TypeConstructorDescription {
            var giftId: Int64
            var state: Api.StarGiftAuctionState
            init(giftId: Int64, state: Api.StarGiftAuctionState) {
                self.giftId = giftId
                self.state = state
            }
        }
        class Cons_updateStarGiftAuctionUserState: TypeConstructorDescription {
            var giftId: Int64
            var userState: Api.StarGiftAuctionUserState
            init(giftId: Int64, userState: Api.StarGiftAuctionUserState) {
                self.giftId = giftId
                self.userState = userState
            }
        }
        class Cons_updateStarsBalance: TypeConstructorDescription {
            var balance: Api.StarsAmount
            init(balance: Api.StarsAmount) {
                self.balance = balance
            }
        }
        class Cons_updateStarsRevenueStatus: TypeConstructorDescription {
            var peer: Api.Peer
            var status: Api.StarsRevenueStatus
            init(peer: Api.Peer, status: Api.StarsRevenueStatus) {
                self.peer = peer
                self.status = status
            }
        }
        class Cons_updateStickerSets: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        class Cons_updateStickerSetsOrder: TypeConstructorDescription {
            var flags: Int32
            var order: [Int64]
            init(flags: Int32, order: [Int64]) {
                self.flags = flags
                self.order = order
            }
        }
        class Cons_updateStoriesStealthMode: TypeConstructorDescription {
            var stealthMode: Api.StoriesStealthMode
            init(stealthMode: Api.StoriesStealthMode) {
                self.stealthMode = stealthMode
            }
        }
        class Cons_updateStory: TypeConstructorDescription {
            var peer: Api.Peer
            var story: Api.StoryItem
            init(peer: Api.Peer, story: Api.StoryItem) {
                self.peer = peer
                self.story = story
            }
        }
        class Cons_updateStoryID: TypeConstructorDescription {
            var id: Int32
            var randomId: Int64
            init(id: Int32, randomId: Int64) {
                self.id = id
                self.randomId = randomId
            }
        }
        class Cons_updateTheme: TypeConstructorDescription {
            var theme: Api.Theme
            init(theme: Api.Theme) {
                self.theme = theme
            }
        }
        class Cons_updateTranscribedAudio: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var msgId: Int32
            var transcriptionId: Int64
            var text: String
            init(flags: Int32, peer: Api.Peer, msgId: Int32, transcriptionId: Int64, text: String) {
                self.flags = flags
                self.peer = peer
                self.msgId = msgId
                self.transcriptionId = transcriptionId
                self.text = text
            }
        }
        class Cons_updateTranscribedAudioFile: TypeConstructorDescription {
            var flags: Int32
            var transcriptionId: Int64
            var text: String
            init(flags: Int32, transcriptionId: Int64, text: String) {
                self.flags = flags
                self.transcriptionId = transcriptionId
                self.text = text
            }
        }
        class Cons_updateUser: TypeConstructorDescription {
            var userId: Int64
            init(userId: Int64) {
                self.userId = userId
            }
        }
        class Cons_updateUserEmojiStatus: TypeConstructorDescription {
            var userId: Int64
            var emojiStatus: Api.EmojiStatus
            init(userId: Int64, emojiStatus: Api.EmojiStatus) {
                self.userId = userId
                self.emojiStatus = emojiStatus
            }
        }
        class Cons_updateUserName: TypeConstructorDescription {
            var userId: Int64
            var firstName: String
            var lastName: String
            var usernames: [Api.Username]
            init(userId: Int64, firstName: String, lastName: String, usernames: [Api.Username]) {
                self.userId = userId
                self.firstName = firstName
                self.lastName = lastName
                self.usernames = usernames
            }
        }
        class Cons_updateUserPhone: TypeConstructorDescription {
            var userId: Int64
            var phone: String
            init(userId: Int64, phone: String) {
                self.userId = userId
                self.phone = phone
            }
        }
        class Cons_updateUserStatus: TypeConstructorDescription {
            var userId: Int64
            var status: Api.UserStatus
            init(userId: Int64, status: Api.UserStatus) {
                self.userId = userId
                self.status = status
            }
        }
        class Cons_updateUserTyping: TypeConstructorDescription {
            var flags: Int32
            var userId: Int64
            var topMsgId: Int32?
            var action: Api.SendMessageAction
            init(flags: Int32, userId: Int64, topMsgId: Int32?, action: Api.SendMessageAction) {
                self.flags = flags
                self.userId = userId
                self.topMsgId = topMsgId
                self.action = action
            }
        }
        class Cons_updateWalletGaslessInfo: TypeConstructorDescription {
            var flags: Int32
            var left: Int32
            var resetAt: Int32
            var minAmount: Int64
            var relayerAddress: String
            init(flags: Int32, left: Int32, resetAt: Int32, minAmount: Int64, relayerAddress: String) {
                self.flags = flags
                self.left = left
                self.resetAt = resetAt
                self.minAmount = minAmount
                self.relayerAddress = relayerAddress
            }
        }
        class Cons_updateWalletState: TypeConstructorDescription {
            var state: Api.WalletState
            init(state: Api.WalletState) {
                self.state = state
            }
        }
        class Cons_updateWalletTonConnectPendingDisconnect: TypeConstructorDescription {
            var sessionIds: [Int64]
            init(sessionIds: [Int64]) {
                self.sessionIds = sessionIds
            }
        }
        class Cons_updateWalletTonConnectSession: TypeConstructorDescription {
            var session: Api.TonConnectSession
            init(session: Api.TonConnectSession) {
                self.session = session
            }
        }
        class Cons_updateWebBrowserException: TypeConstructorDescription {
            var flags: Int32
            var openExternalBrowser: Api.Bool?
            var exception: Api.WebDomainException
            init(flags: Int32, openExternalBrowser: Api.Bool?, exception: Api.WebDomainException) {
                self.flags = flags
                self.openExternalBrowser = openExternalBrowser
                self.exception = exception
            }
        }
        class Cons_updateWebBrowserSettings: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        class Cons_updateWebPage: TypeConstructorDescription {
            var webpage: Api.WebPage
            var pts: Int32
            var ptsCount: Int32
            init(webpage: Api.WebPage, pts: Int32, ptsCount: Int32) {
                self.webpage = webpage
                self.pts = pts
                self.ptsCount = ptsCount
            }
        }
        class Cons_updateWebViewResultSent: TypeConstructorDescription {
            var queryId: Int64
            init(queryId: Int64) {
                self.queryId = queryId
            }
        }
        case updateAiComposeTones
        case updateAttachMenuBots
        case updateAutoSaveSettings
        case updateBotBusinessConnect(Cons_updateBotBusinessConnect)
        case updateBotCallbackQuery(Cons_updateBotCallbackQuery)
        case updateBotChatBoost(Cons_updateBotChatBoost)
        case updateBotChatInviteRequester(Cons_updateBotChatInviteRequester)
        case updateBotCommands(Cons_updateBotCommands)
        case updateBotDeleteBusinessMessage(Cons_updateBotDeleteBusinessMessage)
        case updateBotEditBusinessMessage(Cons_updateBotEditBusinessMessage)
        case updateBotGuestChatQuery(Cons_updateBotGuestChatQuery)
        case updateBotInlineQuery(Cons_updateBotInlineQuery)
        case updateBotInlineSend(Cons_updateBotInlineSend)
        case updateBotMenuButton(Cons_updateBotMenuButton)
        case updateBotMessageReaction(Cons_updateBotMessageReaction)
        case updateBotMessageReactions(Cons_updateBotMessageReactions)
        case updateBotNewBusinessMessage(Cons_updateBotNewBusinessMessage)
        case updateBotPrecheckoutQuery(Cons_updateBotPrecheckoutQuery)
        case updateBotPurchasedPaidMedia(Cons_updateBotPurchasedPaidMedia)
        case updateBotShippingQuery(Cons_updateBotShippingQuery)
        case updateBotStarsSubscription(Cons_updateBotStarsSubscription)
        case updateBotStopped(Cons_updateBotStopped)
        case updateBotWebhookJSON(Cons_updateBotWebhookJSON)
        case updateBotWebhookJSONQuery(Cons_updateBotWebhookJSONQuery)
        case updateBotWidgetCopyQuery(Cons_updateBotWidgetCopyQuery)
        case updateBotWidgetQuery(Cons_updateBotWidgetQuery)
        case updateBusinessBotCallbackQuery(Cons_updateBusinessBotCallbackQuery)
        case updateChannel(Cons_updateChannel)
        case updateChannelAvailableMessages(Cons_updateChannelAvailableMessages)
        case updateChannelMessageForwards(Cons_updateChannelMessageForwards)
        case updateChannelMessageViews(Cons_updateChannelMessageViews)
        case updateChannelParticipant(Cons_updateChannelParticipant)
        case updateChannelReadMessagesContents(Cons_updateChannelReadMessagesContents)
        case updateChannelTooLong(Cons_updateChannelTooLong)
        case updateChannelUserTyping(Cons_updateChannelUserTyping)
        case updateChannelViewForumAsMessages(Cons_updateChannelViewForumAsMessages)
        case updateChannelWebPage(Cons_updateChannelWebPage)
        case updateChat(Cons_updateChat)
        case updateChatDefaultBannedRights(Cons_updateChatDefaultBannedRights)
        case updateChatParticipant(Cons_updateChatParticipant)
        case updateChatParticipantAdd(Cons_updateChatParticipantAdd)
        case updateChatParticipantAdmin(Cons_updateChatParticipantAdmin)
        case updateChatParticipantDelete(Cons_updateChatParticipantDelete)
        case updateChatParticipantRank(Cons_updateChatParticipantRank)
        case updateChatParticipants(Cons_updateChatParticipants)
        case updateChatUserTyping(Cons_updateChatUserTyping)
        case updateConfig
        case updateContactsReset
        case updateDcOptions(Cons_updateDcOptions)
        case updateDeleteChannelMessages(Cons_updateDeleteChannelMessages)
        case updateDeleteEphemeralMessages(Cons_updateDeleteEphemeralMessages)
        case updateDeleteGroupCallMessages(Cons_updateDeleteGroupCallMessages)
        case updateDeleteMessages(Cons_updateDeleteMessages)
        case updateDeleteQuickReply(Cons_updateDeleteQuickReply)
        case updateDeleteQuickReplyMessages(Cons_updateDeleteQuickReplyMessages)
        case updateDeleteScheduledMessages(Cons_updateDeleteScheduledMessages)
        case updateDialogFilter(Cons_updateDialogFilter)
        case updateDialogFilterOrder(Cons_updateDialogFilterOrder)
        case updateDialogFilters
        case updateDialogPinned(Cons_updateDialogPinned)
        case updateDialogUnreadMark(Cons_updateDialogUnreadMark)
        case updateDraftMessage(Cons_updateDraftMessage)
        case updateEditChannelMessage(Cons_updateEditChannelMessage)
        case updateEditEphemeralMessage(Cons_updateEditEphemeralMessage)
        case updateEditForumTopic(Cons_updateEditForumTopic)
        case updateEditMessage(Cons_updateEditMessage)
        case updateEmojiGameInfo(Cons_updateEmojiGameInfo)
        case updateEncryptedChatTyping(Cons_updateEncryptedChatTyping)
        case updateEncryptedMessagesRead(Cons_updateEncryptedMessagesRead)
        case updateEncryption(Cons_updateEncryption)
        case updateEphemeralBotCallbackQuery(Cons_updateEphemeralBotCallbackQuery)
        case updateFavedStickers
        case updateFolderPeers(Cons_updateFolderPeers)
        case updateGeoLiveViewed(Cons_updateGeoLiveViewed)
        case updateGroupCall(Cons_updateGroupCall)
        case updateGroupCallChainBlocks(Cons_updateGroupCallChainBlocks)
        case updateGroupCallConnection(Cons_updateGroupCallConnection)
        case updateGroupCallEncryptedMessage(Cons_updateGroupCallEncryptedMessage)
        case updateGroupCallMessage(Cons_updateGroupCallMessage)
        case updateGroupCallParticipants(Cons_updateGroupCallParticipants)
        case updateInlineBotCallbackQuery(Cons_updateInlineBotCallbackQuery)
        case updateInlineBotWidgetQuery(Cons_updateInlineBotWidgetQuery)
        case updateJoinChatWebViewDecision(Cons_updateJoinChatWebViewDecision)
        case updateLangPack(Cons_updateLangPack)
        case updateLangPackTooLong(Cons_updateLangPackTooLong)
        case updateLoginToken
        case updateManagedBot(Cons_updateManagedBot)
        case updateMessageExtendedMedia(Cons_updateMessageExtendedMedia)
        case updateMessageID(Cons_updateMessageID)
        case updateMessagePoll(Cons_updateMessagePoll)
        case updateMessagePollVote(Cons_updateMessagePollVote)
        case updateMessageReactions(Cons_updateMessageReactions)
        case updateMessageWidgetData(Cons_updateMessageWidgetData)
        case updateMonoForumNoPaidException(Cons_updateMonoForumNoPaidException)
        case updateMoveStickerSetToTop(Cons_updateMoveStickerSetToTop)
        case updateNewAuthorization(Cons_updateNewAuthorization)
        case updateNewBotConnection(Cons_updateNewBotConnection)
        case updateNewChannelMessage(Cons_updateNewChannelMessage)
        case updateNewEncryptedMessage(Cons_updateNewEncryptedMessage)
        case updateNewEphemeralMessage(Cons_updateNewEphemeralMessage)
        case updateNewMessage(Cons_updateNewMessage)
        case updateNewQuickReply(Cons_updateNewQuickReply)
        case updateNewScheduledMessage(Cons_updateNewScheduledMessage)
        case updateNewStickerSet(Cons_updateNewStickerSet)
        case updateNewStoryReaction(Cons_updateNewStoryReaction)
        case updateNotifySettings(Cons_updateNotifySettings)
        case updatePaidReactionPrivacy(Cons_updatePaidReactionPrivacy)
        case updatePeerBlocked(Cons_updatePeerBlocked)
        case updatePeerHistoryTTL(Cons_updatePeerHistoryTTL)
        case updatePeerLocated(Cons_updatePeerLocated)
        case updatePeerSettings(Cons_updatePeerSettings)
        case updatePeerWallpaper(Cons_updatePeerWallpaper)
        case updatePendingJoinRequests(Cons_updatePendingJoinRequests)
        case updatePhoneCall(Cons_updatePhoneCall)
        case updatePhoneCallSignalingData(Cons_updatePhoneCallSignalingData)
        case updatePinnedChannelMessages(Cons_updatePinnedChannelMessages)
        case updatePinnedDialogs(Cons_updatePinnedDialogs)
        case updatePinnedForumTopic(Cons_updatePinnedForumTopic)
        case updatePinnedForumTopics(Cons_updatePinnedForumTopics)
        case updatePinnedMessages(Cons_updatePinnedMessages)
        case updatePinnedSavedDialogs(Cons_updatePinnedSavedDialogs)
        case updatePrivacy(Cons_updatePrivacy)
        case updatePtsChanged
        case updateQuickReplies(Cons_updateQuickReplies)
        case updateQuickReplyMessage(Cons_updateQuickReplyMessage)
        case updateReadChannelDiscussionInbox(Cons_updateReadChannelDiscussionInbox)
        case updateReadChannelDiscussionOutbox(Cons_updateReadChannelDiscussionOutbox)
        case updateReadChannelInbox(Cons_updateReadChannelInbox)
        case updateReadChannelOutbox(Cons_updateReadChannelOutbox)
        case updateReadFeaturedEmojiStickers
        case updateReadFeaturedStickers
        case updateReadHistoryInbox(Cons_updateReadHistoryInbox)
        case updateReadHistoryOutbox(Cons_updateReadHistoryOutbox)
        case updateReadMessagesContents(Cons_updateReadMessagesContents)
        case updateReadMonoForumInbox(Cons_updateReadMonoForumInbox)
        case updateReadMonoForumOutbox(Cons_updateReadMonoForumOutbox)
        case updateReadStories(Cons_updateReadStories)
        case updateRecentEmojiStatuses
        case updateRecentReactions
        case updateRecentStickers
        case updateSavedDialogPinned(Cons_updateSavedDialogPinned)
        case updateSavedGifs
        case updateSavedReactionTags
        case updateSavedRingtones
        case updateSentPhoneCode(Cons_updateSentPhoneCode)
        case updateSentStoryReaction(Cons_updateSentStoryReaction)
        case updateSentWalletTransaction(Cons_updateSentWalletTransaction)
        case updateServiceNotification(Cons_updateServiceNotification)
        case updateSmsJob(Cons_updateSmsJob)
        case updateStarGiftAuctionState(Cons_updateStarGiftAuctionState)
        case updateStarGiftAuctionUserState(Cons_updateStarGiftAuctionUserState)
        case updateStarGiftCraftFail
        case updateStarsBalance(Cons_updateStarsBalance)
        case updateStarsRevenueStatus(Cons_updateStarsRevenueStatus)
        case updateStickerSets(Cons_updateStickerSets)
        case updateStickerSetsOrder(Cons_updateStickerSetsOrder)
        case updateStoriesStealthMode(Cons_updateStoriesStealthMode)
        case updateStory(Cons_updateStory)
        case updateStoryID(Cons_updateStoryID)
        case updateTheme(Cons_updateTheme)
        case updateTranscribedAudio(Cons_updateTranscribedAudio)
        case updateTranscribedAudioFile(Cons_updateTranscribedAudioFile)
        case updateUser(Cons_updateUser)
        case updateUserEmojiStatus(Cons_updateUserEmojiStatus)
        case updateUserName(Cons_updateUserName)
        case updateUserPhone(Cons_updateUserPhone)
        case updateUserStatus(Cons_updateUserStatus)
        case updateUserTyping(Cons_updateUserTyping)
        case updateWalletGaslessInfo(Cons_updateWalletGaslessInfo)
        case updateWalletState(Cons_updateWalletState)
        case updateWalletTonConnectPendingDisconnect(Cons_updateWalletTonConnectPendingDisconnect)
        case updateWalletTonConnectSession(Cons_updateWalletTonConnectSession)
        case updateWebBrowserException(Cons_updateWebBrowserException)
        case updateWebBrowserSettings(Cons_updateWebBrowserSettings)
        case updateWebPage(Cons_updateWebPage)
        case updateWebViewResultSent(Cons_updateWebViewResultSent)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .updateAiComposeTones:
                if boxed {
                    buffer.appendInt32(-1945136645)
                }
                break
            case .updateAttachMenuBots:
                if boxed {
                    buffer.appendInt32(397910539)
                }
                break
            case .updateAutoSaveSettings:
                if boxed {
                    buffer.appendInt32(-335171433)
                }
                break
            case .updateBotBusinessConnect(let _data):
                if boxed {
                    buffer.appendInt32(-1964652166)
                }
                _data.connection.serialize(buffer, true)
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateBotCallbackQuery(let _data):
                if boxed {
                    buffer.appendInt32(-1177566067)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.queryId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                serializeInt64(_data.chatInstance, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeBytes(_data.data!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.gameShortName!, buffer: buffer, boxed: false)
                }
                break
            case .updateBotChatBoost(let _data):
                if boxed {
                    buffer.appendInt32(-1873947492)
                }
                _data.peer.serialize(buffer, true)
                _data.boost.serialize(buffer, true)
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateBotChatInviteRequester(let _data):
                if boxed {
                    buffer.appendInt32(2092125561)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeString(_data.about, buffer: buffer, boxed: false)
                _data.invite.serialize(buffer, true)
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.queryId!, buffer: buffer, boxed: false)
                }
                break
            case .updateBotCommands(let _data):
                if boxed {
                    buffer.appendInt32(1299263278)
                }
                _data.peer.serialize(buffer, true)
                serializeInt64(_data.botId, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.commands.count))
                for item in _data.commands {
                    item.serialize(buffer, true)
                }
                break
            case .updateBotDeleteBusinessMessage(let _data):
                if boxed {
                    buffer.appendInt32(-1607821266)
                }
                serializeString(_data.connectionId, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateBotEditBusinessMessage(let _data):
                if boxed {
                    buffer.appendInt32(132077692)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.connectionId, buffer: buffer, boxed: false)
                _data.message.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.replyToMessage!.serialize(buffer, true)
                }
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateBotGuestChatQuery(let _data):
                if boxed {
                    buffer.appendInt32(-841742019)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.queryId, buffer: buffer, boxed: false)
                _data.message.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.referenceMessages!.count))
                    for item in _data.referenceMessages! {
                        item.serialize(buffer, true)
                    }
                }
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateBotInlineQuery(let _data):
                if boxed {
                    buffer.appendInt32(1232025500)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.queryId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeString(_data.query, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.geo!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.peerType!.serialize(buffer, true)
                }
                serializeString(_data.offset, buffer: buffer, boxed: false)
                break
            case .updateBotInlineSend(let _data):
                if boxed {
                    buffer.appendInt32(317794823)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeString(_data.query, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.geo!.serialize(buffer, true)
                }
                serializeString(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.msgId!.serialize(buffer, true)
                }
                break
            case .updateBotMenuButton(let _data):
                if boxed {
                    buffer.appendInt32(347625491)
                }
                serializeInt64(_data.botId, buffer: buffer, boxed: false)
                _data.button.serialize(buffer, true)
                break
            case .updateBotMessageReaction(let _data):
                if boxed {
                    buffer.appendInt32(-1407069234)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                _data.actor.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.oldReactions.count))
                for item in _data.oldReactions {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.newReactions.count))
                for item in _data.newReactions {
                    item.serialize(buffer, true)
                }
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateBotMessageReactions(let _data):
                if boxed {
                    buffer.appendInt32(164329305)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.reactions.count))
                for item in _data.reactions {
                    item.serialize(buffer, true)
                }
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateBotNewBusinessMessage(let _data):
                if boxed {
                    buffer.appendInt32(-1646578564)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.connectionId, buffer: buffer, boxed: false)
                _data.message.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.replyToMessage!.serialize(buffer, true)
                }
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateBotPrecheckoutQuery(let _data):
                if boxed {
                    buffer.appendInt32(-1934976362)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.queryId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeBytes(_data.payload, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.info!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.shippingOptionId!, buffer: buffer, boxed: false)
                }
                serializeString(_data.currency, buffer: buffer, boxed: false)
                serializeInt64(_data.totalAmount, buffer: buffer, boxed: false)
                break
            case .updateBotPurchasedPaidMedia(let _data):
                if boxed {
                    buffer.appendInt32(675009298)
                }
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeString(_data.payload, buffer: buffer, boxed: false)
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateBotShippingQuery(let _data):
                if boxed {
                    buffer.appendInt32(-1246823043)
                }
                serializeInt64(_data.queryId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeBytes(_data.payload, buffer: buffer, boxed: false)
                _data.shippingAddress.serialize(buffer, true)
                break
            case .updateBotStarsSubscription(let _data):
                if boxed {
                    buffer.appendInt32(1812827683)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeBytes(_data.payload, buffer: buffer, boxed: false)
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateBotStopped(let _data):
                if boxed {
                    buffer.appendInt32(-997782967)
                }
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                _data.stopped.serialize(buffer, true)
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateBotWebhookJSON(let _data):
                if boxed {
                    buffer.appendInt32(-2095595325)
                }
                _data.data.serialize(buffer, true)
                break
            case .updateBotWebhookJSONQuery(let _data):
                if boxed {
                    buffer.appendInt32(-1684914010)
                }
                serializeInt64(_data.queryId, buffer: buffer, boxed: false)
                _data.data.serialize(buffer, true)
                serializeInt32(_data.timeout, buffer: buffer, boxed: false)
                break
            case .updateBotWidgetCopyQuery(let _data):
                if boxed {
                    buffer.appendInt32(-91635977)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.queryId, buffer: buffer, boxed: false)
                _data.queryType.serialize(buffer, true)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeBytes(_data.data, buffer: buffer, boxed: false)
                serializeInt64(_data.widgetId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.walletCard!.serialize(buffer, true)
                }
                break
            case .updateBotWidgetQuery(let _data):
                if boxed {
                    buffer.appendInt32(-1284243864)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.queryId, buffer: buffer, boxed: false)
                _data.queryType.serialize(buffer, true)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                serializeInt64(_data.chatInstance, buffer: buffer, boxed: false)
                serializeString(_data.chatType, buffer: buffer, boxed: false)
                serializeBytes(_data.data, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.widgetId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.walletCard!.serialize(buffer, true)
                }
                break
            case .updateBusinessBotCallbackQuery(let _data):
                if boxed {
                    buffer.appendInt32(513998247)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.queryId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeString(_data.connectionId, buffer: buffer, boxed: false)
                _data.message.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.replyToMessage!.serialize(buffer, true)
                }
                serializeInt64(_data.chatInstance, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeBytes(_data.data!, buffer: buffer, boxed: false)
                }
                break
            case .updateChannel(let _data):
                if boxed {
                    buffer.appendInt32(1666927625)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                break
            case .updateChannelAvailableMessages(let _data):
                if boxed {
                    buffer.appendInt32(-1304443240)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                serializeInt32(_data.availableMinId, buffer: buffer, boxed: false)
                break
            case .updateChannelMessageForwards(let _data):
                if boxed {
                    buffer.appendInt32(-761649164)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                serializeInt32(_data.forwards, buffer: buffer, boxed: false)
                break
            case .updateChannelMessageViews(let _data):
                if boxed {
                    buffer.appendInt32(-232346616)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                serializeInt32(_data.views, buffer: buffer, boxed: false)
                break
            case .updateChannelParticipant(let _data):
                if boxed {
                    buffer.appendInt32(-1738720581)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt64(_data.actorId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.prevParticipant!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.newParticipant!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.invite!.serialize(buffer, true)
                }
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateChannelReadMessagesContents(let _data):
                if boxed {
                    buffer.appendInt32(636691703)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.topMsgId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.savedPeerId!.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                break
            case .updateChannelTooLong(let _data):
                if boxed {
                    buffer.appendInt32(277713951)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.pts!, buffer: buffer, boxed: false)
                }
                break
            case .updateChannelUserTyping(let _data):
                if boxed {
                    buffer.appendInt32(-1937192669)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.topMsgId!, buffer: buffer, boxed: false)
                }
                _data.fromId.serialize(buffer, true)
                _data.action.serialize(buffer, true)
                break
            case .updateChannelViewForumAsMessages(let _data):
                if boxed {
                    buffer.appendInt32(129403168)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                _data.enabled.serialize(buffer, true)
                break
            case .updateChannelWebPage(let _data):
                if boxed {
                    buffer.appendInt32(791390623)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                _data.webpage.serialize(buffer, true)
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                break
            case .updateChat(let _data):
                if boxed {
                    buffer.appendInt32(-124097970)
                }
                serializeInt64(_data.chatId, buffer: buffer, boxed: false)
                break
            case .updateChatDefaultBannedRights(let _data):
                if boxed {
                    buffer.appendInt32(1421875280)
                }
                _data.peer.serialize(buffer, true)
                _data.defaultBannedRights.serialize(buffer, true)
                serializeInt32(_data.version, buffer: buffer, boxed: false)
                break
            case .updateChatParticipant(let _data):
                if boxed {
                    buffer.appendInt32(-796432838)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.chatId, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt64(_data.actorId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.prevParticipant!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.newParticipant!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.invite!.serialize(buffer, true)
                }
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateChatParticipantAdd(let _data):
                if boxed {
                    buffer.appendInt32(1037718609)
                }
                serializeInt64(_data.chatId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeInt64(_data.inviterId, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt32(_data.version, buffer: buffer, boxed: false)
                break
            case .updateChatParticipantAdmin(let _data):
                if boxed {
                    buffer.appendInt32(-674602590)
                }
                serializeInt64(_data.chatId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                _data.isAdmin.serialize(buffer, true)
                serializeInt32(_data.version, buffer: buffer, boxed: false)
                break
            case .updateChatParticipantDelete(let _data):
                if boxed {
                    buffer.appendInt32(-483443337)
                }
                serializeInt64(_data.chatId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeInt32(_data.version, buffer: buffer, boxed: false)
                break
            case .updateChatParticipantRank(let _data):
                if boxed {
                    buffer.appendInt32(-1115461703)
                }
                serializeInt64(_data.chatId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeString(_data.rank, buffer: buffer, boxed: false)
                serializeInt32(_data.version, buffer: buffer, boxed: false)
                break
            case .updateChatParticipants(let _data):
                if boxed {
                    buffer.appendInt32(125178264)
                }
                _data.participants.serialize(buffer, true)
                break
            case .updateChatUserTyping(let _data):
                if boxed {
                    buffer.appendInt32(-2092401936)
                }
                serializeInt64(_data.chatId, buffer: buffer, boxed: false)
                _data.fromId.serialize(buffer, true)
                _data.action.serialize(buffer, true)
                break
            case .updateConfig:
                if boxed {
                    buffer.appendInt32(-1574314746)
                }
                break
            case .updateContactsReset:
                if boxed {
                    buffer.appendInt32(1887741886)
                }
                break
            case .updateDcOptions(let _data):
                if boxed {
                    buffer.appendInt32(-1906403213)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.dcOptions.count))
                for item in _data.dcOptions {
                    item.serialize(buffer, true)
                }
                break
            case .updateDeleteChannelMessages(let _data):
                if boxed {
                    buffer.appendInt32(-1020437742)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                break
            case .updateDeleteEphemeralMessages(let _data):
                if boxed {
                    buffer.appendInt32(1457257720)
                }
                _data.peer.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.ids.count))
                for item in _data.ids {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                break
            case .updateDeleteGroupCallMessages(let _data):
                if boxed {
                    buffer.appendInt32(1048963372)
                }
                _data.call.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                break
            case .updateDeleteMessages(let _data):
                if boxed {
                    buffer.appendInt32(-1576161051)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                break
            case .updateDeleteQuickReply(let _data):
                if boxed {
                    buffer.appendInt32(1407644140)
                }
                serializeInt32(_data.shortcutId, buffer: buffer, boxed: false)
                break
            case .updateDeleteQuickReplyMessages(let _data):
                if boxed {
                    buffer.appendInt32(1450174413)
                }
                serializeInt32(_data.shortcutId, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                break
            case .updateDeleteScheduledMessages(let _data):
                if boxed {
                    buffer.appendInt32(-223929981)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.sentMessages!.count))
                    for item in _data.sentMessages! {
                        serializeInt32(item, buffer: buffer, boxed: false)
                    }
                }
                break
            case .updateDialogFilter(let _data):
                if boxed {
                    buffer.appendInt32(654302845)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.filter!.serialize(buffer, true)
                }
                break
            case .updateDialogFilterOrder(let _data):
                if boxed {
                    buffer.appendInt32(-1512627963)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.order.count))
                for item in _data.order {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                break
            case .updateDialogFilters:
                if boxed {
                    buffer.appendInt32(889491791)
                }
                break
            case .updateDialogPinned(let _data):
                if boxed {
                    buffer.appendInt32(1852826908)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.folderId!, buffer: buffer, boxed: false)
                }
                _data.peer.serialize(buffer, true)
                break
            case .updateDialogUnreadMark(let _data):
                if boxed {
                    buffer.appendInt32(-1235684802)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.savedPeerId!.serialize(buffer, true)
                }
                break
            case .updateDraftMessage(let _data):
                if boxed {
                    buffer.appendInt32(-302247650)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.topMsgId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.savedPeerId!.serialize(buffer, true)
                }
                _data.draft.serialize(buffer, true)
                break
            case .updateEditChannelMessage(let _data):
                if boxed {
                    buffer.appendInt32(457133559)
                }
                _data.message.serialize(buffer, true)
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                break
            case .updateEditEphemeralMessage(let _data):
                if boxed {
                    buffer.appendInt32(1270583041)
                }
                _data.message.serialize(buffer, true)
                break
            case .updateEditForumTopic(let _data):
                if boxed {
                    buffer.appendInt32(593913436)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.topicId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.title!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt64(_data.iconEmojiId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.closed!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.hidden!.serialize(buffer, true)
                }
                break
            case .updateEditMessage(let _data):
                if boxed {
                    buffer.appendInt32(-469536605)
                }
                _data.message.serialize(buffer, true)
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                break
            case .updateEmojiGameInfo(let _data):
                if boxed {
                    buffer.appendInt32(-73640838)
                }
                _data.info.serialize(buffer, true)
                break
            case .updateEncryptedChatTyping(let _data):
                if boxed {
                    buffer.appendInt32(386986326)
                }
                serializeInt32(_data.chatId, buffer: buffer, boxed: false)
                break
            case .updateEncryptedMessagesRead(let _data):
                if boxed {
                    buffer.appendInt32(956179895)
                }
                serializeInt32(_data.chatId, buffer: buffer, boxed: false)
                serializeInt32(_data.maxDate, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                break
            case .updateEncryption(let _data):
                if boxed {
                    buffer.appendInt32(-1264392051)
                }
                _data.chat.serialize(buffer, true)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                break
            case .updateEphemeralBotCallbackQuery(let _data):
                if boxed {
                    buffer.appendInt32(2081454550)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.queryId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.peer!.serialize(buffer, true)
                }
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                serializeBytes(_data.data, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt64(_data.chatInstance!, buffer: buffer, boxed: false)
                }
                _data.message.serialize(buffer, true)
                break
            case .updateFavedStickers:
                if boxed {
                    buffer.appendInt32(-451831443)
                }
                break
            case .updateFolderPeers(let _data):
                if boxed {
                    buffer.appendInt32(422972864)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.folderPeers.count))
                for item in _data.folderPeers {
                    item.serialize(buffer, true)
                }
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                break
            case .updateGeoLiveViewed(let _data):
                if boxed {
                    buffer.appendInt32(-2027964103)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                break
            case .updateGroupCall(let _data):
                if boxed {
                    buffer.appendInt32(-1658710304)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.peer!.serialize(buffer, true)
                }
                _data.call.serialize(buffer, true)
                break
            case .updateGroupCallChainBlocks(let _data):
                if boxed {
                    buffer.appendInt32(-1535694705)
                }
                _data.call.serialize(buffer, true)
                serializeInt32(_data.subChainId, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.blocks.count))
                for item in _data.blocks {
                    serializeBytes(item, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.nextOffset, buffer: buffer, boxed: false)
                break
            case .updateGroupCallConnection(let _data):
                if boxed {
                    buffer.appendInt32(192428418)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.params.serialize(buffer, true)
                break
            case .updateGroupCallEncryptedMessage(let _data):
                if boxed {
                    buffer.appendInt32(-917002394)
                }
                _data.call.serialize(buffer, true)
                _data.fromId.serialize(buffer, true)
                serializeBytes(_data.encryptedMessage, buffer: buffer, boxed: false)
                break
            case .updateGroupCallMessage(let _data):
                if boxed {
                    buffer.appendInt32(-667783411)
                }
                _data.call.serialize(buffer, true)
                _data.message.serialize(buffer, true)
                break
            case .updateGroupCallParticipants(let _data):
                if boxed {
                    buffer.appendInt32(-219423922)
                }
                _data.call.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.participants.count))
                for item in _data.participants {
                    item.serialize(buffer, true)
                }
                serializeInt32(_data.version, buffer: buffer, boxed: false)
                break
            case .updateInlineBotCallbackQuery(let _data):
                if boxed {
                    buffer.appendInt32(1763610706)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.queryId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                _data.msgId.serialize(buffer, true)
                serializeInt64(_data.chatInstance, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeBytes(_data.data!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.gameShortName!, buffer: buffer, boxed: false)
                }
                break
            case .updateInlineBotWidgetQuery(let _data):
                if boxed {
                    buffer.appendInt32(-1510965752)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.queryId, buffer: buffer, boxed: false)
                _data.queryType.serialize(buffer, true)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                _data.inlineMessageId.serialize(buffer, true)
                serializeInt64(_data.chatInstance, buffer: buffer, boxed: false)
                serializeString(_data.chatType, buffer: buffer, boxed: false)
                serializeBytes(_data.data, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.widgetId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.walletCard!.serialize(buffer, true)
                }
                break
            case .updateJoinChatWebViewDecision(let _data):
                if boxed {
                    buffer.appendInt32(-1112768912)
                }
                _data.peer.serialize(buffer, true)
                serializeInt64(_data.queryId, buffer: buffer, boxed: false)
                _data.result.serialize(buffer, true)
                break
            case .updateLangPack(let _data):
                if boxed {
                    buffer.appendInt32(1442983757)
                }
                _data.difference.serialize(buffer, true)
                break
            case .updateLangPackTooLong(let _data):
                if boxed {
                    buffer.appendInt32(1180041828)
                }
                serializeString(_data.langCode, buffer: buffer, boxed: false)
                break
            case .updateLoginToken:
                if boxed {
                    buffer.appendInt32(1448076945)
                }
                break
            case .updateManagedBot(let _data):
                if boxed {
                    buffer.appendInt32(1216408986)
                }
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeInt64(_data.botId, buffer: buffer, boxed: false)
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateMessageExtendedMedia(let _data):
                if boxed {
                    buffer.appendInt32(-710666460)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.extendedMedia.count))
                for item in _data.extendedMedia {
                    item.serialize(buffer, true)
                }
                break
            case .updateMessageID(let _data):
                if boxed {
                    buffer.appendInt32(1318109142)
                }
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.randomId, buffer: buffer, boxed: false)
                break
            case .updateMessagePoll(let _data):
                if boxed {
                    buffer.appendInt32(-699641301)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.peer!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.msgId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.topMsgId!, buffer: buffer, boxed: false)
                }
                serializeInt64(_data.pollId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.poll!.serialize(buffer, true)
                }
                _data.results.serialize(buffer, true)
                break
            case .updateMessagePollVote(let _data):
                if boxed {
                    buffer.appendInt32(1989799956)
                }
                serializeInt64(_data.pollId, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.options.count))
                for item in _data.options {
                    serializeBytes(item, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.positions.count))
                for item in _data.positions {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateMessageReactions(let _data):
                if boxed {
                    buffer.appendInt32(506035194)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.topMsgId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.savedPeerId!.serialize(buffer, true)
                }
                _data.reactions.serialize(buffer, true)
                break
            case .updateMessageWidgetData(let _data):
                if boxed {
                    buffer.appendInt32(-1146062627)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.publicData!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.publicDataHash!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.chatData!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                break
            case .updateMonoForumNoPaidException(let _data):
                if boxed {
                    buffer.appendInt32(-1618924792)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                _data.savedPeerId.serialize(buffer, true)
                break
            case .updateMoveStickerSetToTop(let _data):
                if boxed {
                    buffer.appendInt32(-2030252155)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.stickerset, buffer: buffer, boxed: false)
                break
            case .updateNewAuthorization(let _data):
                if boxed {
                    buffer.appendInt32(-1991136273)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.hash, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.date!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.device!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.location!, buffer: buffer, boxed: false)
                }
                break
            case .updateNewBotConnection(let _data):
                if boxed {
                    buffer.appendInt32(-1306491994)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.botId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.date!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.device!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.location!, buffer: buffer, boxed: false)
                }
                break
            case .updateNewChannelMessage(let _data):
                if boxed {
                    buffer.appendInt32(1656358105)
                }
                _data.message.serialize(buffer, true)
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                break
            case .updateNewEncryptedMessage(let _data):
                if boxed {
                    buffer.appendInt32(314359194)
                }
                _data.message.serialize(buffer, true)
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                break
            case .updateNewEphemeralMessage(let _data):
                if boxed {
                    buffer.appendInt32(549239713)
                }
                _data.message.serialize(buffer, true)
                break
            case .updateNewMessage(let _data):
                if boxed {
                    buffer.appendInt32(522914557)
                }
                _data.message.serialize(buffer, true)
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                break
            case .updateNewQuickReply(let _data):
                if boxed {
                    buffer.appendInt32(-180508905)
                }
                _data.quickReply.serialize(buffer, true)
                break
            case .updateNewScheduledMessage(let _data):
                if boxed {
                    buffer.appendInt32(967122427)
                }
                _data.message.serialize(buffer, true)
                break
            case .updateNewStickerSet(let _data):
                if boxed {
                    buffer.appendInt32(1753886890)
                }
                _data.stickerset.serialize(buffer, true)
                break
            case .updateNewStoryReaction(let _data):
                if boxed {
                    buffer.appendInt32(405070859)
                }
                serializeInt32(_data.storyId, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                _data.reaction.serialize(buffer, true)
                break
            case .updateNotifySettings(let _data):
                if boxed {
                    buffer.appendInt32(-1094555409)
                }
                _data.peer.serialize(buffer, true)
                _data.notifySettings.serialize(buffer, true)
                break
            case .updatePaidReactionPrivacy(let _data):
                if boxed {
                    buffer.appendInt32(-1955438642)
                }
                _data.`private`.serialize(buffer, true)
                break
            case .updatePeerBlocked(let _data):
                if boxed {
                    buffer.appendInt32(-337610926)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peerId.serialize(buffer, true)
                break
            case .updatePeerHistoryTTL(let _data):
                if boxed {
                    buffer.appendInt32(-1147422299)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.ttlPeriod!, buffer: buffer, boxed: false)
                }
                break
            case .updatePeerLocated(let _data):
                if boxed {
                    buffer.appendInt32(-1263546448)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.peers.count))
                for item in _data.peers {
                    item.serialize(buffer, true)
                }
                break
            case .updatePeerSettings(let _data):
                if boxed {
                    buffer.appendInt32(1786671974)
                }
                _data.peer.serialize(buffer, true)
                _data.settings.serialize(buffer, true)
                break
            case .updatePeerWallpaper(let _data):
                if boxed {
                    buffer.appendInt32(-1371598819)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.wallpaper!.serialize(buffer, true)
                }
                break
            case .updatePendingJoinRequests(let _data):
                if boxed {
                    buffer.appendInt32(1885586395)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.requestsPending, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.recentRequesters.count))
                for item in _data.recentRequesters {
                    serializeInt64(item, buffer: buffer, boxed: false)
                }
                break
            case .updatePhoneCall(let _data):
                if boxed {
                    buffer.appendInt32(-1425052898)
                }
                _data.phoneCall.serialize(buffer, true)
                break
            case .updatePhoneCallSignalingData(let _data):
                if boxed {
                    buffer.appendInt32(643940105)
                }
                serializeInt64(_data.phoneCallId, buffer: buffer, boxed: false)
                serializeBytes(_data.data, buffer: buffer, boxed: false)
                break
            case .updatePinnedChannelMessages(let _data):
                if boxed {
                    buffer.appendInt32(1538885128)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                break
            case .updatePinnedDialogs(let _data):
                if boxed {
                    buffer.appendInt32(-99664734)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.folderId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.order!.count))
                    for item in _data.order! {
                        item.serialize(buffer, true)
                    }
                }
                break
            case .updatePinnedForumTopic(let _data):
                if boxed {
                    buffer.appendInt32(1748708434)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.topicId, buffer: buffer, boxed: false)
                break
            case .updatePinnedForumTopics(let _data):
                if boxed {
                    buffer.appendInt32(-554613808)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.order!.count))
                    for item in _data.order! {
                        serializeInt32(item, buffer: buffer, boxed: false)
                    }
                }
                break
            case .updatePinnedMessages(let _data):
                if boxed {
                    buffer.appendInt32(-309990731)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                break
            case .updatePinnedSavedDialogs(let _data):
                if boxed {
                    buffer.appendInt32(1751942566)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.order!.count))
                    for item in _data.order! {
                        item.serialize(buffer, true)
                    }
                }
                break
            case .updatePrivacy(let _data):
                if boxed {
                    buffer.appendInt32(-298113238)
                }
                _data.key.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.rules.count))
                for item in _data.rules {
                    item.serialize(buffer, true)
                }
                break
            case .updatePtsChanged:
                if boxed {
                    buffer.appendInt32(861169551)
                }
                break
            case .updateQuickReplies(let _data):
                if boxed {
                    buffer.appendInt32(-112784718)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.quickReplies.count))
                for item in _data.quickReplies {
                    item.serialize(buffer, true)
                }
                break
            case .updateQuickReplyMessage(let _data):
                if boxed {
                    buffer.appendInt32(1040518415)
                }
                _data.message.serialize(buffer, true)
                break
            case .updateReadChannelDiscussionInbox(let _data):
                if boxed {
                    buffer.appendInt32(-693004986)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                serializeInt32(_data.topMsgId, buffer: buffer, boxed: false)
                serializeInt32(_data.readMaxId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.broadcastId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.broadcastPost!, buffer: buffer, boxed: false)
                }
                break
            case .updateReadChannelDiscussionOutbox(let _data):
                if boxed {
                    buffer.appendInt32(1767677564)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                serializeInt32(_data.topMsgId, buffer: buffer, boxed: false)
                serializeInt32(_data.readMaxId, buffer: buffer, boxed: false)
                break
            case .updateReadChannelInbox(let _data):
                if boxed {
                    buffer.appendInt32(-1842450928)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.folderId!, buffer: buffer, boxed: false)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                serializeInt32(_data.maxId, buffer: buffer, boxed: false)
                serializeInt32(_data.stillUnreadCount, buffer: buffer, boxed: false)
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                break
            case .updateReadChannelOutbox(let _data):
                if boxed {
                    buffer.appendInt32(-1218471511)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                serializeInt32(_data.maxId, buffer: buffer, boxed: false)
                break
            case .updateReadFeaturedEmojiStickers:
                if boxed {
                    buffer.appendInt32(-78886548)
                }
                break
            case .updateReadFeaturedStickers:
                if boxed {
                    buffer.appendInt32(1461528386)
                }
                break
            case .updateReadHistoryInbox(let _data):
                if boxed {
                    buffer.appendInt32(-1635468135)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.folderId!, buffer: buffer, boxed: false)
                }
                _data.peer.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.topMsgId!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.maxId, buffer: buffer, boxed: false)
                serializeInt32(_data.stillUnreadCount, buffer: buffer, boxed: false)
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                break
            case .updateReadHistoryOutbox(let _data):
                if boxed {
                    buffer.appendInt32(791617983)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.maxId, buffer: buffer, boxed: false)
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                break
            case .updateReadMessagesContents(let _data):
                if boxed {
                    buffer.appendInt32(-131960447)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.date!, buffer: buffer, boxed: false)
                }
                break
            case .updateReadMonoForumInbox(let _data):
                if boxed {
                    buffer.appendInt32(2008081266)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                _data.savedPeerId.serialize(buffer, true)
                serializeInt32(_data.readMaxId, buffer: buffer, boxed: false)
                break
            case .updateReadMonoForumOutbox(let _data):
                if boxed {
                    buffer.appendInt32(-1532521610)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                _data.savedPeerId.serialize(buffer, true)
                serializeInt32(_data.readMaxId, buffer: buffer, boxed: false)
                break
            case .updateReadStories(let _data):
                if boxed {
                    buffer.appendInt32(-145845461)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.maxId, buffer: buffer, boxed: false)
                break
            case .updateRecentEmojiStatuses:
                if boxed {
                    buffer.appendInt32(821314523)
                }
                break
            case .updateRecentReactions:
                if boxed {
                    buffer.appendInt32(1870160884)
                }
                break
            case .updateRecentStickers:
                if boxed {
                    buffer.appendInt32(-1706939360)
                }
                break
            case .updateSavedDialogPinned(let _data):
                if boxed {
                    buffer.appendInt32(-1364222348)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                break
            case .updateSavedGifs:
                if boxed {
                    buffer.appendInt32(-1821035490)
                }
                break
            case .updateSavedReactionTags:
                if boxed {
                    buffer.appendInt32(969307186)
                }
                break
            case .updateSavedRingtones:
                if boxed {
                    buffer.appendInt32(1960361625)
                }
                break
            case .updateSentPhoneCode(let _data):
                if boxed {
                    buffer.appendInt32(1347068303)
                }
                _data.sentCode.serialize(buffer, true)
                break
            case .updateSentStoryReaction(let _data):
                if boxed {
                    buffer.appendInt32(2103604867)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.storyId, buffer: buffer, boxed: false)
                _data.reaction.serialize(buffer, true)
                break
            case .updateSentWalletTransaction(let _data):
                if boxed {
                    buffer.appendInt32(-1320989366)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.msgHash, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.transaction!.serialize(buffer, true)
                }
                break
            case .updateServiceNotification(let _data):
                if boxed {
                    buffer.appendInt32(-337352679)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.inboxDate!, buffer: buffer, boxed: false)
                }
                serializeString(_data.type, buffer: buffer, boxed: false)
                serializeString(_data.message, buffer: buffer, boxed: false)
                _data.media.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.entities.count))
                for item in _data.entities {
                    item.serialize(buffer, true)
                }
                break
            case .updateSmsJob(let _data):
                if boxed {
                    buffer.appendInt32(-245208620)
                }
                serializeString(_data.jobId, buffer: buffer, boxed: false)
                break
            case .updateStarGiftAuctionState(let _data):
                if boxed {
                    buffer.appendInt32(1222788802)
                }
                serializeInt64(_data.giftId, buffer: buffer, boxed: false)
                _data.state.serialize(buffer, true)
                break
            case .updateStarGiftAuctionUserState(let _data):
                if boxed {
                    buffer.appendInt32(-598150370)
                }
                serializeInt64(_data.giftId, buffer: buffer, boxed: false)
                _data.userState.serialize(buffer, true)
                break
            case .updateStarGiftCraftFail:
                if boxed {
                    buffer.appendInt32(-1408818108)
                }
                break
            case .updateStarsBalance(let _data):
                if boxed {
                    buffer.appendInt32(1317053305)
                }
                _data.balance.serialize(buffer, true)
                break
            case .updateStarsRevenueStatus(let _data):
                if boxed {
                    buffer.appendInt32(-1518030823)
                }
                _data.peer.serialize(buffer, true)
                _data.status.serialize(buffer, true)
                break
            case .updateStickerSets(let _data):
                if boxed {
                    buffer.appendInt32(834816008)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            case .updateStickerSetsOrder(let _data):
                if boxed {
                    buffer.appendInt32(196268545)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.order.count))
                for item in _data.order {
                    serializeInt64(item, buffer: buffer, boxed: false)
                }
                break
            case .updateStoriesStealthMode(let _data):
                if boxed {
                    buffer.appendInt32(738741697)
                }
                _data.stealthMode.serialize(buffer, true)
                break
            case .updateStory(let _data):
                if boxed {
                    buffer.appendInt32(1974712216)
                }
                _data.peer.serialize(buffer, true)
                _data.story.serialize(buffer, true)
                break
            case .updateStoryID(let _data):
                if boxed {
                    buffer.appendInt32(468923833)
                }
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.randomId, buffer: buffer, boxed: false)
                break
            case .updateTheme(let _data):
                if boxed {
                    buffer.appendInt32(-2112423005)
                }
                _data.theme.serialize(buffer, true)
                break
            case .updateTranscribedAudio(let _data):
                if boxed {
                    buffer.appendInt32(8703322)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                serializeInt64(_data.transcriptionId, buffer: buffer, boxed: false)
                serializeString(_data.text, buffer: buffer, boxed: false)
                break
            case .updateTranscribedAudioFile(let _data):
                if boxed {
                    buffer.appendInt32(1934372475)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.transcriptionId, buffer: buffer, boxed: false)
                serializeString(_data.text, buffer: buffer, boxed: false)
                break
            case .updateUser(let _data):
                if boxed {
                    buffer.appendInt32(542282808)
                }
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                break
            case .updateUserEmojiStatus(let _data):
                if boxed {
                    buffer.appendInt32(674706841)
                }
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                _data.emojiStatus.serialize(buffer, true)
                break
            case .updateUserName(let _data):
                if boxed {
                    buffer.appendInt32(-1484486364)
                }
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeString(_data.firstName, buffer: buffer, boxed: false)
                serializeString(_data.lastName, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.usernames.count))
                for item in _data.usernames {
                    item.serialize(buffer, true)
                }
                break
            case .updateUserPhone(let _data):
                if boxed {
                    buffer.appendInt32(88680979)
                }
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeString(_data.phone, buffer: buffer, boxed: false)
                break
            case .updateUserStatus(let _data):
                if boxed {
                    buffer.appendInt32(-440534818)
                }
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                _data.status.serialize(buffer, true)
                break
            case .updateUserTyping(let _data):
                if boxed {
                    buffer.appendInt32(706199388)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.topMsgId!, buffer: buffer, boxed: false)
                }
                _data.action.serialize(buffer, true)
                break
            case .updateWalletGaslessInfo(let _data):
                if boxed {
                    buffer.appendInt32(-1464984404)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.left, buffer: buffer, boxed: false)
                serializeInt32(_data.resetAt, buffer: buffer, boxed: false)
                serializeInt64(_data.minAmount, buffer: buffer, boxed: false)
                serializeString(_data.relayerAddress, buffer: buffer, boxed: false)
                break
            case .updateWalletState(let _data):
                if boxed {
                    buffer.appendInt32(1791226538)
                }
                _data.state.serialize(buffer, true)
                break
            case .updateWalletTonConnectPendingDisconnect(let _data):
                if boxed {
                    buffer.appendInt32(-772898407)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.sessionIds.count))
                for item in _data.sessionIds {
                    serializeInt64(item, buffer: buffer, boxed: false)
                }
                break
            case .updateWalletTonConnectSession(let _data):
                if boxed {
                    buffer.appendInt32(1352896014)
                }
                _data.session.serialize(buffer, true)
                break
            case .updateWebBrowserException(let _data):
                if boxed {
                    buffer.appendInt32(335872721)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.openExternalBrowser!.serialize(buffer, true)
                }
                _data.exception.serialize(buffer, true)
                break
            case .updateWebBrowserSettings(let _data):
                if boxed {
                    buffer.appendInt32(-1013306658)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            case .updateWebPage(let _data):
                if boxed {
                    buffer.appendInt32(2139689491)
                }
                _data.webpage.serialize(buffer, true)
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                break
            case .updateWebViewResultSent(let _data):
                if boxed {
                    buffer.appendInt32(361936797)
                }
                serializeInt64(_data.queryId, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_updateAiComposeTones(_ reader: BufferReader) -> Update? {
            return Api.Update.updateAiComposeTones
        }
        static func parse_updateAttachMenuBots(_ reader: BufferReader) -> Update? {
            return Api.Update.updateAttachMenuBots
        }
        static func parse_updateAutoSaveSettings(_ reader: BufferReader) -> Update? {
            return Api.Update.updateAutoSaveSettings
        }
        static func parse_updateBotBusinessConnect(_ reader: BufferReader) -> Update? {
            var _1: Api.BotBusinessConnection?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.BotBusinessConnection
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateBotBusinessConnect(Cons_updateBotBusinessConnect(connection: _1!, qts: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotCallbackQuery(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Api.Peer?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int64?
            _6 = reader.readInt64()
            var _7: Buffer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _7 = parseBytes(reader)
            }
            var _8: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _8 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.Update.updateBotCallbackQuery(Cons_updateBotCallbackQuery(flags: _1!, queryId: _2!, userId: _3!, peer: _4!, msgId: _5!, chatInstance: _6!, data: _7, gameShortName: _8))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotChatBoost(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Api.Boost?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Boost
            }
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateBotChatBoost(Cons_updateBotChatBoost(peer: _1!, boost: _2!, qts: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotChatInviteRequester(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: String?
            _5 = parseString(reader)
            var _6: Api.ExportedChatInvite?
            if let signature = reader.readInt32() {
                _6 = Api.parse(reader, signature: signature) as? Api.ExportedChatInvite
            }
            var _7: Int32?
            _7 = reader.readInt32()
            var _8: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _8 = reader.readInt64()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.Update.updateBotChatInviteRequester(Cons_updateBotChatInviteRequester(flags: _1!, peer: _2!, date: _3!, userId: _4!, about: _5!, invite: _6!, qts: _7!, queryId: _8))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotCommands(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: [Api.BotCommand]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.BotCommand.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateBotCommands(Cons_updateBotCommands(peer: _1!, botId: _2!, commands: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotDeleteBusinessMessage(_ reader: BufferReader) -> Update? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: [Int32]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Update.updateBotDeleteBusinessMessage(Cons_updateBotDeleteBusinessMessage(connectionId: _1!, peer: _2!, messages: _3!, qts: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotEditBusinessMessage(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Api.Message?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Message
            }
            var _4: Api.Message?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.Message
                }
            }
            var _5: Int32?
            _5 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updateBotEditBusinessMessage(Cons_updateBotEditBusinessMessage(flags: _1!, connectionId: _2!, message: _3!, replyToMessage: _4, qts: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotGuestChatQuery(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.Message?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Message
            }
            var _4: [Api.Message]?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Message.self)
                }
            }
            var _5: Int32?
            _5 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updateBotGuestChatQuery(Cons_updateBotGuestChatQuery(flags: _1!, queryId: _2!, message: _3!, referenceMessages: _4, qts: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotInlineQuery(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: String?
            _4 = parseString(reader)
            var _5: Api.GeoPoint?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.GeoPoint
                }
            }
            var _6: Api.InlineQueryPeerType?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.InlineQueryPeerType
                }
            }
            var _7: String?
            _7 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            let _c7 = _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.Update.updateBotInlineQuery(Cons_updateBotInlineQuery(flags: _1!, queryId: _2!, userId: _3!, query: _4!, geo: _5, peerType: _6, offset: _7!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotInlineSend(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            _3 = parseString(reader)
            var _4: Api.GeoPoint?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.GeoPoint
                }
            }
            var _5: String?
            _5 = parseString(reader)
            var _6: Api.InputBotInlineMessageID?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.InputBotInlineMessageID
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.Update.updateBotInlineSend(Cons_updateBotInlineSend(flags: _1!, userId: _2!, query: _3!, geo: _4, id: _5!, msgId: _6))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotMenuButton(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Api.BotMenuButton?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.BotMenuButton
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateBotMenuButton(Cons_updateBotMenuButton(botId: _1!, button: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotMessageReaction(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Api.Peer?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _5: [Api.Reaction]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Reaction.self)
            }
            var _6: [Api.Reaction]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Reaction.self)
            }
            var _7: Int32?
            _7 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.Update.updateBotMessageReaction(Cons_updateBotMessageReaction(peer: _1!, msgId: _2!, date: _3!, actor: _4!, oldReactions: _5!, newReactions: _6!, qts: _7!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotMessageReactions(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: [Api.ReactionCount]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.ReactionCount.self)
            }
            var _5: Int32?
            _5 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updateBotMessageReactions(Cons_updateBotMessageReactions(peer: _1!, msgId: _2!, date: _3!, reactions: _4!, qts: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotNewBusinessMessage(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Api.Message?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Message
            }
            var _4: Api.Message?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.Message
                }
            }
            var _5: Int32?
            _5 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updateBotNewBusinessMessage(Cons_updateBotNewBusinessMessage(flags: _1!, connectionId: _2!, message: _3!, replyToMessage: _4, qts: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotPrecheckoutQuery(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Buffer?
            _4 = parseBytes(reader)
            var _5: Api.PaymentRequestedInfo?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.PaymentRequestedInfo
                }
            }
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _6 = parseString(reader)
            }
            var _7: String?
            _7 = parseString(reader)
            var _8: Int64?
            _8 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.Update.updateBotPrecheckoutQuery(Cons_updateBotPrecheckoutQuery(flags: _1!, queryId: _2!, userId: _3!, payload: _4!, info: _5, shippingOptionId: _6, currency: _7!, totalAmount: _8!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotPurchasedPaidMedia(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateBotPurchasedPaidMedia(Cons_updateBotPurchasedPaidMedia(userId: _1!, payload: _2!, qts: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotShippingQuery(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Buffer?
            _3 = parseBytes(reader)
            var _4: Api.PostAddress?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.PostAddress
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Update.updateBotShippingQuery(Cons_updateBotShippingQuery(queryId: _1!, userId: _2!, payload: _3!, shippingAddress: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotStarsSubscription(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Buffer?
            _3 = parseBytes(reader)
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Update.updateBotStarsSubscription(Cons_updateBotStarsSubscription(flags: _1!, userId: _2!, payload: _3!, qts: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotStopped(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.Bool?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Update.updateBotStopped(Cons_updateBotStopped(userId: _1!, date: _2!, stopped: _3!, qts: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotWebhookJSON(_ reader: BufferReader) -> Update? {
            var _1: Api.DataJSON?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.DataJSON
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateBotWebhookJSON(Cons_updateBotWebhookJSON(data: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotWebhookJSONQuery(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Api.DataJSON?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.DataJSON
            }
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateBotWebhookJSONQuery(Cons_updateBotWebhookJSONQuery(queryId: _1!, data: _2!, timeout: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotWidgetCopyQuery(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.WidgetQueryType?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.WidgetQueryType
            }
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: Buffer?
            _5 = parseBytes(reader)
            var _6: Int64?
            _6 = reader.readInt64()
            var _7: Api.wallet.Card?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.wallet.Card
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.Update.updateBotWidgetCopyQuery(Cons_updateBotWidgetCopyQuery(flags: _1!, queryId: _2!, queryType: _3!, userId: _4!, data: _5!, widgetId: _6!, walletCard: _7))
            }
            else {
                return nil
            }
        }
        static func parse_updateBotWidgetQuery(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.WidgetQueryType?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.WidgetQueryType
            }
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: Api.Peer?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: Int64?
            _7 = reader.readInt64()
            var _8: String?
            _8 = parseString(reader)
            var _9: Buffer?
            _9 = parseBytes(reader)
            var _10: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _10 = reader.readInt64()
            }
            var _11: Api.wallet.Card?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _11 = Api.parse(reader, signature: signature) as? Api.wallet.Card
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            let _c9 = _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _11 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 {
                return Api.Update.updateBotWidgetQuery(Cons_updateBotWidgetQuery(flags: _1!, queryId: _2!, queryType: _3!, userId: _4!, peer: _5!, msgId: _6!, chatInstance: _7!, chatType: _8!, data: _9!, widgetId: _10, walletCard: _11))
            }
            else {
                return nil
            }
        }
        static func parse_updateBusinessBotCallbackQuery(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: String?
            _4 = parseString(reader)
            var _5: Api.Message?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.Message
            }
            var _6: Api.Message?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.Message
                }
            }
            var _7: Int64?
            _7 = reader.readInt64()
            var _8: Buffer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _8 = parseBytes(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _6 != nil
            let _c7 = _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.Update.updateBusinessBotCallbackQuery(Cons_updateBusinessBotCallbackQuery(flags: _1!, queryId: _2!, userId: _3!, connectionId: _4!, message: _5!, replyToMessage: _6, chatInstance: _7!, data: _8))
            }
            else {
                return nil
            }
        }
        static func parse_updateChannel(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateChannel(Cons_updateChannel(channelId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChannelAvailableMessages(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateChannelAvailableMessages(Cons_updateChannelAvailableMessages(channelId: _1!, availableMinId: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChannelMessageForwards(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateChannelMessageForwards(Cons_updateChannelMessageForwards(channelId: _1!, id: _2!, forwards: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChannelMessageViews(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateChannelMessageViews(Cons_updateChannelMessageViews(channelId: _1!, id: _2!, views: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChannelParticipant(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: Int64?
            _5 = reader.readInt64()
            var _6: Api.ChannelParticipant?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.ChannelParticipant
                }
            }
            var _7: Api.ChannelParticipant?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.ChannelParticipant
                }
            }
            var _8: Api.ExportedChatInvite?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.ExportedChatInvite
                }
            }
            var _9: Int32?
            _9 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _8 != nil
            let _c9 = _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.Update.updateChannelParticipant(Cons_updateChannelParticipant(flags: _1!, channelId: _2!, date: _3!, actorId: _4!, userId: _5!, prevParticipant: _6, newParticipant: _7, invite: _8, qts: _9!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChannelReadMessagesContents(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _5: [Int32]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updateChannelReadMessagesContents(Cons_updateChannelReadMessagesContents(flags: _1!, channelId: _2!, topMsgId: _3, savedPeerId: _4, messages: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChannelTooLong(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateChannelTooLong(Cons_updateChannelTooLong(flags: _1!, channelId: _2!, pts: _3))
            }
            else {
                return nil
            }
        }
        static func parse_updateChannelUserTyping(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Api.Peer?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _5: Api.SendMessageAction?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.SendMessageAction
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updateChannelUserTyping(Cons_updateChannelUserTyping(flags: _1!, channelId: _2!, topMsgId: _3, fromId: _4!, action: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChannelViewForumAsMessages(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Api.Bool?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateChannelViewForumAsMessages(Cons_updateChannelViewForumAsMessages(channelId: _1!, enabled: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChannelWebPage(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Api.WebPage?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.WebPage
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Update.updateChannelWebPage(Cons_updateChannelWebPage(channelId: _1!, webpage: _2!, pts: _3!, ptsCount: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChat(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateChat(Cons_updateChat(chatId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChatDefaultBannedRights(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Api.ChatBannedRights?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.ChatBannedRights
            }
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateChatDefaultBannedRights(Cons_updateChatDefaultBannedRights(peer: _1!, defaultBannedRights: _2!, version: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChatParticipant(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: Int64?
            _5 = reader.readInt64()
            var _6: Api.ChatParticipant?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.ChatParticipant
                }
            }
            var _7: Api.ChatParticipant?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.ChatParticipant
                }
            }
            var _8: Api.ExportedChatInvite?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.ExportedChatInvite
                }
            }
            var _9: Int32?
            _9 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _8 != nil
            let _c9 = _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.Update.updateChatParticipant(Cons_updateChatParticipant(flags: _1!, chatId: _2!, date: _3!, actorId: _4!, userId: _5!, prevParticipant: _6, newParticipant: _7, invite: _8, qts: _9!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChatParticipantAdd(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            _5 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updateChatParticipantAdd(Cons_updateChatParticipantAdd(chatId: _1!, userId: _2!, inviterId: _3!, date: _4!, version: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChatParticipantAdmin(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.Bool?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Update.updateChatParticipantAdmin(Cons_updateChatParticipantAdmin(chatId: _1!, userId: _2!, isAdmin: _3!, version: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChatParticipantDelete(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateChatParticipantDelete(Cons_updateChatParticipantDelete(chatId: _1!, userId: _2!, version: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChatParticipantRank(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            _3 = parseString(reader)
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Update.updateChatParticipantRank(Cons_updateChatParticipantRank(chatId: _1!, userId: _2!, rank: _3!, version: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChatParticipants(_ reader: BufferReader) -> Update? {
            var _1: Api.ChatParticipants?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ChatParticipants
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateChatParticipants(Cons_updateChatParticipants(participants: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateChatUserTyping(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Api.SendMessageAction?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.SendMessageAction
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateChatUserTyping(Cons_updateChatUserTyping(chatId: _1!, fromId: _2!, action: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateConfig(_ reader: BufferReader) -> Update? {
            return Api.Update.updateConfig
        }
        static func parse_updateContactsReset(_ reader: BufferReader) -> Update? {
            return Api.Update.updateContactsReset
        }
        static func parse_updateDcOptions(_ reader: BufferReader) -> Update? {
            var _1: [Api.DcOption]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.DcOption.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateDcOptions(Cons_updateDcOptions(dcOptions: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateDeleteChannelMessages(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: [Int32]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Update.updateDeleteChannelMessages(Cons_updateDeleteChannelMessages(channelId: _1!, messages: _2!, pts: _3!, ptsCount: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_updateDeleteEphemeralMessages(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: [Int32]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateDeleteEphemeralMessages(Cons_updateDeleteEphemeralMessages(peer: _1!, ids: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateDeleteGroupCallMessages(_ reader: BufferReader) -> Update? {
            var _1: Api.InputGroupCall?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputGroupCall
            }
            var _2: [Int32]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateDeleteGroupCallMessages(Cons_updateDeleteGroupCallMessages(call: _1!, messages: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateDeleteMessages(_ reader: BufferReader) -> Update? {
            var _1: [Int32]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateDeleteMessages(Cons_updateDeleteMessages(messages: _1!, pts: _2!, ptsCount: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateDeleteQuickReply(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateDeleteQuickReply(Cons_updateDeleteQuickReply(shortcutId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateDeleteQuickReplyMessages(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Int32]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateDeleteQuickReplyMessages(Cons_updateDeleteQuickReplyMessages(shortcutId: _1!, messages: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateDeleteScheduledMessages(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: [Int32]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            var _4: [Int32]?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _4 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Update.updateDeleteScheduledMessages(Cons_updateDeleteScheduledMessages(flags: _1!, peer: _2!, messages: _3!, sentMessages: _4))
            }
            else {
                return nil
            }
        }
        static func parse_updateDialogFilter(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.DialogFilter?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.DialogFilter
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateDialogFilter(Cons_updateDialogFilter(flags: _1!, id: _2!, filter: _3))
            }
            else {
                return nil
            }
        }
        static func parse_updateDialogFilterOrder(_ reader: BufferReader) -> Update? {
            var _1: [Int32]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateDialogFilterOrder(Cons_updateDialogFilterOrder(order: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateDialogFilters(_ reader: BufferReader) -> Update? {
            return Api.Update.updateDialogFilters
        }
        static func parse_updateDialogPinned(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _2 = reader.readInt32()
            }
            var _3: Api.DialogPeer?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.DialogPeer
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateDialogPinned(Cons_updateDialogPinned(flags: _1!, folderId: _2, peer: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateDialogUnreadMark(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.DialogPeer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.DialogPeer
            }
            var _3: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateDialogUnreadMark(Cons_updateDialogUnreadMark(flags: _1!, peer: _2!, savedPeerId: _3))
            }
            else {
                return nil
            }
        }
        static func parse_updateDraftMessage(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _5: Api.DraftMessage?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.DraftMessage
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updateDraftMessage(Cons_updateDraftMessage(flags: _1!, peer: _2!, topMsgId: _3, savedPeerId: _4, draft: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_updateEditChannelMessage(_ reader: BufferReader) -> Update? {
            var _1: Api.Message?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Message
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateEditChannelMessage(Cons_updateEditChannelMessage(message: _1!, pts: _2!, ptsCount: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateEditEphemeralMessage(_ reader: BufferReader) -> Update? {
            var _1: Api.EphemeralMessage?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.EphemeralMessage
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateEditEphemeralMessage(Cons_updateEditEphemeralMessage(message: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateEditForumTopic(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            var _5: Int64?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _5 = reader.readInt64()
            }
            var _6: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            var _7: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.Update.updateEditForumTopic(Cons_updateEditForumTopic(flags: _1!, peer: _2!, topicId: _3!, title: _4, iconEmojiId: _5, closed: _6, hidden: _7))
            }
            else {
                return nil
            }
        }
        static func parse_updateEditMessage(_ reader: BufferReader) -> Update? {
            var _1: Api.Message?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Message
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateEditMessage(Cons_updateEditMessage(message: _1!, pts: _2!, ptsCount: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateEmojiGameInfo(_ reader: BufferReader) -> Update? {
            var _1: Api.messages.EmojiGameInfo?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.messages.EmojiGameInfo
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateEmojiGameInfo(Cons_updateEmojiGameInfo(info: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateEncryptedChatTyping(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateEncryptedChatTyping(Cons_updateEncryptedChatTyping(chatId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateEncryptedMessagesRead(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateEncryptedMessagesRead(Cons_updateEncryptedMessagesRead(chatId: _1!, maxDate: _2!, date: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateEncryption(_ reader: BufferReader) -> Update? {
            var _1: Api.EncryptedChat?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.EncryptedChat
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateEncryption(Cons_updateEncryption(chat: _1!, date: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateEphemeralBotCallbackQuery(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Buffer?
            _6 = parseBytes(reader)
            var _7: Int64?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _7 = reader.readInt64()
            }
            var _8: Api.EphemeralMessage?
            if let signature = reader.readInt32() {
                _8 = Api.parse(reader, signature: signature) as? Api.EphemeralMessage
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _7 != nil
            let _c8 = _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.Update.updateEphemeralBotCallbackQuery(Cons_updateEphemeralBotCallbackQuery(flags: _1!, queryId: _2!, userId: _3!, peer: _4, msgId: _5!, data: _6!, chatInstance: _7, message: _8!))
            }
            else {
                return nil
            }
        }
        static func parse_updateFavedStickers(_ reader: BufferReader) -> Update? {
            return Api.Update.updateFavedStickers
        }
        static func parse_updateFolderPeers(_ reader: BufferReader) -> Update? {
            var _1: [Api.FolderPeer]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.FolderPeer.self)
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateFolderPeers(Cons_updateFolderPeers(folderPeers: _1!, pts: _2!, ptsCount: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateGeoLiveViewed(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateGeoLiveViewed(Cons_updateGeoLiveViewed(peer: _1!, msgId: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateGroupCall(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _3: Api.GroupCall?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.GroupCall
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateGroupCall(Cons_updateGroupCall(flags: _1!, peer: _2, call: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateGroupCallChainBlocks(_ reader: BufferReader) -> Update? {
            var _1: Api.InputGroupCall?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputGroupCall
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: [Buffer]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: -1255641564, elementType: Buffer.self)
            }
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Update.updateGroupCallChainBlocks(Cons_updateGroupCallChainBlocks(call: _1!, subChainId: _2!, blocks: _3!, nextOffset: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_updateGroupCallConnection(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.DataJSON?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.DataJSON
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateGroupCallConnection(Cons_updateGroupCallConnection(flags: _1!, params: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateGroupCallEncryptedMessage(_ reader: BufferReader) -> Update? {
            var _1: Api.InputGroupCall?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputGroupCall
            }
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Buffer?
            _3 = parseBytes(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateGroupCallEncryptedMessage(Cons_updateGroupCallEncryptedMessage(call: _1!, fromId: _2!, encryptedMessage: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateGroupCallMessage(_ reader: BufferReader) -> Update? {
            var _1: Api.InputGroupCall?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputGroupCall
            }
            var _2: Api.GroupCallMessage?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.GroupCallMessage
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateGroupCallMessage(Cons_updateGroupCallMessage(call: _1!, message: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateGroupCallParticipants(_ reader: BufferReader) -> Update? {
            var _1: Api.InputGroupCall?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputGroupCall
            }
            var _2: [Api.GroupCallParticipant]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.GroupCallParticipant.self)
            }
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateGroupCallParticipants(Cons_updateGroupCallParticipants(call: _1!, participants: _2!, version: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateInlineBotCallbackQuery(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Api.InputBotInlineMessageID?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.InputBotInlineMessageID
            }
            var _5: Int64?
            _5 = reader.readInt64()
            var _6: Buffer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _6 = parseBytes(reader)
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _7 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.Update.updateInlineBotCallbackQuery(Cons_updateInlineBotCallbackQuery(flags: _1!, queryId: _2!, userId: _3!, msgId: _4!, chatInstance: _5!, data: _6, gameShortName: _7))
            }
            else {
                return nil
            }
        }
        static func parse_updateInlineBotWidgetQuery(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.WidgetQueryType?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.WidgetQueryType
            }
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: Api.InputBotInlineMessageID?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.InputBotInlineMessageID
            }
            var _6: Int64?
            _6 = reader.readInt64()
            var _7: String?
            _7 = parseString(reader)
            var _8: Buffer?
            _8 = parseBytes(reader)
            var _9: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _9 = reader.readInt64()
            }
            var _10: Api.wallet.Card?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _10 = Api.parse(reader, signature: signature) as? Api.wallet.Card
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _10 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 {
                return Api.Update.updateInlineBotWidgetQuery(Cons_updateInlineBotWidgetQuery(flags: _1!, queryId: _2!, queryType: _3!, userId: _4!, inlineMessageId: _5!, chatInstance: _6!, chatType: _7!, data: _8!, widgetId: _9, walletCard: _10))
            }
            else {
                return nil
            }
        }
        static func parse_updateJoinChatWebViewDecision(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.JoinChatBotResult?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.JoinChatBotResult
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateJoinChatWebViewDecision(Cons_updateJoinChatWebViewDecision(peer: _1!, queryId: _2!, result: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateLangPack(_ reader: BufferReader) -> Update? {
            var _1: Api.LangPackDifference?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.LangPackDifference
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateLangPack(Cons_updateLangPack(difference: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateLangPackTooLong(_ reader: BufferReader) -> Update? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateLangPackTooLong(Cons_updateLangPackTooLong(langCode: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateLoginToken(_ reader: BufferReader) -> Update? {
            return Api.Update.updateLoginToken
        }
        static func parse_updateManagedBot(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateManagedBot(Cons_updateManagedBot(userId: _1!, botId: _2!, qts: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateMessageExtendedMedia(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: [Api.MessageExtendedMedia]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageExtendedMedia.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateMessageExtendedMedia(Cons_updateMessageExtendedMedia(peer: _1!, msgId: _2!, extendedMedia: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateMessageID(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateMessageID(Cons_updateMessageID(id: _1!, randomId: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateMessagePoll(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Int64?
            _5 = reader.readInt64()
            var _6: Api.Poll?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.Poll
                }
            }
            var _7: Api.PollResults?
            if let signature = reader.readInt32() {
                _7 = Api.parse(reader, signature: signature) as? Api.PollResults
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _6 != nil
            let _c7 = _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.Update.updateMessagePoll(Cons_updateMessagePoll(flags: _1!, peer: _2, msgId: _3, topMsgId: _4, pollId: _5!, poll: _6, results: _7!))
            }
            else {
                return nil
            }
        }
        static func parse_updateMessagePollVote(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: [Buffer]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: -1255641564, elementType: Buffer.self)
            }
            var _4: [Int32]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            var _5: Int32?
            _5 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updateMessagePollVote(Cons_updateMessagePollVote(pollId: _1!, peer: _2!, options: _3!, positions: _4!, qts: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_updateMessageReactions(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _6: Api.MessageReactions?
            if let signature = reader.readInt32() {
                _6 = Api.parse(reader, signature: signature) as? Api.MessageReactions
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.Update.updateMessageReactions(Cons_updateMessageReactions(flags: _1!, peer: _2!, msgId: _3!, topMsgId: _4, savedPeerId: _5, reactions: _6!))
            }
            else {
                return nil
            }
        }
        static func parse_updateMessageWidgetData(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            var _5: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = reader.readInt64()
            }
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _6 = parseString(reader)
            }
            var _7: Int32?
            _7 = reader.readInt32()
            var _8: Int32?
            _8 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.Update.updateMessageWidgetData(Cons_updateMessageWidgetData(flags: _1!, peer: _2!, msgId: _3!, publicData: _4, publicDataHash: _5, chatData: _6, pts: _7!, ptsCount: _8!))
            }
            else {
                return nil
            }
        }
        static func parse_updateMonoForumNoPaidException(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.Peer?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateMonoForumNoPaidException(Cons_updateMonoForumNoPaidException(flags: _1!, channelId: _2!, savedPeerId: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateMoveStickerSetToTop(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateMoveStickerSetToTop(Cons_updateMoveStickerSetToTop(flags: _1!, stickerset: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateNewAuthorization(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updateNewAuthorization(Cons_updateNewAuthorization(flags: _1!, hash: _2!, date: _3, device: _4, location: _5))
            }
            else {
                return nil
            }
        }
        static func parse_updateNewBotConnection(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _3 = reader.readInt32()
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _4 = parseString(reader)
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _5 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updateNewBotConnection(Cons_updateNewBotConnection(flags: _1!, botId: _2!, date: _3, device: _4, location: _5))
            }
            else {
                return nil
            }
        }
        static func parse_updateNewChannelMessage(_ reader: BufferReader) -> Update? {
            var _1: Api.Message?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Message
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateNewChannelMessage(Cons_updateNewChannelMessage(message: _1!, pts: _2!, ptsCount: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateNewEncryptedMessage(_ reader: BufferReader) -> Update? {
            var _1: Api.EncryptedMessage?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.EncryptedMessage
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateNewEncryptedMessage(Cons_updateNewEncryptedMessage(message: _1!, qts: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateNewEphemeralMessage(_ reader: BufferReader) -> Update? {
            var _1: Api.EphemeralMessage?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.EphemeralMessage
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateNewEphemeralMessage(Cons_updateNewEphemeralMessage(message: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateNewMessage(_ reader: BufferReader) -> Update? {
            var _1: Api.Message?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Message
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateNewMessage(Cons_updateNewMessage(message: _1!, pts: _2!, ptsCount: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateNewQuickReply(_ reader: BufferReader) -> Update? {
            var _1: Api.QuickReply?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.QuickReply
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateNewQuickReply(Cons_updateNewQuickReply(quickReply: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateNewScheduledMessage(_ reader: BufferReader) -> Update? {
            var _1: Api.Message?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Message
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateNewScheduledMessage(Cons_updateNewScheduledMessage(message: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateNewStickerSet(_ reader: BufferReader) -> Update? {
            var _1: Api.messages.StickerSet?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.messages.StickerSet
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateNewStickerSet(Cons_updateNewStickerSet(stickerset: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateNewStoryReaction(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Api.Reaction?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Reaction
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateNewStoryReaction(Cons_updateNewStoryReaction(storyId: _1!, peer: _2!, reaction: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateNotifySettings(_ reader: BufferReader) -> Update? {
            var _1: Api.NotifyPeer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.NotifyPeer
            }
            var _2: Api.PeerNotifySettings?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.PeerNotifySettings
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateNotifySettings(Cons_updateNotifySettings(peer: _1!, notifySettings: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updatePaidReactionPrivacy(_ reader: BufferReader) -> Update? {
            var _1: Api.PaidReactionPrivacy?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.PaidReactionPrivacy
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updatePaidReactionPrivacy(Cons_updatePaidReactionPrivacy(private: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updatePeerBlocked(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updatePeerBlocked(Cons_updatePeerBlocked(flags: _1!, peerId: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updatePeerHistoryTTL(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updatePeerHistoryTTL(Cons_updatePeerHistoryTTL(flags: _1!, peer: _2!, ttlPeriod: _3))
            }
            else {
                return nil
            }
        }
        static func parse_updatePeerLocated(_ reader: BufferReader) -> Update? {
            var _1: [Api.PeerLocated]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PeerLocated.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updatePeerLocated(Cons_updatePeerLocated(peers: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updatePeerSettings(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Api.PeerSettings?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.PeerSettings
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updatePeerSettings(Cons_updatePeerSettings(peer: _1!, settings: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updatePeerWallpaper(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Api.WallPaper?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.WallPaper
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updatePeerWallpaper(Cons_updatePeerWallpaper(flags: _1!, peer: _2!, wallpaper: _3))
            }
            else {
                return nil
            }
        }
        static func parse_updatePendingJoinRequests(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: [Int64]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updatePendingJoinRequests(Cons_updatePendingJoinRequests(peer: _1!, requestsPending: _2!, recentRequesters: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updatePhoneCall(_ reader: BufferReader) -> Update? {
            var _1: Api.PhoneCall?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.PhoneCall
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updatePhoneCall(Cons_updatePhoneCall(phoneCall: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updatePhoneCallSignalingData(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Buffer?
            _2 = parseBytes(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updatePhoneCallSignalingData(Cons_updatePhoneCallSignalingData(phoneCallId: _1!, data: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updatePinnedChannelMessages(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: [Int32]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            _5 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updatePinnedChannelMessages(Cons_updatePinnedChannelMessages(flags: _1!, channelId: _2!, messages: _3!, pts: _4!, ptsCount: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_updatePinnedDialogs(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _2 = reader.readInt32()
            }
            var _3: [Api.DialogPeer]?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.DialogPeer.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updatePinnedDialogs(Cons_updatePinnedDialogs(flags: _1!, folderId: _2, order: _3))
            }
            else {
                return nil
            }
        }
        static func parse_updatePinnedForumTopic(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updatePinnedForumTopic(Cons_updatePinnedForumTopic(flags: _1!, peer: _2!, topicId: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updatePinnedForumTopics(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: [Int32]?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _3 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updatePinnedForumTopics(Cons_updatePinnedForumTopics(flags: _1!, peer: _2!, order: _3))
            }
            else {
                return nil
            }
        }
        static func parse_updatePinnedMessages(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: [Int32]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            _5 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updatePinnedMessages(Cons_updatePinnedMessages(flags: _1!, peer: _2!, messages: _3!, pts: _4!, ptsCount: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_updatePinnedSavedDialogs(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.DialogPeer]?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.DialogPeer.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            if _c1 && _c2 {
                return Api.Update.updatePinnedSavedDialogs(Cons_updatePinnedSavedDialogs(flags: _1!, order: _2))
            }
            else {
                return nil
            }
        }
        static func parse_updatePrivacy(_ reader: BufferReader) -> Update? {
            var _1: Api.PrivacyKey?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.PrivacyKey
            }
            var _2: [Api.PrivacyRule]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PrivacyRule.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updatePrivacy(Cons_updatePrivacy(key: _1!, rules: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updatePtsChanged(_ reader: BufferReader) -> Update? {
            return Api.Update.updatePtsChanged
        }
        static func parse_updateQuickReplies(_ reader: BufferReader) -> Update? {
            var _1: [Api.QuickReply]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.QuickReply.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateQuickReplies(Cons_updateQuickReplies(quickReplies: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateQuickReplyMessage(_ reader: BufferReader) -> Update? {
            var _1: Api.Message?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Message
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateQuickReplyMessage(Cons_updateQuickReplyMessage(message: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateReadChannelDiscussionInbox(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = reader.readInt64()
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _6 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.Update.updateReadChannelDiscussionInbox(Cons_updateReadChannelDiscussionInbox(flags: _1!, channelId: _2!, topMsgId: _3!, readMaxId: _4!, broadcastId: _5, broadcastPost: _6))
            }
            else {
                return nil
            }
        }
        static func parse_updateReadChannelDiscussionOutbox(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateReadChannelDiscussionOutbox(Cons_updateReadChannelDiscussionOutbox(channelId: _1!, topMsgId: _2!, readMaxId: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateReadChannelInbox(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt32()
            }
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int32?
            _6 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.Update.updateReadChannelInbox(Cons_updateReadChannelInbox(flags: _1!, folderId: _2, channelId: _3!, maxId: _4!, stillUnreadCount: _5!, pts: _6!))
            }
            else {
                return nil
            }
        }
        static func parse_updateReadChannelOutbox(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateReadChannelOutbox(Cons_updateReadChannelOutbox(channelId: _1!, maxId: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateReadFeaturedEmojiStickers(_ reader: BufferReader) -> Update? {
            return Api.Update.updateReadFeaturedEmojiStickers
        }
        static func parse_updateReadFeaturedStickers(_ reader: BufferReader) -> Update? {
            return Api.Update.updateReadFeaturedStickers
        }
        static func parse_updateReadHistoryInbox(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt32()
            }
            var _3: Api.Peer?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: Int32?
            _7 = reader.readInt32()
            var _8: Int32?
            _8 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.Update.updateReadHistoryInbox(Cons_updateReadHistoryInbox(flags: _1!, folderId: _2, peer: _3!, topMsgId: _4, maxId: _5!, stillUnreadCount: _6!, pts: _7!, ptsCount: _8!))
            }
            else {
                return nil
            }
        }
        static func parse_updateReadHistoryOutbox(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Update.updateReadHistoryOutbox(Cons_updateReadHistoryOutbox(peer: _1!, maxId: _2!, pts: _3!, ptsCount: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_updateReadMessagesContents(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Int32]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updateReadMessagesContents(Cons_updateReadMessagesContents(flags: _1!, messages: _2!, pts: _3!, ptsCount: _4!, date: _5))
            }
            else {
                return nil
            }
        }
        static func parse_updateReadMonoForumInbox(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateReadMonoForumInbox(Cons_updateReadMonoForumInbox(channelId: _1!, savedPeerId: _2!, readMaxId: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateReadMonoForumOutbox(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateReadMonoForumOutbox(Cons_updateReadMonoForumOutbox(channelId: _1!, savedPeerId: _2!, readMaxId: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateReadStories(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateReadStories(Cons_updateReadStories(peer: _1!, maxId: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateRecentEmojiStatuses(_ reader: BufferReader) -> Update? {
            return Api.Update.updateRecentEmojiStatuses
        }
        static func parse_updateRecentReactions(_ reader: BufferReader) -> Update? {
            return Api.Update.updateRecentReactions
        }
        static func parse_updateRecentStickers(_ reader: BufferReader) -> Update? {
            return Api.Update.updateRecentStickers
        }
        static func parse_updateSavedDialogPinned(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.DialogPeer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.DialogPeer
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateSavedDialogPinned(Cons_updateSavedDialogPinned(flags: _1!, peer: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateSavedGifs(_ reader: BufferReader) -> Update? {
            return Api.Update.updateSavedGifs
        }
        static func parse_updateSavedReactionTags(_ reader: BufferReader) -> Update? {
            return Api.Update.updateSavedReactionTags
        }
        static func parse_updateSavedRingtones(_ reader: BufferReader) -> Update? {
            return Api.Update.updateSavedRingtones
        }
        static func parse_updateSentPhoneCode(_ reader: BufferReader) -> Update? {
            var _1: Api.auth.SentCode?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.auth.SentCode
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateSentPhoneCode(Cons_updateSentPhoneCode(sentCode: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateSentStoryReaction(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.Reaction?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Reaction
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateSentStoryReaction(Cons_updateSentStoryReaction(peer: _1!, storyId: _2!, reaction: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateSentWalletTransaction(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Api.WalletTransaction?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.WalletTransaction
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateSentWalletTransaction(Cons_updateSentWalletTransaction(flags: _1!, msgHash: _2!, transaction: _3))
            }
            else {
                return nil
            }
        }
        static func parse_updateServiceNotification(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _2 = reader.readInt32()
            }
            var _3: String?
            _3 = parseString(reader)
            var _4: String?
            _4 = parseString(reader)
            var _5: Api.MessageMedia?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.MessageMedia
            }
            var _6: [Api.MessageEntity]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self)
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.Update.updateServiceNotification(Cons_updateServiceNotification(flags: _1!, inboxDate: _2, type: _3!, message: _4!, media: _5!, entities: _6!))
            }
            else {
                return nil
            }
        }
        static func parse_updateSmsJob(_ reader: BufferReader) -> Update? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateSmsJob(Cons_updateSmsJob(jobId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateStarGiftAuctionState(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Api.StarGiftAuctionState?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.StarGiftAuctionState
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateStarGiftAuctionState(Cons_updateStarGiftAuctionState(giftId: _1!, state: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateStarGiftAuctionUserState(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Api.StarGiftAuctionUserState?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.StarGiftAuctionUserState
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateStarGiftAuctionUserState(Cons_updateStarGiftAuctionUserState(giftId: _1!, userState: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateStarGiftCraftFail(_ reader: BufferReader) -> Update? {
            return Api.Update.updateStarGiftCraftFail
        }
        static func parse_updateStarsBalance(_ reader: BufferReader) -> Update? {
            var _1: Api.StarsAmount?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.StarsAmount
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateStarsBalance(Cons_updateStarsBalance(balance: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateStarsRevenueStatus(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Api.StarsRevenueStatus?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.StarsRevenueStatus
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateStarsRevenueStatus(Cons_updateStarsRevenueStatus(peer: _1!, status: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateStickerSets(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateStickerSets(Cons_updateStickerSets(flags: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateStickerSetsOrder(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Int64]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateStickerSetsOrder(Cons_updateStickerSetsOrder(flags: _1!, order: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateStoriesStealthMode(_ reader: BufferReader) -> Update? {
            var _1: Api.StoriesStealthMode?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.StoriesStealthMode
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateStoriesStealthMode(Cons_updateStoriesStealthMode(stealthMode: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateStory(_ reader: BufferReader) -> Update? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Api.StoryItem?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.StoryItem
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateStory(Cons_updateStory(peer: _1!, story: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateStoryID(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateStoryID(Cons_updateStoryID(id: _1!, randomId: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateTheme(_ reader: BufferReader) -> Update? {
            var _1: Api.Theme?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Theme
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateTheme(Cons_updateTheme(theme: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateTranscribedAudio(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: String?
            _5 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updateTranscribedAudio(Cons_updateTranscribedAudio(flags: _1!, peer: _2!, msgId: _3!, transcriptionId: _4!, text: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_updateTranscribedAudioFile(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            _3 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateTranscribedAudioFile(Cons_updateTranscribedAudioFile(flags: _1!, transcriptionId: _2!, text: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateUser(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateUser(Cons_updateUser(userId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateUserEmojiStatus(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Api.EmojiStatus?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.EmojiStatus
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateUserEmojiStatus(Cons_updateUserEmojiStatus(userId: _1!, emojiStatus: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateUserName(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            _3 = parseString(reader)
            var _4: [Api.Username]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Username.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Update.updateUserName(Cons_updateUserName(userId: _1!, firstName: _2!, lastName: _3!, usernames: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_updateUserPhone(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateUserPhone(Cons_updateUserPhone(userId: _1!, phone: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateUserStatus(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Api.UserStatus?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.UserStatus
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Update.updateUserStatus(Cons_updateUserStatus(userId: _1!, status: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateUserTyping(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Api.SendMessageAction?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.SendMessageAction
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Update.updateUserTyping(Cons_updateUserTyping(flags: _1!, userId: _2!, topMsgId: _3, action: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_updateWalletGaslessInfo(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: String?
            _5 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Update.updateWalletGaslessInfo(Cons_updateWalletGaslessInfo(flags: _1!, left: _2!, resetAt: _3!, minAmount: _4!, relayerAddress: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_updateWalletState(_ reader: BufferReader) -> Update? {
            var _1: Api.WalletState?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.WalletState
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateWalletState(Cons_updateWalletState(state: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateWalletTonConnectPendingDisconnect(_ reader: BufferReader) -> Update? {
            var _1: [Int64]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateWalletTonConnectPendingDisconnect(Cons_updateWalletTonConnectPendingDisconnect(sessionIds: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateWalletTonConnectSession(_ reader: BufferReader) -> Update? {
            var _1: Api.TonConnectSession?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.TonConnectSession
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateWalletTonConnectSession(Cons_updateWalletTonConnectSession(session: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateWebBrowserException(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            var _3: Api.WebDomainException?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.WebDomainException
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateWebBrowserException(Cons_updateWebBrowserException(flags: _1!, openExternalBrowser: _2, exception: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateWebBrowserSettings(_ reader: BufferReader) -> Update? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateWebBrowserSettings(Cons_updateWebBrowserSettings(flags: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_updateWebPage(_ reader: BufferReader) -> Update? {
            var _1: Api.WebPage?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.WebPage
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Update.updateWebPage(Cons_updateWebPage(webpage: _1!, pts: _2!, ptsCount: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_updateWebViewResultSent(_ reader: BufferReader) -> Update? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.Update.updateWebViewResultSent(Cons_updateWebViewResultSent(queryId: _1!))
            }
            else {
                return nil
            }
        }
    }
}
