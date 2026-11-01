extension Api {
    indirect enum EphemeralMessage: TypeConstructorDescription {
        class Cons_ephemeralMessage: TypeConstructorDescription {
            var flags: Int32
            var id: Int32
            var fromId: Api.Peer
            var peerId: Api.Peer?
            var receiverId: Int64
            var topMsgId: Int32?
            var date: Int32
            var message: String
            var entities: [Api.MessageEntity]?
            var media: Api.MessageMedia?
            var replyMarkup: Api.ReplyMarkup?
            var replyTo: Api.MessageReplyHeader?
            var richMessage: Api.RichMessage?
            var chatInstance: Int64?
            var anchorMsgId: Int32?
            init(flags: Int32, id: Int32, fromId: Api.Peer, peerId: Api.Peer?, receiverId: Int64, topMsgId: Int32?, date: Int32, message: String, entities: [Api.MessageEntity]?, media: Api.MessageMedia?, replyMarkup: Api.ReplyMarkup?, replyTo: Api.MessageReplyHeader?, richMessage: Api.RichMessage?, chatInstance: Int64?, anchorMsgId: Int32?) {
                self.flags = flags
                self.id = id
                self.fromId = fromId
                self.peerId = peerId
                self.receiverId = receiverId
                self.topMsgId = topMsgId
                self.date = date
                self.message = message
                self.entities = entities
                self.media = media
                self.replyMarkup = replyMarkup
                self.replyTo = replyTo
                self.richMessage = richMessage
                self.chatInstance = chatInstance
                self.anchorMsgId = anchorMsgId
            }
        }
        case ephemeralMessage(Cons_ephemeralMessage)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .ephemeralMessage(let _data):
                if boxed {
                    buffer.appendInt32(-584597783)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                _data.fromId.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    _data.peerId!.serialize(buffer, true)
                }
                serializeInt64(_data.receiverId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.topMsgId!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeString(_data.message, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.entities!.count))
                    for item in _data.entities! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.media!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    _data.replyMarkup!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    _data.replyTo!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    _data.richMessage!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    serializeInt64(_data.chatInstance!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    serializeInt32(_data.anchorMsgId!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_ephemeralMessage(_ reader: BufferReader) -> EphemeralMessage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.Peer?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _4: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _5: Int64?
            _5 = reader.readInt64()
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _6 = reader.readInt32()
            }
            var _7: Int32?
            _7 = reader.readInt32()
            var _8: String?
            _8 = parseString(reader)
            var _9: [Api.MessageEntity]?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let _ = reader.readInt32() {
                    _9 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self)
                }
            }
            var _10: Api.MessageMedia?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _10 = Api.parse(reader, signature: signature) as? Api.MessageMedia
                }
            }
            var _11: Api.ReplyMarkup?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _11 = Api.parse(reader, signature: signature) as? Api.ReplyMarkup
                }
            }
            var _12: Api.MessageReplyHeader?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                if let signature = reader.readInt32() {
                    _12 = Api.parse(reader, signature: signature) as? Api.MessageReplyHeader
                }
            }
            var _13: Api.RichMessage?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                if let signature = reader.readInt32() {
                    _13 = Api.parse(reader, signature: signature) as? Api.RichMessage
                }
            }
            var _14: Int64?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                _14 = reader.readInt64()
            }
            var _15: Int32?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                _15 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _13 != nil
            let _c14 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _14 != nil
            let _c15 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _15 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 && _c15 {
                return Api.EphemeralMessage.ephemeralMessage(Cons_ephemeralMessage(flags: _1!, id: _2!, fromId: _3!, peerId: _4, receiverId: _5!, topMsgId: _6, date: _7!, message: _8!, entities: _9, media: _10, replyMarkup: _11, replyTo: _12, richMessage: _13, chatInstance: _14, anchorMsgId: _15))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum ExportedChatInvite: TypeConstructorDescription {
        class Cons_chatInviteExported: TypeConstructorDescription {
            var flags: Int32
            var link: String
            var adminId: Int64
            var date: Int32
            var startDate: Int32?
            var expireDate: Int32?
            var usageLimit: Int32?
            var usage: Int32?
            var requested: Int32?
            var subscriptionExpired: Int32?
            var title: String?
            var subscriptionPricing: Api.StarsSubscriptionPricing?
            init(flags: Int32, link: String, adminId: Int64, date: Int32, startDate: Int32?, expireDate: Int32?, usageLimit: Int32?, usage: Int32?, requested: Int32?, subscriptionExpired: Int32?, title: String?, subscriptionPricing: Api.StarsSubscriptionPricing?) {
                self.flags = flags
                self.link = link
                self.adminId = adminId
                self.date = date
                self.startDate = startDate
                self.expireDate = expireDate
                self.usageLimit = usageLimit
                self.usage = usage
                self.requested = requested
                self.subscriptionExpired = subscriptionExpired
                self.title = title
                self.subscriptionPricing = subscriptionPricing
            }
        }
        case chatInviteExported(Cons_chatInviteExported)
        case chatInvitePublicJoinRequests

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .chatInviteExported(let _data):
                if boxed {
                    buffer.appendInt32(-1574126186)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.link, buffer: buffer, boxed: false)
                serializeInt64(_data.adminId, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.startDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.expireDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.usageLimit!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.usage!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    serializeInt32(_data.requested!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    serializeInt32(_data.subscriptionExpired!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    serializeString(_data.title!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    _data.subscriptionPricing!.serialize(buffer, true)
                }
                break
            case .chatInvitePublicJoinRequests:
                if boxed {
                    buffer.appendInt32(-317687113)
                }
                break
            }
        }

        static func parse_chatInviteExported(_ reader: BufferReader) -> ExportedChatInvite? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _5 = reader.readInt32()
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _6 = reader.readInt32()
            }
            var _7: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _7 = reader.readInt32()
            }
            var _8: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _8 = reader.readInt32()
            }
            var _9: Int32?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                _9 = reader.readInt32()
            }
            var _10: Int32?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                _10 = reader.readInt32()
            }
            var _11: String?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                _11 = parseString(reader)
            }
            var _12: Api.StarsSubscriptionPricing?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                if let signature = reader.readInt32() {
                    _12 = Api.parse(reader, signature: signature) as? Api.StarsSubscriptionPricing
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _12 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 {
                return Api.ExportedChatInvite.chatInviteExported(Cons_chatInviteExported(flags: _1!, link: _2!, adminId: _3!, date: _4!, startDate: _5, expireDate: _6, usageLimit: _7, usage: _8, requested: _9, subscriptionExpired: _10, title: _11, subscriptionPricing: _12))
            }
            else {
                return nil
            }
        }
        static func parse_chatInvitePublicJoinRequests(_ reader: BufferReader) -> ExportedChatInvite? {
            return Api.ExportedChatInvite.chatInvitePublicJoinRequests
        }
    }
}
extension Api {
    enum ExportedChatlistInvite: TypeConstructorDescription {
        class Cons_exportedChatlistInvite: TypeConstructorDescription {
            var flags: Int32
            var title: String
            var url: String
            var peers: [Api.Peer]
            init(flags: Int32, title: String, url: String, peers: [Api.Peer]) {
                self.flags = flags
                self.title = title
                self.url = url
                self.peers = peers
            }
        }
        case exportedChatlistInvite(Cons_exportedChatlistInvite)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .exportedChatlistInvite(let _data):
                if boxed {
                    buffer.appendInt32(206668204)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeString(_data.url, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.peers.count))
                for item in _data.peers {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_exportedChatlistInvite(_ reader: BufferReader) -> ExportedChatlistInvite? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            _3 = parseString(reader)
            var _4: [Api.Peer]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Peer.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.ExportedChatlistInvite.exportedChatlistInvite(Cons_exportedChatlistInvite(flags: _1!, title: _2!, url: _3!, peers: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum FactCheck: TypeConstructorDescription {
        class Cons_factCheck: TypeConstructorDescription {
            var flags: Int32
            var country: String?
            var text: Api.TextWithEntities?
            var hash: Int64
            init(flags: Int32, country: String?, text: Api.TextWithEntities?, hash: Int64) {
                self.flags = flags
                self.country = country
                self.text = text
                self.hash = hash
            }
        }
        case factCheck(Cons_factCheck)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .factCheck(let _data):
                if boxed {
                    buffer.appendInt32(-1197736753)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.country!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.text!.serialize(buffer, true)
                }
                serializeInt64(_data.hash, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_factCheck(_ reader: BufferReader) -> FactCheck? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _2 = parseString(reader)
            }
            var _3: Api.TextWithEntities?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
                }
            }
            var _4: Int64?
            _4 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.FactCheck.factCheck(Cons_factCheck(flags: _1!, country: _2, text: _3, hash: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum Folder: TypeConstructorDescription {
        class Cons_folder: TypeConstructorDescription {
            var flags: Int32
            var id: Int32
            var title: String
            var photo: Api.ChatPhoto?
            init(flags: Int32, id: Int32, title: String, photo: Api.ChatPhoto?) {
                self.flags = flags
                self.id = id
                self.title = title
                self.photo = photo
            }
        }
        case folder(Cons_folder)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .folder(let _data):
                if boxed {
                    buffer.appendInt32(-11252123)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.photo!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_folder(_ reader: BufferReader) -> Folder? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: String?
            _3 = parseString(reader)
            var _4: Api.ChatPhoto?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.ChatPhoto
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Folder.folder(Cons_folder(flags: _1!, id: _2!, title: _3!, photo: _4))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum FolderPeer: TypeConstructorDescription {
        class Cons_folderPeer: TypeConstructorDescription {
            var peer: Api.Peer
            var folderId: Int32
            init(peer: Api.Peer, folderId: Int32) {
                self.peer = peer
                self.folderId = folderId
            }
        }
        case folderPeer(Cons_folderPeer)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .folderPeer(let _data):
                if boxed {
                    buffer.appendInt32(-373643672)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.folderId, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_folderPeer(_ reader: BufferReader) -> FolderPeer? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.FolderPeer.folderPeer(Cons_folderPeer(peer: _1!, folderId: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum ForumTopic: TypeConstructorDescription {
        class Cons_forumTopic: TypeConstructorDescription {
            var flags: Int32
            var id: Int32
            var date: Int32
            var peer: Api.Peer
            var title: String
            var iconColor: Int32
            var iconEmojiId: Int64?
            var topMessage: Int32
            var readInboxMaxId: Int32
            var readOutboxMaxId: Int32
            var unreadCount: Int32
            var unreadMentionsCount: Int32
            var unreadReactionsCount: Int32
            var unreadPollVotesCount: Int32
            var fromId: Api.Peer
            var notifySettings: Api.PeerNotifySettings
            var draft: Api.DraftMessage?
            init(flags: Int32, id: Int32, date: Int32, peer: Api.Peer, title: String, iconColor: Int32, iconEmojiId: Int64?, topMessage: Int32, readInboxMaxId: Int32, readOutboxMaxId: Int32, unreadCount: Int32, unreadMentionsCount: Int32, unreadReactionsCount: Int32, unreadPollVotesCount: Int32, fromId: Api.Peer, notifySettings: Api.PeerNotifySettings, draft: Api.DraftMessage?) {
                self.flags = flags
                self.id = id
                self.date = date
                self.peer = peer
                self.title = title
                self.iconColor = iconColor
                self.iconEmojiId = iconEmojiId
                self.topMessage = topMessage
                self.readInboxMaxId = readInboxMaxId
                self.readOutboxMaxId = readOutboxMaxId
                self.unreadCount = unreadCount
                self.unreadMentionsCount = unreadMentionsCount
                self.unreadReactionsCount = unreadReactionsCount
                self.unreadPollVotesCount = unreadPollVotesCount
                self.fromId = fromId
                self.notifySettings = notifySettings
                self.draft = draft
            }
        }
        class Cons_forumTopicDeleted: TypeConstructorDescription {
            var id: Int32
            init(id: Int32) {
                self.id = id
            }
        }
        case forumTopic(Cons_forumTopic)
        case forumTopicDeleted(Cons_forumTopicDeleted)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .forumTopic(let _data):
                if boxed {
                    buffer.appendInt32(-52766699)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeInt32(_data.iconColor, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.iconEmojiId!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.topMessage, buffer: buffer, boxed: false)
                serializeInt32(_data.readInboxMaxId, buffer: buffer, boxed: false)
                serializeInt32(_data.readOutboxMaxId, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadCount, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadMentionsCount, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadReactionsCount, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadPollVotesCount, buffer: buffer, boxed: false)
                _data.fromId.serialize(buffer, true)
                _data.notifySettings.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    _data.draft!.serialize(buffer, true)
                }
                break
            case .forumTopicDeleted(let _data):
                if boxed {
                    buffer.appendInt32(37687451)
                }
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_forumTopic(_ reader: BufferReader) -> ForumTopic? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Api.Peer?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _5: String?
            _5 = parseString(reader)
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _7 = reader.readInt64()
            }
            var _8: Int32?
            _8 = reader.readInt32()
            var _9: Int32?
            _9 = reader.readInt32()
            var _10: Int32?
            _10 = reader.readInt32()
            var _11: Int32?
            _11 = reader.readInt32()
            var _12: Int32?
            _12 = reader.readInt32()
            var _13: Int32?
            _13 = reader.readInt32()
            var _14: Int32?
            _14 = reader.readInt32()
            var _15: Api.Peer?
            if let signature = reader.readInt32() {
                _15 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _16: Api.PeerNotifySettings?
            if let signature = reader.readInt32() {
                _16 = Api.parse(reader, signature: signature) as? Api.PeerNotifySettings
            }
            var _17: Api.DraftMessage?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _17 = Api.parse(reader, signature: signature) as? Api.DraftMessage
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _7 != nil
            let _c8 = _8 != nil
            let _c9 = _9 != nil
            let _c10 = _10 != nil
            let _c11 = _11 != nil
            let _c12 = _12 != nil
            let _c13 = _13 != nil
            let _c14 = _14 != nil
            let _c15 = _15 != nil
            let _c16 = _16 != nil
            let _c17 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _17 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 && _c15 && _c16 && _c17 {
                return Api.ForumTopic.forumTopic(Cons_forumTopic(flags: _1!, id: _2!, date: _3!, peer: _4!, title: _5!, iconColor: _6!, iconEmojiId: _7, topMessage: _8!, readInboxMaxId: _9!, readOutboxMaxId: _10!, unreadCount: _11!, unreadMentionsCount: _12!, unreadReactionsCount: _13!, unreadPollVotesCount: _14!, fromId: _15!, notifySettings: _16!, draft: _17))
            }
            else {
                return nil
            }
        }
        static func parse_forumTopicDeleted(_ reader: BufferReader) -> ForumTopic? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.ForumTopic.forumTopicDeleted(Cons_forumTopicDeleted(id: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum FoundStory: TypeConstructorDescription {
        class Cons_foundStory: TypeConstructorDescription {
            var peer: Api.Peer
            var story: Api.StoryItem
            init(peer: Api.Peer, story: Api.StoryItem) {
                self.peer = peer
                self.story = story
            }
        }
        case foundStory(Cons_foundStory)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .foundStory(let _data):
                if boxed {
                    buffer.appendInt32(-394605632)
                }
                _data.peer.serialize(buffer, true)
                _data.story.serialize(buffer, true)
                break
            }
        }

        static func parse_foundStory(_ reader: BufferReader) -> FoundStory? {
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
                return Api.FoundStory.foundStory(Cons_foundStory(peer: _1!, story: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum Game: TypeConstructorDescription {
        class Cons_game: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var accessHash: Int64
            var shortName: String
            var title: String
            var description: String
            var photo: Api.Photo
            var document: Api.Document?
            init(flags: Int32, id: Int64, accessHash: Int64, shortName: String, title: String, description: String, photo: Api.Photo, document: Api.Document?) {
                self.flags = flags
                self.id = id
                self.accessHash = accessHash
                self.shortName = shortName
                self.title = title
                self.description = description
                self.photo = photo
                self.document = document
            }
        }
        case game(Cons_game)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .game(let _data):
                if boxed {
                    buffer.appendInt32(-1107729093)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeString(_data.shortName, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeString(_data.description, buffer: buffer, boxed: false)
                _data.photo.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.document!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_game(_ reader: BufferReader) -> Game? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: String?
            _4 = parseString(reader)
            var _5: String?
            _5 = parseString(reader)
            var _6: String?
            _6 = parseString(reader)
            var _7: Api.Photo?
            if let signature = reader.readInt32() {
                _7 = Api.parse(reader, signature: signature) as? Api.Photo
            }
            var _8: Api.Document?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.Document
                }
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
                return Api.Game.game(Cons_game(flags: _1!, id: _2!, accessHash: _3!, shortName: _4!, title: _5!, description: _6!, photo: _7!, document: _8))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum GeoPoint: TypeConstructorDescription {
        class Cons_geoPoint: TypeConstructorDescription {
            var flags: Int32
            var long: Double
            var lat: Double
            var accessHash: Int64
            var accuracyRadius: Int32?
            init(flags: Int32, long: Double, lat: Double, accessHash: Int64, accuracyRadius: Int32?) {
                self.flags = flags
                self.long = long
                self.lat = lat
                self.accessHash = accessHash
                self.accuracyRadius = accuracyRadius
            }
        }
        case geoPoint(Cons_geoPoint)
        case geoPointEmpty

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .geoPoint(let _data):
                if boxed {
                    buffer.appendInt32(-1297942941)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeDouble(_data.long, buffer: buffer, boxed: false)
                serializeDouble(_data.lat, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.accuracyRadius!, buffer: buffer, boxed: false)
                }
                break
            case .geoPointEmpty:
                if boxed {
                    buffer.appendInt32(286776671)
                }
                break
            }
        }

        static func parse_geoPoint(_ reader: BufferReader) -> GeoPoint? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Double?
            _2 = reader.readDouble()
            var _3: Double?
            _3 = reader.readDouble()
            var _4: Int64?
            _4 = reader.readInt64()
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
                return Api.GeoPoint.geoPoint(Cons_geoPoint(flags: _1!, long: _2!, lat: _3!, accessHash: _4!, accuracyRadius: _5))
            }
            else {
                return nil
            }
        }
        static func parse_geoPointEmpty(_ reader: BufferReader) -> GeoPoint? {
            return Api.GeoPoint.geoPointEmpty
        }
    }
}
extension Api {
    enum GeoPointAddress: TypeConstructorDescription {
        class Cons_geoPointAddress: TypeConstructorDescription {
            var flags: Int32
            var countryIso2: String
            var state: String?
            var city: String?
            var street: String?
            init(flags: Int32, countryIso2: String, state: String?, city: String?, street: String?) {
                self.flags = flags
                self.countryIso2 = countryIso2
                self.state = state
                self.city = city
                self.street = street
            }
        }
        case geoPointAddress(Cons_geoPointAddress)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .geoPointAddress(let _data):
                if boxed {
                    buffer.appendInt32(-565420653)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.countryIso2, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.state!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.city!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.street!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_geoPointAddress(_ reader: BufferReader) -> GeoPointAddress? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = parseString(reader)
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _4 = parseString(reader)
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _5 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.GeoPointAddress.geoPointAddress(Cons_geoPointAddress(flags: _1!, countryIso2: _2!, state: _3, city: _4, street: _5))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum GroupCall: TypeConstructorDescription {
        class Cons_groupCall: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var accessHash: Int64
            var participantsCount: Int32
            var title: String?
            var streamDcId: Int32?
            var recordStartDate: Int32?
            var scheduleDate: Int32?
            var unmutedVideoCount: Int32?
            var unmutedVideoLimit: Int32
            var version: Int32
            var inviteLink: String?
            var sendPaidMessagesStars: Int64?
            var defaultSendAs: Api.Peer?
            init(flags: Int32, id: Int64, accessHash: Int64, participantsCount: Int32, title: String?, streamDcId: Int32?, recordStartDate: Int32?, scheduleDate: Int32?, unmutedVideoCount: Int32?, unmutedVideoLimit: Int32, version: Int32, inviteLink: String?, sendPaidMessagesStars: Int64?, defaultSendAs: Api.Peer?) {
                self.flags = flags
                self.id = id
                self.accessHash = accessHash
                self.participantsCount = participantsCount
                self.title = title
                self.streamDcId = streamDcId
                self.recordStartDate = recordStartDate
                self.scheduleDate = scheduleDate
                self.unmutedVideoCount = unmutedVideoCount
                self.unmutedVideoLimit = unmutedVideoLimit
                self.version = version
                self.inviteLink = inviteLink
                self.sendPaidMessagesStars = sendPaidMessagesStars
                self.defaultSendAs = defaultSendAs
            }
        }
        class Cons_groupCallDiscarded: TypeConstructorDescription {
            var id: Int64
            var accessHash: Int64
            var duration: Int32
            init(id: Int64, accessHash: Int64, duration: Int32) {
                self.id = id
                self.accessHash = accessHash
                self.duration = duration
            }
        }
        case groupCall(Cons_groupCall)
        case groupCallDiscarded(Cons_groupCallDiscarded)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .groupCall(let _data):
                if boxed {
                    buffer.appendInt32(-273500649)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeInt32(_data.participantsCount, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.title!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.streamDcId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeInt32(_data.recordStartDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    serializeInt32(_data.scheduleDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    serializeInt32(_data.unmutedVideoCount!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.unmutedVideoLimit, buffer: buffer, boxed: false)
                serializeInt32(_data.version, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 16) != 0 {
                    serializeString(_data.inviteLink!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 20) != 0 {
                    serializeInt64(_data.sendPaidMessagesStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 21) != 0 {
                    _data.defaultSendAs!.serialize(buffer, true)
                }
                break
            case .groupCallDiscarded(let _data):
                if boxed {
                    buffer.appendInt32(2004925620)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeInt32(_data.duration, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_groupCall(_ reader: BufferReader) -> GroupCall? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _5 = parseString(reader)
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _6 = reader.readInt32()
            }
            var _7: Int32?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _7 = reader.readInt32()
            }
            var _8: Int32?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                _8 = reader.readInt32()
            }
            var _9: Int32?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                _9 = reader.readInt32()
            }
            var _10: Int32?
            _10 = reader.readInt32()
            var _11: Int32?
            _11 = reader.readInt32()
            var _12: String?
            if Int(_1 ?? 0) & Int(1 << 16) != 0 {
                _12 = parseString(reader)
            }
            var _13: Int64?
            if Int(_1 ?? 0) & Int(1 << 20) != 0 {
                _13 = reader.readInt64()
            }
            var _14: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 21) != 0 {
                if let signature = reader.readInt32() {
                    _14 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _9 != nil
            let _c10 = _10 != nil
            let _c11 = _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 16) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 20) == 0) || _13 != nil
            let _c14 = (Int(_1 ?? 0) & Int(1 << 21) == 0) || _14 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 {
                return Api.GroupCall.groupCall(Cons_groupCall(flags: _1!, id: _2!, accessHash: _3!, participantsCount: _4!, title: _5, streamDcId: _6, recordStartDate: _7, scheduleDate: _8, unmutedVideoCount: _9, unmutedVideoLimit: _10!, version: _11!, inviteLink: _12, sendPaidMessagesStars: _13, defaultSendAs: _14))
            }
            else {
                return nil
            }
        }
        static func parse_groupCallDiscarded(_ reader: BufferReader) -> GroupCall? {
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
                return Api.GroupCall.groupCallDiscarded(Cons_groupCallDiscarded(id: _1!, accessHash: _2!, duration: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum GroupCallDonor: TypeConstructorDescription {
        class Cons_groupCallDonor: TypeConstructorDescription {
            var flags: Int32
            var peerId: Api.Peer?
            var stars: Int64
            init(flags: Int32, peerId: Api.Peer?, stars: Int64) {
                self.flags = flags
                self.peerId = peerId
                self.stars = stars
            }
        }
        case groupCallDonor(Cons_groupCallDonor)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .groupCallDonor(let _data):
                if boxed {
                    buffer.appendInt32(-297595771)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.peerId!.serialize(buffer, true)
                }
                serializeInt64(_data.stars, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_groupCallDonor(_ reader: BufferReader) -> GroupCallDonor? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _3: Int64?
            _3 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.GroupCallDonor.groupCallDonor(Cons_groupCallDonor(flags: _1!, peerId: _2, stars: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum GroupCallMessage: TypeConstructorDescription {
        class Cons_groupCallMessage: TypeConstructorDescription {
            var flags: Int32
            var id: Int32
            var fromId: Api.Peer
            var date: Int32
            var message: Api.TextWithEntities
            var paidMessageStars: Int64?
            init(flags: Int32, id: Int32, fromId: Api.Peer, date: Int32, message: Api.TextWithEntities, paidMessageStars: Int64?) {
                self.flags = flags
                self.id = id
                self.fromId = fromId
                self.date = date
                self.message = message
                self.paidMessageStars = paidMessageStars
            }
        }
        case groupCallMessage(Cons_groupCallMessage)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .groupCallMessage(let _data):
                if boxed {
                    buffer.appendInt32(445316222)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                _data.fromId.serialize(buffer, true)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                _data.message.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.paidMessageStars!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_groupCallMessage(_ reader: BufferReader) -> GroupCallMessage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.Peer?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Api.TextWithEntities?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
            }
            var _6: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _6 = reader.readInt64()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.GroupCallMessage.groupCallMessage(Cons_groupCallMessage(flags: _1!, id: _2!, fromId: _3!, date: _4!, message: _5!, paidMessageStars: _6))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum GroupCallParticipant: TypeConstructorDescription {
        class Cons_groupCallParticipant: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var date: Int32
            var activeDate: Int32?
            var source: Int32
            var volume: Int32?
            var about: String?
            var raiseHandRating: Int64?
            var video: Api.GroupCallParticipantVideo?
            var presentation: Api.GroupCallParticipantVideo?
            var paidStarsTotal: Int64?
            init(flags: Int32, peer: Api.Peer, date: Int32, activeDate: Int32?, source: Int32, volume: Int32?, about: String?, raiseHandRating: Int64?, video: Api.GroupCallParticipantVideo?, presentation: Api.GroupCallParticipantVideo?, paidStarsTotal: Int64?) {
                self.flags = flags
                self.peer = peer
                self.date = date
                self.activeDate = activeDate
                self.source = source
                self.volume = volume
                self.about = about
                self.raiseHandRating = raiseHandRating
                self.video = video
                self.presentation = presentation
                self.paidStarsTotal = paidStarsTotal
            }
        }
        case groupCallParticipant(Cons_groupCallParticipant)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .groupCallParticipant(let _data):
                if boxed {
                    buffer.appendInt32(708691884)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.activeDate!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.source, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    serializeInt32(_data.volume!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    serializeString(_data.about!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 13) != 0 {
                    serializeInt64(_data.raiseHandRating!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    _data.video!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 14) != 0 {
                    _data.presentation!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 16) != 0 {
                    serializeInt64(_data.paidStarsTotal!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_groupCallParticipant(_ reader: BufferReader) -> GroupCallParticipant? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                _6 = reader.readInt32()
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                _7 = parseString(reader)
            }
            var _8: Int64?
            if Int(_1 ?? 0) & Int(1 << 13) != 0 {
                _8 = reader.readInt64()
            }
            var _9: Api.GroupCallParticipantVideo?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.GroupCallParticipantVideo
                }
            }
            var _10: Api.GroupCallParticipantVideo?
            if Int(_1 ?? 0) & Int(1 << 14) != 0 {
                if let signature = reader.readInt32() {
                    _10 = Api.parse(reader, signature: signature) as? Api.GroupCallParticipantVideo
                }
            }
            var _11: Int64?
            if Int(_1 ?? 0) & Int(1 << 16) != 0 {
                _11 = reader.readInt64()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 13) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 14) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 16) == 0) || _11 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 {
                return Api.GroupCallParticipant.groupCallParticipant(Cons_groupCallParticipant(flags: _1!, peer: _2!, date: _3!, activeDate: _4, source: _5!, volume: _6, about: _7, raiseHandRating: _8, video: _9, presentation: _10, paidStarsTotal: _11))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum GroupCallParticipantVideo: TypeConstructorDescription {
        class Cons_groupCallParticipantVideo: TypeConstructorDescription {
            var flags: Int32
            var endpoint: String
            var sourceGroups: [Api.GroupCallParticipantVideoSourceGroup]
            var audioSource: Int32?
            init(flags: Int32, endpoint: String, sourceGroups: [Api.GroupCallParticipantVideoSourceGroup], audioSource: Int32?) {
                self.flags = flags
                self.endpoint = endpoint
                self.sourceGroups = sourceGroups
                self.audioSource = audioSource
            }
        }
        case groupCallParticipantVideo(Cons_groupCallParticipantVideo)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .groupCallParticipantVideo(let _data):
                if boxed {
                    buffer.appendInt32(1735736008)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.endpoint, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.sourceGroups.count))
                for item in _data.sourceGroups {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.audioSource!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_groupCallParticipantVideo(_ reader: BufferReader) -> GroupCallParticipantVideo? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: [Api.GroupCallParticipantVideoSourceGroup]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.GroupCallParticipantVideoSourceGroup.self)
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _4 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.GroupCallParticipantVideo.groupCallParticipantVideo(Cons_groupCallParticipantVideo(flags: _1!, endpoint: _2!, sourceGroups: _3!, audioSource: _4))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum GroupCallParticipantVideoSourceGroup: TypeConstructorDescription {
        class Cons_groupCallParticipantVideoSourceGroup: TypeConstructorDescription {
            var semantics: String
            var sources: [Int32]
            init(semantics: String, sources: [Int32]) {
                self.semantics = semantics
                self.sources = sources
            }
        }
        case groupCallParticipantVideoSourceGroup(Cons_groupCallParticipantVideoSourceGroup)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .groupCallParticipantVideoSourceGroup(let _data):
                if boxed {
                    buffer.appendInt32(-592373577)
                }
                serializeString(_data.semantics, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.sources.count))
                for item in _data.sources {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_groupCallParticipantVideoSourceGroup(_ reader: BufferReader) -> GroupCallParticipantVideoSourceGroup? {
            var _1: String?
            _1 = parseString(reader)
            var _2: [Int32]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.GroupCallParticipantVideoSourceGroup.groupCallParticipantVideoSourceGroup(Cons_groupCallParticipantVideoSourceGroup(semantics: _1!, sources: _2!))
            }
            else {
                return nil
            }
        }
    }
}
