extension Api {
    indirect enum MessageMedia: TypeConstructorDescription {
        class Cons_messageMediaContact: TypeConstructorDescription {
            var phoneNumber: String
            var firstName: String
            var lastName: String
            var vcard: String
            var userId: Int64
            init(phoneNumber: String, firstName: String, lastName: String, vcard: String, userId: Int64) {
                self.phoneNumber = phoneNumber
                self.firstName = firstName
                self.lastName = lastName
                self.vcard = vcard
                self.userId = userId
            }
        }
        class Cons_messageMediaDice: TypeConstructorDescription {
            var flags: Int32
            var value: Int32
            var emoticon: String
            var gameOutcome: Api.messages.EmojiGameOutcome?
            init(flags: Int32, value: Int32, emoticon: String, gameOutcome: Api.messages.EmojiGameOutcome?) {
                self.flags = flags
                self.value = value
                self.emoticon = emoticon
                self.gameOutcome = gameOutcome
            }
        }
        class Cons_messageMediaDocument: TypeConstructorDescription {
            var flags: Int32
            var document: Api.Document?
            var altDocuments: [Api.Document]?
            var videoCover: Api.Photo?
            var videoTimestamp: Int32?
            var ttlSeconds: Int32?
            init(flags: Int32, document: Api.Document?, altDocuments: [Api.Document]?, videoCover: Api.Photo?, videoTimestamp: Int32?, ttlSeconds: Int32?) {
                self.flags = flags
                self.document = document
                self.altDocuments = altDocuments
                self.videoCover = videoCover
                self.videoTimestamp = videoTimestamp
                self.ttlSeconds = ttlSeconds
            }
        }
        class Cons_messageMediaGame: TypeConstructorDescription {
            var game: Api.Game
            init(game: Api.Game) {
                self.game = game
            }
        }
        class Cons_messageMediaGeo: TypeConstructorDescription {
            var geo: Api.GeoPoint
            init(geo: Api.GeoPoint) {
                self.geo = geo
            }
        }
        class Cons_messageMediaGeoLive: TypeConstructorDescription {
            var flags: Int32
            var geo: Api.GeoPoint
            var heading: Int32?
            var period: Int32
            var proximityNotificationRadius: Int32?
            init(flags: Int32, geo: Api.GeoPoint, heading: Int32?, period: Int32, proximityNotificationRadius: Int32?) {
                self.flags = flags
                self.geo = geo
                self.heading = heading
                self.period = period
                self.proximityNotificationRadius = proximityNotificationRadius
            }
        }
        class Cons_messageMediaGiveaway: TypeConstructorDescription {
            var flags: Int32
            var channels: [Int64]
            var countriesIso2: [String]?
            var prizeDescription: String?
            var quantity: Int32
            var months: Int32?
            var stars: Int64?
            var untilDate: Int32
            init(flags: Int32, channels: [Int64], countriesIso2: [String]?, prizeDescription: String?, quantity: Int32, months: Int32?, stars: Int64?, untilDate: Int32) {
                self.flags = flags
                self.channels = channels
                self.countriesIso2 = countriesIso2
                self.prizeDescription = prizeDescription
                self.quantity = quantity
                self.months = months
                self.stars = stars
                self.untilDate = untilDate
            }
        }
        class Cons_messageMediaGiveawayResults: TypeConstructorDescription {
            var flags: Int32
            var channelId: Int64
            var additionalPeersCount: Int32?
            var launchMsgId: Int32
            var winnersCount: Int32
            var unclaimedCount: Int32
            var winners: [Int64]
            var months: Int32?
            var stars: Int64?
            var prizeDescription: String?
            var untilDate: Int32
            init(flags: Int32, channelId: Int64, additionalPeersCount: Int32?, launchMsgId: Int32, winnersCount: Int32, unclaimedCount: Int32, winners: [Int64], months: Int32?, stars: Int64?, prizeDescription: String?, untilDate: Int32) {
                self.flags = flags
                self.channelId = channelId
                self.additionalPeersCount = additionalPeersCount
                self.launchMsgId = launchMsgId
                self.winnersCount = winnersCount
                self.unclaimedCount = unclaimedCount
                self.winners = winners
                self.months = months
                self.stars = stars
                self.prizeDescription = prizeDescription
                self.untilDate = untilDate
            }
        }
        class Cons_messageMediaInvoice: TypeConstructorDescription {
            var flags: Int32
            var title: String
            var description: String
            var photo: Api.WebDocument?
            var receiptMsgId: Int32?
            var currency: String
            var totalAmount: Int64
            var startParam: String
            var extendedMedia: Api.MessageExtendedMedia?
            init(flags: Int32, title: String, description: String, photo: Api.WebDocument?, receiptMsgId: Int32?, currency: String, totalAmount: Int64, startParam: String, extendedMedia: Api.MessageExtendedMedia?) {
                self.flags = flags
                self.title = title
                self.description = description
                self.photo = photo
                self.receiptMsgId = receiptMsgId
                self.currency = currency
                self.totalAmount = totalAmount
                self.startParam = startParam
                self.extendedMedia = extendedMedia
            }
        }
        class Cons_messageMediaPaidMedia: TypeConstructorDescription {
            var starsAmount: Int64
            var extendedMedia: [Api.MessageExtendedMedia]
            init(starsAmount: Int64, extendedMedia: [Api.MessageExtendedMedia]) {
                self.starsAmount = starsAmount
                self.extendedMedia = extendedMedia
            }
        }
        class Cons_messageMediaPhoto: TypeConstructorDescription {
            var flags: Int32
            var photo: Api.Photo?
            var ttlSeconds: Int32?
            var video: Api.Document?
            init(flags: Int32, photo: Api.Photo?, ttlSeconds: Int32?, video: Api.Document?) {
                self.flags = flags
                self.photo = photo
                self.ttlSeconds = ttlSeconds
                self.video = video
            }
        }
        class Cons_messageMediaPoll: TypeConstructorDescription {
            var flags: Int32
            var poll: Api.Poll
            var results: Api.PollResults
            var attachedMedia: Api.MessageMedia?
            init(flags: Int32, poll: Api.Poll, results: Api.PollResults, attachedMedia: Api.MessageMedia?) {
                self.flags = flags
                self.poll = poll
                self.results = results
                self.attachedMedia = attachedMedia
            }
        }
        class Cons_messageMediaStory: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var id: Int32
            var story: Api.StoryItem?
            init(flags: Int32, peer: Api.Peer, id: Int32, story: Api.StoryItem?) {
                self.flags = flags
                self.peer = peer
                self.id = id
                self.story = story
            }
        }
        class Cons_messageMediaToDo: TypeConstructorDescription {
            var flags: Int32
            var todo: Api.TodoList
            var completions: [Api.TodoCompletion]?
            init(flags: Int32, todo: Api.TodoList, completions: [Api.TodoCompletion]?) {
                self.flags = flags
                self.todo = todo
                self.completions = completions
            }
        }
        class Cons_messageMediaVenue: TypeConstructorDescription {
            var geo: Api.GeoPoint
            var title: String
            var address: String
            var provider: String
            var venueId: String
            var venueType: String
            init(geo: Api.GeoPoint, title: String, address: String, provider: String, venueId: String, venueType: String) {
                self.geo = geo
                self.title = title
                self.address = address
                self.provider = provider
                self.venueId = venueId
                self.venueType = venueType
            }
        }
        class Cons_messageMediaVideoStream: TypeConstructorDescription {
            var flags: Int32
            var call: Api.InputGroupCall
            init(flags: Int32, call: Api.InputGroupCall) {
                self.flags = flags
                self.call = call
            }
        }
        class Cons_messageMediaWebPage: TypeConstructorDescription {
            var flags: Int32
            var webpage: Api.WebPage
            init(flags: Int32, webpage: Api.WebPage) {
                self.flags = flags
                self.webpage = webpage
            }
        }
        class Cons_messageMediaWidget: TypeConstructorDescription {
            var flags: Int32
            var width: Int32
            var height: Int32
            var payload: Buffer
            var publicData: String?
            var publicDataHash: Int64?
            var chatData: String?
            var widgetId: Int64?
            init(flags: Int32, width: Int32, height: Int32, payload: Buffer, publicData: String?, publicDataHash: Int64?, chatData: String?, widgetId: Int64?) {
                self.flags = flags
                self.width = width
                self.height = height
                self.payload = payload
                self.publicData = publicData
                self.publicDataHash = publicDataHash
                self.chatData = chatData
                self.widgetId = widgetId
            }
        }
        case messageMediaContact(Cons_messageMediaContact)
        case messageMediaDice(Cons_messageMediaDice)
        case messageMediaDocument(Cons_messageMediaDocument)
        case messageMediaEmpty
        case messageMediaGame(Cons_messageMediaGame)
        case messageMediaGeo(Cons_messageMediaGeo)
        case messageMediaGeoLive(Cons_messageMediaGeoLive)
        case messageMediaGiveaway(Cons_messageMediaGiveaway)
        case messageMediaGiveawayResults(Cons_messageMediaGiveawayResults)
        case messageMediaInvoice(Cons_messageMediaInvoice)
        case messageMediaPaidMedia(Cons_messageMediaPaidMedia)
        case messageMediaPhoto(Cons_messageMediaPhoto)
        case messageMediaPoll(Cons_messageMediaPoll)
        case messageMediaStory(Cons_messageMediaStory)
        case messageMediaToDo(Cons_messageMediaToDo)
        case messageMediaUnsupported
        case messageMediaVenue(Cons_messageMediaVenue)
        case messageMediaVideoStream(Cons_messageMediaVideoStream)
        case messageMediaWebPage(Cons_messageMediaWebPage)
        case messageMediaWidget(Cons_messageMediaWidget)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .messageMediaContact(let _data):
                if boxed {
                    buffer.appendInt32(1882335561)
                }
                serializeString(_data.phoneNumber, buffer: buffer, boxed: false)
                serializeString(_data.firstName, buffer: buffer, boxed: false)
                serializeString(_data.lastName, buffer: buffer, boxed: false)
                serializeString(_data.vcard, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                break
            case .messageMediaDice(let _data):
                if boxed {
                    buffer.appendInt32(147581959)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.value, buffer: buffer, boxed: false)
                serializeString(_data.emoticon, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.gameOutcome!.serialize(buffer, true)
                }
                break
            case .messageMediaDocument(let _data):
                if boxed {
                    buffer.appendInt32(1389939929)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.document!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.altDocuments!.count))
                    for item in _data.altDocuments! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    _data.videoCover!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    serializeInt32(_data.videoTimestamp!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.ttlSeconds!, buffer: buffer, boxed: false)
                }
                break
            case .messageMediaEmpty:
                if boxed {
                    buffer.appendInt32(1038967584)
                }
                break
            case .messageMediaGame(let _data):
                if boxed {
                    buffer.appendInt32(-38694904)
                }
                _data.game.serialize(buffer, true)
                break
            case .messageMediaGeo(let _data):
                if boxed {
                    buffer.appendInt32(1457575028)
                }
                _data.geo.serialize(buffer, true)
                break
            case .messageMediaGeoLive(let _data):
                if boxed {
                    buffer.appendInt32(-1186937242)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.geo.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.heading!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.period, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.proximityNotificationRadius!, buffer: buffer, boxed: false)
                }
                break
            case .messageMediaGiveaway(let _data):
                if boxed {
                    buffer.appendInt32(-1442366485)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.channels.count))
                for item in _data.channels {
                    serializeInt64(item, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.countriesIso2!.count))
                    for item in _data.countriesIso2! {
                        serializeString(item, buffer: buffer, boxed: false)
                    }
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.prizeDescription!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.quantity, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.months!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeInt64(_data.stars!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.untilDate, buffer: buffer, boxed: false)
                break
            case .messageMediaGiveawayResults(let _data):
                if boxed {
                    buffer.appendInt32(-827703647)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.additionalPeersCount!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.launchMsgId, buffer: buffer, boxed: false)
                serializeInt32(_data.winnersCount, buffer: buffer, boxed: false)
                serializeInt32(_data.unclaimedCount, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.winners.count))
                for item in _data.winners {
                    serializeInt64(item, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.months!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeInt64(_data.stars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.prizeDescription!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.untilDate, buffer: buffer, boxed: false)
                break
            case .messageMediaInvoice(let _data):
                if boxed {
                    buffer.appendInt32(-156940077)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeString(_data.description, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.photo!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.receiptMsgId!, buffer: buffer, boxed: false)
                }
                serializeString(_data.currency, buffer: buffer, boxed: false)
                serializeInt64(_data.totalAmount, buffer: buffer, boxed: false)
                serializeString(_data.startParam, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    _data.extendedMedia!.serialize(buffer, true)
                }
                break
            case .messageMediaPaidMedia(let _data):
                if boxed {
                    buffer.appendInt32(-1467669359)
                }
                serializeInt64(_data.starsAmount, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.extendedMedia.count))
                for item in _data.extendedMedia {
                    item.serialize(buffer, true)
                }
                break
            case .messageMediaPhoto(let _data):
                if boxed {
                    buffer.appendInt32(-501814429)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.photo!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.ttlSeconds!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    _data.video!.serialize(buffer, true)
                }
                break
            case .messageMediaPoll(let _data):
                if boxed {
                    buffer.appendInt32(2000637542)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.poll.serialize(buffer, true)
                _data.results.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.attachedMedia!.serialize(buffer, true)
                }
                break
            case .messageMediaStory(let _data):
                if boxed {
                    buffer.appendInt32(1758159491)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.story!.serialize(buffer, true)
                }
                break
            case .messageMediaToDo(let _data):
                if boxed {
                    buffer.appendInt32(-1974226924)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.todo.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.completions!.count))
                    for item in _data.completions! {
                        item.serialize(buffer, true)
                    }
                }
                break
            case .messageMediaUnsupported:
                if boxed {
                    buffer.appendInt32(-1618676578)
                }
                break
            case .messageMediaVenue(let _data):
                if boxed {
                    buffer.appendInt32(784356159)
                }
                _data.geo.serialize(buffer, true)
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeString(_data.address, buffer: buffer, boxed: false)
                serializeString(_data.provider, buffer: buffer, boxed: false)
                serializeString(_data.venueId, buffer: buffer, boxed: false)
                serializeString(_data.venueType, buffer: buffer, boxed: false)
                break
            case .messageMediaVideoStream(let _data):
                if boxed {
                    buffer.appendInt32(-899896439)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.call.serialize(buffer, true)
                break
            case .messageMediaWebPage(let _data):
                if boxed {
                    buffer.appendInt32(-571405253)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.webpage.serialize(buffer, true)
                break
            case .messageMediaWidget(let _data):
                if boxed {
                    buffer.appendInt32(574157332)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.width, buffer: buffer, boxed: false)
                serializeInt32(_data.height, buffer: buffer, boxed: false)
                serializeBytes(_data.payload, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.publicData!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt64(_data.publicDataHash!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeString(_data.chatData!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeInt64(_data.widgetId!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_messageMediaContact(_ reader: BufferReader) -> MessageMedia? {
            var _1: String?
            _1 = parseString(reader)
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            _3 = parseString(reader)
            var _4: String?
            _4 = parseString(reader)
            var _5: Int64?
            _5 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.MessageMedia.messageMediaContact(Cons_messageMediaContact(phoneNumber: _1!, firstName: _2!, lastName: _3!, vcard: _4!, userId: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaDice(_ reader: BufferReader) -> MessageMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: String?
            _3 = parseString(reader)
            var _4: Api.messages.EmojiGameOutcome?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.messages.EmojiGameOutcome
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.MessageMedia.messageMediaDice(Cons_messageMediaDice(flags: _1!, value: _2!, emoticon: _3!, gameOutcome: _4))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaDocument(_ reader: BufferReader) -> MessageMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Document?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Document
                }
            }
            var _3: [Api.Document]?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                if let _ = reader.readInt32() {
                    _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Document.self)
                }
            }
            var _4: Api.Photo?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.Photo
                }
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                _5 = reader.readInt32()
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _6 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.MessageMedia.messageMediaDocument(Cons_messageMediaDocument(flags: _1!, document: _2, altDocuments: _3, videoCover: _4, videoTimestamp: _5, ttlSeconds: _6))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaEmpty(_ reader: BufferReader) -> MessageMedia? {
            return Api.MessageMedia.messageMediaEmpty
        }
        static func parse_messageMediaGame(_ reader: BufferReader) -> MessageMedia? {
            var _1: Api.Game?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Game
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageMedia.messageMediaGame(Cons_messageMediaGame(game: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaGeo(_ reader: BufferReader) -> MessageMedia? {
            var _1: Api.GeoPoint?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.GeoPoint
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageMedia.messageMediaGeo(Cons_messageMediaGeo(geo: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaGeoLive(_ reader: BufferReader) -> MessageMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.GeoPoint?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.GeoPoint
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _5 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.MessageMedia.messageMediaGeoLive(Cons_messageMediaGeoLive(flags: _1!, geo: _2!, heading: _3, period: _4!, proximityNotificationRadius: _5))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaGiveaway(_ reader: BufferReader) -> MessageMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Int64]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
            }
            var _3: [String]?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let _ = reader.readInt32() {
                    _3 = Api.parseVector(reader, elementSignature: -1255641564, elementType: String.self)
                }
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _4 = parseString(reader)
            }
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _6 = reader.readInt32()
            }
            var _7: Int64?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _7 = reader.readInt64()
            }
            var _8: Int32?
            _8 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _7 != nil
            let _c8 = _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.MessageMedia.messageMediaGiveaway(Cons_messageMediaGiveaway(flags: _1!, channels: _2!, countriesIso2: _3, prizeDescription: _4, quantity: _5!, months: _6, stars: _7, untilDate: _8!))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaGiveawayResults(_ reader: BufferReader) -> MessageMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: [Int64]?
            if let _ = reader.readInt32() {
                _7 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
            }
            var _8: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _8 = reader.readInt32()
            }
            var _9: Int64?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _9 = reader.readInt64()
            }
            var _10: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _10 = parseString(reader)
            }
            var _11: Int32?
            _11 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _10 != nil
            let _c11 = _11 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 {
                return Api.MessageMedia.messageMediaGiveawayResults(Cons_messageMediaGiveawayResults(flags: _1!, channelId: _2!, additionalPeersCount: _3, launchMsgId: _4!, winnersCount: _5!, unclaimedCount: _6!, winners: _7!, months: _8, stars: _9, prizeDescription: _10, untilDate: _11!))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaInvoice(_ reader: BufferReader) -> MessageMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            _3 = parseString(reader)
            var _4: Api.WebDocument?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.WebDocument
                }
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _5 = reader.readInt32()
            }
            var _6: String?
            _6 = parseString(reader)
            var _7: Int64?
            _7 = reader.readInt64()
            var _8: String?
            _8 = parseString(reader)
            var _9: Api.MessageExtendedMedia?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.MessageExtendedMedia
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.MessageMedia.messageMediaInvoice(Cons_messageMediaInvoice(flags: _1!, title: _2!, description: _3!, photo: _4, receiptMsgId: _5, currency: _6!, totalAmount: _7!, startParam: _8!, extendedMedia: _9))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaPaidMedia(_ reader: BufferReader) -> MessageMedia? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: [Api.MessageExtendedMedia]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageExtendedMedia.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageMedia.messageMediaPaidMedia(Cons_messageMediaPaidMedia(starsAmount: _1!, extendedMedia: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaPhoto(_ reader: BufferReader) -> MessageMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Photo?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Photo
                }
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Api.Document?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.Document
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.MessageMedia.messageMediaPhoto(Cons_messageMediaPhoto(flags: _1!, photo: _2, ttlSeconds: _3, video: _4))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaPoll(_ reader: BufferReader) -> MessageMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Poll?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Poll
            }
            var _3: Api.PollResults?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.PollResults
            }
            var _4: Api.MessageMedia?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.MessageMedia
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.MessageMedia.messageMediaPoll(Cons_messageMediaPoll(flags: _1!, poll: _2!, results: _3!, attachedMedia: _4))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaStory(_ reader: BufferReader) -> MessageMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Api.StoryItem?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.StoryItem
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.MessageMedia.messageMediaStory(Cons_messageMediaStory(flags: _1!, peer: _2!, id: _3!, story: _4))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaToDo(_ reader: BufferReader) -> MessageMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.TodoList?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.TodoList
            }
            var _3: [Api.TodoCompletion]?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.TodoCompletion.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessageMedia.messageMediaToDo(Cons_messageMediaToDo(flags: _1!, todo: _2!, completions: _3))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaUnsupported(_ reader: BufferReader) -> MessageMedia? {
            return Api.MessageMedia.messageMediaUnsupported
        }
        static func parse_messageMediaVenue(_ reader: BufferReader) -> MessageMedia? {
            var _1: Api.GeoPoint?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.GeoPoint
            }
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            _3 = parseString(reader)
            var _4: String?
            _4 = parseString(reader)
            var _5: String?
            _5 = parseString(reader)
            var _6: String?
            _6 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.MessageMedia.messageMediaVenue(Cons_messageMediaVenue(geo: _1!, title: _2!, address: _3!, provider: _4!, venueId: _5!, venueType: _6!))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaVideoStream(_ reader: BufferReader) -> MessageMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.InputGroupCall?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.InputGroupCall
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageMedia.messageMediaVideoStream(Cons_messageMediaVideoStream(flags: _1!, call: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaWebPage(_ reader: BufferReader) -> MessageMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.WebPage?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.WebPage
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageMedia.messageMediaWebPage(Cons_messageMediaWebPage(flags: _1!, webpage: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageMediaWidget(_ reader: BufferReader) -> MessageMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Buffer?
            _4 = parseBytes(reader)
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _5 = parseString(reader)
            }
            var _6: Int64?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _6 = reader.readInt64()
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _7 = parseString(reader)
            }
            var _8: Int64?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _8 = reader.readInt64()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.MessageMedia.messageMediaWidget(Cons_messageMediaWidget(flags: _1!, width: _2!, height: _3!, payload: _4!, publicData: _5, publicDataHash: _6, chatData: _7, widgetId: _8))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum MessagePeerReaction: TypeConstructorDescription {
        class Cons_messagePeerReaction: TypeConstructorDescription {
            var flags: Int32
            var peerId: Api.Peer
            var date: Int32
            var reaction: Api.Reaction
            init(flags: Int32, peerId: Api.Peer, date: Int32, reaction: Api.Reaction) {
                self.flags = flags
                self.peerId = peerId
                self.date = date
                self.reaction = reaction
            }
        }
        case messagePeerReaction(Cons_messagePeerReaction)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .messagePeerReaction(let _data):
                if boxed {
                    buffer.appendInt32(-1938180548)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peerId.serialize(buffer, true)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                _data.reaction.serialize(buffer, true)
                break
            }
        }

        static func parse_messagePeerReaction(_ reader: BufferReader) -> MessagePeerReaction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Api.Reaction?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.Reaction
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.MessagePeerReaction.messagePeerReaction(Cons_messagePeerReaction(flags: _1!, peerId: _2!, date: _3!, reaction: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum MessagePeerVote: TypeConstructorDescription {
        class Cons_messagePeerVote: TypeConstructorDescription {
            var peer: Api.Peer
            var option: Buffer
            var date: Int32
            init(peer: Api.Peer, option: Buffer, date: Int32) {
                self.peer = peer
                self.option = option
                self.date = date
            }
        }
        class Cons_messagePeerVoteInputOption: TypeConstructorDescription {
            var peer: Api.Peer
            var date: Int32
            init(peer: Api.Peer, date: Int32) {
                self.peer = peer
                self.date = date
            }
        }
        class Cons_messagePeerVoteMultiple: TypeConstructorDescription {
            var peer: Api.Peer
            var options: [Buffer]
            var date: Int32
            init(peer: Api.Peer, options: [Buffer], date: Int32) {
                self.peer = peer
                self.options = options
                self.date = date
            }
        }
        case messagePeerVote(Cons_messagePeerVote)
        case messagePeerVoteInputOption(Cons_messagePeerVoteInputOption)
        case messagePeerVoteMultiple(Cons_messagePeerVoteMultiple)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .messagePeerVote(let _data):
                if boxed {
                    buffer.appendInt32(-1228133028)
                }
                _data.peer.serialize(buffer, true)
                serializeBytes(_data.option, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                break
            case .messagePeerVoteInputOption(let _data):
                if boxed {
                    buffer.appendInt32(1959634180)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                break
            case .messagePeerVoteMultiple(let _data):
                if boxed {
                    buffer.appendInt32(1177089766)
                }
                _data.peer.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.options.count))
                for item in _data.options {
                    serializeBytes(item, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_messagePeerVote(_ reader: BufferReader) -> MessagePeerVote? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Buffer?
            _2 = parseBytes(reader)
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessagePeerVote.messagePeerVote(Cons_messagePeerVote(peer: _1!, option: _2!, date: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_messagePeerVoteInputOption(_ reader: BufferReader) -> MessagePeerVote? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessagePeerVote.messagePeerVoteInputOption(Cons_messagePeerVoteInputOption(peer: _1!, date: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messagePeerVoteMultiple(_ reader: BufferReader) -> MessagePeerVote? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: [Buffer]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: -1255641564, elementType: Buffer.self)
            }
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessagePeerVote.messagePeerVoteMultiple(Cons_messagePeerVoteMultiple(peer: _1!, options: _2!, date: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum MessageReactions: TypeConstructorDescription {
        class Cons_messageReactions: TypeConstructorDescription {
            var flags: Int32
            var results: [Api.ReactionCount]
            var recentReactions: [Api.MessagePeerReaction]?
            var topReactors: [Api.MessageReactor]?
            init(flags: Int32, results: [Api.ReactionCount], recentReactions: [Api.MessagePeerReaction]?, topReactors: [Api.MessageReactor]?) {
                self.flags = flags
                self.results = results
                self.recentReactions = recentReactions
                self.topReactors = topReactors
            }
        }
        case messageReactions(Cons_messageReactions)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .messageReactions(let _data):
                if boxed {
                    buffer.appendInt32(171155211)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.results.count))
                for item in _data.results {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.recentReactions!.count))
                    for item in _data.recentReactions! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.topReactors!.count))
                    for item in _data.topReactors! {
                        item.serialize(buffer, true)
                    }
                }
                break
            }
        }

        static func parse_messageReactions(_ reader: BufferReader) -> MessageReactions? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.ReactionCount]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.ReactionCount.self)
            }
            var _3: [Api.MessagePeerReaction]?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let _ = reader.readInt32() {
                    _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessagePeerReaction.self)
                }
            }
            var _4: [Api.MessageReactor]?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let _ = reader.readInt32() {
                    _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageReactor.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.MessageReactions.messageReactions(Cons_messageReactions(flags: _1!, results: _2!, recentReactions: _3, topReactors: _4))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum MessageReactor: TypeConstructorDescription {
        class Cons_messageReactor: TypeConstructorDescription {
            var flags: Int32
            var peerId: Api.Peer?
            var count: Int32
            init(flags: Int32, peerId: Api.Peer?, count: Int32) {
                self.flags = flags
                self.peerId = peerId
                self.count = count
            }
        }
        case messageReactor(Cons_messageReactor)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .messageReactor(let _data):
                if boxed {
                    buffer.appendInt32(1269016922)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.peerId!.serialize(buffer, true)
                }
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_messageReactor(_ reader: BufferReader) -> MessageReactor? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessageReactor.messageReactor(Cons_messageReactor(flags: _1!, peerId: _2, count: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum MessageReplies: TypeConstructorDescription {
        class Cons_messageReplies: TypeConstructorDescription {
            var flags: Int32
            var replies: Int32
            var repliesPts: Int32
            var recentRepliers: [Api.Peer]?
            var channelId: Int64?
            var maxId: Int32?
            var readMaxId: Int32?
            init(flags: Int32, replies: Int32, repliesPts: Int32, recentRepliers: [Api.Peer]?, channelId: Int64?, maxId: Int32?, readMaxId: Int32?) {
                self.flags = flags
                self.replies = replies
                self.repliesPts = repliesPts
                self.recentRepliers = recentRepliers
                self.channelId = channelId
                self.maxId = maxId
                self.readMaxId = readMaxId
            }
        }
        case messageReplies(Cons_messageReplies)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .messageReplies(let _data):
                if boxed {
                    buffer.appendInt32(-2083123262)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.replies, buffer: buffer, boxed: false)
                serializeInt32(_data.repliesPts, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.recentRepliers!.count))
                    for item in _data.recentRepliers! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.channelId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.maxId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.readMaxId!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_messageReplies(_ reader: BufferReader) -> MessageReplies? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: [Api.Peer]?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let _ = reader.readInt32() {
                    _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Peer.self)
                }
            }
            var _5: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = reader.readInt64()
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _6 = reader.readInt32()
            }
            var _7: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _7 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.MessageReplies.messageReplies(Cons_messageReplies(flags: _1!, replies: _2!, repliesPts: _3!, recentRepliers: _4, channelId: _5, maxId: _6, readMaxId: _7))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum MessageReplyHeader: TypeConstructorDescription {
        class Cons_messageReplyHeader: TypeConstructorDescription {
            var flags: Int32
            var replyToMsgId: Int32?
            var replyToPeerId: Api.Peer?
            var replyFrom: Api.MessageFwdHeader?
            var replyMedia: Api.MessageMedia?
            var replyToTopId: Int32?
            var quoteText: String?
            var quoteEntities: [Api.MessageEntity]?
            var quoteOffset: Int32?
            var todoItemId: Int32?
            var pollOption: Buffer?
            var quoteRich: [Api.RichText]?
            init(flags: Int32, replyToMsgId: Int32?, replyToPeerId: Api.Peer?, replyFrom: Api.MessageFwdHeader?, replyMedia: Api.MessageMedia?, replyToTopId: Int32?, quoteText: String?, quoteEntities: [Api.MessageEntity]?, quoteOffset: Int32?, todoItemId: Int32?, pollOption: Buffer?, quoteRich: [Api.RichText]?) {
                self.flags = flags
                self.replyToMsgId = replyToMsgId
                self.replyToPeerId = replyToPeerId
                self.replyFrom = replyFrom
                self.replyMedia = replyMedia
                self.replyToTopId = replyToTopId
                self.quoteText = quoteText
                self.quoteEntities = quoteEntities
                self.quoteOffset = quoteOffset
                self.todoItemId = todoItemId
                self.pollOption = pollOption
                self.quoteRich = quoteRich
            }
        }
        class Cons_messageReplyStoryHeader: TypeConstructorDescription {
            var peer: Api.Peer
            var storyId: Int32
            init(peer: Api.Peer, storyId: Int32) {
                self.peer = peer
                self.storyId = storyId
            }
        }
        case messageReplyHeader(Cons_messageReplyHeader)
        case messageReplyStoryHeader(Cons_messageReplyStoryHeader)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .messageReplyHeader(let _data):
                if boxed {
                    buffer.appendInt32(-575296651)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.replyToMsgId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.replyToPeerId!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    _data.replyFrom!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    _data.replyMedia!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.replyToTopId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    serializeString(_data.quoteText!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.quoteEntities!.count))
                    for item in _data.quoteEntities! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    serializeInt32(_data.quoteOffset!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    serializeInt32(_data.todoItemId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 12) != 0 {
                    serializeBytes(_data.pollOption!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 14) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.quoteRich!.count))
                    for item in _data.quoteRich! {
                        item.serialize(buffer, true)
                    }
                }
                break
            case .messageReplyStoryHeader(let _data):
                if boxed {
                    buffer.appendInt32(240843065)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.storyId, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_messageReplyHeader(_ reader: BufferReader) -> MessageReplyHeader? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _2 = reader.readInt32()
            }
            var _3: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _4: Api.MessageFwdHeader?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.MessageFwdHeader
                }
            }
            var _5: Api.MessageMedia?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.MessageMedia
                }
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _6 = reader.readInt32()
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                _7 = parseString(reader)
            }
            var _8: [Api.MessageEntity]?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                if let _ = reader.readInt32() {
                    _8 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self)
                }
            }
            var _9: Int32?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                _9 = reader.readInt32()
            }
            var _10: Int32?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                _10 = reader.readInt32()
            }
            var _11: Buffer?
            if Int(_1 ?? 0) & Int(1 << 12) != 0 {
                _11 = parseBytes(reader)
            }
            var _12: [Api.RichText]?
            if Int(_1 ?? 0) & Int(1 << 14) != 0 {
                if let _ = reader.readInt32() {
                    _12 = Api.parseVector(reader, elementSignature: 0, elementType: Api.RichText.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 12) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 14) == 0) || _12 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 {
                return Api.MessageReplyHeader.messageReplyHeader(Cons_messageReplyHeader(flags: _1!, replyToMsgId: _2, replyToPeerId: _3, replyFrom: _4, replyMedia: _5, replyToTopId: _6, quoteText: _7, quoteEntities: _8, quoteOffset: _9, todoItemId: _10, pollOption: _11, quoteRich: _12))
            }
            else {
                return nil
            }
        }
        static func parse_messageReplyStoryHeader(_ reader: BufferReader) -> MessageReplyHeader? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageReplyHeader.messageReplyStoryHeader(Cons_messageReplyStoryHeader(peer: _1!, storyId: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum MessageViews: TypeConstructorDescription {
        class Cons_messageViews: TypeConstructorDescription {
            var flags: Int32
            var views: Int32?
            var forwards: Int32?
            var replies: Api.MessageReplies?
            init(flags: Int32, views: Int32?, forwards: Int32?, replies: Api.MessageReplies?) {
                self.flags = flags
                self.views = views
                self.forwards = forwards
                self.replies = replies
            }
        }
        case messageViews(Cons_messageViews)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .messageViews(let _data):
                if boxed {
                    buffer.appendInt32(1163625789)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.views!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.forwards!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.replies!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_messageViews(_ reader: BufferReader) -> MessageViews? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt32()
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Api.MessageReplies?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.MessageReplies
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.MessageViews.messageViews(Cons_messageViews(flags: _1!, views: _2, forwards: _3, replies: _4))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum MyBoost: TypeConstructorDescription {
        class Cons_myBoost: TypeConstructorDescription {
            var flags: Int32
            var slot: Int32
            var peer: Api.Peer?
            var date: Int32
            var expires: Int32
            var cooldownUntilDate: Int32?
            init(flags: Int32, slot: Int32, peer: Api.Peer?, date: Int32, expires: Int32, cooldownUntilDate: Int32?) {
                self.flags = flags
                self.slot = slot
                self.peer = peer
                self.date = date
                self.expires = expires
                self.cooldownUntilDate = cooldownUntilDate
            }
        }
        case myBoost(Cons_myBoost)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .myBoost(let _data):
                if boxed {
                    buffer.appendInt32(-1001897636)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.slot, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.peer!.serialize(buffer, true)
                }
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt32(_data.expires, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.cooldownUntilDate!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_myBoost(_ reader: BufferReader) -> MyBoost? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _6 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.MyBoost.myBoost(Cons_myBoost(flags: _1!, slot: _2!, peer: _3, date: _4!, expires: _5!, cooldownUntilDate: _6))
            }
            else {
                return nil
            }
        }
    }
}
