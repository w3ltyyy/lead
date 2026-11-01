extension Api {
    indirect enum Dialog: TypeConstructorDescription {
        class Cons_dialog: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var topMessage: Int32
            var readInboxMaxId: Int32
            var readOutboxMaxId: Int32
            var unreadCount: Int32
            var unreadMentionsCount: Int32
            var unreadReactionsCount: Int32
            var unreadPollVotesCount: Int32
            var notifySettings: Api.PeerNotifySettings
            var pts: Int32?
            var draft: Api.DraftMessage?
            var folderId: Int32?
            var ttlPeriod: Int32?
            init(flags: Int32, peer: Api.Peer, topMessage: Int32, readInboxMaxId: Int32, readOutboxMaxId: Int32, unreadCount: Int32, unreadMentionsCount: Int32, unreadReactionsCount: Int32, unreadPollVotesCount: Int32, notifySettings: Api.PeerNotifySettings, pts: Int32?, draft: Api.DraftMessage?, folderId: Int32?, ttlPeriod: Int32?) {
                self.flags = flags
                self.peer = peer
                self.topMessage = topMessage
                self.readInboxMaxId = readInboxMaxId
                self.readOutboxMaxId = readOutboxMaxId
                self.unreadCount = unreadCount
                self.unreadMentionsCount = unreadMentionsCount
                self.unreadReactionsCount = unreadReactionsCount
                self.unreadPollVotesCount = unreadPollVotesCount
                self.notifySettings = notifySettings
                self.pts = pts
                self.draft = draft
                self.folderId = folderId
                self.ttlPeriod = ttlPeriod
            }
        }
        class Cons_dialogCommunity: TypeConstructorDescription {
            var flags: Int32
            var communityId: Int64
            var notifySettings: Api.PeerNotifySettings
            init(flags: Int32, communityId: Int64, notifySettings: Api.PeerNotifySettings) {
                self.flags = flags
                self.communityId = communityId
                self.notifySettings = notifySettings
            }
        }
        class Cons_dialogFolder: TypeConstructorDescription {
            var flags: Int32
            var folder: Api.Folder
            var peer: Api.Peer
            var topMessage: Int32
            var unreadMutedPeersCount: Int32
            var unreadUnmutedPeersCount: Int32
            var unreadMutedMessagesCount: Int32
            var unreadUnmutedMessagesCount: Int32
            init(flags: Int32, folder: Api.Folder, peer: Api.Peer, topMessage: Int32, unreadMutedPeersCount: Int32, unreadUnmutedPeersCount: Int32, unreadMutedMessagesCount: Int32, unreadUnmutedMessagesCount: Int32) {
                self.flags = flags
                self.folder = folder
                self.peer = peer
                self.topMessage = topMessage
                self.unreadMutedPeersCount = unreadMutedPeersCount
                self.unreadUnmutedPeersCount = unreadUnmutedPeersCount
                self.unreadMutedMessagesCount = unreadMutedMessagesCount
                self.unreadUnmutedMessagesCount = unreadUnmutedMessagesCount
            }
        }
        case dialog(Cons_dialog)
        case dialogCommunity(Cons_dialogCommunity)
        case dialogFolder(Cons_dialogFolder)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .dialog(let _data):
                if boxed {
                    buffer.appendInt32(-58066957)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.topMessage, buffer: buffer, boxed: false)
                serializeInt32(_data.readInboxMaxId, buffer: buffer, boxed: false)
                serializeInt32(_data.readOutboxMaxId, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadCount, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadMentionsCount, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadReactionsCount, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadPollVotesCount, buffer: buffer, boxed: false)
                _data.notifySettings.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.pts!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.draft!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.folderId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeInt32(_data.ttlPeriod!, buffer: buffer, boxed: false)
                }
                break
            case .dialogCommunity(let _data):
                if boxed {
                    buffer.appendInt32(-141948557)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.communityId, buffer: buffer, boxed: false)
                _data.notifySettings.serialize(buffer, true)
                break
            case .dialogFolder(let _data):
                if boxed {
                    buffer.appendInt32(1908216652)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.folder.serialize(buffer, true)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.topMessage, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadMutedPeersCount, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadUnmutedPeersCount, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadMutedMessagesCount, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadUnmutedMessagesCount, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_dialog(_ reader: BufferReader) -> Dialog? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: Int32?
            _7 = reader.readInt32()
            var _8: Int32?
            _8 = reader.readInt32()
            var _9: Int32?
            _9 = reader.readInt32()
            var _10: Api.PeerNotifySettings?
            if let signature = reader.readInt32() {
                _10 = Api.parse(reader, signature: signature) as? Api.PeerNotifySettings
            }
            var _11: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _11 = reader.readInt32()
            }
            var _12: Api.DraftMessage?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _12 = Api.parse(reader, signature: signature) as? Api.DraftMessage
                }
            }
            var _13: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _13 = reader.readInt32()
            }
            var _14: Int32?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _14 = reader.readInt32()
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
            let _c10 = _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _13 != nil
            let _c14 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _14 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 {
                return Api.Dialog.dialog(Cons_dialog(flags: _1!, peer: _2!, topMessage: _3!, readInboxMaxId: _4!, readOutboxMaxId: _5!, unreadCount: _6!, unreadMentionsCount: _7!, unreadReactionsCount: _8!, unreadPollVotesCount: _9!, notifySettings: _10!, pts: _11, draft: _12, folderId: _13, ttlPeriod: _14))
            }
            else {
                return nil
            }
        }
        static func parse_dialogCommunity(_ reader: BufferReader) -> Dialog? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.PeerNotifySettings?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.PeerNotifySettings
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Dialog.dialogCommunity(Cons_dialogCommunity(flags: _1!, communityId: _2!, notifySettings: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_dialogFolder(_ reader: BufferReader) -> Dialog? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Folder?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Folder
            }
            var _3: Api.Peer?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: Int32?
            _7 = reader.readInt32()
            var _8: Int32?
            _8 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.Dialog.dialogFolder(Cons_dialogFolder(flags: _1!, folder: _2!, peer: _3!, topMessage: _4!, unreadMutedPeersCount: _5!, unreadUnmutedPeersCount: _6!, unreadMutedMessagesCount: _7!, unreadUnmutedMessagesCount: _8!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum DialogFilter: TypeConstructorDescription {
        class Cons_dialogFilter: TypeConstructorDescription {
            var flags: Int32
            var id: Int32
            var title: Api.TextWithEntities
            var emoticon: String?
            var color: Int32?
            var pinnedPeers: [Api.InputPeer]
            var includePeers: [Api.InputPeer]
            var excludePeers: [Api.InputPeer]
            init(flags: Int32, id: Int32, title: Api.TextWithEntities, emoticon: String?, color: Int32?, pinnedPeers: [Api.InputPeer], includePeers: [Api.InputPeer], excludePeers: [Api.InputPeer]) {
                self.flags = flags
                self.id = id
                self.title = title
                self.emoticon = emoticon
                self.color = color
                self.pinnedPeers = pinnedPeers
                self.includePeers = includePeers
                self.excludePeers = excludePeers
            }
        }
        class Cons_dialogFilterChatlist: TypeConstructorDescription {
            var flags: Int32
            var id: Int32
            var title: Api.TextWithEntities
            var emoticon: String?
            var color: Int32?
            var pinnedPeers: [Api.InputPeer]
            var includePeers: [Api.InputPeer]
            init(flags: Int32, id: Int32, title: Api.TextWithEntities, emoticon: String?, color: Int32?, pinnedPeers: [Api.InputPeer], includePeers: [Api.InputPeer]) {
                self.flags = flags
                self.id = id
                self.title = title
                self.emoticon = emoticon
                self.color = color
                self.pinnedPeers = pinnedPeers
                self.includePeers = includePeers
            }
        }
        case dialogFilter(Cons_dialogFilter)
        case dialogFilterChatlist(Cons_dialogFilterChatlist)
        case dialogFilterDefault

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .dialogFilter(let _data):
                if boxed {
                    buffer.appendInt32(-1438177711)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                _data.title.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 25) != 0 {
                    serializeString(_data.emoticon!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 27) != 0 {
                    serializeInt32(_data.color!, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.pinnedPeers.count))
                for item in _data.pinnedPeers {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.includePeers.count))
                for item in _data.includePeers {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.excludePeers.count))
                for item in _data.excludePeers {
                    item.serialize(buffer, true)
                }
                break
            case .dialogFilterChatlist(let _data):
                if boxed {
                    buffer.appendInt32(-1772913705)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                _data.title.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 25) != 0 {
                    serializeString(_data.emoticon!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 27) != 0 {
                    serializeInt32(_data.color!, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.pinnedPeers.count))
                for item in _data.pinnedPeers {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.includePeers.count))
                for item in _data.includePeers {
                    item.serialize(buffer, true)
                }
                break
            case .dialogFilterDefault:
                if boxed {
                    buffer.appendInt32(909284270)
                }
                break
            }
        }

        static func parse_dialogFilter(_ reader: BufferReader) -> DialogFilter? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.TextWithEntities?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 25) != 0 {
                _4 = parseString(reader)
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 27) != 0 {
                _5 = reader.readInt32()
            }
            var _6: [Api.InputPeer]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.InputPeer.self)
            }
            var _7: [Api.InputPeer]?
            if let _ = reader.readInt32() {
                _7 = Api.parseVector(reader, elementSignature: 0, elementType: Api.InputPeer.self)
            }
            var _8: [Api.InputPeer]?
            if let _ = reader.readInt32() {
                _8 = Api.parseVector(reader, elementSignature: 0, elementType: Api.InputPeer.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 25) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 27) == 0) || _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.DialogFilter.dialogFilter(Cons_dialogFilter(flags: _1!, id: _2!, title: _3!, emoticon: _4, color: _5, pinnedPeers: _6!, includePeers: _7!, excludePeers: _8!))
            }
            else {
                return nil
            }
        }
        static func parse_dialogFilterChatlist(_ reader: BufferReader) -> DialogFilter? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.TextWithEntities?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 25) != 0 {
                _4 = parseString(reader)
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 27) != 0 {
                _5 = reader.readInt32()
            }
            var _6: [Api.InputPeer]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.InputPeer.self)
            }
            var _7: [Api.InputPeer]?
            if let _ = reader.readInt32() {
                _7 = Api.parseVector(reader, elementSignature: 0, elementType: Api.InputPeer.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 25) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 27) == 0) || _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.DialogFilter.dialogFilterChatlist(Cons_dialogFilterChatlist(flags: _1!, id: _2!, title: _3!, emoticon: _4, color: _5, pinnedPeers: _6!, includePeers: _7!))
            }
            else {
                return nil
            }
        }
        static func parse_dialogFilterDefault(_ reader: BufferReader) -> DialogFilter? {
            return Api.DialogFilter.dialogFilterDefault
        }
    }
}
extension Api {
    enum DialogPeer: TypeConstructorDescription {
        class Cons_dialogPeer: TypeConstructorDescription {
            var peer: Api.Peer
            init(peer: Api.Peer) {
                self.peer = peer
            }
        }
        class Cons_dialogPeerCommunity: TypeConstructorDescription {
            var communityId: Int64
            init(communityId: Int64) {
                self.communityId = communityId
            }
        }
        class Cons_dialogPeerFolder: TypeConstructorDescription {
            var folderId: Int32
            init(folderId: Int32) {
                self.folderId = folderId
            }
        }
        case dialogPeer(Cons_dialogPeer)
        case dialogPeerCommunity(Cons_dialogPeerCommunity)
        case dialogPeerFolder(Cons_dialogPeerFolder)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .dialogPeer(let _data):
                if boxed {
                    buffer.appendInt32(-445792507)
                }
                _data.peer.serialize(buffer, true)
                break
            case .dialogPeerCommunity(let _data):
                if boxed {
                    buffer.appendInt32(795199716)
                }
                serializeInt64(_data.communityId, buffer: buffer, boxed: false)
                break
            case .dialogPeerFolder(let _data):
                if boxed {
                    buffer.appendInt32(1363483106)
                }
                serializeInt32(_data.folderId, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_dialogPeer(_ reader: BufferReader) -> DialogPeer? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.DialogPeer.dialogPeer(Cons_dialogPeer(peer: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_dialogPeerCommunity(_ reader: BufferReader) -> DialogPeer? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.DialogPeer.dialogPeerCommunity(Cons_dialogPeerCommunity(communityId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_dialogPeerFolder(_ reader: BufferReader) -> DialogPeer? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.DialogPeer.dialogPeerFolder(Cons_dialogPeerFolder(folderId: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum DisallowedGiftsSettings: TypeConstructorDescription {
        class Cons_disallowedGiftsSettings: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        case disallowedGiftsSettings(Cons_disallowedGiftsSettings)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .disallowedGiftsSettings(let _data):
                if boxed {
                    buffer.appendInt32(1911715524)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_disallowedGiftsSettings(_ reader: BufferReader) -> DisallowedGiftsSettings? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.DisallowedGiftsSettings.disallowedGiftsSettings(Cons_disallowedGiftsSettings(flags: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum Document: TypeConstructorDescription {
        class Cons_document: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var accessHash: Int64
            var fileReference: Buffer
            var date: Int32
            var mimeType: String
            var size: Int64
            var thumbs: [Api.PhotoSize]?
            var videoThumbs: [Api.VideoSize]?
            var dcId: Int32
            var attributes: [Api.DocumentAttribute]
            init(flags: Int32, id: Int64, accessHash: Int64, fileReference: Buffer, date: Int32, mimeType: String, size: Int64, thumbs: [Api.PhotoSize]?, videoThumbs: [Api.VideoSize]?, dcId: Int32, attributes: [Api.DocumentAttribute]) {
                self.flags = flags
                self.id = id
                self.accessHash = accessHash
                self.fileReference = fileReference
                self.date = date
                self.mimeType = mimeType
                self.size = size
                self.thumbs = thumbs
                self.videoThumbs = videoThumbs
                self.dcId = dcId
                self.attributes = attributes
            }
        }
        class Cons_documentEmpty: TypeConstructorDescription {
            var id: Int64
            init(id: Int64) {
                self.id = id
            }
        }
        case document(Cons_document)
        case documentEmpty(Cons_documentEmpty)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .document(let _data):
                if boxed {
                    buffer.appendInt32(-1881881384)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeBytes(_data.fileReference, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeString(_data.mimeType, buffer: buffer, boxed: false)
                serializeInt64(_data.size, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.thumbs!.count))
                    for item in _data.thumbs! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.videoThumbs!.count))
                    for item in _data.videoThumbs! {
                        item.serialize(buffer, true)
                    }
                }
                serializeInt32(_data.dcId, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.attributes.count))
                for item in _data.attributes {
                    item.serialize(buffer, true)
                }
                break
            case .documentEmpty(let _data):
                if boxed {
                    buffer.appendInt32(922273905)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_document(_ reader: BufferReader) -> Document? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Buffer?
            _4 = parseBytes(reader)
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: String?
            _6 = parseString(reader)
            var _7: Int64?
            _7 = reader.readInt64()
            var _8: [Api.PhotoSize]?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _8 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PhotoSize.self)
                }
            }
            var _9: [Api.VideoSize]?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let _ = reader.readInt32() {
                    _9 = Api.parseVector(reader, elementSignature: 0, elementType: Api.VideoSize.self)
                }
            }
            var _10: Int32?
            _10 = reader.readInt32()
            var _11: [Api.DocumentAttribute]?
            if let _ = reader.readInt32() {
                _11 = Api.parseVector(reader, elementSignature: 0, elementType: Api.DocumentAttribute.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _9 != nil
            let _c10 = _10 != nil
            let _c11 = _11 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 {
                return Api.Document.document(Cons_document(flags: _1!, id: _2!, accessHash: _3!, fileReference: _4!, date: _5!, mimeType: _6!, size: _7!, thumbs: _8, videoThumbs: _9, dcId: _10!, attributes: _11!))
            }
            else {
                return nil
            }
        }
        static func parse_documentEmpty(_ reader: BufferReader) -> Document? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.Document.documentEmpty(Cons_documentEmpty(id: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum DocumentAttribute: TypeConstructorDescription {
        class Cons_documentAttributeAudio: TypeConstructorDescription {
            var flags: Int32
            var duration: Int32
            var title: String?
            var performer: String?
            var waveform: Buffer?
            init(flags: Int32, duration: Int32, title: String?, performer: String?, waveform: Buffer?) {
                self.flags = flags
                self.duration = duration
                self.title = title
                self.performer = performer
                self.waveform = waveform
            }
        }
        class Cons_documentAttributeCustomEmoji: TypeConstructorDescription {
            var flags: Int32
            var alt: String
            var stickerset: Api.InputStickerSet
            init(flags: Int32, alt: String, stickerset: Api.InputStickerSet) {
                self.flags = flags
                self.alt = alt
                self.stickerset = stickerset
            }
        }
        class Cons_documentAttributeFilename: TypeConstructorDescription {
            var fileName: String
            init(fileName: String) {
                self.fileName = fileName
            }
        }
        class Cons_documentAttributeImageSize: TypeConstructorDescription {
            var w: Int32
            var h: Int32
            init(w: Int32, h: Int32) {
                self.w = w
                self.h = h
            }
        }
        class Cons_documentAttributeSticker: TypeConstructorDescription {
            var flags: Int32
            var alt: String
            var stickerset: Api.InputStickerSet
            var maskCoords: Api.MaskCoords?
            init(flags: Int32, alt: String, stickerset: Api.InputStickerSet, maskCoords: Api.MaskCoords?) {
                self.flags = flags
                self.alt = alt
                self.stickerset = stickerset
                self.maskCoords = maskCoords
            }
        }
        class Cons_documentAttributeVideo: TypeConstructorDescription {
            var flags: Int32
            var duration: Double
            var w: Int32
            var h: Int32
            var preloadPrefixSize: Int32?
            var videoStartTs: Double?
            var videoCodec: String?
            init(flags: Int32, duration: Double, w: Int32, h: Int32, preloadPrefixSize: Int32?, videoStartTs: Double?, videoCodec: String?) {
                self.flags = flags
                self.duration = duration
                self.w = w
                self.h = h
                self.preloadPrefixSize = preloadPrefixSize
                self.videoStartTs = videoStartTs
                self.videoCodec = videoCodec
            }
        }
        case documentAttributeAnimated
        case documentAttributeAudio(Cons_documentAttributeAudio)
        case documentAttributeCustomEmoji(Cons_documentAttributeCustomEmoji)
        case documentAttributeFilename(Cons_documentAttributeFilename)
        case documentAttributeHasStickers
        case documentAttributeImageSize(Cons_documentAttributeImageSize)
        case documentAttributeSticker(Cons_documentAttributeSticker)
        case documentAttributeVideo(Cons_documentAttributeVideo)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .documentAttributeAnimated:
                if boxed {
                    buffer.appendInt32(297109817)
                }
                break
            case .documentAttributeAudio(let _data):
                if boxed {
                    buffer.appendInt32(-1739392570)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.duration, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.title!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.performer!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeBytes(_data.waveform!, buffer: buffer, boxed: false)
                }
                break
            case .documentAttributeCustomEmoji(let _data):
                if boxed {
                    buffer.appendInt32(-48981863)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.alt, buffer: buffer, boxed: false)
                _data.stickerset.serialize(buffer, true)
                break
            case .documentAttributeFilename(let _data):
                if boxed {
                    buffer.appendInt32(358154344)
                }
                serializeString(_data.fileName, buffer: buffer, boxed: false)
                break
            case .documentAttributeHasStickers:
                if boxed {
                    buffer.appendInt32(-1744710921)
                }
                break
            case .documentAttributeImageSize(let _data):
                if boxed {
                    buffer.appendInt32(1815593308)
                }
                serializeInt32(_data.w, buffer: buffer, boxed: false)
                serializeInt32(_data.h, buffer: buffer, boxed: false)
                break
            case .documentAttributeSticker(let _data):
                if boxed {
                    buffer.appendInt32(1662637586)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.alt, buffer: buffer, boxed: false)
                _data.stickerset.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.maskCoords!.serialize(buffer, true)
                }
                break
            case .documentAttributeVideo(let _data):
                if boxed {
                    buffer.appendInt32(1137015880)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeDouble(_data.duration, buffer: buffer, boxed: false)
                serializeInt32(_data.w, buffer: buffer, boxed: false)
                serializeInt32(_data.h, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.preloadPrefixSize!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeDouble(_data.videoStartTs!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeString(_data.videoCodec!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_documentAttributeAnimated(_ reader: BufferReader) -> DocumentAttribute? {
            return Api.DocumentAttribute.documentAttributeAnimated
        }
        static func parse_documentAttributeAudio(_ reader: BufferReader) -> DocumentAttribute? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = parseString(reader)
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _4 = parseString(reader)
            }
            var _5: Buffer?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _5 = parseBytes(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.DocumentAttribute.documentAttributeAudio(Cons_documentAttributeAudio(flags: _1!, duration: _2!, title: _3, performer: _4, waveform: _5))
            }
            else {
                return nil
            }
        }
        static func parse_documentAttributeCustomEmoji(_ reader: BufferReader) -> DocumentAttribute? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Api.InputStickerSet?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.InputStickerSet
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.DocumentAttribute.documentAttributeCustomEmoji(Cons_documentAttributeCustomEmoji(flags: _1!, alt: _2!, stickerset: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_documentAttributeFilename(_ reader: BufferReader) -> DocumentAttribute? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.DocumentAttribute.documentAttributeFilename(Cons_documentAttributeFilename(fileName: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_documentAttributeHasStickers(_ reader: BufferReader) -> DocumentAttribute? {
            return Api.DocumentAttribute.documentAttributeHasStickers
        }
        static func parse_documentAttributeImageSize(_ reader: BufferReader) -> DocumentAttribute? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.DocumentAttribute.documentAttributeImageSize(Cons_documentAttributeImageSize(w: _1!, h: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_documentAttributeSticker(_ reader: BufferReader) -> DocumentAttribute? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Api.InputStickerSet?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.InputStickerSet
            }
            var _4: Api.MaskCoords?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.MaskCoords
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.DocumentAttribute.documentAttributeSticker(Cons_documentAttributeSticker(flags: _1!, alt: _2!, stickerset: _3!, maskCoords: _4))
            }
            else {
                return nil
            }
        }
        static func parse_documentAttributeVideo(_ reader: BufferReader) -> DocumentAttribute? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Double?
            _2 = reader.readDouble()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _5 = reader.readInt32()
            }
            var _6: Double?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _6 = reader.readDouble()
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _7 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.DocumentAttribute.documentAttributeVideo(Cons_documentAttributeVideo(flags: _1!, duration: _2!, w: _3!, h: _4!, preloadPrefixSize: _5, videoStartTs: _6, videoCodec: _7))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum DraftMessage: TypeConstructorDescription {
        class Cons_draftMessage: TypeConstructorDescription {
            var flags: Int32
            var replyTo: Api.InputReplyTo?
            var message: String
            var entities: [Api.MessageEntity]?
            var media: Api.InputMedia?
            var date: Int32
            var effect: Int64?
            var suggestedPost: Api.SuggestedPost?
            var richMessage: Api.RichMessage?
            init(flags: Int32, replyTo: Api.InputReplyTo?, message: String, entities: [Api.MessageEntity]?, media: Api.InputMedia?, date: Int32, effect: Int64?, suggestedPost: Api.SuggestedPost?, richMessage: Api.RichMessage?) {
                self.flags = flags
                self.replyTo = replyTo
                self.message = message
                self.entities = entities
                self.media = media
                self.date = date
                self.effect = effect
                self.suggestedPost = suggestedPost
                self.richMessage = richMessage
            }
        }
        class Cons_draftMessageEmpty: TypeConstructorDescription {
            var flags: Int32
            var date: Int32?
            init(flags: Int32, date: Int32?) {
                self.flags = flags
                self.date = date
            }
        }
        case draftMessage(Cons_draftMessage)
        case draftMessageEmpty(Cons_draftMessageEmpty)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .draftMessage(let _data):
                if boxed {
                    buffer.appendInt32(1627271828)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    _data.replyTo!.serialize(buffer, true)
                }
                serializeString(_data.message, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.entities!.count))
                    for item in _data.entities! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    _data.media!.serialize(buffer, true)
                }
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    serializeInt64(_data.effect!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    _data.suggestedPost!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    _data.richMessage!.serialize(buffer, true)
                }
                break
            case .draftMessageEmpty(let _data):
                if boxed {
                    buffer.appendInt32(453805082)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.date!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_draftMessage(_ reader: BufferReader) -> DraftMessage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.InputReplyTo?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.InputReplyTo
                }
            }
            var _3: String?
            _3 = parseString(reader)
            var _4: [Api.MessageEntity]?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let _ = reader.readInt32() {
                    _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self)
                }
            }
            var _5: Api.InputMedia?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.InputMedia
                }
            }
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: Int64?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                _7 = reader.readInt64()
            }
            var _8: Api.SuggestedPost?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.SuggestedPost
                }
            }
            var _9: Api.RichMessage?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.RichMessage
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.DraftMessage.draftMessage(Cons_draftMessage(flags: _1!, replyTo: _2, message: _3!, entities: _4, media: _5, date: _6!, effect: _7, suggestedPost: _8, richMessage: _9))
            }
            else {
                return nil
            }
        }
        static func parse_draftMessageEmpty(_ reader: BufferReader) -> DraftMessage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            if _c1 && _c2 {
                return Api.DraftMessage.draftMessageEmpty(Cons_draftMessageEmpty(flags: _1!, date: _2))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum EmojiStatus: TypeConstructorDescription {
        class Cons_emojiStatus: TypeConstructorDescription {
            var flags: Int32
            var documentId: Int64
            var until: Int32?
            init(flags: Int32, documentId: Int64, until: Int32?) {
                self.flags = flags
                self.documentId = documentId
                self.until = until
            }
        }
        class Cons_emojiStatusCollectible: TypeConstructorDescription {
            var flags: Int32
            var collectibleId: Int64
            var documentId: Int64
            var title: String
            var slug: String
            var patternDocumentId: Int64
            var centerColor: Int32
            var edgeColor: Int32
            var patternColor: Int32
            var textColor: Int32
            var until: Int32?
            init(flags: Int32, collectibleId: Int64, documentId: Int64, title: String, slug: String, patternDocumentId: Int64, centerColor: Int32, edgeColor: Int32, patternColor: Int32, textColor: Int32, until: Int32?) {
                self.flags = flags
                self.collectibleId = collectibleId
                self.documentId = documentId
                self.title = title
                self.slug = slug
                self.patternDocumentId = patternDocumentId
                self.centerColor = centerColor
                self.edgeColor = edgeColor
                self.patternColor = patternColor
                self.textColor = textColor
                self.until = until
            }
        }
        class Cons_inputEmojiStatusCollectible: TypeConstructorDescription {
            var flags: Int32
            var collectibleId: Int64
            var until: Int32?
            init(flags: Int32, collectibleId: Int64, until: Int32?) {
                self.flags = flags
                self.collectibleId = collectibleId
                self.until = until
            }
        }
        case emojiStatus(Cons_emojiStatus)
        case emojiStatusCollectible(Cons_emojiStatusCollectible)
        case emojiStatusEmpty
        case inputEmojiStatusCollectible(Cons_inputEmojiStatusCollectible)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .emojiStatus(let _data):
                if boxed {
                    buffer.appendInt32(-402717046)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.documentId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.until!, buffer: buffer, boxed: false)
                }
                break
            case .emojiStatusCollectible(let _data):
                if boxed {
                    buffer.appendInt32(1904500795)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.collectibleId, buffer: buffer, boxed: false)
                serializeInt64(_data.documentId, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeString(_data.slug, buffer: buffer, boxed: false)
                serializeInt64(_data.patternDocumentId, buffer: buffer, boxed: false)
                serializeInt32(_data.centerColor, buffer: buffer, boxed: false)
                serializeInt32(_data.edgeColor, buffer: buffer, boxed: false)
                serializeInt32(_data.patternColor, buffer: buffer, boxed: false)
                serializeInt32(_data.textColor, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.until!, buffer: buffer, boxed: false)
                }
                break
            case .emojiStatusEmpty:
                if boxed {
                    buffer.appendInt32(769727150)
                }
                break
            case .inputEmojiStatusCollectible(let _data):
                if boxed {
                    buffer.appendInt32(118758847)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.collectibleId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.until!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_emojiStatus(_ reader: BufferReader) -> EmojiStatus? {
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
                return Api.EmojiStatus.emojiStatus(Cons_emojiStatus(flags: _1!, documentId: _2!, until: _3))
            }
            else {
                return nil
            }
        }
        static func parse_emojiStatusCollectible(_ reader: BufferReader) -> EmojiStatus? {
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
            var _6: Int64?
            _6 = reader.readInt64()
            var _7: Int32?
            _7 = reader.readInt32()
            var _8: Int32?
            _8 = reader.readInt32()
            var _9: Int32?
            _9 = reader.readInt32()
            var _10: Int32?
            _10 = reader.readInt32()
            var _11: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _11 = reader.readInt32()
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
            let _c10 = _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _11 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 {
                return Api.EmojiStatus.emojiStatusCollectible(Cons_emojiStatusCollectible(flags: _1!, collectibleId: _2!, documentId: _3!, title: _4!, slug: _5!, patternDocumentId: _6!, centerColor: _7!, edgeColor: _8!, patternColor: _9!, textColor: _10!, until: _11))
            }
            else {
                return nil
            }
        }
        static func parse_emojiStatusEmpty(_ reader: BufferReader) -> EmojiStatus? {
            return Api.EmojiStatus.emojiStatusEmpty
        }
        static func parse_inputEmojiStatusCollectible(_ reader: BufferReader) -> EmojiStatus? {
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
                return Api.EmojiStatus.inputEmojiStatusCollectible(Cons_inputEmojiStatusCollectible(flags: _1!, collectibleId: _2!, until: _3))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum EncryptedChat: TypeConstructorDescription {
        class Cons_encryptedChat: TypeConstructorDescription {
            var id: Int32
            var accessHash: Int64
            var date: Int32
            var adminId: Int64
            var participantId: Int64
            var gAOrB: Buffer
            var keyFingerprint: Int64
            init(id: Int32, accessHash: Int64, date: Int32, adminId: Int64, participantId: Int64, gAOrB: Buffer, keyFingerprint: Int64) {
                self.id = id
                self.accessHash = accessHash
                self.date = date
                self.adminId = adminId
                self.participantId = participantId
                self.gAOrB = gAOrB
                self.keyFingerprint = keyFingerprint
            }
        }
        class Cons_encryptedChatDiscarded: TypeConstructorDescription {
            var flags: Int32
            var id: Int32
            init(flags: Int32, id: Int32) {
                self.flags = flags
                self.id = id
            }
        }
        class Cons_encryptedChatEmpty: TypeConstructorDescription {
            var id: Int32
            init(id: Int32) {
                self.id = id
            }
        }
        class Cons_encryptedChatRequested: TypeConstructorDescription {
            var flags: Int32
            var folderId: Int32?
            var id: Int32
            var accessHash: Int64
            var date: Int32
            var adminId: Int64
            var participantId: Int64
            var gA: Buffer
            init(flags: Int32, folderId: Int32?, id: Int32, accessHash: Int64, date: Int32, adminId: Int64, participantId: Int64, gA: Buffer) {
                self.flags = flags
                self.folderId = folderId
                self.id = id
                self.accessHash = accessHash
                self.date = date
                self.adminId = adminId
                self.participantId = participantId
                self.gA = gA
            }
        }
        class Cons_encryptedChatWaiting: TypeConstructorDescription {
            var id: Int32
            var accessHash: Int64
            var date: Int32
            var adminId: Int64
            var participantId: Int64
            init(id: Int32, accessHash: Int64, date: Int32, adminId: Int64, participantId: Int64) {
                self.id = id
                self.accessHash = accessHash
                self.date = date
                self.adminId = adminId
                self.participantId = participantId
            }
        }
        case encryptedChat(Cons_encryptedChat)
        case encryptedChatDiscarded(Cons_encryptedChatDiscarded)
        case encryptedChatEmpty(Cons_encryptedChatEmpty)
        case encryptedChatRequested(Cons_encryptedChatRequested)
        case encryptedChatWaiting(Cons_encryptedChatWaiting)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .encryptedChat(let _data):
                if boxed {
                    buffer.appendInt32(1643173063)
                }
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt64(_data.adminId, buffer: buffer, boxed: false)
                serializeInt64(_data.participantId, buffer: buffer, boxed: false)
                serializeBytes(_data.gAOrB, buffer: buffer, boxed: false)
                serializeInt64(_data.keyFingerprint, buffer: buffer, boxed: false)
                break
            case .encryptedChatDiscarded(let _data):
                if boxed {
                    buffer.appendInt32(505183301)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                break
            case .encryptedChatEmpty(let _data):
                if boxed {
                    buffer.appendInt32(-1417756512)
                }
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                break
            case .encryptedChatRequested(let _data):
                if boxed {
                    buffer.appendInt32(1223809356)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.folderId!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt64(_data.adminId, buffer: buffer, boxed: false)
                serializeInt64(_data.participantId, buffer: buffer, boxed: false)
                serializeBytes(_data.gA, buffer: buffer, boxed: false)
                break
            case .encryptedChatWaiting(let _data):
                if boxed {
                    buffer.appendInt32(1722964307)
                }
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt64(_data.adminId, buffer: buffer, boxed: false)
                serializeInt64(_data.participantId, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_encryptedChat(_ reader: BufferReader) -> EncryptedChat? {
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
            var _6: Buffer?
            _6 = parseBytes(reader)
            var _7: Int64?
            _7 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.EncryptedChat.encryptedChat(Cons_encryptedChat(id: _1!, accessHash: _2!, date: _3!, adminId: _4!, participantId: _5!, gAOrB: _6!, keyFingerprint: _7!))
            }
            else {
                return nil
            }
        }
        static func parse_encryptedChatDiscarded(_ reader: BufferReader) -> EncryptedChat? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.EncryptedChat.encryptedChatDiscarded(Cons_encryptedChatDiscarded(flags: _1!, id: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_encryptedChatEmpty(_ reader: BufferReader) -> EncryptedChat? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.EncryptedChat.encryptedChatEmpty(Cons_encryptedChatEmpty(id: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_encryptedChatRequested(_ reader: BufferReader) -> EncryptedChat? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt32()
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int64?
            _6 = reader.readInt64()
            var _7: Int64?
            _7 = reader.readInt64()
            var _8: Buffer?
            _8 = parseBytes(reader)
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.EncryptedChat.encryptedChatRequested(Cons_encryptedChatRequested(flags: _1!, folderId: _2, id: _3!, accessHash: _4!, date: _5!, adminId: _6!, participantId: _7!, gA: _8!))
            }
            else {
                return nil
            }
        }
        static func parse_encryptedChatWaiting(_ reader: BufferReader) -> EncryptedChat? {
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
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.EncryptedChat.encryptedChatWaiting(Cons_encryptedChatWaiting(id: _1!, accessHash: _2!, date: _3!, adminId: _4!, participantId: _5!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum EncryptedFile: TypeConstructorDescription {
        class Cons_encryptedFile: TypeConstructorDescription {
            var id: Int64
            var accessHash: Int64
            var size: Int64
            var dcId: Int32
            var keyFingerprint: Int32
            init(id: Int64, accessHash: Int64, size: Int64, dcId: Int32, keyFingerprint: Int32) {
                self.id = id
                self.accessHash = accessHash
                self.size = size
                self.dcId = dcId
                self.keyFingerprint = keyFingerprint
            }
        }
        case encryptedFile(Cons_encryptedFile)
        case encryptedFileEmpty

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .encryptedFile(let _data):
                if boxed {
                    buffer.appendInt32(-1476358952)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeInt64(_data.size, buffer: buffer, boxed: false)
                serializeInt32(_data.dcId, buffer: buffer, boxed: false)
                serializeInt32(_data.keyFingerprint, buffer: buffer, boxed: false)
                break
            case .encryptedFileEmpty:
                if boxed {
                    buffer.appendInt32(-1038136962)
                }
                break
            }
        }

        static func parse_encryptedFile(_ reader: BufferReader) -> EncryptedFile? {
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
                return Api.EncryptedFile.encryptedFile(Cons_encryptedFile(id: _1!, accessHash: _2!, size: _3!, dcId: _4!, keyFingerprint: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_encryptedFileEmpty(_ reader: BufferReader) -> EncryptedFile? {
            return Api.EncryptedFile.encryptedFileEmpty
        }
    }
}
extension Api {
    enum EncryptedMessage: TypeConstructorDescription {
        class Cons_encryptedMessage: TypeConstructorDescription {
            var randomId: Int64
            var chatId: Int32
            var date: Int32
            var bytes: Buffer
            var file: Api.EncryptedFile
            init(randomId: Int64, chatId: Int32, date: Int32, bytes: Buffer, file: Api.EncryptedFile) {
                self.randomId = randomId
                self.chatId = chatId
                self.date = date
                self.bytes = bytes
                self.file = file
            }
        }
        class Cons_encryptedMessageService: TypeConstructorDescription {
            var randomId: Int64
            var chatId: Int32
            var date: Int32
            var bytes: Buffer
            init(randomId: Int64, chatId: Int32, date: Int32, bytes: Buffer) {
                self.randomId = randomId
                self.chatId = chatId
                self.date = date
                self.bytes = bytes
            }
        }
        case encryptedMessage(Cons_encryptedMessage)
        case encryptedMessageService(Cons_encryptedMessageService)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .encryptedMessage(let _data):
                if boxed {
                    buffer.appendInt32(-317144808)
                }
                serializeInt64(_data.randomId, buffer: buffer, boxed: false)
                serializeInt32(_data.chatId, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeBytes(_data.bytes, buffer: buffer, boxed: false)
                _data.file.serialize(buffer, true)
                break
            case .encryptedMessageService(let _data):
                if boxed {
                    buffer.appendInt32(594758406)
                }
                serializeInt64(_data.randomId, buffer: buffer, boxed: false)
                serializeInt32(_data.chatId, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeBytes(_data.bytes, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_encryptedMessage(_ reader: BufferReader) -> EncryptedMessage? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Buffer?
            _4 = parseBytes(reader)
            var _5: Api.EncryptedFile?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.EncryptedFile
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.EncryptedMessage.encryptedMessage(Cons_encryptedMessage(randomId: _1!, chatId: _2!, date: _3!, bytes: _4!, file: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_encryptedMessageService(_ reader: BufferReader) -> EncryptedMessage? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Buffer?
            _4 = parseBytes(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.EncryptedMessage.encryptedMessageService(Cons_encryptedMessageService(randomId: _1!, chatId: _2!, date: _3!, bytes: _4!))
            }
            else {
                return nil
            }
        }
    }
}
