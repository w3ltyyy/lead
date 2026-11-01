extension Api {
    enum ChannelParticipant: TypeConstructorDescription {
        class Cons_channelParticipant: TypeConstructorDescription {
            var flags: Int32
            var userId: Int64
            var date: Int32
            var subscriptionUntilDate: Int32?
            var rank: String?
            init(flags: Int32, userId: Int64, date: Int32, subscriptionUntilDate: Int32?, rank: String?) {
                self.flags = flags
                self.userId = userId
                self.date = date
                self.subscriptionUntilDate = subscriptionUntilDate
                self.rank = rank
            }
        }
        class Cons_channelParticipantAdmin: TypeConstructorDescription {
            var flags: Int32
            var userId: Int64
            var inviterId: Int64?
            var promotedBy: Int64
            var date: Int32
            var adminRights: Api.ChatAdminRights
            var rank: String?
            init(flags: Int32, userId: Int64, inviterId: Int64?, promotedBy: Int64, date: Int32, adminRights: Api.ChatAdminRights, rank: String?) {
                self.flags = flags
                self.userId = userId
                self.inviterId = inviterId
                self.promotedBy = promotedBy
                self.date = date
                self.adminRights = adminRights
                self.rank = rank
            }
        }
        class Cons_channelParticipantBanned: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var kickedBy: Int64
            var date: Int32
            var bannedRights: Api.ChatBannedRights
            var rank: String?
            init(flags: Int32, peer: Api.Peer, kickedBy: Int64, date: Int32, bannedRights: Api.ChatBannedRights, rank: String?) {
                self.flags = flags
                self.peer = peer
                self.kickedBy = kickedBy
                self.date = date
                self.bannedRights = bannedRights
                self.rank = rank
            }
        }
        class Cons_channelParticipantCreator: TypeConstructorDescription {
            var flags: Int32
            var userId: Int64
            var adminRights: Api.ChatAdminRights
            var rank: String?
            init(flags: Int32, userId: Int64, adminRights: Api.ChatAdminRights, rank: String?) {
                self.flags = flags
                self.userId = userId
                self.adminRights = adminRights
                self.rank = rank
            }
        }
        class Cons_channelParticipantLeft: TypeConstructorDescription {
            var peer: Api.Peer
            init(peer: Api.Peer) {
                self.peer = peer
            }
        }
        class Cons_channelParticipantSelf: TypeConstructorDescription {
            var flags: Int32
            var userId: Int64
            var inviterId: Int64
            var date: Int32
            var subscriptionUntilDate: Int32?
            var rank: String?
            init(flags: Int32, userId: Int64, inviterId: Int64, date: Int32, subscriptionUntilDate: Int32?, rank: String?) {
                self.flags = flags
                self.userId = userId
                self.inviterId = inviterId
                self.date = date
                self.subscriptionUntilDate = subscriptionUntilDate
                self.rank = rank
            }
        }
        case channelParticipant(Cons_channelParticipant)
        case channelParticipantAdmin(Cons_channelParticipantAdmin)
        case channelParticipantBanned(Cons_channelParticipantBanned)
        case channelParticipantCreator(Cons_channelParticipantCreator)
        case channelParticipantLeft(Cons_channelParticipantLeft)
        case channelParticipantSelf(Cons_channelParticipantSelf)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .channelParticipant(let _data):
                if boxed {
                    buffer.appendInt32(466961494)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.subscriptionUntilDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.rank!, buffer: buffer, boxed: false)
                }
                break
            case .channelParticipantAdmin(let _data):
                if boxed {
                    buffer.appendInt32(885242707)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt64(_data.inviterId!, buffer: buffer, boxed: false)
                }
                serializeInt64(_data.promotedBy, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                _data.adminRights.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.rank!, buffer: buffer, boxed: false)
                }
                break
            case .channelParticipantBanned(let _data):
                if boxed {
                    buffer.appendInt32(-705647215)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt64(_data.kickedBy, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                _data.bannedRights.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.rank!, buffer: buffer, boxed: false)
                }
                break
            case .channelParticipantCreator(let _data):
                if boxed {
                    buffer.appendInt32(803602899)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                _data.adminRights.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.rank!, buffer: buffer, boxed: false)
                }
                break
            case .channelParticipantLeft(let _data):
                if boxed {
                    buffer.appendInt32(453242886)
                }
                _data.peer.serialize(buffer, true)
                break
            case .channelParticipantSelf(let _data):
                if boxed {
                    buffer.appendInt32(-1454929382)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeInt64(_data.inviterId, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.subscriptionUntilDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.rank!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_channelParticipant(_ reader: BufferReader) -> ChannelParticipant? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = reader.readInt32()
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _5 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.ChannelParticipant.channelParticipant(Cons_channelParticipant(flags: _1!, userId: _2!, date: _3!, subscriptionUntilDate: _4, rank: _5))
            }
            else {
                return nil
            }
        }
        static func parse_channelParticipantAdmin(_ reader: BufferReader) -> ChannelParticipant? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _3 = reader.readInt64()
            }
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Api.ChatAdminRights?
            if let signature = reader.readInt32() {
                _6 = Api.parse(reader, signature: signature) as? Api.ChatAdminRights
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _7 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.ChannelParticipant.channelParticipantAdmin(Cons_channelParticipantAdmin(flags: _1!, userId: _2!, inviterId: _3, promotedBy: _4!, date: _5!, adminRights: _6!, rank: _7))
            }
            else {
                return nil
            }
        }
        static func parse_channelParticipantBanned(_ reader: BufferReader) -> ChannelParticipant? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Api.ChatBannedRights?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.ChatBannedRights
            }
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _6 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.ChannelParticipant.channelParticipantBanned(Cons_channelParticipantBanned(flags: _1!, peer: _2!, kickedBy: _3!, date: _4!, bannedRights: _5!, rank: _6))
            }
            else {
                return nil
            }
        }
        static func parse_channelParticipantCreator(_ reader: BufferReader) -> ChannelParticipant? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.ChatAdminRights?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.ChatAdminRights
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.ChannelParticipant.channelParticipantCreator(Cons_channelParticipantCreator(flags: _1!, userId: _2!, adminRights: _3!, rank: _4))
            }
            else {
                return nil
            }
        }
        static func parse_channelParticipantLeft(_ reader: BufferReader) -> ChannelParticipant? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelParticipant.channelParticipantLeft(Cons_channelParticipantLeft(peer: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelParticipantSelf(_ reader: BufferReader) -> ChannelParticipant? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _5 = reader.readInt32()
            }
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _6 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.ChannelParticipant.channelParticipantSelf(Cons_channelParticipantSelf(flags: _1!, userId: _2!, inviterId: _3!, date: _4!, subscriptionUntilDate: _5, rank: _6))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum Chat: TypeConstructorDescription {
        class Cons_channel: TypeConstructorDescription {
            var flags: Int32
            var flags2: Int32
            var id: Int64
            var accessHash: Int64?
            var title: String
            var username: String?
            var photo: Api.ChatPhoto
            var date: Int32
            var restrictionReason: [Api.RestrictionReason]?
            var adminRights: Api.ChatAdminRights?
            var bannedRights: Api.ChatBannedRights?
            var defaultBannedRights: Api.ChatBannedRights?
            var participantsCount: Int32?
            var usernames: [Api.Username]?
            var storiesMaxId: Api.RecentStory?
            var color: Api.PeerColor?
            var profileColor: Api.PeerColor?
            var emojiStatus: Api.EmojiStatus?
            var level: Int32?
            var subscriptionUntilDate: Int32?
            var botVerificationIcon: Int64?
            var sendPaidMessagesStars: Int64?
            var linkedMonoforumId: Int64?
            var linkedCommunityId: Int64?
            var pinnedMsgId: Int32?
            init(flags: Int32, flags2: Int32, id: Int64, accessHash: Int64?, title: String, username: String?, photo: Api.ChatPhoto, date: Int32, restrictionReason: [Api.RestrictionReason]?, adminRights: Api.ChatAdminRights?, bannedRights: Api.ChatBannedRights?, defaultBannedRights: Api.ChatBannedRights?, participantsCount: Int32?, usernames: [Api.Username]?, storiesMaxId: Api.RecentStory?, color: Api.PeerColor?, profileColor: Api.PeerColor?, emojiStatus: Api.EmojiStatus?, level: Int32?, subscriptionUntilDate: Int32?, botVerificationIcon: Int64?, sendPaidMessagesStars: Int64?, linkedMonoforumId: Int64?, linkedCommunityId: Int64?, pinnedMsgId: Int32?) {
                self.flags = flags
                self.flags2 = flags2
                self.id = id
                self.accessHash = accessHash
                self.title = title
                self.username = username
                self.photo = photo
                self.date = date
                self.restrictionReason = restrictionReason
                self.adminRights = adminRights
                self.bannedRights = bannedRights
                self.defaultBannedRights = defaultBannedRights
                self.participantsCount = participantsCount
                self.usernames = usernames
                self.storiesMaxId = storiesMaxId
                self.color = color
                self.profileColor = profileColor
                self.emojiStatus = emojiStatus
                self.level = level
                self.subscriptionUntilDate = subscriptionUntilDate
                self.botVerificationIcon = botVerificationIcon
                self.sendPaidMessagesStars = sendPaidMessagesStars
                self.linkedMonoforumId = linkedMonoforumId
                self.linkedCommunityId = linkedCommunityId
                self.pinnedMsgId = pinnedMsgId
            }
        }
        class Cons_channelForbidden: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var accessHash: Int64
            var title: String
            var untilDate: Int32?
            init(flags: Int32, id: Int64, accessHash: Int64, title: String, untilDate: Int32?) {
                self.flags = flags
                self.id = id
                self.accessHash = accessHash
                self.title = title
                self.untilDate = untilDate
            }
        }
        class Cons_chat: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var title: String
            var photo: Api.ChatPhoto
            var participantsCount: Int32
            var date: Int32
            var version: Int32
            var migratedTo: Api.InputChannel?
            var adminRights: Api.ChatAdminRights?
            var defaultBannedRights: Api.ChatBannedRights?
            init(flags: Int32, id: Int64, title: String, photo: Api.ChatPhoto, participantsCount: Int32, date: Int32, version: Int32, migratedTo: Api.InputChannel?, adminRights: Api.ChatAdminRights?, defaultBannedRights: Api.ChatBannedRights?) {
                self.flags = flags
                self.id = id
                self.title = title
                self.photo = photo
                self.participantsCount = participantsCount
                self.date = date
                self.version = version
                self.migratedTo = migratedTo
                self.adminRights = adminRights
                self.defaultBannedRights = defaultBannedRights
            }
        }
        class Cons_chatEmpty: TypeConstructorDescription {
            var id: Int64
            init(id: Int64) {
                self.id = id
            }
        }
        class Cons_chatForbidden: TypeConstructorDescription {
            var id: Int64
            var title: String
            init(id: Int64, title: String) {
                self.id = id
                self.title = title
            }
        }
        class Cons_community: TypeConstructorDescription {
            var flags: Int32
            var flags2: Int32
            var id: Int64
            var accessHash: Int64?
            var title: String
            var photo: Api.ChatPhoto
            var date: Int32
            var adminRights: Api.ChatAdminRights?
            var defaultBannedRights: Api.ChatBannedRights?
            init(flags: Int32, flags2: Int32, id: Int64, accessHash: Int64?, title: String, photo: Api.ChatPhoto, date: Int32, adminRights: Api.ChatAdminRights?, defaultBannedRights: Api.ChatBannedRights?) {
                self.flags = flags
                self.flags2 = flags2
                self.id = id
                self.accessHash = accessHash
                self.title = title
                self.photo = photo
                self.date = date
                self.adminRights = adminRights
                self.defaultBannedRights = defaultBannedRights
            }
        }
        class Cons_communityForbidden: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var accessHash: Int64?
            var title: String
            init(flags: Int32, id: Int64, accessHash: Int64?, title: String) {
                self.flags = flags
                self.id = id
                self.accessHash = accessHash
                self.title = title
            }
        }
        case channel(Cons_channel)
        case channelForbidden(Cons_channelForbidden)
        case chat(Cons_chat)
        case chatEmpty(Cons_chatEmpty)
        case chatForbidden(Cons_chatForbidden)
        case community(Cons_community)
        case communityForbidden(Cons_communityForbidden)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .channel(let _data):
                if boxed {
                    buffer.appendInt32(2060538432)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.flags2, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 13) != 0 {
                    serializeInt64(_data.accessHash!, buffer: buffer, boxed: false)
                }
                serializeString(_data.title, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    serializeString(_data.username!, buffer: buffer, boxed: false)
                }
                _data.photo.serialize(buffer, true)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.restrictionReason!.count))
                    for item in _data.restrictionReason! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 14) != 0 {
                    _data.adminRights!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 15) != 0 {
                    _data.bannedRights!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 18) != 0 {
                    _data.defaultBannedRights!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 17) != 0 {
                    serializeInt32(_data.participantsCount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.usernames!.count))
                    for item in _data.usernames! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags2) & Int(1 << 4) != 0 {
                    _data.storiesMaxId!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 7) != 0 {
                    _data.color!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 8) != 0 {
                    _data.profileColor!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 9) != 0 {
                    _data.emojiStatus!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 10) != 0 {
                    serializeInt32(_data.level!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 11) != 0 {
                    serializeInt32(_data.subscriptionUntilDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 13) != 0 {
                    serializeInt64(_data.botVerificationIcon!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 14) != 0 {
                    serializeInt64(_data.sendPaidMessagesStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 18) != 0 {
                    serializeInt64(_data.linkedMonoforumId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 20) != 0 {
                    serializeInt64(_data.linkedCommunityId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 22) != 0 {
                    serializeInt32(_data.pinnedMsgId!, buffer: buffer, boxed: false)
                }
                break
            case .channelForbidden(let _data):
                if boxed {
                    buffer.appendInt32(399807445)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 16) != 0 {
                    serializeInt32(_data.untilDate!, buffer: buffer, boxed: false)
                }
                break
            case .chat(let _data):
                if boxed {
                    buffer.appendInt32(1103884886)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                _data.photo.serialize(buffer, true)
                serializeInt32(_data.participantsCount, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt32(_data.version, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    _data.migratedTo!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 14) != 0 {
                    _data.adminRights!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 18) != 0 {
                    _data.defaultBannedRights!.serialize(buffer, true)
                }
                break
            case .chatEmpty(let _data):
                if boxed {
                    buffer.appendInt32(693512293)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                break
            case .chatForbidden(let _data):
                if boxed {
                    buffer.appendInt32(1704108455)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                break
            case .community(let _data):
                if boxed {
                    buffer.appendInt32(1710221652)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.flags2, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 13) != 0 {
                    serializeInt64(_data.accessHash!, buffer: buffer, boxed: false)
                }
                serializeString(_data.title, buffer: buffer, boxed: false)
                _data.photo.serialize(buffer, true)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 14) != 0 {
                    _data.adminRights!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 18) != 0 {
                    _data.defaultBannedRights!.serialize(buffer, true)
                }
                break
            case .communityForbidden(let _data):
                if boxed {
                    buffer.appendInt32(-46343496)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 13) != 0 {
                    serializeInt64(_data.accessHash!, buffer: buffer, boxed: false)
                }
                serializeString(_data.title, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_channel(_ reader: BufferReader) -> Chat? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int64?
            if Int(_1 ?? 0) & Int(1 << 13) != 0 {
                _4 = reader.readInt64()
            }
            var _5: String?
            _5 = parseString(reader)
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                _6 = parseString(reader)
            }
            var _7: Api.ChatPhoto?
            if let signature = reader.readInt32() {
                _7 = Api.parse(reader, signature: signature) as? Api.ChatPhoto
            }
            var _8: Int32?
            _8 = reader.readInt32()
            var _9: [Api.RestrictionReason]?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                if let _ = reader.readInt32() {
                    _9 = Api.parseVector(reader, elementSignature: 0, elementType: Api.RestrictionReason.self)
                }
            }
            var _10: Api.ChatAdminRights?
            if Int(_1 ?? 0) & Int(1 << 14) != 0 {
                if let signature = reader.readInt32() {
                    _10 = Api.parse(reader, signature: signature) as? Api.ChatAdminRights
                }
            }
            var _11: Api.ChatBannedRights?
            if Int(_1 ?? 0) & Int(1 << 15) != 0 {
                if let signature = reader.readInt32() {
                    _11 = Api.parse(reader, signature: signature) as? Api.ChatBannedRights
                }
            }
            var _12: Api.ChatBannedRights?
            if Int(_1 ?? 0) & Int(1 << 18) != 0 {
                if let signature = reader.readInt32() {
                    _12 = Api.parse(reader, signature: signature) as? Api.ChatBannedRights
                }
            }
            var _13: Int32?
            if Int(_1 ?? 0) & Int(1 << 17) != 0 {
                _13 = reader.readInt32()
            }
            var _14: [Api.Username]?
            if Int(_2 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _14 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Username.self)
                }
            }
            var _15: Api.RecentStory?
            if Int(_2 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _15 = Api.parse(reader, signature: signature) as? Api.RecentStory
                }
            }
            var _16: Api.PeerColor?
            if Int(_2 ?? 0) & Int(1 << 7) != 0 {
                if let signature = reader.readInt32() {
                    _16 = Api.parse(reader, signature: signature) as? Api.PeerColor
                }
            }
            var _17: Api.PeerColor?
            if Int(_2 ?? 0) & Int(1 << 8) != 0 {
                if let signature = reader.readInt32() {
                    _17 = Api.parse(reader, signature: signature) as? Api.PeerColor
                }
            }
            var _18: Api.EmojiStatus?
            if Int(_2 ?? 0) & Int(1 << 9) != 0 {
                if let signature = reader.readInt32() {
                    _18 = Api.parse(reader, signature: signature) as? Api.EmojiStatus
                }
            }
            var _19: Int32?
            if Int(_2 ?? 0) & Int(1 << 10) != 0 {
                _19 = reader.readInt32()
            }
            var _20: Int32?
            if Int(_2 ?? 0) & Int(1 << 11) != 0 {
                _20 = reader.readInt32()
            }
            var _21: Int64?
            if Int(_2 ?? 0) & Int(1 << 13) != 0 {
                _21 = reader.readInt64()
            }
            var _22: Int64?
            if Int(_2 ?? 0) & Int(1 << 14) != 0 {
                _22 = reader.readInt64()
            }
            var _23: Int64?
            if Int(_2 ?? 0) & Int(1 << 18) != 0 {
                _23 = reader.readInt64()
            }
            var _24: Int64?
            if Int(_2 ?? 0) & Int(1 << 20) != 0 {
                _24 = reader.readInt64()
            }
            var _25: Int32?
            if Int(_2 ?? 0) & Int(1 << 22) != 0 {
                _25 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 13) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 14) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 15) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 18) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 17) == 0) || _13 != nil
            let _c14 = (Int(_2 ?? 0) & Int(1 << 0) == 0) || _14 != nil
            let _c15 = (Int(_2 ?? 0) & Int(1 << 4) == 0) || _15 != nil
            let _c16 = (Int(_2 ?? 0) & Int(1 << 7) == 0) || _16 != nil
            let _c17 = (Int(_2 ?? 0) & Int(1 << 8) == 0) || _17 != nil
            let _c18 = (Int(_2 ?? 0) & Int(1 << 9) == 0) || _18 != nil
            let _c19 = (Int(_2 ?? 0) & Int(1 << 10) == 0) || _19 != nil
            let _c20 = (Int(_2 ?? 0) & Int(1 << 11) == 0) || _20 != nil
            let _c21 = (Int(_2 ?? 0) & Int(1 << 13) == 0) || _21 != nil
            let _c22 = (Int(_2 ?? 0) & Int(1 << 14) == 0) || _22 != nil
            let _c23 = (Int(_2 ?? 0) & Int(1 << 18) == 0) || _23 != nil
            let _c24 = (Int(_2 ?? 0) & Int(1 << 20) == 0) || _24 != nil
            let _c25 = (Int(_2 ?? 0) & Int(1 << 22) == 0) || _25 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 && _c15 && _c16 && _c17 && _c18 && _c19 && _c20 && _c21 && _c22 && _c23 && _c24 && _c25 {
                return Api.Chat.channel(Cons_channel(flags: _1!, flags2: _2!, id: _3!, accessHash: _4, title: _5!, username: _6, photo: _7!, date: _8!, restrictionReason: _9, adminRights: _10, bannedRights: _11, defaultBannedRights: _12, participantsCount: _13, usernames: _14, storiesMaxId: _15, color: _16, profileColor: _17, emojiStatus: _18, level: _19, subscriptionUntilDate: _20, botVerificationIcon: _21, sendPaidMessagesStars: _22, linkedMonoforumId: _23, linkedCommunityId: _24, pinnedMsgId: _25))
            }
            else {
                return nil
            }
        }
        static func parse_channelForbidden(_ reader: BufferReader) -> Chat? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: String?
            _4 = parseString(reader)
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 16) != 0 {
                _5 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 16) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.Chat.channelForbidden(Cons_channelForbidden(flags: _1!, id: _2!, accessHash: _3!, title: _4!, untilDate: _5))
            }
            else {
                return nil
            }
        }
        static func parse_chat(_ reader: BufferReader) -> Chat? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            _3 = parseString(reader)
            var _4: Api.ChatPhoto?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.ChatPhoto
            }
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: Int32?
            _7 = reader.readInt32()
            var _8: Api.InputChannel?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.InputChannel
                }
            }
            var _9: Api.ChatAdminRights?
            if Int(_1 ?? 0) & Int(1 << 14) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.ChatAdminRights
                }
            }
            var _10: Api.ChatBannedRights?
            if Int(_1 ?? 0) & Int(1 << 18) != 0 {
                if let signature = reader.readInt32() {
                    _10 = Api.parse(reader, signature: signature) as? Api.ChatBannedRights
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 14) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 18) == 0) || _10 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 {
                return Api.Chat.chat(Cons_chat(flags: _1!, id: _2!, title: _3!, photo: _4!, participantsCount: _5!, date: _6!, version: _7!, migratedTo: _8, adminRights: _9, defaultBannedRights: _10))
            }
            else {
                return nil
            }
        }
        static func parse_chatEmpty(_ reader: BufferReader) -> Chat? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.Chat.chatEmpty(Cons_chatEmpty(id: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_chatForbidden(_ reader: BufferReader) -> Chat? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.Chat.chatForbidden(Cons_chatForbidden(id: _1!, title: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_community(_ reader: BufferReader) -> Chat? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int64?
            if Int(_1 ?? 0) & Int(1 << 13) != 0 {
                _4 = reader.readInt64()
            }
            var _5: String?
            _5 = parseString(reader)
            var _6: Api.ChatPhoto?
            if let signature = reader.readInt32() {
                _6 = Api.parse(reader, signature: signature) as? Api.ChatPhoto
            }
            var _7: Int32?
            _7 = reader.readInt32()
            var _8: Api.ChatAdminRights?
            if Int(_1 ?? 0) & Int(1 << 14) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.ChatAdminRights
                }
            }
            var _9: Api.ChatBannedRights?
            if Int(_1 ?? 0) & Int(1 << 18) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.ChatBannedRights
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 13) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 14) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 18) == 0) || _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.Chat.community(Cons_community(flags: _1!, flags2: _2!, id: _3!, accessHash: _4, title: _5!, photo: _6!, date: _7!, adminRights: _8, defaultBannedRights: _9))
            }
            else {
                return nil
            }
        }
        static func parse_communityForbidden(_ reader: BufferReader) -> Chat? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            if Int(_1 ?? 0) & Int(1 << 13) != 0 {
                _3 = reader.readInt64()
            }
            var _4: String?
            _4 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 13) == 0) || _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Chat.communityForbidden(Cons_communityForbidden(flags: _1!, id: _2!, accessHash: _3, title: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum ChatAdminRights: TypeConstructorDescription {
        class Cons_chatAdminRights: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        case chatAdminRights(Cons_chatAdminRights)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .chatAdminRights(let _data):
                if boxed {
                    buffer.appendInt32(1605510357)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_chatAdminRights(_ reader: BufferReader) -> ChatAdminRights? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChatAdminRights.chatAdminRights(Cons_chatAdminRights(flags: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum ChatBannedRights: TypeConstructorDescription {
        class Cons_chatBannedRights: TypeConstructorDescription {
            var flags: Int32
            var untilDate: Int32
            init(flags: Int32, untilDate: Int32) {
                self.flags = flags
                self.untilDate = untilDate
            }
        }
        case chatBannedRights(Cons_chatBannedRights)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .chatBannedRights(let _data):
                if boxed {
                    buffer.appendInt32(-1626209256)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.untilDate, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_chatBannedRights(_ reader: BufferReader) -> ChatBannedRights? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChatBannedRights.chatBannedRights(Cons_chatBannedRights(flags: _1!, untilDate: _2!))
            }
            else {
                return nil
            }
        }
    }
}
