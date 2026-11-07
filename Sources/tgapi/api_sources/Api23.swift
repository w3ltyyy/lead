extension Api {
    indirect enum Updates: TypeConstructorDescription {
        class Cons_updateShort: TypeConstructorDescription {
            var update: Api.Update
            var date: Int32
            init(update: Api.Update, date: Int32) {
                self.update = update
                self.date = date
            }
        }
        class Cons_updateShortChatMessage: TypeConstructorDescription {
            var flags: Int32
            var id: Int32
            var fromId: Int64
            var chatId: Int64
            var message: String
            var pts: Int32
            var ptsCount: Int32
            var date: Int32
            var fwdFrom: Api.MessageFwdHeader?
            var viaBotId: Int64?
            var replyTo: Api.MessageReplyHeader?
            var entities: [Api.MessageEntity]?
            var ttlPeriod: Int32?
            init(flags: Int32, id: Int32, fromId: Int64, chatId: Int64, message: String, pts: Int32, ptsCount: Int32, date: Int32, fwdFrom: Api.MessageFwdHeader?, viaBotId: Int64?, replyTo: Api.MessageReplyHeader?, entities: [Api.MessageEntity]?, ttlPeriod: Int32?) {
                self.flags = flags
                self.id = id
                self.fromId = fromId
                self.chatId = chatId
                self.message = message
                self.pts = pts
                self.ptsCount = ptsCount
                self.date = date
                self.fwdFrom = fwdFrom
                self.viaBotId = viaBotId
                self.replyTo = replyTo
                self.entities = entities
                self.ttlPeriod = ttlPeriod
            }
        }
        class Cons_updateShortMessage: TypeConstructorDescription {
            var flags: Int32
            var id: Int32
            var userId: Int64
            var message: String
            var pts: Int32
            var ptsCount: Int32
            var date: Int32
            var fwdFrom: Api.MessageFwdHeader?
            var viaBotId: Int64?
            var replyTo: Api.MessageReplyHeader?
            var entities: [Api.MessageEntity]?
            var ttlPeriod: Int32?
            init(flags: Int32, id: Int32, userId: Int64, message: String, pts: Int32, ptsCount: Int32, date: Int32, fwdFrom: Api.MessageFwdHeader?, viaBotId: Int64?, replyTo: Api.MessageReplyHeader?, entities: [Api.MessageEntity]?, ttlPeriod: Int32?) {
                self.flags = flags
                self.id = id
                self.userId = userId
                self.message = message
                self.pts = pts
                self.ptsCount = ptsCount
                self.date = date
                self.fwdFrom = fwdFrom
                self.viaBotId = viaBotId
                self.replyTo = replyTo
                self.entities = entities
                self.ttlPeriod = ttlPeriod
            }
        }
        class Cons_updateShortSentMessage: TypeConstructorDescription {
            var flags: Int32
            var id: Int32
            var pts: Int32
            var ptsCount: Int32
            var date: Int32
            var media: Api.MessageMedia?
            var entities: [Api.MessageEntity]?
            var ttlPeriod: Int32?
            init(flags: Int32, id: Int32, pts: Int32, ptsCount: Int32, date: Int32, media: Api.MessageMedia?, entities: [Api.MessageEntity]?, ttlPeriod: Int32?) {
                self.flags = flags
                self.id = id
                self.pts = pts
                self.ptsCount = ptsCount
                self.date = date
                self.media = media
                self.entities = entities
                self.ttlPeriod = ttlPeriod
            }
        }
        class Cons_updates: TypeConstructorDescription {
            var updates: [Api.Update]
            var users: [Api.User]
            var chats: [Api.Chat]
            var date: Int32
            var seq: Int32
            init(updates: [Api.Update], users: [Api.User], chats: [Api.Chat], date: Int32, seq: Int32) {
                self.updates = updates
                self.users = users
                self.chats = chats
                self.date = date
                self.seq = seq
            }
        }
        class Cons_updatesCombined: TypeConstructorDescription {
            var updates: [Api.Update]
            var users: [Api.User]
            var chats: [Api.Chat]
            var date: Int32
            var seqStart: Int32
            var seq: Int32
            init(updates: [Api.Update], users: [Api.User], chats: [Api.Chat], date: Int32, seqStart: Int32, seq: Int32) {
                self.updates = updates
                self.users = users
                self.chats = chats
                self.date = date
                self.seqStart = seqStart
                self.seq = seq
            }
        }
        case updateShort(Cons_updateShort)
        case updateShortChatMessage(Cons_updateShortChatMessage)
        case updateShortMessage(Cons_updateShortMessage)
        case updateShortSentMessage(Cons_updateShortSentMessage)
        case updates(Cons_updates)
        case updatesCombined(Cons_updatesCombined)
        case updatesTooLong

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .updateShort(let _data):
                if boxed {
                    buffer.appendInt32(2027216577)
                }
                _data.update.serialize(buffer, true)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                break
            case .updateShortChatMessage(let _data):
                if boxed {
                    buffer.appendInt32(1299050149)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.fromId, buffer: buffer, boxed: false)
                serializeInt64(_data.chatId, buffer: buffer, boxed: false)
                serializeString(_data.message, buffer: buffer, boxed: false)
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.fwdFrom!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    serializeInt64(_data.viaBotId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.replyTo!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.entities!.count))
                    for item in _data.entities! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 25) != 0 {
                    serializeInt32(_data.ttlPeriod!, buffer: buffer, boxed: false)
                }
                break
            case .updateShortMessage(let _data):
                if boxed {
                    buffer.appendInt32(826001400)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeString(_data.message, buffer: buffer, boxed: false)
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.fwdFrom!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    serializeInt64(_data.viaBotId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.replyTo!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.entities!.count))
                    for item in _data.entities! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 25) != 0 {
                    serializeInt32(_data.ttlPeriod!, buffer: buffer, boxed: false)
                }
                break
            case .updateShortSentMessage(let _data):
                if boxed {
                    buffer.appendInt32(-1877614335)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.ptsCount, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    _data.media!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.entities!.count))
                    for item in _data.entities! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 25) != 0 {
                    serializeInt32(_data.ttlPeriod!, buffer: buffer, boxed: false)
                }
                break
            case .updates(let _data):
                if boxed {
                    buffer.appendInt32(1957577280)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.updates.count))
                for item in _data.updates {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt32(_data.seq, buffer: buffer, boxed: false)
                break
            case .updatesCombined(let _data):
                if boxed {
                    buffer.appendInt32(1918567619)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.updates.count))
                for item in _data.updates {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt32(_data.seqStart, buffer: buffer, boxed: false)
                serializeInt32(_data.seq, buffer: buffer, boxed: false)
                break
            case .updatesTooLong:
                if boxed {
                    buffer.appendInt32(-484987010)
                }
                break
            }
        }

        static func parse_updateShort(_ reader: BufferReader) -> Updates? {
            var _1: Api.Update?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Update
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Updates.updateShort(Cons_updateShort(update: _1!, date: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_updateShortChatMessage(_ reader: BufferReader) -> Updates? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: String?
            _5 = parseString(reader)
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: Int32?
            _7 = reader.readInt32()
            var _8: Int32?
            _8 = reader.readInt32()
            var _9: Api.MessageFwdHeader?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.MessageFwdHeader
                }
            }
            var _10: Int64?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                _10 = reader.readInt64()
            }
            var _11: Api.MessageReplyHeader?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _11 = Api.parse(reader, signature: signature) as? Api.MessageReplyHeader
                }
            }
            var _12: [Api.MessageEntity]?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                if let _ = reader.readInt32() {
                    _12 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self)
                }
            }
            var _13: Int32?
            if Int(_1 ?? 0) & Int(1 << 25) != 0 {
                _13 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 25) == 0) || _13 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 {
                return Api.Updates.updateShortChatMessage(Cons_updateShortChatMessage(flags: _1!, id: _2!, fromId: _3!, chatId: _4!, message: _5!, pts: _6!, ptsCount: _7!, date: _8!, fwdFrom: _9, viaBotId: _10, replyTo: _11, entities: _12, ttlPeriod: _13))
            }
            else {
                return nil
            }
        }
        static func parse_updateShortMessage(_ reader: BufferReader) -> Updates? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: String?
            _4 = parseString(reader)
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: Int32?
            _7 = reader.readInt32()
            var _8: Api.MessageFwdHeader?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.MessageFwdHeader
                }
            }
            var _9: Int64?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                _9 = reader.readInt64()
            }
            var _10: Api.MessageReplyHeader?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _10 = Api.parse(reader, signature: signature) as? Api.MessageReplyHeader
                }
            }
            var _11: [Api.MessageEntity]?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                if let _ = reader.readInt32() {
                    _11 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self)
                }
            }
            var _12: Int32?
            if Int(_1 ?? 0) & Int(1 << 25) != 0 {
                _12 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 25) == 0) || _12 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 {
                return Api.Updates.updateShortMessage(Cons_updateShortMessage(flags: _1!, id: _2!, userId: _3!, message: _4!, pts: _5!, ptsCount: _6!, date: _7!, fwdFrom: _8, viaBotId: _9, replyTo: _10, entities: _11, ttlPeriod: _12))
            }
            else {
                return nil
            }
        }
        static func parse_updateShortSentMessage(_ reader: BufferReader) -> Updates? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Api.MessageMedia?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.MessageMedia
                }
            }
            var _7: [Api.MessageEntity]?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                if let _ = reader.readInt32() {
                    _7 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self)
                }
            }
            var _8: Int32?
            if Int(_1 ?? 0) & Int(1 << 25) != 0 {
                _8 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 25) == 0) || _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.Updates.updateShortSentMessage(Cons_updateShortSentMessage(flags: _1!, id: _2!, pts: _3!, ptsCount: _4!, date: _5!, media: _6, entities: _7, ttlPeriod: _8))
            }
            else {
                return nil
            }
        }
        static func parse_updates(_ reader: BufferReader) -> Updates? {
            var _1: [Api.Update]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Update.self)
            }
            var _2: [Api.User]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            var _3: [Api.Chat]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
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
                return Api.Updates.updates(Cons_updates(updates: _1!, users: _2!, chats: _3!, date: _4!, seq: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_updatesCombined(_ reader: BufferReader) -> Updates? {
            var _1: [Api.Update]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Update.self)
            }
            var _2: [Api.User]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            var _3: [Api.Chat]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int32?
            _6 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.Updates.updatesCombined(Cons_updatesCombined(updates: _1!, users: _2!, chats: _3!, date: _4!, seqStart: _5!, seq: _6!))
            }
            else {
                return nil
            }
        }
        static func parse_updatesTooLong(_ reader: BufferReader) -> Updates? {
            return Api.Updates.updatesTooLong
        }
    }
}
extension Api {
    enum User: TypeConstructorDescription {
        class Cons_user: TypeConstructorDescription {
            var flags: Int32
            var flags2: Int32
            var id: Int64
            var accessHash: Int64?
            var firstName: String?
            var lastName: String?
            var username: String?
            var phone: String?
            var photo: Api.UserProfilePhoto?
            var status: Api.UserStatus?
            var botInfoVersion: Int32?
            var restrictionReason: [Api.RestrictionReason]?
            var botInlinePlaceholder: String?
            var langCode: String?
            var emojiStatus: Api.EmojiStatus?
            var usernames: [Api.Username]?
            var storiesMaxId: Api.RecentStory?
            var color: Api.PeerColor?
            var profileColor: Api.PeerColor?
            var botActiveUsers: Int32?
            var botVerificationIcon: Int64?
            var sendPaidMessagesStars: Int64?
            var linkedCommunityId: Int64?
            init(flags: Int32, flags2: Int32, id: Int64, accessHash: Int64?, firstName: String?, lastName: String?, username: String?, phone: String?, photo: Api.UserProfilePhoto?, status: Api.UserStatus?, botInfoVersion: Int32?, restrictionReason: [Api.RestrictionReason]?, botInlinePlaceholder: String?, langCode: String?, emojiStatus: Api.EmojiStatus?, usernames: [Api.Username]?, storiesMaxId: Api.RecentStory?, color: Api.PeerColor?, profileColor: Api.PeerColor?, botActiveUsers: Int32?, botVerificationIcon: Int64?, sendPaidMessagesStars: Int64?, linkedCommunityId: Int64?) {
                self.flags = flags
                self.flags2 = flags2
                self.id = id
                self.accessHash = accessHash
                self.firstName = firstName
                self.lastName = lastName
                self.username = username
                self.phone = phone
                self.photo = photo
                self.status = status
                self.botInfoVersion = botInfoVersion
                self.restrictionReason = restrictionReason
                self.botInlinePlaceholder = botInlinePlaceholder
                self.langCode = langCode
                self.emojiStatus = emojiStatus
                self.usernames = usernames
                self.storiesMaxId = storiesMaxId
                self.color = color
                self.profileColor = profileColor
                self.botActiveUsers = botActiveUsers
                self.botVerificationIcon = botVerificationIcon
                self.sendPaidMessagesStars = sendPaidMessagesStars
                self.linkedCommunityId = linkedCommunityId
            }
        }
        class Cons_userEmpty: TypeConstructorDescription {
            var id: Int64
            init(id: Int64) {
                self.id = id
            }
        }
        case user(Cons_user)
        case userEmpty(Cons_userEmpty)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .user(let _data):
                if boxed {
                    buffer.appendInt32(-1313289085)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.flags2, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.accessHash!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.firstName!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.lastName!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.username!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeString(_data.phone!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    _data.photo!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    _data.status!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 14) != 0 {
                    serializeInt32(_data.botInfoVersion!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 18) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.restrictionReason!.count))
                    for item in _data.restrictionReason! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 19) != 0 {
                    serializeString(_data.botInlinePlaceholder!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 22) != 0 {
                    serializeString(_data.langCode!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 30) != 0 {
                    _data.emojiStatus!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.usernames!.count))
                    for item in _data.usernames! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags2) & Int(1 << 5) != 0 {
                    _data.storiesMaxId!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 8) != 0 {
                    _data.color!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 9) != 0 {
                    _data.profileColor!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 12) != 0 {
                    serializeInt32(_data.botActiveUsers!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 14) != 0 {
                    serializeInt64(_data.botVerificationIcon!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 15) != 0 {
                    serializeInt64(_data.sendPaidMessagesStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 21) != 0 {
                    serializeInt64(_data.linkedCommunityId!, buffer: buffer, boxed: false)
                }
                break
            case .userEmpty(let _data):
                if boxed {
                    buffer.appendInt32(-742634630)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_user(_ reader: BufferReader) -> User? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = reader.readInt64()
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _5 = parseString(reader)
            }
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _6 = parseString(reader)
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _7 = parseString(reader)
            }
            var _8: String?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _8 = parseString(reader)
            }
            var _9: Api.UserProfilePhoto?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.UserProfilePhoto
                }
            }
            var _10: Api.UserStatus?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                if let signature = reader.readInt32() {
                    _10 = Api.parse(reader, signature: signature) as? Api.UserStatus
                }
            }
            var _11: Int32?
            if Int(_1 ?? 0) & Int(1 << 14) != 0 {
                _11 = reader.readInt32()
            }
            var _12: [Api.RestrictionReason]?
            if Int(_1 ?? 0) & Int(1 << 18) != 0 {
                if let _ = reader.readInt32() {
                    _12 = Api.parseVector(reader, elementSignature: 0, elementType: Api.RestrictionReason.self)
                }
            }
            var _13: String?
            if Int(_1 ?? 0) & Int(1 << 19) != 0 {
                _13 = parseString(reader)
            }
            var _14: String?
            if Int(_1 ?? 0) & Int(1 << 22) != 0 {
                _14 = parseString(reader)
            }
            var _15: Api.EmojiStatus?
            if Int(_1 ?? 0) & Int(1 << 30) != 0 {
                if let signature = reader.readInt32() {
                    _15 = Api.parse(reader, signature: signature) as? Api.EmojiStatus
                }
            }
            var _16: [Api.Username]?
            if Int(_2 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _16 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Username.self)
                }
            }
            var _17: Api.RecentStory?
            if Int(_2 ?? 0) & Int(1 << 5) != 0 {
                if let signature = reader.readInt32() {
                    _17 = Api.parse(reader, signature: signature) as? Api.RecentStory
                }
            }
            var _18: Api.PeerColor?
            if Int(_2 ?? 0) & Int(1 << 8) != 0 {
                if let signature = reader.readInt32() {
                    _18 = Api.parse(reader, signature: signature) as? Api.PeerColor
                }
            }
            var _19: Api.PeerColor?
            if Int(_2 ?? 0) & Int(1 << 9) != 0 {
                if let signature = reader.readInt32() {
                    _19 = Api.parse(reader, signature: signature) as? Api.PeerColor
                }
            }
            var _20: Int32?
            if Int(_2 ?? 0) & Int(1 << 12) != 0 {
                _20 = reader.readInt32()
            }
            var _21: Int64?
            if Int(_2 ?? 0) & Int(1 << 14) != 0 {
                _21 = reader.readInt64()
            }
            var _22: Int64?
            if Int(_2 ?? 0) & Int(1 << 15) != 0 {
                _22 = reader.readInt64()
            }
            var _23: Int64?
            if Int(_2 ?? 0) & Int(1 << 21) != 0 {
                _23 = reader.readInt64()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 14) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 18) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 19) == 0) || _13 != nil
            let _c14 = (Int(_1 ?? 0) & Int(1 << 22) == 0) || _14 != nil
            let _c15 = (Int(_1 ?? 0) & Int(1 << 30) == 0) || _15 != nil
            let _c16 = (Int(_2 ?? 0) & Int(1 << 0) == 0) || _16 != nil
            let _c17 = (Int(_2 ?? 0) & Int(1 << 5) == 0) || _17 != nil
            let _c18 = (Int(_2 ?? 0) & Int(1 << 8) == 0) || _18 != nil
            let _c19 = (Int(_2 ?? 0) & Int(1 << 9) == 0) || _19 != nil
            let _c20 = (Int(_2 ?? 0) & Int(1 << 12) == 0) || _20 != nil
            let _c21 = (Int(_2 ?? 0) & Int(1 << 14) == 0) || _21 != nil
            let _c22 = (Int(_2 ?? 0) & Int(1 << 15) == 0) || _22 != nil
            let _c23 = (Int(_2 ?? 0) & Int(1 << 21) == 0) || _23 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 && _c15 && _c16 && _c17 && _c18 && _c19 && _c20 && _c21 && _c22 && _c23 {
                return Api.User.user(Cons_user(flags: _1!, flags2: _2!, id: _3!, accessHash: _4, firstName: _5, lastName: _6, username: _7, phone: _8, photo: _9, status: _10, botInfoVersion: _11, restrictionReason: _12, botInlinePlaceholder: _13, langCode: _14, emojiStatus: _15, usernames: _16, storiesMaxId: _17, color: _18, profileColor: _19, botActiveUsers: _20, botVerificationIcon: _21, sendPaidMessagesStars: _22, linkedCommunityId: _23))
            }
            else {
                return nil
            }
        }
        static func parse_userEmpty(_ reader: BufferReader) -> User? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.User.userEmpty(Cons_userEmpty(id: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum UserFull: TypeConstructorDescription {
        class Cons_userFull: TypeConstructorDescription {
            var flags: Int32
            var flags2: Int32
            var id: Int64
            var about: String?
            var settings: Api.PeerSettings
            var personalPhoto: Api.Photo?
            var profilePhoto: Api.Photo?
            var fallbackPhoto: Api.Photo?
            var notifySettings: Api.PeerNotifySettings
            var botInfo: Api.BotInfo?
            var pinnedMsgId: Int32?
            var commonChatsCount: Int32
            var folderId: Int32?
            var ttlPeriod: Int32?
            var theme: Api.ChatTheme?
            var privateForwardName: String?
            var botGroupAdminRights: Api.ChatAdminRights?
            var botBroadcastAdminRights: Api.ChatAdminRights?
            var wallpaper: Api.WallPaper?
            var stories: Api.PeerStories?
            var businessWorkHours: Api.BusinessWorkHours?
            var businessLocation: Api.BusinessLocation?
            var businessGreetingMessage: Api.BusinessGreetingMessage?
            var businessAwayMessage: Api.BusinessAwayMessage?
            var businessIntro: Api.BusinessIntro?
            var birthday: Api.Birthday?
            var personalChannelId: Int64?
            var personalChannelMessage: Int32?
            var stargiftsCount: Int32?
            var starrefProgram: Api.StarRefProgram?
            var botVerification: Api.BotVerification?
            var sendPaidMessagesStars: Int64?
            var disallowedGifts: Api.DisallowedGiftsSettings?
            var starsRating: Api.StarsRating?
            var starsMyPendingRating: Api.StarsRating?
            var starsMyPendingRatingDate: Int32?
            var mainTab: Api.ProfileTab?
            var savedMusic: Api.Document?
            var note: Api.TextWithEntities?
            var botManagerId: Int64?
            var walletCard: Api.wallet.Card?
            var shareTheme: Api.ShareTheme?
            init(flags: Int32, flags2: Int32, id: Int64, about: String?, settings: Api.PeerSettings, personalPhoto: Api.Photo?, profilePhoto: Api.Photo?, fallbackPhoto: Api.Photo?, notifySettings: Api.PeerNotifySettings, botInfo: Api.BotInfo?, pinnedMsgId: Int32?, commonChatsCount: Int32, folderId: Int32?, ttlPeriod: Int32?, theme: Api.ChatTheme?, privateForwardName: String?, botGroupAdminRights: Api.ChatAdminRights?, botBroadcastAdminRights: Api.ChatAdminRights?, wallpaper: Api.WallPaper?, stories: Api.PeerStories?, businessWorkHours: Api.BusinessWorkHours?, businessLocation: Api.BusinessLocation?, businessGreetingMessage: Api.BusinessGreetingMessage?, businessAwayMessage: Api.BusinessAwayMessage?, businessIntro: Api.BusinessIntro?, birthday: Api.Birthday?, personalChannelId: Int64?, personalChannelMessage: Int32?, stargiftsCount: Int32?, starrefProgram: Api.StarRefProgram?, botVerification: Api.BotVerification?, sendPaidMessagesStars: Int64?, disallowedGifts: Api.DisallowedGiftsSettings?, starsRating: Api.StarsRating?, starsMyPendingRating: Api.StarsRating?, starsMyPendingRatingDate: Int32?, mainTab: Api.ProfileTab?, savedMusic: Api.Document?, note: Api.TextWithEntities?, botManagerId: Int64?, walletCard: Api.wallet.Card?, shareTheme: Api.ShareTheme?) {
                self.flags = flags
                self.flags2 = flags2
                self.id = id
                self.about = about
                self.settings = settings
                self.personalPhoto = personalPhoto
                self.profilePhoto = profilePhoto
                self.fallbackPhoto = fallbackPhoto
                self.notifySettings = notifySettings
                self.botInfo = botInfo
                self.pinnedMsgId = pinnedMsgId
                self.commonChatsCount = commonChatsCount
                self.folderId = folderId
                self.ttlPeriod = ttlPeriod
                self.theme = theme
                self.privateForwardName = privateForwardName
                self.botGroupAdminRights = botGroupAdminRights
                self.botBroadcastAdminRights = botBroadcastAdminRights
                self.wallpaper = wallpaper
                self.stories = stories
                self.businessWorkHours = businessWorkHours
                self.businessLocation = businessLocation
                self.businessGreetingMessage = businessGreetingMessage
                self.businessAwayMessage = businessAwayMessage
                self.businessIntro = businessIntro
                self.birthday = birthday
                self.personalChannelId = personalChannelId
                self.personalChannelMessage = personalChannelMessage
                self.stargiftsCount = stargiftsCount
                self.starrefProgram = starrefProgram
                self.botVerification = botVerification
                self.sendPaidMessagesStars = sendPaidMessagesStars
                self.disallowedGifts = disallowedGifts
                self.starsRating = starsRating
                self.starsMyPendingRating = starsMyPendingRating
                self.starsMyPendingRatingDate = starsMyPendingRatingDate
                self.mainTab = mainTab
                self.savedMusic = savedMusic
                self.note = note
                self.botManagerId = botManagerId
                self.walletCard = walletCard
                self.shareTheme = shareTheme
            }
        }
        case userFull(Cons_userFull)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .userFull(let _data):
                if boxed {
                    buffer.appendInt32(-1190384899)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.flags2, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.about!, buffer: buffer, boxed: false)
                }
                _data.settings.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 21) != 0 {
                    _data.personalPhoto!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.profilePhoto!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 22) != 0 {
                    _data.fallbackPhoto!.serialize(buffer, true)
                }
                _data.notifySettings.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.botInfo!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    serializeInt32(_data.pinnedMsgId!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.commonChatsCount, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    serializeInt32(_data.folderId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 14) != 0 {
                    serializeInt32(_data.ttlPeriod!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 15) != 0 {
                    _data.theme!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 16) != 0 {
                    serializeString(_data.privateForwardName!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 17) != 0 {
                    _data.botGroupAdminRights!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 18) != 0 {
                    _data.botBroadcastAdminRights!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 24) != 0 {
                    _data.wallpaper!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 25) != 0 {
                    _data.stories!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 0) != 0 {
                    _data.businessWorkHours!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 1) != 0 {
                    _data.businessLocation!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 2) != 0 {
                    _data.businessGreetingMessage!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 3) != 0 {
                    _data.businessAwayMessage!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 4) != 0 {
                    _data.businessIntro!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 5) != 0 {
                    _data.birthday!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 6) != 0 {
                    serializeInt64(_data.personalChannelId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 6) != 0 {
                    serializeInt32(_data.personalChannelMessage!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 8) != 0 {
                    serializeInt32(_data.stargiftsCount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 11) != 0 {
                    _data.starrefProgram!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 12) != 0 {
                    _data.botVerification!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 14) != 0 {
                    serializeInt64(_data.sendPaidMessagesStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 15) != 0 {
                    _data.disallowedGifts!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 17) != 0 {
                    _data.starsRating!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 18) != 0 {
                    _data.starsMyPendingRating!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 18) != 0 {
                    serializeInt32(_data.starsMyPendingRatingDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 20) != 0 {
                    _data.mainTab!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 21) != 0 {
                    _data.savedMusic!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 22) != 0 {
                    _data.note!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 25) != 0 {
                    serializeInt64(_data.botManagerId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 19) != 0 {
                    _data.walletCard!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 27) != 0 {
                    _data.shareTheme!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_userFull(_ reader: BufferReader) -> UserFull? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _4 = parseString(reader)
            }
            var _5: Api.PeerSettings?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.PeerSettings
            }
            var _6: Api.Photo?
            if Int(_1 ?? 0) & Int(1 << 21) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.Photo
                }
            }
            var _7: Api.Photo?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.Photo
                }
            }
            var _8: Api.Photo?
            if Int(_1 ?? 0) & Int(1 << 22) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.Photo
                }
            }
            var _9: Api.PeerNotifySettings?
            if let signature = reader.readInt32() {
                _9 = Api.parse(reader, signature: signature) as? Api.PeerNotifySettings
            }
            var _10: Api.BotInfo?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _10 = Api.parse(reader, signature: signature) as? Api.BotInfo
                }
            }
            var _11: Int32?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                _11 = reader.readInt32()
            }
            var _12: Int32?
            _12 = reader.readInt32()
            var _13: Int32?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                _13 = reader.readInt32()
            }
            var _14: Int32?
            if Int(_1 ?? 0) & Int(1 << 14) != 0 {
                _14 = reader.readInt32()
            }
            var _15: Api.ChatTheme?
            if Int(_1 ?? 0) & Int(1 << 15) != 0 {
                if let signature = reader.readInt32() {
                    _15 = Api.parse(reader, signature: signature) as? Api.ChatTheme
                }
            }
            var _16: String?
            if Int(_1 ?? 0) & Int(1 << 16) != 0 {
                _16 = parseString(reader)
            }
            var _17: Api.ChatAdminRights?
            if Int(_1 ?? 0) & Int(1 << 17) != 0 {
                if let signature = reader.readInt32() {
                    _17 = Api.parse(reader, signature: signature) as? Api.ChatAdminRights
                }
            }
            var _18: Api.ChatAdminRights?
            if Int(_1 ?? 0) & Int(1 << 18) != 0 {
                if let signature = reader.readInt32() {
                    _18 = Api.parse(reader, signature: signature) as? Api.ChatAdminRights
                }
            }
            var _19: Api.WallPaper?
            if Int(_1 ?? 0) & Int(1 << 24) != 0 {
                if let signature = reader.readInt32() {
                    _19 = Api.parse(reader, signature: signature) as? Api.WallPaper
                }
            }
            var _20: Api.PeerStories?
            if Int(_1 ?? 0) & Int(1 << 25) != 0 {
                if let signature = reader.readInt32() {
                    _20 = Api.parse(reader, signature: signature) as? Api.PeerStories
                }
            }
            var _21: Api.BusinessWorkHours?
            if Int(_2 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _21 = Api.parse(reader, signature: signature) as? Api.BusinessWorkHours
                }
            }
            var _22: Api.BusinessLocation?
            if Int(_2 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _22 = Api.parse(reader, signature: signature) as? Api.BusinessLocation
                }
            }
            var _23: Api.BusinessGreetingMessage?
            if Int(_2 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _23 = Api.parse(reader, signature: signature) as? Api.BusinessGreetingMessage
                }
            }
            var _24: Api.BusinessAwayMessage?
            if Int(_2 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _24 = Api.parse(reader, signature: signature) as? Api.BusinessAwayMessage
                }
            }
            var _25: Api.BusinessIntro?
            if Int(_2 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _25 = Api.parse(reader, signature: signature) as? Api.BusinessIntro
                }
            }
            var _26: Api.Birthday?
            if Int(_2 ?? 0) & Int(1 << 5) != 0 {
                if let signature = reader.readInt32() {
                    _26 = Api.parse(reader, signature: signature) as? Api.Birthday
                }
            }
            var _27: Int64?
            if Int(_2 ?? 0) & Int(1 << 6) != 0 {
                _27 = reader.readInt64()
            }
            var _28: Int32?
            if Int(_2 ?? 0) & Int(1 << 6) != 0 {
                _28 = reader.readInt32()
            }
            var _29: Int32?
            if Int(_2 ?? 0) & Int(1 << 8) != 0 {
                _29 = reader.readInt32()
            }
            var _30: Api.StarRefProgram?
            if Int(_2 ?? 0) & Int(1 << 11) != 0 {
                if let signature = reader.readInt32() {
                    _30 = Api.parse(reader, signature: signature) as? Api.StarRefProgram
                }
            }
            var _31: Api.BotVerification?
            if Int(_2 ?? 0) & Int(1 << 12) != 0 {
                if let signature = reader.readInt32() {
                    _31 = Api.parse(reader, signature: signature) as? Api.BotVerification
                }
            }
            var _32: Int64?
            if Int(_2 ?? 0) & Int(1 << 14) != 0 {
                _32 = reader.readInt64()
            }
            var _33: Api.DisallowedGiftsSettings?
            if Int(_2 ?? 0) & Int(1 << 15) != 0 {
                if let signature = reader.readInt32() {
                    _33 = Api.parse(reader, signature: signature) as? Api.DisallowedGiftsSettings
                }
            }
            var _34: Api.StarsRating?
            if Int(_2 ?? 0) & Int(1 << 17) != 0 {
                if let signature = reader.readInt32() {
                    _34 = Api.parse(reader, signature: signature) as? Api.StarsRating
                }
            }
            var _35: Api.StarsRating?
            if Int(_2 ?? 0) & Int(1 << 18) != 0 {
                if let signature = reader.readInt32() {
                    _35 = Api.parse(reader, signature: signature) as? Api.StarsRating
                }
            }
            var _36: Int32?
            if Int(_2 ?? 0) & Int(1 << 18) != 0 {
                _36 = reader.readInt32()
            }
            var _37: Api.ProfileTab?
            if Int(_2 ?? 0) & Int(1 << 20) != 0 {
                if let signature = reader.readInt32() {
                    _37 = Api.parse(reader, signature: signature) as? Api.ProfileTab
                }
            }
            var _38: Api.Document?
            if Int(_2 ?? 0) & Int(1 << 21) != 0 {
                if let signature = reader.readInt32() {
                    _38 = Api.parse(reader, signature: signature) as? Api.Document
                }
            }
            var _39: Api.TextWithEntities?
            if Int(_2 ?? 0) & Int(1 << 22) != 0 {
                if let signature = reader.readInt32() {
                    _39 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
                }
            }
            var _40: Int64?
            if Int(_2 ?? 0) & Int(1 << 25) != 0 {
                _40 = reader.readInt64()
            }
            var _41: Api.wallet.Card?
            if Int(_2 ?? 0) & Int(1 << 19) != 0 {
                if let signature = reader.readInt32() {
                    _41 = Api.parse(reader, signature: signature) as? Api.wallet.Card
                }
            }
            var _42: Api.ShareTheme?
            if Int(_2 ?? 0) & Int(1 << 27) != 0 {
                if let signature = reader.readInt32() {
                    _42 = Api.parse(reader, signature: signature) as? Api.ShareTheme
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 21) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 22) == 0) || _8 != nil
            let _c9 = _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _11 != nil
            let _c12 = _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _13 != nil
            let _c14 = (Int(_1 ?? 0) & Int(1 << 14) == 0) || _14 != nil
            let _c15 = (Int(_1 ?? 0) & Int(1 << 15) == 0) || _15 != nil
            let _c16 = (Int(_1 ?? 0) & Int(1 << 16) == 0) || _16 != nil
            let _c17 = (Int(_1 ?? 0) & Int(1 << 17) == 0) || _17 != nil
            let _c18 = (Int(_1 ?? 0) & Int(1 << 18) == 0) || _18 != nil
            let _c19 = (Int(_1 ?? 0) & Int(1 << 24) == 0) || _19 != nil
            let _c20 = (Int(_1 ?? 0) & Int(1 << 25) == 0) || _20 != nil
            let _c21 = (Int(_2 ?? 0) & Int(1 << 0) == 0) || _21 != nil
            let _c22 = (Int(_2 ?? 0) & Int(1 << 1) == 0) || _22 != nil
            let _c23 = (Int(_2 ?? 0) & Int(1 << 2) == 0) || _23 != nil
            let _c24 = (Int(_2 ?? 0) & Int(1 << 3) == 0) || _24 != nil
            let _c25 = (Int(_2 ?? 0) & Int(1 << 4) == 0) || _25 != nil
            let _c26 = (Int(_2 ?? 0) & Int(1 << 5) == 0) || _26 != nil
            let _c27 = (Int(_2 ?? 0) & Int(1 << 6) == 0) || _27 != nil
            let _c28 = (Int(_2 ?? 0) & Int(1 << 6) == 0) || _28 != nil
            let _c29 = (Int(_2 ?? 0) & Int(1 << 8) == 0) || _29 != nil
            let _c30 = (Int(_2 ?? 0) & Int(1 << 11) == 0) || _30 != nil
            let _c31 = (Int(_2 ?? 0) & Int(1 << 12) == 0) || _31 != nil
            let _c32 = (Int(_2 ?? 0) & Int(1 << 14) == 0) || _32 != nil
            let _c33 = (Int(_2 ?? 0) & Int(1 << 15) == 0) || _33 != nil
            let _c34 = (Int(_2 ?? 0) & Int(1 << 17) == 0) || _34 != nil
            let _c35 = (Int(_2 ?? 0) & Int(1 << 18) == 0) || _35 != nil
            let _c36 = (Int(_2 ?? 0) & Int(1 << 18) == 0) || _36 != nil
            let _c37 = (Int(_2 ?? 0) & Int(1 << 20) == 0) || _37 != nil
            let _c38 = (Int(_2 ?? 0) & Int(1 << 21) == 0) || _38 != nil
            let _c39 = (Int(_2 ?? 0) & Int(1 << 22) == 0) || _39 != nil
            let _c40 = (Int(_2 ?? 0) & Int(1 << 25) == 0) || _40 != nil
            let _c41 = (Int(_2 ?? 0) & Int(1 << 19) == 0) || _41 != nil
            let _c42 = (Int(_2 ?? 0) & Int(1 << 27) == 0) || _42 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 && _c15 && _c16 && _c17 && _c18 && _c19 && _c20 && _c21 && _c22 && _c23 && _c24 && _c25 && _c26 && _c27 && _c28 && _c29 && _c30 && _c31 && _c32 && _c33 && _c34 && _c35 && _c36 && _c37 && _c38 && _c39 && _c40 && _c41 && _c42 {
                return Api.UserFull.userFull(Cons_userFull(flags: _1!, flags2: _2!, id: _3!, about: _4, settings: _5!, personalPhoto: _6, profilePhoto: _7, fallbackPhoto: _8, notifySettings: _9!, botInfo: _10, pinnedMsgId: _11, commonChatsCount: _12!, folderId: _13, ttlPeriod: _14, theme: _15, privateForwardName: _16, botGroupAdminRights: _17, botBroadcastAdminRights: _18, wallpaper: _19, stories: _20, businessWorkHours: _21, businessLocation: _22, businessGreetingMessage: _23, businessAwayMessage: _24, businessIntro: _25, birthday: _26, personalChannelId: _27, personalChannelMessage: _28, stargiftsCount: _29, starrefProgram: _30, botVerification: _31, sendPaidMessagesStars: _32, disallowedGifts: _33, starsRating: _34, starsMyPendingRating: _35, starsMyPendingRatingDate: _36, mainTab: _37, savedMusic: _38, note: _39, botManagerId: _40, walletCard: _41, shareTheme: _42))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum UserProfilePhoto: TypeConstructorDescription {
        class Cons_userProfilePhoto: TypeConstructorDescription {
            var flags: Int32
            var photoId: Int64
            var strippedThumb: Buffer?
            var dcId: Int32
            init(flags: Int32, photoId: Int64, strippedThumb: Buffer?, dcId: Int32) {
                self.flags = flags
                self.photoId = photoId
                self.strippedThumb = strippedThumb
                self.dcId = dcId
            }
        }
        case userProfilePhoto(Cons_userProfilePhoto)
        case userProfilePhotoEmpty

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .userProfilePhoto(let _data):
                if boxed {
                    buffer.appendInt32(-2100168954)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.photoId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeBytes(_data.strippedThumb!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.dcId, buffer: buffer, boxed: false)
                break
            case .userProfilePhotoEmpty:
                if boxed {
                    buffer.appendInt32(1326562017)
                }
                break
            }
        }

        static func parse_userProfilePhoto(_ reader: BufferReader) -> UserProfilePhoto? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Buffer?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _3 = parseBytes(reader)
            }
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.UserProfilePhoto.userProfilePhoto(Cons_userProfilePhoto(flags: _1!, photoId: _2!, strippedThumb: _3, dcId: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_userProfilePhotoEmpty(_ reader: BufferReader) -> UserProfilePhoto? {
            return Api.UserProfilePhoto.userProfilePhotoEmpty
        }
    }
}
extension Api {
    enum UserStatus: TypeConstructorDescription {
        class Cons_userStatusLastMonth: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        class Cons_userStatusLastWeek: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        class Cons_userStatusOffline: TypeConstructorDescription {
            var wasOnline: Int32
            init(wasOnline: Int32) {
                self.wasOnline = wasOnline
            }
        }
        class Cons_userStatusOnline: TypeConstructorDescription {
            var expires: Int32
            init(expires: Int32) {
                self.expires = expires
            }
        }
        class Cons_userStatusRecently: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        case userStatusEmpty
        case userStatusLastMonth(Cons_userStatusLastMonth)
        case userStatusLastWeek(Cons_userStatusLastWeek)
        case userStatusOffline(Cons_userStatusOffline)
        case userStatusOnline(Cons_userStatusOnline)
        case userStatusRecently(Cons_userStatusRecently)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .userStatusEmpty:
                if boxed {
                    buffer.appendInt32(164646985)
                }
                break
            case .userStatusLastMonth(let _data):
                if boxed {
                    buffer.appendInt32(1703516023)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            case .userStatusLastWeek(let _data):
                if boxed {
                    buffer.appendInt32(1410997530)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            case .userStatusOffline(let _data):
                if boxed {
                    buffer.appendInt32(9203775)
                }
                serializeInt32(_data.wasOnline, buffer: buffer, boxed: false)
                break
            case .userStatusOnline(let _data):
                if boxed {
                    buffer.appendInt32(-306628279)
                }
                serializeInt32(_data.expires, buffer: buffer, boxed: false)
                break
            case .userStatusRecently(let _data):
                if boxed {
                    buffer.appendInt32(2065268168)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_userStatusEmpty(_ reader: BufferReader) -> UserStatus? {
            return Api.UserStatus.userStatusEmpty
        }
        static func parse_userStatusLastMonth(_ reader: BufferReader) -> UserStatus? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.UserStatus.userStatusLastMonth(Cons_userStatusLastMonth(flags: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_userStatusLastWeek(_ reader: BufferReader) -> UserStatus? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.UserStatus.userStatusLastWeek(Cons_userStatusLastWeek(flags: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_userStatusOffline(_ reader: BufferReader) -> UserStatus? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.UserStatus.userStatusOffline(Cons_userStatusOffline(wasOnline: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_userStatusOnline(_ reader: BufferReader) -> UserStatus? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.UserStatus.userStatusOnline(Cons_userStatusOnline(expires: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_userStatusRecently(_ reader: BufferReader) -> UserStatus? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.UserStatus.userStatusRecently(Cons_userStatusRecently(flags: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum UserWallet: TypeConstructorDescription {
        class Cons_userWallet: TypeConstructorDescription {
            var flags: Int32
            var address: String
            var balance: Int64
            var publicKey: Buffer?
            var stateInit: Buffer?
            init(flags: Int32, address: String, balance: Int64, publicKey: Buffer?, stateInit: Buffer?) {
                self.flags = flags
                self.address = address
                self.balance = balance
                self.publicKey = publicKey
                self.stateInit = stateInit
            }
        }
        case userWallet(Cons_userWallet)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .userWallet(let _data):
                if boxed {
                    buffer.appendInt32(1162684215)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.address, buffer: buffer, boxed: false)
                serializeInt64(_data.balance, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeBytes(_data.publicKey!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeBytes(_data.stateInit!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_userWallet(_ reader: BufferReader) -> UserWallet? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Buffer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseBytes(reader)
            }
            var _5: Buffer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = parseBytes(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.UserWallet.userWallet(Cons_userWallet(flags: _1!, address: _2!, balance: _3!, publicKey: _4, stateInit: _5))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum Username: TypeConstructorDescription {
        class Cons_username: TypeConstructorDescription {
            var flags: Int32
            var username: String
            init(flags: Int32, username: String) {
                self.flags = flags
                self.username = username
            }
        }
        case username(Cons_username)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .username(let _data):
                if boxed {
                    buffer.appendInt32(-1274595769)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.username, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_username(_ reader: BufferReader) -> Username? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Username.username(Cons_username(flags: _1!, username: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum VideoSize: TypeConstructorDescription {
        class Cons_videoSize: TypeConstructorDescription {
            var flags: Int32
            var type: String
            var w: Int32
            var h: Int32
            var size: Int32
            var videoStartTs: Double?
            init(flags: Int32, type: String, w: Int32, h: Int32, size: Int32, videoStartTs: Double?) {
                self.flags = flags
                self.type = type
                self.w = w
                self.h = h
                self.size = size
                self.videoStartTs = videoStartTs
            }
        }
        class Cons_videoSizeEmojiMarkup: TypeConstructorDescription {
            var emojiId: Int64
            var backgroundColors: [Int32]
            init(emojiId: Int64, backgroundColors: [Int32]) {
                self.emojiId = emojiId
                self.backgroundColors = backgroundColors
            }
        }
        class Cons_videoSizeStickerMarkup: TypeConstructorDescription {
            var stickerset: Api.InputStickerSet
            var stickerId: Int64
            var backgroundColors: [Int32]
            init(stickerset: Api.InputStickerSet, stickerId: Int64, backgroundColors: [Int32]) {
                self.stickerset = stickerset
                self.stickerId = stickerId
                self.backgroundColors = backgroundColors
            }
        }
        case videoSize(Cons_videoSize)
        case videoSizeEmojiMarkup(Cons_videoSizeEmojiMarkup)
        case videoSizeStickerMarkup(Cons_videoSizeStickerMarkup)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .videoSize(let _data):
                if boxed {
                    buffer.appendInt32(-567037804)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.type, buffer: buffer, boxed: false)
                serializeInt32(_data.w, buffer: buffer, boxed: false)
                serializeInt32(_data.h, buffer: buffer, boxed: false)
                serializeInt32(_data.size, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeDouble(_data.videoStartTs!, buffer: buffer, boxed: false)
                }
                break
            case .videoSizeEmojiMarkup(let _data):
                if boxed {
                    buffer.appendInt32(-128171716)
                }
                serializeInt64(_data.emojiId, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.backgroundColors.count))
                for item in _data.backgroundColors {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                break
            case .videoSizeStickerMarkup(let _data):
                if boxed {
                    buffer.appendInt32(228623102)
                }
                _data.stickerset.serialize(buffer, true)
                serializeInt64(_data.stickerId, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.backgroundColors.count))
                for item in _data.backgroundColors {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_videoSize(_ reader: BufferReader) -> VideoSize? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Double?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _6 = reader.readDouble()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.VideoSize.videoSize(Cons_videoSize(flags: _1!, type: _2!, w: _3!, h: _4!, size: _5!, videoStartTs: _6))
            }
            else {
                return nil
            }
        }
        static func parse_videoSizeEmojiMarkup(_ reader: BufferReader) -> VideoSize? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: [Int32]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.VideoSize.videoSizeEmojiMarkup(Cons_videoSizeEmojiMarkup(emojiId: _1!, backgroundColors: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_videoSizeStickerMarkup(_ reader: BufferReader) -> VideoSize? {
            var _1: Api.InputStickerSet?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputStickerSet
            }
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: [Int32]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.VideoSize.videoSizeStickerMarkup(Cons_videoSizeStickerMarkup(stickerset: _1!, stickerId: _2!, backgroundColors: _3!))
            }
            else {
                return nil
            }
        }
    }
}
