extension Api {
    enum RecentMeUrl: TypeConstructorDescription {
        class Cons_recentMeUrlChat: TypeConstructorDescription {
            var url: String
            var chatId: Int64
            init(url: String, chatId: Int64) {
                self.url = url
                self.chatId = chatId
            }
        }
        class Cons_recentMeUrlChatInvite: TypeConstructorDescription {
            var url: String
            var chatInvite: Api.ChatInvite
            init(url: String, chatInvite: Api.ChatInvite) {
                self.url = url
                self.chatInvite = chatInvite
            }
        }
        class Cons_recentMeUrlStickerSet: TypeConstructorDescription {
            var url: String
            var set: Api.StickerSetCovered
            init(url: String, set: Api.StickerSetCovered) {
                self.url = url
                self.set = set
            }
        }
        class Cons_recentMeUrlUnknown: TypeConstructorDescription {
            var url: String
            init(url: String) {
                self.url = url
            }
        }
        class Cons_recentMeUrlUser: TypeConstructorDescription {
            var url: String
            var userId: Int64
            init(url: String, userId: Int64) {
                self.url = url
                self.userId = userId
            }
        }
        case recentMeUrlChat(Cons_recentMeUrlChat)
        case recentMeUrlChatInvite(Cons_recentMeUrlChatInvite)
        case recentMeUrlStickerSet(Cons_recentMeUrlStickerSet)
        case recentMeUrlUnknown(Cons_recentMeUrlUnknown)
        case recentMeUrlUser(Cons_recentMeUrlUser)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .recentMeUrlChat(let _data):
                if boxed {
                    buffer.appendInt32(-1294306862)
                }
                serializeString(_data.url, buffer: buffer, boxed: false)
                serializeInt64(_data.chatId, buffer: buffer, boxed: false)
                break
            case .recentMeUrlChatInvite(let _data):
                if boxed {
                    buffer.appendInt32(-347535331)
                }
                serializeString(_data.url, buffer: buffer, boxed: false)
                _data.chatInvite.serialize(buffer, true)
                break
            case .recentMeUrlStickerSet(let _data):
                if boxed {
                    buffer.appendInt32(-1140172836)
                }
                serializeString(_data.url, buffer: buffer, boxed: false)
                _data.set.serialize(buffer, true)
                break
            case .recentMeUrlUnknown(let _data):
                if boxed {
                    buffer.appendInt32(1189204285)
                }
                serializeString(_data.url, buffer: buffer, boxed: false)
                break
            case .recentMeUrlUser(let _data):
                if boxed {
                    buffer.appendInt32(-1188296222)
                }
                serializeString(_data.url, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_recentMeUrlChat(_ reader: BufferReader) -> RecentMeUrl? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.RecentMeUrl.recentMeUrlChat(Cons_recentMeUrlChat(url: _1!, chatId: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_recentMeUrlChatInvite(_ reader: BufferReader) -> RecentMeUrl? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Api.ChatInvite?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.ChatInvite
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.RecentMeUrl.recentMeUrlChatInvite(Cons_recentMeUrlChatInvite(url: _1!, chatInvite: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_recentMeUrlStickerSet(_ reader: BufferReader) -> RecentMeUrl? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Api.StickerSetCovered?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.StickerSetCovered
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.RecentMeUrl.recentMeUrlStickerSet(Cons_recentMeUrlStickerSet(url: _1!, set: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_recentMeUrlUnknown(_ reader: BufferReader) -> RecentMeUrl? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.RecentMeUrl.recentMeUrlUnknown(Cons_recentMeUrlUnknown(url: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_recentMeUrlUser(_ reader: BufferReader) -> RecentMeUrl? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.RecentMeUrl.recentMeUrlUser(Cons_recentMeUrlUser(url: _1!, userId: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum RecentStory: TypeConstructorDescription {
        class Cons_recentStory: TypeConstructorDescription {
            var flags: Int32
            var maxId: Int32?
            init(flags: Int32, maxId: Int32?) {
                self.flags = flags
                self.maxId = maxId
            }
        }
        case recentStory(Cons_recentStory)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .recentStory(let _data):
                if boxed {
                    buffer.appendInt32(1897752877)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.maxId!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_recentStory(_ reader: BufferReader) -> RecentStory? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _2 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _2 != nil
            if _c1 && _c2 {
                return Api.RecentStory.recentStory(Cons_recentStory(flags: _1!, maxId: _2))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum ReplyMarkup: TypeConstructorDescription {
        class Cons_replyInlineMarkup: TypeConstructorDescription {
            var flags: Int32
            var rows: [Api.KeyboardInlineButtonRow]
            init(flags: Int32, rows: [Api.KeyboardInlineButtonRow]) {
                self.flags = flags
                self.rows = rows
            }
        }
        class Cons_replyKeyboardForceReply: TypeConstructorDescription {
            var flags: Int32
            var placeholder: String?
            init(flags: Int32, placeholder: String?) {
                self.flags = flags
                self.placeholder = placeholder
            }
        }
        class Cons_replyKeyboardHide: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        class Cons_replyKeyboardMarkup: TypeConstructorDescription {
            var flags: Int32
            var rows: [Api.KeyboardButtonRow]
            var placeholder: String?
            init(flags: Int32, rows: [Api.KeyboardButtonRow], placeholder: String?) {
                self.flags = flags
                self.rows = rows
                self.placeholder = placeholder
            }
        }
        case replyInlineMarkup(Cons_replyInlineMarkup)
        case replyKeyboardForceReply(Cons_replyKeyboardForceReply)
        case replyKeyboardHide(Cons_replyKeyboardHide)
        case replyKeyboardMarkup(Cons_replyKeyboardMarkup)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .replyInlineMarkup(let _data):
                if boxed {
                    buffer.appendInt32(-1297000592)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.rows.count))
                for item in _data.rows {
                    item.serialize(buffer, true)
                }
                break
            case .replyKeyboardForceReply(let _data):
                if boxed {
                    buffer.appendInt32(-2035021048)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.placeholder!, buffer: buffer, boxed: false)
                }
                break
            case .replyKeyboardHide(let _data):
                if boxed {
                    buffer.appendInt32(-1606526075)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            case .replyKeyboardMarkup(let _data):
                if boxed {
                    buffer.appendInt32(-2049074735)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.rows.count))
                for item in _data.rows {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.placeholder!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_replyInlineMarkup(_ reader: BufferReader) -> ReplyMarkup? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.KeyboardInlineButtonRow]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.KeyboardInlineButtonRow.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ReplyMarkup.replyInlineMarkup(Cons_replyInlineMarkup(flags: _1!, rows: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_replyKeyboardForceReply(_ reader: BufferReader) -> ReplyMarkup? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _2 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _2 != nil
            if _c1 && _c2 {
                return Api.ReplyMarkup.replyKeyboardForceReply(Cons_replyKeyboardForceReply(flags: _1!, placeholder: _2))
            }
            else {
                return nil
            }
        }
        static func parse_replyKeyboardHide(_ reader: BufferReader) -> ReplyMarkup? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.ReplyMarkup.replyKeyboardHide(Cons_replyKeyboardHide(flags: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_replyKeyboardMarkup(_ reader: BufferReader) -> ReplyMarkup? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.KeyboardButtonRow]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.KeyboardButtonRow.self)
            }
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _3 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.ReplyMarkup.replyKeyboardMarkup(Cons_replyKeyboardMarkup(flags: _1!, rows: _2!, placeholder: _3))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum RequestPeerType: TypeConstructorDescription {
        class Cons_requestPeerTypeBroadcast: TypeConstructorDescription {
            var flags: Int32
            var hasUsername: Api.Bool?
            var userAdminRights: Api.ChatAdminRights?
            var botAdminRights: Api.ChatAdminRights?
            init(flags: Int32, hasUsername: Api.Bool?, userAdminRights: Api.ChatAdminRights?, botAdminRights: Api.ChatAdminRights?) {
                self.flags = flags
                self.hasUsername = hasUsername
                self.userAdminRights = userAdminRights
                self.botAdminRights = botAdminRights
            }
        }
        class Cons_requestPeerTypeChat: TypeConstructorDescription {
            var flags: Int32
            var hasUsername: Api.Bool?
            var forum: Api.Bool?
            var userAdminRights: Api.ChatAdminRights?
            var botAdminRights: Api.ChatAdminRights?
            init(flags: Int32, hasUsername: Api.Bool?, forum: Api.Bool?, userAdminRights: Api.ChatAdminRights?, botAdminRights: Api.ChatAdminRights?) {
                self.flags = flags
                self.hasUsername = hasUsername
                self.forum = forum
                self.userAdminRights = userAdminRights
                self.botAdminRights = botAdminRights
            }
        }
        class Cons_requestPeerTypeCreateBot: TypeConstructorDescription {
            var flags: Int32
            var suggestedName: String?
            var suggestedUsername: String?
            init(flags: Int32, suggestedName: String?, suggestedUsername: String?) {
                self.flags = flags
                self.suggestedName = suggestedName
                self.suggestedUsername = suggestedUsername
            }
        }
        class Cons_requestPeerTypeUser: TypeConstructorDescription {
            var flags: Int32
            var bot: Api.Bool?
            var premium: Api.Bool?
            init(flags: Int32, bot: Api.Bool?, premium: Api.Bool?) {
                self.flags = flags
                self.bot = bot
                self.premium = premium
            }
        }
        case requestPeerTypeBroadcast(Cons_requestPeerTypeBroadcast)
        case requestPeerTypeChat(Cons_requestPeerTypeChat)
        case requestPeerTypeCreateBot(Cons_requestPeerTypeCreateBot)
        case requestPeerTypeUser(Cons_requestPeerTypeUser)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .requestPeerTypeBroadcast(let _data):
                if boxed {
                    buffer.appendInt32(865857388)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.hasUsername!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.userAdminRights!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.botAdminRights!.serialize(buffer, true)
                }
                break
            case .requestPeerTypeChat(let _data):
                if boxed {
                    buffer.appendInt32(-906990053)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.hasUsername!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    _data.forum!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.userAdminRights!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.botAdminRights!.serialize(buffer, true)
                }
                break
            case .requestPeerTypeCreateBot(let _data):
                if boxed {
                    buffer.appendInt32(1048699000)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.suggestedName!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.suggestedUsername!, buffer: buffer, boxed: false)
                }
                break
            case .requestPeerTypeUser(let _data):
                if boxed {
                    buffer.appendInt32(1597737472)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.bot!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.premium!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_requestPeerTypeBroadcast(_ reader: BufferReader) -> RequestPeerType? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            var _3: Api.ChatAdminRights?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.ChatAdminRights
                }
            }
            var _4: Api.ChatAdminRights?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.ChatAdminRights
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.RequestPeerType.requestPeerTypeBroadcast(Cons_requestPeerTypeBroadcast(flags: _1!, hasUsername: _2, userAdminRights: _3, botAdminRights: _4))
            }
            else {
                return nil
            }
        }
        static func parse_requestPeerTypeChat(_ reader: BufferReader) -> RequestPeerType? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            var _3: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            var _4: Api.ChatAdminRights?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.ChatAdminRights
                }
            }
            var _5: Api.ChatAdminRights?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.ChatAdminRights
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.RequestPeerType.requestPeerTypeChat(Cons_requestPeerTypeChat(flags: _1!, hasUsername: _2, forum: _3, userAdminRights: _4, botAdminRights: _5))
            }
            else {
                return nil
            }
        }
        static func parse_requestPeerTypeCreateBot(_ reader: BufferReader) -> RequestPeerType? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _2 = parseString(reader)
            }
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _3 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.RequestPeerType.requestPeerTypeCreateBot(Cons_requestPeerTypeCreateBot(flags: _1!, suggestedName: _2, suggestedUsername: _3))
            }
            else {
                return nil
            }
        }
        static func parse_requestPeerTypeUser(_ reader: BufferReader) -> RequestPeerType? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            var _3: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.RequestPeerType.requestPeerTypeUser(Cons_requestPeerTypeUser(flags: _1!, bot: _2, premium: _3))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum RequestedPeer: TypeConstructorDescription {
        class Cons_requestedPeerChannel: TypeConstructorDescription {
            var flags: Int32
            var channelId: Int64
            var title: String?
            var username: String?
            var photo: Api.Photo?
            init(flags: Int32, channelId: Int64, title: String?, username: String?, photo: Api.Photo?) {
                self.flags = flags
                self.channelId = channelId
                self.title = title
                self.username = username
                self.photo = photo
            }
        }
        class Cons_requestedPeerChat: TypeConstructorDescription {
            var flags: Int32
            var chatId: Int64
            var title: String?
            var photo: Api.Photo?
            init(flags: Int32, chatId: Int64, title: String?, photo: Api.Photo?) {
                self.flags = flags
                self.chatId = chatId
                self.title = title
                self.photo = photo
            }
        }
        class Cons_requestedPeerUser: TypeConstructorDescription {
            var flags: Int32
            var userId: Int64
            var firstName: String?
            var lastName: String?
            var username: String?
            var photo: Api.Photo?
            init(flags: Int32, userId: Int64, firstName: String?, lastName: String?, username: String?, photo: Api.Photo?) {
                self.flags = flags
                self.userId = userId
                self.firstName = firstName
                self.lastName = lastName
                self.username = username
                self.photo = photo
            }
        }
        case requestedPeerChannel(Cons_requestedPeerChannel)
        case requestedPeerChat(Cons_requestedPeerChat)
        case requestedPeerUser(Cons_requestedPeerUser)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .requestedPeerChannel(let _data):
                if boxed {
                    buffer.appendInt32(-1952185372)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.title!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.username!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.photo!.serialize(buffer, true)
                }
                break
            case .requestedPeerChat(let _data):
                if boxed {
                    buffer.appendInt32(1929860175)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.chatId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.title!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.photo!.serialize(buffer, true)
                }
                break
            case .requestedPeerUser(let _data):
                if boxed {
                    buffer.appendInt32(-701500310)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.firstName!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.lastName!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.username!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.photo!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_requestedPeerChannel(_ reader: BufferReader) -> RequestedPeer? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = parseString(reader)
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _4 = parseString(reader)
            }
            var _5: Api.Photo?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.Photo
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.RequestedPeer.requestedPeerChannel(Cons_requestedPeerChannel(flags: _1!, channelId: _2!, title: _3, username: _4, photo: _5))
            }
            else {
                return nil
            }
        }
        static func parse_requestedPeerChat(_ reader: BufferReader) -> RequestedPeer? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = parseString(reader)
            }
            var _4: Api.Photo?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.Photo
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.RequestedPeer.requestedPeerChat(Cons_requestedPeerChat(flags: _1!, chatId: _2!, title: _3, photo: _4))
            }
            else {
                return nil
            }
        }
        static func parse_requestedPeerUser(_ reader: BufferReader) -> RequestedPeer? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = parseString(reader)
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _5 = parseString(reader)
            }
            var _6: Api.Photo?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.Photo
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.RequestedPeer.requestedPeerUser(Cons_requestedPeerUser(flags: _1!, userId: _2!, firstName: _3, lastName: _4, username: _5, photo: _6))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum RestrictionReason: TypeConstructorDescription {
        class Cons_restrictionReason: TypeConstructorDescription {
            var platform: String
            var reason: String
            var text: String
            init(platform: String, reason: String, text: String) {
                self.platform = platform
                self.reason = reason
                self.text = text
            }
        }
        case restrictionReason(Cons_restrictionReason)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .restrictionReason(let _data):
                if boxed {
                    buffer.appendInt32(-797791052)
                }
                serializeString(_data.platform, buffer: buffer, boxed: false)
                serializeString(_data.reason, buffer: buffer, boxed: false)
                serializeString(_data.text, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_restrictionReason(_ reader: BufferReader) -> RestrictionReason? {
            var _1: String?
            _1 = parseString(reader)
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            _3 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.RestrictionReason.restrictionReason(Cons_restrictionReason(platform: _1!, reason: _2!, text: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum RichButtonStyle: TypeConstructorDescription {
        class Cons_richButtonStyle: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        case richButtonStyle(Cons_richButtonStyle)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .richButtonStyle(let _data):
                if boxed {
                    buffer.appendInt32(63312061)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_richButtonStyle(_ reader: BufferReader) -> RichButtonStyle? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichButtonStyle.richButtonStyle(Cons_richButtonStyle(flags: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum RichMessage: TypeConstructorDescription {
        class Cons_richMessage: TypeConstructorDescription {
            var flags: Int32
            var blocks: [Api.PageBlock]
            var photos: [Api.Photo]
            var documents: [Api.Document]
            init(flags: Int32, blocks: [Api.PageBlock], photos: [Api.Photo], documents: [Api.Document]) {
                self.flags = flags
                self.blocks = blocks
                self.photos = photos
                self.documents = documents
            }
        }
        case richMessage(Cons_richMessage)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .richMessage(let _data):
                if boxed {
                    buffer.appendInt32(-1158439541)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.blocks.count))
                for item in _data.blocks {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.photos.count))
                for item in _data.photos {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.documents.count))
                for item in _data.documents {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_richMessage(_ reader: BufferReader) -> RichMessage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.PageBlock]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageBlock.self)
            }
            var _3: [Api.Photo]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Photo.self)
            }
            var _4: [Api.Document]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Document.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.RichMessage.richMessage(Cons_richMessage(flags: _1!, blocks: _2!, photos: _3!, documents: _4!))
            }
            else {
                return nil
            }
        }
    }
}
