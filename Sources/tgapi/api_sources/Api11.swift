extension Api {
    indirect enum MessageAction: TypeConstructorDescription {
        class Cons_messageActionBoostApply: TypeConstructorDescription {
            var boosts: Int32
            init(boosts: Int32) {
                self.boosts = boosts
            }
        }
        class Cons_messageActionBotAllowed: TypeConstructorDescription {
            var flags: Int32
            var domain: String?
            var app: Api.BotApp?
            init(flags: Int32, domain: String?, app: Api.BotApp?) {
                self.flags = flags
                self.domain = domain
                self.app = app
            }
        }
        class Cons_messageActionChangeCommunity: TypeConstructorDescription {
            var flags: Int32
            var communityId: Int64?
            init(flags: Int32, communityId: Int64?) {
                self.flags = flags
                self.communityId = communityId
            }
        }
        class Cons_messageActionChangeCreator: TypeConstructorDescription {
            var newCreatorId: Int64
            init(newCreatorId: Int64) {
                self.newCreatorId = newCreatorId
            }
        }
        class Cons_messageActionChannelCreate: TypeConstructorDescription {
            var title: String
            init(title: String) {
                self.title = title
            }
        }
        class Cons_messageActionChannelMigrateFrom: TypeConstructorDescription {
            var title: String
            var chatId: Int64
            init(title: String, chatId: Int64) {
                self.title = title
                self.chatId = chatId
            }
        }
        class Cons_messageActionChatAddUser: TypeConstructorDescription {
            var users: [Int64]
            init(users: [Int64]) {
                self.users = users
            }
        }
        class Cons_messageActionChatCreate: TypeConstructorDescription {
            var title: String
            var users: [Int64]
            init(title: String, users: [Int64]) {
                self.title = title
                self.users = users
            }
        }
        class Cons_messageActionChatDeleteUser: TypeConstructorDescription {
            var userId: Int64
            init(userId: Int64) {
                self.userId = userId
            }
        }
        class Cons_messageActionChatEditPhoto: TypeConstructorDescription {
            var photo: Api.Photo
            init(photo: Api.Photo) {
                self.photo = photo
            }
        }
        class Cons_messageActionChatEditTitle: TypeConstructorDescription {
            var title: String
            init(title: String) {
                self.title = title
            }
        }
        class Cons_messageActionChatJoinedByLink: TypeConstructorDescription {
            var inviterId: Int64
            init(inviterId: Int64) {
                self.inviterId = inviterId
            }
        }
        class Cons_messageActionChatJoinedViaCommunity: TypeConstructorDescription {
            var communityId: Int64
            init(communityId: Int64) {
                self.communityId = communityId
            }
        }
        class Cons_messageActionChatMigrateTo: TypeConstructorDescription {
            var channelId: Int64
            init(channelId: Int64) {
                self.channelId = channelId
            }
        }
        class Cons_messageActionConferenceCall: TypeConstructorDescription {
            var flags: Int32
            var callId: Int64
            var duration: Int32?
            var otherParticipants: [Api.Peer]?
            init(flags: Int32, callId: Int64, duration: Int32?, otherParticipants: [Api.Peer]?) {
                self.flags = flags
                self.callId = callId
                self.duration = duration
                self.otherParticipants = otherParticipants
            }
        }
        class Cons_messageActionCustomAction: TypeConstructorDescription {
            var message: String
            init(message: String) {
                self.message = message
            }
        }
        class Cons_messageActionGameScore: TypeConstructorDescription {
            var gameId: Int64
            var score: Int32
            init(gameId: Int64, score: Int32) {
                self.gameId = gameId
                self.score = score
            }
        }
        class Cons_messageActionGeoProximityReached: TypeConstructorDescription {
            var fromId: Api.Peer
            var toId: Api.Peer
            var distance: Int32
            init(fromId: Api.Peer, toId: Api.Peer, distance: Int32) {
                self.fromId = fromId
                self.toId = toId
                self.distance = distance
            }
        }
        class Cons_messageActionGiftCode: TypeConstructorDescription {
            var flags: Int32
            var boostPeer: Api.Peer?
            var days: Int32
            var slug: String
            var currency: String?
            var amount: Int64?
            var cryptoCurrency: String?
            var cryptoAmount: Int64?
            var message: Api.TextWithEntities?
            init(flags: Int32, boostPeer: Api.Peer?, days: Int32, slug: String, currency: String?, amount: Int64?, cryptoCurrency: String?, cryptoAmount: Int64?, message: Api.TextWithEntities?) {
                self.flags = flags
                self.boostPeer = boostPeer
                self.days = days
                self.slug = slug
                self.currency = currency
                self.amount = amount
                self.cryptoCurrency = cryptoCurrency
                self.cryptoAmount = cryptoAmount
                self.message = message
            }
        }
        class Cons_messageActionGiftPremium: TypeConstructorDescription {
            var flags: Int32
            var currency: String
            var amount: Int64
            var days: Int32
            var cryptoCurrency: String?
            var cryptoAmount: Int64?
            var message: Api.TextWithEntities?
            init(flags: Int32, currency: String, amount: Int64, days: Int32, cryptoCurrency: String?, cryptoAmount: Int64?, message: Api.TextWithEntities?) {
                self.flags = flags
                self.currency = currency
                self.amount = amount
                self.days = days
                self.cryptoCurrency = cryptoCurrency
                self.cryptoAmount = cryptoAmount
                self.message = message
            }
        }
        class Cons_messageActionGiftStars: TypeConstructorDescription {
            var flags: Int32
            var currency: String
            var amount: Int64
            var stars: Int64
            var cryptoCurrency: String?
            var cryptoAmount: Int64?
            var transactionId: String?
            init(flags: Int32, currency: String, amount: Int64, stars: Int64, cryptoCurrency: String?, cryptoAmount: Int64?, transactionId: String?) {
                self.flags = flags
                self.currency = currency
                self.amount = amount
                self.stars = stars
                self.cryptoCurrency = cryptoCurrency
                self.cryptoAmount = cryptoAmount
                self.transactionId = transactionId
            }
        }
        class Cons_messageActionGiftTon: TypeConstructorDescription {
            var flags: Int32
            var currency: String
            var amount: Int64
            var cryptoCurrency: String
            var cryptoAmount: Int64
            var transactionId: String?
            init(flags: Int32, currency: String, amount: Int64, cryptoCurrency: String, cryptoAmount: Int64, transactionId: String?) {
                self.flags = flags
                self.currency = currency
                self.amount = amount
                self.cryptoCurrency = cryptoCurrency
                self.cryptoAmount = cryptoAmount
                self.transactionId = transactionId
            }
        }
        class Cons_messageActionGiveawayLaunch: TypeConstructorDescription {
            var flags: Int32
            var stars: Int64?
            init(flags: Int32, stars: Int64?) {
                self.flags = flags
                self.stars = stars
            }
        }
        class Cons_messageActionGiveawayResults: TypeConstructorDescription {
            var flags: Int32
            var winnersCount: Int32
            var unclaimedCount: Int32
            init(flags: Int32, winnersCount: Int32, unclaimedCount: Int32) {
                self.flags = flags
                self.winnersCount = winnersCount
                self.unclaimedCount = unclaimedCount
            }
        }
        class Cons_messageActionGramTransfer: TypeConstructorDescription {
            var flags: Int32
            var amount: Int64
            var peerAddress: String
            var transactionId: String
            var comment: String?
            init(flags: Int32, amount: Int64, peerAddress: String, transactionId: String, comment: String?) {
                self.flags = flags
                self.amount = amount
                self.peerAddress = peerAddress
                self.transactionId = transactionId
                self.comment = comment
            }
        }
        class Cons_messageActionGroupCall: TypeConstructorDescription {
            var flags: Int32
            var call: Api.InputGroupCall
            var duration: Int32?
            init(flags: Int32, call: Api.InputGroupCall, duration: Int32?) {
                self.flags = flags
                self.call = call
                self.duration = duration
            }
        }
        class Cons_messageActionGroupCallScheduled: TypeConstructorDescription {
            var call: Api.InputGroupCall
            var scheduleDate: Int32
            init(call: Api.InputGroupCall, scheduleDate: Int32) {
                self.call = call
                self.scheduleDate = scheduleDate
            }
        }
        class Cons_messageActionInviteToGroupCall: TypeConstructorDescription {
            var call: Api.InputGroupCall
            var users: [Int64]
            init(call: Api.InputGroupCall, users: [Int64]) {
                self.call = call
                self.users = users
            }
        }
        class Cons_messageActionManagedBotCreated: TypeConstructorDescription {
            var botId: Int64
            init(botId: Int64) {
                self.botId = botId
            }
        }
        class Cons_messageActionNewCreatorPending: TypeConstructorDescription {
            var newCreatorId: Int64
            init(newCreatorId: Int64) {
                self.newCreatorId = newCreatorId
            }
        }
        class Cons_messageActionNoForwardsRequest: TypeConstructorDescription {
            var flags: Int32
            var prevValue: Api.Bool
            var newValue: Api.Bool
            init(flags: Int32, prevValue: Api.Bool, newValue: Api.Bool) {
                self.flags = flags
                self.prevValue = prevValue
                self.newValue = newValue
            }
        }
        class Cons_messageActionNoForwardsToggle: TypeConstructorDescription {
            var prevValue: Api.Bool
            var newValue: Api.Bool
            init(prevValue: Api.Bool, newValue: Api.Bool) {
                self.prevValue = prevValue
                self.newValue = newValue
            }
        }
        class Cons_messageActionPaidMessagesPrice: TypeConstructorDescription {
            var flags: Int32
            var stars: Int64
            init(flags: Int32, stars: Int64) {
                self.flags = flags
                self.stars = stars
            }
        }
        class Cons_messageActionPaidMessagesRefunded: TypeConstructorDescription {
            var count: Int32
            var stars: Int64
            init(count: Int32, stars: Int64) {
                self.count = count
                self.stars = stars
            }
        }
        class Cons_messageActionPaymentRefunded: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var currency: String
            var totalAmount: Int64
            var payload: Buffer?
            var charge: Api.PaymentCharge
            init(flags: Int32, peer: Api.Peer, currency: String, totalAmount: Int64, payload: Buffer?, charge: Api.PaymentCharge) {
                self.flags = flags
                self.peer = peer
                self.currency = currency
                self.totalAmount = totalAmount
                self.payload = payload
                self.charge = charge
            }
        }
        class Cons_messageActionPaymentSent: TypeConstructorDescription {
            var flags: Int32
            var currency: String
            var totalAmount: Int64
            var invoiceSlug: String?
            var subscriptionUntilDate: Int32?
            init(flags: Int32, currency: String, totalAmount: Int64, invoiceSlug: String?, subscriptionUntilDate: Int32?) {
                self.flags = flags
                self.currency = currency
                self.totalAmount = totalAmount
                self.invoiceSlug = invoiceSlug
                self.subscriptionUntilDate = subscriptionUntilDate
            }
        }
        class Cons_messageActionPaymentSentMe: TypeConstructorDescription {
            var flags: Int32
            var currency: String
            var totalAmount: Int64
            var payload: Buffer
            var info: Api.PaymentRequestedInfo?
            var shippingOptionId: String?
            var charge: Api.PaymentCharge
            var subscriptionUntilDate: Int32?
            init(flags: Int32, currency: String, totalAmount: Int64, payload: Buffer, info: Api.PaymentRequestedInfo?, shippingOptionId: String?, charge: Api.PaymentCharge, subscriptionUntilDate: Int32?) {
                self.flags = flags
                self.currency = currency
                self.totalAmount = totalAmount
                self.payload = payload
                self.info = info
                self.shippingOptionId = shippingOptionId
                self.charge = charge
                self.subscriptionUntilDate = subscriptionUntilDate
            }
        }
        class Cons_messageActionPhoneCall: TypeConstructorDescription {
            var flags: Int32
            var callId: Int64
            var reason: Api.PhoneCallDiscardReason?
            var duration: Int32?
            init(flags: Int32, callId: Int64, reason: Api.PhoneCallDiscardReason?, duration: Int32?) {
                self.flags = flags
                self.callId = callId
                self.reason = reason
                self.duration = duration
            }
        }
        class Cons_messageActionPollAppendAnswer: TypeConstructorDescription {
            var answer: Api.PollAnswer
            init(answer: Api.PollAnswer) {
                self.answer = answer
            }
        }
        class Cons_messageActionPollDeleteAnswer: TypeConstructorDescription {
            var answer: Api.PollAnswer
            init(answer: Api.PollAnswer) {
                self.answer = answer
            }
        }
        class Cons_messageActionPrizeStars: TypeConstructorDescription {
            var flags: Int32
            var stars: Int64
            var transactionId: String
            var boostPeer: Api.Peer
            var giveawayMsgId: Int32
            init(flags: Int32, stars: Int64, transactionId: String, boostPeer: Api.Peer, giveawayMsgId: Int32) {
                self.flags = flags
                self.stars = stars
                self.transactionId = transactionId
                self.boostPeer = boostPeer
                self.giveawayMsgId = giveawayMsgId
            }
        }
        class Cons_messageActionRequestedPeer: TypeConstructorDescription {
            var buttonId: Int32
            var peers: [Api.Peer]
            init(buttonId: Int32, peers: [Api.Peer]) {
                self.buttonId = buttonId
                self.peers = peers
            }
        }
        class Cons_messageActionRequestedPeerSentMe: TypeConstructorDescription {
            var buttonId: Int32
            var peers: [Api.RequestedPeer]
            init(buttonId: Int32, peers: [Api.RequestedPeer]) {
                self.buttonId = buttonId
                self.peers = peers
            }
        }
        class Cons_messageActionSecureValuesSent: TypeConstructorDescription {
            var types: [Api.SecureValueType]
            init(types: [Api.SecureValueType]) {
                self.types = types
            }
        }
        class Cons_messageActionSecureValuesSentMe: TypeConstructorDescription {
            var values: [Api.SecureValue]
            var credentials: Api.SecureCredentialsEncrypted
            init(values: [Api.SecureValue], credentials: Api.SecureCredentialsEncrypted) {
                self.values = values
                self.credentials = credentials
            }
        }
        class Cons_messageActionSetChatTheme: TypeConstructorDescription {
            var theme: Api.ChatTheme
            init(theme: Api.ChatTheme) {
                self.theme = theme
            }
        }
        class Cons_messageActionSetChatWallPaper: TypeConstructorDescription {
            var flags: Int32
            var wallpaper: Api.WallPaper
            init(flags: Int32, wallpaper: Api.WallPaper) {
                self.flags = flags
                self.wallpaper = wallpaper
            }
        }
        class Cons_messageActionSetMessagesTTL: TypeConstructorDescription {
            var flags: Int32
            var period: Int32
            var autoSettingFrom: Int64?
            init(flags: Int32, period: Int32, autoSettingFrom: Int64?) {
                self.flags = flags
                self.period = period
                self.autoSettingFrom = autoSettingFrom
            }
        }
        class Cons_messageActionStarGift: TypeConstructorDescription {
            var flags: Int32
            var gift: Api.StarGift
            var message: Api.TextWithEntities?
            var convertStars: Int64?
            var upgradeMsgId: Int32?
            var upgradeStars: Int64?
            var fromId: Api.Peer?
            var peer: Api.Peer?
            var savedId: Int64?
            var prepaidUpgradeHash: String?
            var giftMsgId: Int32?
            var toId: Api.Peer?
            var giftNum: Int32?
            init(flags: Int32, gift: Api.StarGift, message: Api.TextWithEntities?, convertStars: Int64?, upgradeMsgId: Int32?, upgradeStars: Int64?, fromId: Api.Peer?, peer: Api.Peer?, savedId: Int64?, prepaidUpgradeHash: String?, giftMsgId: Int32?, toId: Api.Peer?, giftNum: Int32?) {
                self.flags = flags
                self.gift = gift
                self.message = message
                self.convertStars = convertStars
                self.upgradeMsgId = upgradeMsgId
                self.upgradeStars = upgradeStars
                self.fromId = fromId
                self.peer = peer
                self.savedId = savedId
                self.prepaidUpgradeHash = prepaidUpgradeHash
                self.giftMsgId = giftMsgId
                self.toId = toId
                self.giftNum = giftNum
            }
        }
        class Cons_messageActionStarGiftPurchaseOffer: TypeConstructorDescription {
            var flags: Int32
            var gift: Api.StarGift
            var price: Api.StarsAmount
            var expiresAt: Int32
            init(flags: Int32, gift: Api.StarGift, price: Api.StarsAmount, expiresAt: Int32) {
                self.flags = flags
                self.gift = gift
                self.price = price
                self.expiresAt = expiresAt
            }
        }
        class Cons_messageActionStarGiftPurchaseOfferDeclined: TypeConstructorDescription {
            var flags: Int32
            var gift: Api.StarGift
            var price: Api.StarsAmount
            init(flags: Int32, gift: Api.StarGift, price: Api.StarsAmount) {
                self.flags = flags
                self.gift = gift
                self.price = price
            }
        }
        class Cons_messageActionStarGiftUnique: TypeConstructorDescription {
            var flags: Int32
            var gift: Api.StarGift
            var canExportAt: Int32?
            var transferStars: Int64?
            var fromId: Api.Peer?
            var peer: Api.Peer?
            var savedId: Int64?
            var resaleAmount: Api.StarsAmount?
            var canTransferAt: Int32?
            var canResellAt: Int32?
            var dropOriginalDetailsStars: Int64?
            var canCraftAt: Int32?
            var message: Api.TextWithEntities?
            init(flags: Int32, gift: Api.StarGift, canExportAt: Int32?, transferStars: Int64?, fromId: Api.Peer?, peer: Api.Peer?, savedId: Int64?, resaleAmount: Api.StarsAmount?, canTransferAt: Int32?, canResellAt: Int32?, dropOriginalDetailsStars: Int64?, canCraftAt: Int32?, message: Api.TextWithEntities?) {
                self.flags = flags
                self.gift = gift
                self.canExportAt = canExportAt
                self.transferStars = transferStars
                self.fromId = fromId
                self.peer = peer
                self.savedId = savedId
                self.resaleAmount = resaleAmount
                self.canTransferAt = canTransferAt
                self.canResellAt = canResellAt
                self.dropOriginalDetailsStars = dropOriginalDetailsStars
                self.canCraftAt = canCraftAt
                self.message = message
            }
        }
        class Cons_messageActionSuggestBirthday: TypeConstructorDescription {
            var birthday: Api.Birthday
            init(birthday: Api.Birthday) {
                self.birthday = birthday
            }
        }
        class Cons_messageActionSuggestProfilePhoto: TypeConstructorDescription {
            var photo: Api.Photo
            init(photo: Api.Photo) {
                self.photo = photo
            }
        }
        class Cons_messageActionSuggestedPostApproval: TypeConstructorDescription {
            var flags: Int32
            var rejectComment: String?
            var scheduleDate: Int32?
            var price: Api.StarsAmount?
            init(flags: Int32, rejectComment: String?, scheduleDate: Int32?, price: Api.StarsAmount?) {
                self.flags = flags
                self.rejectComment = rejectComment
                self.scheduleDate = scheduleDate
                self.price = price
            }
        }
        class Cons_messageActionSuggestedPostRefund: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        class Cons_messageActionSuggestedPostSuccess: TypeConstructorDescription {
            var price: Api.StarsAmount
            init(price: Api.StarsAmount) {
                self.price = price
            }
        }
        class Cons_messageActionTodoAppendTasks: TypeConstructorDescription {
            var list: [Api.TodoItem]
            init(list: [Api.TodoItem]) {
                self.list = list
            }
        }
        class Cons_messageActionTodoCompletions: TypeConstructorDescription {
            var completed: [Int32]
            var incompleted: [Int32]
            init(completed: [Int32], incompleted: [Int32]) {
                self.completed = completed
                self.incompleted = incompleted
            }
        }
        class Cons_messageActionTopicCreate: TypeConstructorDescription {
            var flags: Int32
            var title: String
            var iconColor: Int32
            var iconEmojiId: Int64?
            init(flags: Int32, title: String, iconColor: Int32, iconEmojiId: Int64?) {
                self.flags = flags
                self.title = title
                self.iconColor = iconColor
                self.iconEmojiId = iconEmojiId
            }
        }
        class Cons_messageActionTopicEdit: TypeConstructorDescription {
            var flags: Int32
            var title: String?
            var iconEmojiId: Int64?
            var closed: Api.Bool?
            var hidden: Api.Bool?
            init(flags: Int32, title: String?, iconEmojiId: Int64?, closed: Api.Bool?, hidden: Api.Bool?) {
                self.flags = flags
                self.title = title
                self.iconEmojiId = iconEmojiId
                self.closed = closed
                self.hidden = hidden
            }
        }
        class Cons_messageActionWalletTonConnectRequest: TypeConstructorDescription {
            var flags: Int32
            var sessionId: Int64
            var expires: Int32
            var topic: String?
            var traceId: String?
            var dappName: String?
            init(flags: Int32, sessionId: Int64, expires: Int32, topic: String?, traceId: String?, dappName: String?) {
                self.flags = flags
                self.sessionId = sessionId
                self.expires = expires
                self.topic = topic
                self.traceId = traceId
                self.dappName = dappName
            }
        }
        class Cons_messageActionWebViewDataSent: TypeConstructorDescription {
            var text: String
            init(text: String) {
                self.text = text
            }
        }
        class Cons_messageActionWebViewDataSentMe: TypeConstructorDescription {
            var text: String
            var data: String
            init(text: String, data: String) {
                self.text = text
                self.data = data
            }
        }
        case messageActionBoostApply(Cons_messageActionBoostApply)
        case messageActionBotAllowed(Cons_messageActionBotAllowed)
        case messageActionChangeCommunity(Cons_messageActionChangeCommunity)
        case messageActionChangeCreator(Cons_messageActionChangeCreator)
        case messageActionChannelCreate(Cons_messageActionChannelCreate)
        case messageActionChannelMigrateFrom(Cons_messageActionChannelMigrateFrom)
        case messageActionChatAddUser(Cons_messageActionChatAddUser)
        case messageActionChatCreate(Cons_messageActionChatCreate)
        case messageActionChatDeletePhoto
        case messageActionChatDeleteUser(Cons_messageActionChatDeleteUser)
        case messageActionChatEditPhoto(Cons_messageActionChatEditPhoto)
        case messageActionChatEditTitle(Cons_messageActionChatEditTitle)
        case messageActionChatJoinedByLink(Cons_messageActionChatJoinedByLink)
        case messageActionChatJoinedByRequest
        case messageActionChatJoinedViaCommunity(Cons_messageActionChatJoinedViaCommunity)
        case messageActionChatMigrateTo(Cons_messageActionChatMigrateTo)
        case messageActionConferenceCall(Cons_messageActionConferenceCall)
        case messageActionContactSignUp
        case messageActionCustomAction(Cons_messageActionCustomAction)
        case messageActionEmpty
        case messageActionGameScore(Cons_messageActionGameScore)
        case messageActionGeoProximityReached(Cons_messageActionGeoProximityReached)
        case messageActionGiftCode(Cons_messageActionGiftCode)
        case messageActionGiftPremium(Cons_messageActionGiftPremium)
        case messageActionGiftStars(Cons_messageActionGiftStars)
        case messageActionGiftTon(Cons_messageActionGiftTon)
        case messageActionGiveawayLaunch(Cons_messageActionGiveawayLaunch)
        case messageActionGiveawayResults(Cons_messageActionGiveawayResults)
        case messageActionGramTransfer(Cons_messageActionGramTransfer)
        case messageActionGroupCall(Cons_messageActionGroupCall)
        case messageActionGroupCallScheduled(Cons_messageActionGroupCallScheduled)
        case messageActionHistoryClear
        case messageActionInviteToGroupCall(Cons_messageActionInviteToGroupCall)
        case messageActionManagedBotCreated(Cons_messageActionManagedBotCreated)
        case messageActionNewCreatorPending(Cons_messageActionNewCreatorPending)
        case messageActionNoForwardsRequest(Cons_messageActionNoForwardsRequest)
        case messageActionNoForwardsToggle(Cons_messageActionNoForwardsToggle)
        case messageActionNoPaidMessagesTokenUsed
        case messageActionPaidMessagesPrice(Cons_messageActionPaidMessagesPrice)
        case messageActionPaidMessagesRefunded(Cons_messageActionPaidMessagesRefunded)
        case messageActionPaymentRefunded(Cons_messageActionPaymentRefunded)
        case messageActionPaymentSent(Cons_messageActionPaymentSent)
        case messageActionPaymentSentMe(Cons_messageActionPaymentSentMe)
        case messageActionPhoneCall(Cons_messageActionPhoneCall)
        case messageActionPinMessage
        case messageActionPollAppendAnswer(Cons_messageActionPollAppendAnswer)
        case messageActionPollDeleteAnswer(Cons_messageActionPollDeleteAnswer)
        case messageActionPrizeStars(Cons_messageActionPrizeStars)
        case messageActionRequestedPeer(Cons_messageActionRequestedPeer)
        case messageActionRequestedPeerSentMe(Cons_messageActionRequestedPeerSentMe)
        case messageActionScreenshotTaken
        case messageActionSecureValuesSent(Cons_messageActionSecureValuesSent)
        case messageActionSecureValuesSentMe(Cons_messageActionSecureValuesSentMe)
        case messageActionSetChatTheme(Cons_messageActionSetChatTheme)
        case messageActionSetChatWallPaper(Cons_messageActionSetChatWallPaper)
        case messageActionSetMessagesTTL(Cons_messageActionSetMessagesTTL)
        case messageActionStarGift(Cons_messageActionStarGift)
        case messageActionStarGiftPurchaseOffer(Cons_messageActionStarGiftPurchaseOffer)
        case messageActionStarGiftPurchaseOfferDeclined(Cons_messageActionStarGiftPurchaseOfferDeclined)
        case messageActionStarGiftUnique(Cons_messageActionStarGiftUnique)
        case messageActionSuggestBirthday(Cons_messageActionSuggestBirthday)
        case messageActionSuggestProfilePhoto(Cons_messageActionSuggestProfilePhoto)
        case messageActionSuggestedPostApproval(Cons_messageActionSuggestedPostApproval)
        case messageActionSuggestedPostRefund(Cons_messageActionSuggestedPostRefund)
        case messageActionSuggestedPostSuccess(Cons_messageActionSuggestedPostSuccess)
        case messageActionTodoAppendTasks(Cons_messageActionTodoAppendTasks)
        case messageActionTodoCompletions(Cons_messageActionTodoCompletions)
        case messageActionTopicCreate(Cons_messageActionTopicCreate)
        case messageActionTopicEdit(Cons_messageActionTopicEdit)
        case messageActionWalletTonConnectRequest(Cons_messageActionWalletTonConnectRequest)
        case messageActionWebViewDataSent(Cons_messageActionWebViewDataSent)
        case messageActionWebViewDataSentMe(Cons_messageActionWebViewDataSentMe)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .messageActionBoostApply(let _data):
                if boxed {
                    buffer.appendInt32(-872240531)
                }
                serializeInt32(_data.boosts, buffer: buffer, boxed: false)
                break
            case .messageActionBotAllowed(let _data):
                if boxed {
                    buffer.appendInt32(-988359047)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.domain!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.app!.serialize(buffer, true)
                }
                break
            case .messageActionChangeCommunity(let _data):
                if boxed {
                    buffer.appendInt32(1562426088)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.communityId!, buffer: buffer, boxed: false)
                }
                break
            case .messageActionChangeCreator(let _data):
                if boxed {
                    buffer.appendInt32(-511160261)
                }
                serializeInt64(_data.newCreatorId, buffer: buffer, boxed: false)
                break
            case .messageActionChannelCreate(let _data):
                if boxed {
                    buffer.appendInt32(-1781355374)
                }
                serializeString(_data.title, buffer: buffer, boxed: false)
                break
            case .messageActionChannelMigrateFrom(let _data):
                if boxed {
                    buffer.appendInt32(-365344535)
                }
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeInt64(_data.chatId, buffer: buffer, boxed: false)
                break
            case .messageActionChatAddUser(let _data):
                if boxed {
                    buffer.appendInt32(365886720)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    serializeInt64(item, buffer: buffer, boxed: false)
                }
                break
            case .messageActionChatCreate(let _data):
                if boxed {
                    buffer.appendInt32(-1119368275)
                }
                serializeString(_data.title, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    serializeInt64(item, buffer: buffer, boxed: false)
                }
                break
            case .messageActionChatDeletePhoto:
                if boxed {
                    buffer.appendInt32(-1780220945)
                }
                break
            case .messageActionChatDeleteUser(let _data):
                if boxed {
                    buffer.appendInt32(-1539362612)
                }
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                break
            case .messageActionChatEditPhoto(let _data):
                if boxed {
                    buffer.appendInt32(2144015272)
                }
                _data.photo.serialize(buffer, true)
                break
            case .messageActionChatEditTitle(let _data):
                if boxed {
                    buffer.appendInt32(-1247687078)
                }
                serializeString(_data.title, buffer: buffer, boxed: false)
                break
            case .messageActionChatJoinedByLink(let _data):
                if boxed {
                    buffer.appendInt32(51520707)
                }
                serializeInt64(_data.inviterId, buffer: buffer, boxed: false)
                break
            case .messageActionChatJoinedByRequest:
                if boxed {
                    buffer.appendInt32(-339958837)
                }
                break
            case .messageActionChatJoinedViaCommunity(let _data):
                if boxed {
                    buffer.appendInt32(1250688640)
                }
                serializeInt64(_data.communityId, buffer: buffer, boxed: false)
                break
            case .messageActionChatMigrateTo(let _data):
                if boxed {
                    buffer.appendInt32(-519864430)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                break
            case .messageActionConferenceCall(let _data):
                if boxed {
                    buffer.appendInt32(805187450)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.callId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.duration!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.otherParticipants!.count))
                    for item in _data.otherParticipants! {
                        item.serialize(buffer, true)
                    }
                }
                break
            case .messageActionContactSignUp:
                if boxed {
                    buffer.appendInt32(-202219658)
                }
                break
            case .messageActionCustomAction(let _data):
                if boxed {
                    buffer.appendInt32(-85549226)
                }
                serializeString(_data.message, buffer: buffer, boxed: false)
                break
            case .messageActionEmpty:
                if boxed {
                    buffer.appendInt32(-1230047312)
                }
                break
            case .messageActionGameScore(let _data):
                if boxed {
                    buffer.appendInt32(-1834538890)
                }
                serializeInt64(_data.gameId, buffer: buffer, boxed: false)
                serializeInt32(_data.score, buffer: buffer, boxed: false)
                break
            case .messageActionGeoProximityReached(let _data):
                if boxed {
                    buffer.appendInt32(-1730095465)
                }
                _data.fromId.serialize(buffer, true)
                _data.toId.serialize(buffer, true)
                serializeInt32(_data.distance, buffer: buffer, boxed: false)
                break
            case .messageActionGiftCode(let _data):
                if boxed {
                    buffer.appendInt32(834962247)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.boostPeer!.serialize(buffer, true)
                }
                serializeInt32(_data.days, buffer: buffer, boxed: false)
                serializeString(_data.slug, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.currency!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt64(_data.amount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.cryptoCurrency!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt64(_data.cryptoAmount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    _data.message!.serialize(buffer, true)
                }
                break
            case .messageActionGiftPremium(let _data):
                if boxed {
                    buffer.appendInt32(1223234306)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.currency, buffer: buffer, boxed: false)
                serializeInt64(_data.amount, buffer: buffer, boxed: false)
                serializeInt32(_data.days, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.cryptoCurrency!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.cryptoAmount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.message!.serialize(buffer, true)
                }
                break
            case .messageActionGiftStars(let _data):
                if boxed {
                    buffer.appendInt32(1171632161)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.currency, buffer: buffer, boxed: false)
                serializeInt64(_data.amount, buffer: buffer, boxed: false)
                serializeInt64(_data.stars, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.cryptoCurrency!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.cryptoAmount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.transactionId!, buffer: buffer, boxed: false)
                }
                break
            case .messageActionGiftTon(let _data):
                if boxed {
                    buffer.appendInt32(-1465661799)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.currency, buffer: buffer, boxed: false)
                serializeInt64(_data.amount, buffer: buffer, boxed: false)
                serializeString(_data.cryptoCurrency, buffer: buffer, boxed: false)
                serializeInt64(_data.cryptoAmount, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.transactionId!, buffer: buffer, boxed: false)
                }
                break
            case .messageActionGiveawayLaunch(let _data):
                if boxed {
                    buffer.appendInt32(-1475391004)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.stars!, buffer: buffer, boxed: false)
                }
                break
            case .messageActionGiveawayResults(let _data):
                if boxed {
                    buffer.appendInt32(-2015170219)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.winnersCount, buffer: buffer, boxed: false)
                serializeInt32(_data.unclaimedCount, buffer: buffer, boxed: false)
                break
            case .messageActionGramTransfer(let _data):
                if boxed {
                    buffer.appendInt32(-1825969613)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.amount, buffer: buffer, boxed: false)
                serializeString(_data.peerAddress, buffer: buffer, boxed: false)
                serializeString(_data.transactionId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.comment!, buffer: buffer, boxed: false)
                }
                break
            case .messageActionGroupCall(let _data):
                if boxed {
                    buffer.appendInt32(2047704898)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.call.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.duration!, buffer: buffer, boxed: false)
                }
                break
            case .messageActionGroupCallScheduled(let _data):
                if boxed {
                    buffer.appendInt32(-1281329567)
                }
                _data.call.serialize(buffer, true)
                serializeInt32(_data.scheduleDate, buffer: buffer, boxed: false)
                break
            case .messageActionHistoryClear:
                if boxed {
                    buffer.appendInt32(-1615153660)
                }
                break
            case .messageActionInviteToGroupCall(let _data):
                if boxed {
                    buffer.appendInt32(1345295095)
                }
                _data.call.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    serializeInt64(item, buffer: buffer, boxed: false)
                }
                break
            case .messageActionManagedBotCreated(let _data):
                if boxed {
                    buffer.appendInt32(375414334)
                }
                serializeInt64(_data.botId, buffer: buffer, boxed: false)
                break
            case .messageActionNewCreatorPending(let _data):
                if boxed {
                    buffer.appendInt32(-1333866363)
                }
                serializeInt64(_data.newCreatorId, buffer: buffer, boxed: false)
                break
            case .messageActionNoForwardsRequest(let _data):
                if boxed {
                    buffer.appendInt32(1042781114)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.prevValue.serialize(buffer, true)
                _data.newValue.serialize(buffer, true)
                break
            case .messageActionNoForwardsToggle(let _data):
                if boxed {
                    buffer.appendInt32(-1082301070)
                }
                _data.prevValue.serialize(buffer, true)
                _data.newValue.serialize(buffer, true)
                break
            case .messageActionNoPaidMessagesTokenUsed:
                if boxed {
                    buffer.appendInt32(-1043140154)
                }
                break
            case .messageActionPaidMessagesPrice(let _data):
                if boxed {
                    buffer.appendInt32(-2068281992)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.stars, buffer: buffer, boxed: false)
                break
            case .messageActionPaidMessagesRefunded(let _data):
                if boxed {
                    buffer.appendInt32(-1407246387)
                }
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                serializeInt64(_data.stars, buffer: buffer, boxed: false)
                break
            case .messageActionPaymentRefunded(let _data):
                if boxed {
                    buffer.appendInt32(1102307842)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeString(_data.currency, buffer: buffer, boxed: false)
                serializeInt64(_data.totalAmount, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeBytes(_data.payload!, buffer: buffer, boxed: false)
                }
                _data.charge.serialize(buffer, true)
                break
            case .messageActionPaymentSent(let _data):
                if boxed {
                    buffer.appendInt32(-970673810)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.currency, buffer: buffer, boxed: false)
                serializeInt64(_data.totalAmount, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.invoiceSlug!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.subscriptionUntilDate!, buffer: buffer, boxed: false)
                }
                break
            case .messageActionPaymentSentMe(let _data):
                if boxed {
                    buffer.appendInt32(-6288180)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.currency, buffer: buffer, boxed: false)
                serializeInt64(_data.totalAmount, buffer: buffer, boxed: false)
                serializeBytes(_data.payload, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.info!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.shippingOptionId!, buffer: buffer, boxed: false)
                }
                _data.charge.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.subscriptionUntilDate!, buffer: buffer, boxed: false)
                }
                break
            case .messageActionPhoneCall(let _data):
                if boxed {
                    buffer.appendInt32(-2132731265)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.callId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.reason!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.duration!, buffer: buffer, boxed: false)
                }
                break
            case .messageActionPinMessage:
                if boxed {
                    buffer.appendInt32(-1799538451)
                }
                break
            case .messageActionPollAppendAnswer(let _data):
                if boxed {
                    buffer.appendInt32(-1650340500)
                }
                _data.answer.serialize(buffer, true)
                break
            case .messageActionPollDeleteAnswer(let _data):
                if boxed {
                    buffer.appendInt32(966161628)
                }
                _data.answer.serialize(buffer, true)
                break
            case .messageActionPrizeStars(let _data):
                if boxed {
                    buffer.appendInt32(-1341372510)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.stars, buffer: buffer, boxed: false)
                serializeString(_data.transactionId, buffer: buffer, boxed: false)
                _data.boostPeer.serialize(buffer, true)
                serializeInt32(_data.giveawayMsgId, buffer: buffer, boxed: false)
                break
            case .messageActionRequestedPeer(let _data):
                if boxed {
                    buffer.appendInt32(827428507)
                }
                serializeInt32(_data.buttonId, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.peers.count))
                for item in _data.peers {
                    item.serialize(buffer, true)
                }
                break
            case .messageActionRequestedPeerSentMe(let _data):
                if boxed {
                    buffer.appendInt32(-1816979384)
                }
                serializeInt32(_data.buttonId, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.peers.count))
                for item in _data.peers {
                    item.serialize(buffer, true)
                }
                break
            case .messageActionScreenshotTaken:
                if boxed {
                    buffer.appendInt32(1200788123)
                }
                break
            case .messageActionSecureValuesSent(let _data):
                if boxed {
                    buffer.appendInt32(-648257196)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.types.count))
                for item in _data.types {
                    item.serialize(buffer, true)
                }
                break
            case .messageActionSecureValuesSentMe(let _data):
                if boxed {
                    buffer.appendInt32(455635795)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.values.count))
                for item in _data.values {
                    item.serialize(buffer, true)
                }
                _data.credentials.serialize(buffer, true)
                break
            case .messageActionSetChatTheme(let _data):
                if boxed {
                    buffer.appendInt32(-1189364422)
                }
                _data.theme.serialize(buffer, true)
                break
            case .messageActionSetChatWallPaper(let _data):
                if boxed {
                    buffer.appendInt32(1348510708)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.wallpaper.serialize(buffer, true)
                break
            case .messageActionSetMessagesTTL(let _data):
                if boxed {
                    buffer.appendInt32(1007897979)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.period, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.autoSettingFrom!, buffer: buffer, boxed: false)
                }
                break
            case .messageActionStarGift(let _data):
                if boxed {
                    buffer.appendInt32(-366202413)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.gift.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.message!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt64(_data.convertStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeInt32(_data.upgradeMsgId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    serializeInt64(_data.upgradeStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    _data.fromId!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 12) != 0 {
                    _data.peer!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 12) != 0 {
                    serializeInt64(_data.savedId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 14) != 0 {
                    serializeString(_data.prepaidUpgradeHash!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 15) != 0 {
                    serializeInt32(_data.giftMsgId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 18) != 0 {
                    _data.toId!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 19) != 0 {
                    serializeInt32(_data.giftNum!, buffer: buffer, boxed: false)
                }
                break
            case .messageActionStarGiftPurchaseOffer(let _data):
                if boxed {
                    buffer.appendInt32(2000845012)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.gift.serialize(buffer, true)
                _data.price.serialize(buffer, true)
                serializeInt32(_data.expiresAt, buffer: buffer, boxed: false)
                break
            case .messageActionStarGiftPurchaseOfferDeclined(let _data):
                if boxed {
                    buffer.appendInt32(1940760427)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.gift.serialize(buffer, true)
                _data.price.serialize(buffer, true)
                break
            case .messageActionStarGiftUnique(let _data):
                if boxed {
                    buffer.appendInt32(2115768711)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.gift.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.canExportAt!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt64(_data.transferStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    _data.fromId!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    _data.peer!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    serializeInt64(_data.savedId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    _data.resaleAmount!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    serializeInt32(_data.canTransferAt!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    serializeInt32(_data.canResellAt!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 12) != 0 {
                    serializeInt64(_data.dropOriginalDetailsStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 15) != 0 {
                    serializeInt32(_data.canCraftAt!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 18) != 0 {
                    _data.message!.serialize(buffer, true)
                }
                break
            case .messageActionSuggestBirthday(let _data):
                if boxed {
                    buffer.appendInt32(747579941)
                }
                _data.birthday.serialize(buffer, true)
                break
            case .messageActionSuggestProfilePhoto(let _data):
                if boxed {
                    buffer.appendInt32(1474192222)
                }
                _data.photo.serialize(buffer, true)
                break
            case .messageActionSuggestedPostApproval(let _data):
                if boxed {
                    buffer.appendInt32(-293988970)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.rejectComment!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.scheduleDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    _data.price!.serialize(buffer, true)
                }
                break
            case .messageActionSuggestedPostRefund(let _data):
                if boxed {
                    buffer.appendInt32(1777932024)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            case .messageActionSuggestedPostSuccess(let _data):
                if boxed {
                    buffer.appendInt32(-1780625559)
                }
                _data.price.serialize(buffer, true)
                break
            case .messageActionTodoAppendTasks(let _data):
                if boxed {
                    buffer.appendInt32(-940721021)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.list.count))
                for item in _data.list {
                    item.serialize(buffer, true)
                }
                break
            case .messageActionTodoCompletions(let _data):
                if boxed {
                    buffer.appendInt32(-864265079)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.completed.count))
                for item in _data.completed {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.incompleted.count))
                for item in _data.incompleted {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                break
            case .messageActionTopicCreate(let _data):
                if boxed {
                    buffer.appendInt32(228168278)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeInt32(_data.iconColor, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.iconEmojiId!, buffer: buffer, boxed: false)
                }
                break
            case .messageActionTopicEdit(let _data):
                if boxed {
                    buffer.appendInt32(-1064024032)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
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
            case .messageActionWalletTonConnectRequest(let _data):
                if boxed {
                    buffer.appendInt32(1773716671)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.sessionId, buffer: buffer, boxed: false)
                serializeInt32(_data.expires, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.topic!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.traceId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeString(_data.dappName!, buffer: buffer, boxed: false)
                }
                break
            case .messageActionWebViewDataSent(let _data):
                if boxed {
                    buffer.appendInt32(-1262252875)
                }
                serializeString(_data.text, buffer: buffer, boxed: false)
                break
            case .messageActionWebViewDataSentMe(let _data):
                if boxed {
                    buffer.appendInt32(1205698681)
                }
                serializeString(_data.text, buffer: buffer, boxed: false)
                serializeString(_data.data, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_messageActionBoostApply(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionBoostApply(Cons_messageActionBoostApply(boosts: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionBotAllowed(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = parseString(reader)
            }
            var _3: Api.BotApp?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.BotApp
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessageAction.messageActionBotAllowed(Cons_messageActionBotAllowed(flags: _1!, domain: _2, app: _3))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionChangeCommunity(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt64()
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionChangeCommunity(Cons_messageActionChangeCommunity(flags: _1!, communityId: _2))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionChangeCreator(_ reader: BufferReader) -> MessageAction? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionChangeCreator(Cons_messageActionChangeCreator(newCreatorId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionChannelCreate(_ reader: BufferReader) -> MessageAction? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionChannelCreate(Cons_messageActionChannelCreate(title: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionChannelMigrateFrom(_ reader: BufferReader) -> MessageAction? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionChannelMigrateFrom(Cons_messageActionChannelMigrateFrom(title: _1!, chatId: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionChatAddUser(_ reader: BufferReader) -> MessageAction? {
            var _1: [Int64]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionChatAddUser(Cons_messageActionChatAddUser(users: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionChatCreate(_ reader: BufferReader) -> MessageAction? {
            var _1: String?
            _1 = parseString(reader)
            var _2: [Int64]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionChatCreate(Cons_messageActionChatCreate(title: _1!, users: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionChatDeletePhoto(_ reader: BufferReader) -> MessageAction? {
            return Api.MessageAction.messageActionChatDeletePhoto
        }
        static func parse_messageActionChatDeleteUser(_ reader: BufferReader) -> MessageAction? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionChatDeleteUser(Cons_messageActionChatDeleteUser(userId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionChatEditPhoto(_ reader: BufferReader) -> MessageAction? {
            var _1: Api.Photo?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Photo
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionChatEditPhoto(Cons_messageActionChatEditPhoto(photo: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionChatEditTitle(_ reader: BufferReader) -> MessageAction? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionChatEditTitle(Cons_messageActionChatEditTitle(title: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionChatJoinedByLink(_ reader: BufferReader) -> MessageAction? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionChatJoinedByLink(Cons_messageActionChatJoinedByLink(inviterId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionChatJoinedByRequest(_ reader: BufferReader) -> MessageAction? {
            return Api.MessageAction.messageActionChatJoinedByRequest
        }
        static func parse_messageActionChatJoinedViaCommunity(_ reader: BufferReader) -> MessageAction? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionChatJoinedViaCommunity(Cons_messageActionChatJoinedViaCommunity(communityId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionChatMigrateTo(_ reader: BufferReader) -> MessageAction? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionChatMigrateTo(Cons_messageActionChatMigrateTo(channelId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionConferenceCall(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _3 = reader.readInt32()
            }
            var _4: [Api.Peer]?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let _ = reader.readInt32() {
                    _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Peer.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.MessageAction.messageActionConferenceCall(Cons_messageActionConferenceCall(flags: _1!, callId: _2!, duration: _3, otherParticipants: _4))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionContactSignUp(_ reader: BufferReader) -> MessageAction? {
            return Api.MessageAction.messageActionContactSignUp
        }
        static func parse_messageActionCustomAction(_ reader: BufferReader) -> MessageAction? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionCustomAction(Cons_messageActionCustomAction(message: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionEmpty(_ reader: BufferReader) -> MessageAction? {
            return Api.MessageAction.messageActionEmpty
        }
        static func parse_messageActionGameScore(_ reader: BufferReader) -> MessageAction? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionGameScore(Cons_messageActionGameScore(gameId: _1!, score: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionGeoProximityReached(_ reader: BufferReader) -> MessageAction? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
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
                return Api.MessageAction.messageActionGeoProximityReached(Cons_messageActionGeoProximityReached(fromId: _1!, toId: _2!, distance: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionGiftCode(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: String?
            _4 = parseString(reader)
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _5 = parseString(reader)
            }
            var _6: Int64?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _6 = reader.readInt64()
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _7 = parseString(reader)
            }
            var _8: Int64?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _8 = reader.readInt64()
            }
            var _9: Api.TextWithEntities?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.MessageAction.messageActionGiftCode(Cons_messageActionGiftCode(flags: _1!, boostPeer: _2, days: _3!, slug: _4!, currency: _5, amount: _6, cryptoCurrency: _7, cryptoAmount: _8, message: _9))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionGiftPremium(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = parseString(reader)
            }
            var _6: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _6 = reader.readInt64()
            }
            var _7: Api.TextWithEntities?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.MessageAction.messageActionGiftPremium(Cons_messageActionGiftPremium(flags: _1!, currency: _2!, amount: _3!, days: _4!, cryptoCurrency: _5, cryptoAmount: _6, message: _7))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionGiftStars(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = parseString(reader)
            }
            var _6: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _6 = reader.readInt64()
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _7 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.MessageAction.messageActionGiftStars(Cons_messageActionGiftStars(flags: _1!, currency: _2!, amount: _3!, stars: _4!, cryptoCurrency: _5, cryptoAmount: _6, transactionId: _7))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionGiftTon(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: String?
            _4 = parseString(reader)
            var _5: Int64?
            _5 = reader.readInt64()
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _6 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.MessageAction.messageActionGiftTon(Cons_messageActionGiftTon(flags: _1!, currency: _2!, amount: _3!, cryptoCurrency: _4!, cryptoAmount: _5!, transactionId: _6))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionGiveawayLaunch(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt64()
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionGiveawayLaunch(Cons_messageActionGiveawayLaunch(flags: _1!, stars: _2))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionGiveawayResults(_ reader: BufferReader) -> MessageAction? {
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
                return Api.MessageAction.messageActionGiveawayResults(Cons_messageActionGiveawayResults(flags: _1!, winnersCount: _2!, unclaimedCount: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionGramTransfer(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            _3 = parseString(reader)
            var _4: String?
            _4 = parseString(reader)
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.MessageAction.messageActionGramTransfer(Cons_messageActionGramTransfer(flags: _1!, amount: _2!, peerAddress: _3!, transactionId: _4!, comment: _5))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionGroupCall(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.InputGroupCall?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.InputGroupCall
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessageAction.messageActionGroupCall(Cons_messageActionGroupCall(flags: _1!, call: _2!, duration: _3))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionGroupCallScheduled(_ reader: BufferReader) -> MessageAction? {
            var _1: Api.InputGroupCall?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputGroupCall
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionGroupCallScheduled(Cons_messageActionGroupCallScheduled(call: _1!, scheduleDate: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionHistoryClear(_ reader: BufferReader) -> MessageAction? {
            return Api.MessageAction.messageActionHistoryClear
        }
        static func parse_messageActionInviteToGroupCall(_ reader: BufferReader) -> MessageAction? {
            var _1: Api.InputGroupCall?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputGroupCall
            }
            var _2: [Int64]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionInviteToGroupCall(Cons_messageActionInviteToGroupCall(call: _1!, users: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionManagedBotCreated(_ reader: BufferReader) -> MessageAction? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionManagedBotCreated(Cons_messageActionManagedBotCreated(botId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionNewCreatorPending(_ reader: BufferReader) -> MessageAction? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionNewCreatorPending(Cons_messageActionNewCreatorPending(newCreatorId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionNoForwardsRequest(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Bool?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            var _3: Api.Bool?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessageAction.messageActionNoForwardsRequest(Cons_messageActionNoForwardsRequest(flags: _1!, prevValue: _2!, newValue: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionNoForwardsToggle(_ reader: BufferReader) -> MessageAction? {
            var _1: Api.Bool?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            var _2: Api.Bool?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionNoForwardsToggle(Cons_messageActionNoForwardsToggle(prevValue: _1!, newValue: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionNoPaidMessagesTokenUsed(_ reader: BufferReader) -> MessageAction? {
            return Api.MessageAction.messageActionNoPaidMessagesTokenUsed
        }
        static func parse_messageActionPaidMessagesPrice(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionPaidMessagesPrice(Cons_messageActionPaidMessagesPrice(flags: _1!, stars: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionPaidMessagesRefunded(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionPaidMessagesRefunded(Cons_messageActionPaidMessagesRefunded(count: _1!, stars: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionPaymentRefunded(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: String?
            _3 = parseString(reader)
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: Buffer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = parseBytes(reader)
            }
            var _6: Api.PaymentCharge?
            if let signature = reader.readInt32() {
                _6 = Api.parse(reader, signature: signature) as? Api.PaymentCharge
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.MessageAction.messageActionPaymentRefunded(Cons_messageActionPaymentRefunded(flags: _1!, peer: _2!, currency: _3!, totalAmount: _4!, payload: _5, charge: _6!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionPaymentSent(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _5 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.MessageAction.messageActionPaymentSent(Cons_messageActionPaymentSent(flags: _1!, currency: _2!, totalAmount: _3!, invoiceSlug: _4, subscriptionUntilDate: _5))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionPaymentSentMe(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
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
            var _7: Api.PaymentCharge?
            if let signature = reader.readInt32() {
                _7 = Api.parse(reader, signature: signature) as? Api.PaymentCharge
            }
            var _8: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _8 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            let _c7 = _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.MessageAction.messageActionPaymentSentMe(Cons_messageActionPaymentSentMe(flags: _1!, currency: _2!, totalAmount: _3!, payload: _4!, info: _5, shippingOptionId: _6, charge: _7!, subscriptionUntilDate: _8))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionPhoneCall(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.PhoneCallDiscardReason?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.PhoneCallDiscardReason
                }
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _4 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.MessageAction.messageActionPhoneCall(Cons_messageActionPhoneCall(flags: _1!, callId: _2!, reason: _3, duration: _4))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionPinMessage(_ reader: BufferReader) -> MessageAction? {
            return Api.MessageAction.messageActionPinMessage
        }
        static func parse_messageActionPollAppendAnswer(_ reader: BufferReader) -> MessageAction? {
            var _1: Api.PollAnswer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.PollAnswer
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionPollAppendAnswer(Cons_messageActionPollAppendAnswer(answer: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionPollDeleteAnswer(_ reader: BufferReader) -> MessageAction? {
            var _1: Api.PollAnswer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.PollAnswer
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionPollDeleteAnswer(Cons_messageActionPollDeleteAnswer(answer: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionPrizeStars(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            _3 = parseString(reader)
            var _4: Api.Peer?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _5: Int32?
            _5 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.MessageAction.messageActionPrizeStars(Cons_messageActionPrizeStars(flags: _1!, stars: _2!, transactionId: _3!, boostPeer: _4!, giveawayMsgId: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionRequestedPeer(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.Peer]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Peer.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionRequestedPeer(Cons_messageActionRequestedPeer(buttonId: _1!, peers: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionRequestedPeerSentMe(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.RequestedPeer]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.RequestedPeer.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionRequestedPeerSentMe(Cons_messageActionRequestedPeerSentMe(buttonId: _1!, peers: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionScreenshotTaken(_ reader: BufferReader) -> MessageAction? {
            return Api.MessageAction.messageActionScreenshotTaken
        }
        static func parse_messageActionSecureValuesSent(_ reader: BufferReader) -> MessageAction? {
            var _1: [Api.SecureValueType]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.SecureValueType.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionSecureValuesSent(Cons_messageActionSecureValuesSent(types: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionSecureValuesSentMe(_ reader: BufferReader) -> MessageAction? {
            var _1: [Api.SecureValue]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.SecureValue.self)
            }
            var _2: Api.SecureCredentialsEncrypted?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.SecureCredentialsEncrypted
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionSecureValuesSentMe(Cons_messageActionSecureValuesSentMe(values: _1!, credentials: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionSetChatTheme(_ reader: BufferReader) -> MessageAction? {
            var _1: Api.ChatTheme?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ChatTheme
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionSetChatTheme(Cons_messageActionSetChatTheme(theme: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionSetChatWallPaper(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.WallPaper?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.WallPaper
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionSetChatWallPaper(Cons_messageActionSetChatWallPaper(flags: _1!, wallpaper: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionSetMessagesTTL(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt64()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessageAction.messageActionSetMessagesTTL(Cons_messageActionSetMessagesTTL(flags: _1!, period: _2!, autoSettingFrom: _3))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionStarGift(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.StarGift?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.StarGift
            }
            var _3: Api.TextWithEntities?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
                }
            }
            var _4: Int64?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _4 = reader.readInt64()
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _5 = reader.readInt32()
            }
            var _6: Int64?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                _6 = reader.readInt64()
            }
            var _7: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _8: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 12) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _9: Int64?
            if Int(_1 ?? 0) & Int(1 << 12) != 0 {
                _9 = reader.readInt64()
            }
            var _10: String?
            if Int(_1 ?? 0) & Int(1 << 14) != 0 {
                _10 = parseString(reader)
            }
            var _11: Int32?
            if Int(_1 ?? 0) & Int(1 << 15) != 0 {
                _11 = reader.readInt32()
            }
            var _12: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 18) != 0 {
                if let signature = reader.readInt32() {
                    _12 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _13: Int32?
            if Int(_1 ?? 0) & Int(1 << 19) != 0 {
                _13 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 12) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 12) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 14) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 15) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 18) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 19) == 0) || _13 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 {
                return Api.MessageAction.messageActionStarGift(Cons_messageActionStarGift(flags: _1!, gift: _2!, message: _3, convertStars: _4, upgradeMsgId: _5, upgradeStars: _6, fromId: _7, peer: _8, savedId: _9, prepaidUpgradeHash: _10, giftMsgId: _11, toId: _12, giftNum: _13))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionStarGiftPurchaseOffer(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.StarGift?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.StarGift
            }
            var _3: Api.StarsAmount?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.StarsAmount
            }
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.MessageAction.messageActionStarGiftPurchaseOffer(Cons_messageActionStarGiftPurchaseOffer(flags: _1!, gift: _2!, price: _3!, expiresAt: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionStarGiftPurchaseOfferDeclined(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.StarGift?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.StarGift
            }
            var _3: Api.StarsAmount?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.StarsAmount
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessageAction.messageActionStarGiftPurchaseOfferDeclined(Cons_messageActionStarGiftPurchaseOfferDeclined(flags: _1!, gift: _2!, price: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionStarGiftUnique(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.StarGift?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.StarGift
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Int64?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _4 = reader.readInt64()
            }
            var _5: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _6: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _7: Int64?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                _7 = reader.readInt64()
            }
            var _8: Api.StarsAmount?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.StarsAmount
                }
            }
            var _9: Int32?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                _9 = reader.readInt32()
            }
            var _10: Int32?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                _10 = reader.readInt32()
            }
            var _11: Int64?
            if Int(_1 ?? 0) & Int(1 << 12) != 0 {
                _11 = reader.readInt64()
            }
            var _12: Int32?
            if Int(_1 ?? 0) & Int(1 << 15) != 0 {
                _12 = reader.readInt32()
            }
            var _13: Api.TextWithEntities?
            if Int(_1 ?? 0) & Int(1 << 18) != 0 {
                if let signature = reader.readInt32() {
                    _13 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 12) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 15) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 18) == 0) || _13 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 {
                return Api.MessageAction.messageActionStarGiftUnique(Cons_messageActionStarGiftUnique(flags: _1!, gift: _2!, canExportAt: _3, transferStars: _4, fromId: _5, peer: _6, savedId: _7, resaleAmount: _8, canTransferAt: _9, canResellAt: _10, dropOriginalDetailsStars: _11, canCraftAt: _12, message: _13))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionSuggestBirthday(_ reader: BufferReader) -> MessageAction? {
            var _1: Api.Birthday?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Birthday
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionSuggestBirthday(Cons_messageActionSuggestBirthday(birthday: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionSuggestProfilePhoto(_ reader: BufferReader) -> MessageAction? {
            var _1: Api.Photo?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Photo
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionSuggestProfilePhoto(Cons_messageActionSuggestProfilePhoto(photo: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionSuggestedPostApproval(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _2 = parseString(reader)
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Api.StarsAmount?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.StarsAmount
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.MessageAction.messageActionSuggestedPostApproval(Cons_messageActionSuggestedPostApproval(flags: _1!, rejectComment: _2, scheduleDate: _3, price: _4))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionSuggestedPostRefund(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionSuggestedPostRefund(Cons_messageActionSuggestedPostRefund(flags: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionSuggestedPostSuccess(_ reader: BufferReader) -> MessageAction? {
            var _1: Api.StarsAmount?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.StarsAmount
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionSuggestedPostSuccess(Cons_messageActionSuggestedPostSuccess(price: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionTodoAppendTasks(_ reader: BufferReader) -> MessageAction? {
            var _1: [Api.TodoItem]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.TodoItem.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionTodoAppendTasks(Cons_messageActionTodoAppendTasks(list: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionTodoCompletions(_ reader: BufferReader) -> MessageAction? {
            var _1: [Int32]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            var _2: [Int32]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionTodoCompletions(Cons_messageActionTodoCompletions(completed: _1!, incompleted: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionTopicCreate(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = reader.readInt64()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.MessageAction.messageActionTopicCreate(Cons_messageActionTopicCreate(flags: _1!, title: _2!, iconColor: _3!, iconEmojiId: _4))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionTopicEdit(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = parseString(reader)
            }
            var _3: Int64?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _3 = reader.readInt64()
            }
            var _4: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            var _5: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.MessageAction.messageActionTopicEdit(Cons_messageActionTopicEdit(flags: _1!, title: _2, iconEmojiId: _3, closed: _4, hidden: _5))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionWalletTonConnectRequest(_ reader: BufferReader) -> MessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _5 = parseString(reader)
            }
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _6 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.MessageAction.messageActionWalletTonConnectRequest(Cons_messageActionWalletTonConnectRequest(flags: _1!, sessionId: _2!, expires: _3!, topic: _4, traceId: _5, dappName: _6))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionWebViewDataSent(_ reader: BufferReader) -> MessageAction? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageAction.messageActionWebViewDataSent(Cons_messageActionWebViewDataSent(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageActionWebViewDataSentMe(_ reader: BufferReader) -> MessageAction? {
            var _1: String?
            _1 = parseString(reader)
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageAction.messageActionWebViewDataSentMe(Cons_messageActionWebViewDataSentMe(text: _1!, data: _2!))
            }
            else {
                return nil
            }
        }
    }
}
