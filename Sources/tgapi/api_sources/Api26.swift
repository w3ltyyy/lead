extension Api.contacts {
    enum SponsoredPeers: TypeConstructorDescription {
        class Cons_sponsoredPeers: TypeConstructorDescription {
            var peers: [Api.SponsoredPeer]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(peers: [Api.SponsoredPeer], chats: [Api.Chat], users: [Api.User]) {
                self.peers = peers
                self.chats = chats
                self.users = users
            }
        }
        case sponsoredPeers(Cons_sponsoredPeers)
        case sponsoredPeersEmpty

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .sponsoredPeers(let _data):
                if boxed {
                    buffer.appendInt32(-352114556)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.peers.count))
                for item in _data.peers {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                break
            case .sponsoredPeersEmpty:
                if boxed {
                    buffer.appendInt32(-365775695)
                }
                break
            }
        }

        static func parse_sponsoredPeers(_ reader: BufferReader) -> SponsoredPeers? {
            var _1: [Api.SponsoredPeer]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.SponsoredPeer.self)
            }
            var _2: [Api.Chat]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _3: [Api.User]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.contacts.SponsoredPeers.sponsoredPeers(Cons_sponsoredPeers(peers: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_sponsoredPeersEmpty(_ reader: BufferReader) -> SponsoredPeers? {
            return Api.contacts.SponsoredPeers.sponsoredPeersEmpty
        }
    }
}
extension Api.contacts {
    enum TopPeers: TypeConstructorDescription {
        class Cons_topPeers: TypeConstructorDescription {
            var categories: [Api.TopPeerCategoryPeers]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(categories: [Api.TopPeerCategoryPeers], chats: [Api.Chat], users: [Api.User]) {
                self.categories = categories
                self.chats = chats
                self.users = users
            }
        }
        case topPeers(Cons_topPeers)
        case topPeersDisabled
        case topPeersNotModified

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .topPeers(let _data):
                if boxed {
                    buffer.appendInt32(1891070632)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.categories.count))
                for item in _data.categories {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                break
            case .topPeersDisabled:
                if boxed {
                    buffer.appendInt32(-1255369827)
                }
                break
            case .topPeersNotModified:
                if boxed {
                    buffer.appendInt32(-567906571)
                }
                break
            }
        }

        static func parse_topPeers(_ reader: BufferReader) -> TopPeers? {
            var _1: [Api.TopPeerCategoryPeers]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.TopPeerCategoryPeers.self)
            }
            var _2: [Api.Chat]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _3: [Api.User]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.contacts.TopPeers.topPeers(Cons_topPeers(categories: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_topPeersDisabled(_ reader: BufferReader) -> TopPeers? {
            return Api.contacts.TopPeers.topPeersDisabled
        }
        static func parse_topPeersNotModified(_ reader: BufferReader) -> TopPeers? {
            return Api.contacts.TopPeers.topPeersNotModified
        }
    }
}
extension Api.help {
    enum PromoData: TypeConstructorDescription {
        class Cons_promoData: TypeConstructorDescription {
            var flags: Int32
            var expires: Int32
            var peer: Api.Peer?
            var psaType: String?
            var psaMessage: String?
            var pendingSuggestions: [String]
            var dismissedSuggestions: [String]
            var customPendingSuggestion: Api.PendingSuggestion?
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, expires: Int32, peer: Api.Peer?, psaType: String?, psaMessage: String?, pendingSuggestions: [String], dismissedSuggestions: [String], customPendingSuggestion: Api.PendingSuggestion?, chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.expires = expires
                self.peer = peer
                self.psaType = psaType
                self.psaMessage = psaMessage
                self.pendingSuggestions = pendingSuggestions
                self.dismissedSuggestions = dismissedSuggestions
                self.customPendingSuggestion = customPendingSuggestion
                self.chats = chats
                self.users = users
            }
        }
        class Cons_promoDataEmpty: TypeConstructorDescription {
            var expires: Int32
            init(expires: Int32) {
                self.expires = expires
            }
        }
        case promoData(Cons_promoData)
        case promoDataEmpty(Cons_promoDataEmpty)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .promoData(let _data):
                if boxed {
                    buffer.appendInt32(145021050)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.expires, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.peer!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.psaType!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.psaMessage!, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.pendingSuggestions.count))
                for item in _data.pendingSuggestions {
                    serializeString(item, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.dismissedSuggestions.count))
                for item in _data.dismissedSuggestions {
                    serializeString(item, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    _data.customPendingSuggestion!.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                break
            case .promoDataEmpty(let _data):
                if boxed {
                    buffer.appendInt32(-1728664459)
                }
                serializeInt32(_data.expires, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_promoData(_ reader: BufferReader) -> PromoData? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _4 = parseString(reader)
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _5 = parseString(reader)
            }
            var _6: [String]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: -1255641564, elementType: String.self)
            }
            var _7: [String]?
            if let _ = reader.readInt32() {
                _7 = Api.parseVector(reader, elementSignature: -1255641564, elementType: String.self)
            }
            var _8: Api.PendingSuggestion?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.PendingSuggestion
                }
            }
            var _9: [Api.Chat]?
            if let _ = reader.readInt32() {
                _9 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _10: [Api.User]?
            if let _ = reader.readInt32() {
                _10 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _8 != nil
            let _c9 = _9 != nil
            let _c10 = _10 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 {
                return Api.help.PromoData.promoData(Cons_promoData(flags: _1!, expires: _2!, peer: _3, psaType: _4, psaMessage: _5, pendingSuggestions: _6!, dismissedSuggestions: _7!, customPendingSuggestion: _8, chats: _9!, users: _10!))
            }
            else {
                return nil
            }
        }
        static func parse_promoDataEmpty(_ reader: BufferReader) -> PromoData? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.help.PromoData.promoDataEmpty(Cons_promoDataEmpty(expires: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.help {
    enum RecentMeUrls: TypeConstructorDescription {
        class Cons_recentMeUrls: TypeConstructorDescription {
            var urls: [Api.RecentMeUrl]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(urls: [Api.RecentMeUrl], chats: [Api.Chat], users: [Api.User]) {
                self.urls = urls
                self.chats = chats
                self.users = users
            }
        }
        case recentMeUrls(Cons_recentMeUrls)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .recentMeUrls(let _data):
                if boxed {
                    buffer.appendInt32(235081943)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.urls.count))
                for item in _data.urls {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_recentMeUrls(_ reader: BufferReader) -> RecentMeUrls? {
            var _1: [Api.RecentMeUrl]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.RecentMeUrl.self)
            }
            var _2: [Api.Chat]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _3: [Api.User]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.help.RecentMeUrls.recentMeUrls(Cons_recentMeUrls(urls: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.help {
    enum TermsOfService: TypeConstructorDescription {
        class Cons_termsOfService: TypeConstructorDescription {
            var flags: Int32
            var id: Api.DataJSON
            var text: String
            var entities: [Api.MessageEntity]
            var minAgeConfirm: Int32?
            init(flags: Int32, id: Api.DataJSON, text: String, entities: [Api.MessageEntity], minAgeConfirm: Int32?) {
                self.flags = flags
                self.id = id
                self.text = text
                self.entities = entities
                self.minAgeConfirm = minAgeConfirm
            }
        }
        case termsOfService(Cons_termsOfService)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .termsOfService(let _data):
                if boxed {
                    buffer.appendInt32(2013922064)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.id.serialize(buffer, true)
                serializeString(_data.text, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.entities.count))
                for item in _data.entities {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.minAgeConfirm!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_termsOfService(_ reader: BufferReader) -> TermsOfService? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.DataJSON?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.DataJSON
            }
            var _3: String?
            _3 = parseString(reader)
            var _4: [Api.MessageEntity]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self)
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _5 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.help.TermsOfService.termsOfService(Cons_termsOfService(flags: _1!, id: _2!, text: _3!, entities: _4!, minAgeConfirm: _5))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum ChatFull: TypeConstructorDescription {
        class Cons_chatFull: TypeConstructorDescription {
            var fullChat: Api.ChatFull
            var chats: [Api.Chat]
            var users: [Api.User]
            init(fullChat: Api.ChatFull, chats: [Api.Chat], users: [Api.User]) {
                self.fullChat = fullChat
                self.chats = chats
                self.users = users
            }
        }
        case chatFull(Cons_chatFull)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .chatFull(let _data):
                if boxed {
                    buffer.appendInt32(-438840932)
                }
                _data.fullChat.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_chatFull(_ reader: BufferReader) -> ChatFull? {
            var _1: Api.ChatFull?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ChatFull
            }
            var _2: [Api.Chat]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _3: [Api.User]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.messages.ChatFull.chatFull(Cons_chatFull(fullChat: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum Chats: TypeConstructorDescription {
        class Cons_chats: TypeConstructorDescription {
            var chats: [Api.Chat]
            init(chats: [Api.Chat]) {
                self.chats = chats
            }
        }
        class Cons_chatsSlice: TypeConstructorDescription {
            var count: Int32
            var chats: [Api.Chat]
            init(count: Int32, chats: [Api.Chat]) {
                self.count = count
                self.chats = chats
            }
        }
        case chats(Cons_chats)
        case chatsSlice(Cons_chatsSlice)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .chats(let _data):
                if boxed {
                    buffer.appendInt32(1694474197)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                break
            case .chatsSlice(let _data):
                if boxed {
                    buffer.appendInt32(-1663561404)
                }
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_chats(_ reader: BufferReader) -> Chats? {
            var _1: [Api.Chat]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.messages.Chats.chats(Cons_chats(chats: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_chatsSlice(_ reader: BufferReader) -> Chats? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.Chat]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.messages.Chats.chatsSlice(Cons_chatsSlice(count: _1!, chats: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum Dialogs: TypeConstructorDescription {
        class Cons_dialogs: TypeConstructorDescription {
            var dialogs: [Api.Dialog]
            var messages: [Api.Message]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(dialogs: [Api.Dialog], messages: [Api.Message], chats: [Api.Chat], users: [Api.User]) {
                self.dialogs = dialogs
                self.messages = messages
                self.chats = chats
                self.users = users
            }
        }
        class Cons_dialogsNotModified: TypeConstructorDescription {
            var count: Int32
            init(count: Int32) {
                self.count = count
            }
        }
        class Cons_dialogsSlice: TypeConstructorDescription {
            var count: Int32
            var dialogs: [Api.Dialog]
            var messages: [Api.Message]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(count: Int32, dialogs: [Api.Dialog], messages: [Api.Message], chats: [Api.Chat], users: [Api.User]) {
                self.count = count
                self.dialogs = dialogs
                self.messages = messages
                self.chats = chats
                self.users = users
            }
        }
        case dialogs(Cons_dialogs)
        case dialogsNotModified(Cons_dialogsNotModified)
        case dialogsSlice(Cons_dialogsSlice)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .dialogs(let _data):
                if boxed {
                    buffer.appendInt32(364538944)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.dialogs.count))
                for item in _data.dialogs {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                break
            case .dialogsNotModified(let _data):
                if boxed {
                    buffer.appendInt32(-253500010)
                }
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                break
            case .dialogsSlice(let _data):
                if boxed {
                    buffer.appendInt32(1910543603)
                }
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.dialogs.count))
                for item in _data.dialogs {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_dialogs(_ reader: BufferReader) -> Dialogs? {
            var _1: [Api.Dialog]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Dialog.self)
            }
            var _2: [Api.Message]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Message.self)
            }
            var _3: [Api.Chat]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _4: [Api.User]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.messages.Dialogs.dialogs(Cons_dialogs(dialogs: _1!, messages: _2!, chats: _3!, users: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_dialogsNotModified(_ reader: BufferReader) -> Dialogs? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.messages.Dialogs.dialogsNotModified(Cons_dialogsNotModified(count: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_dialogsSlice(_ reader: BufferReader) -> Dialogs? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.Dialog]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Dialog.self)
            }
            var _3: [Api.Message]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Message.self)
            }
            var _4: [Api.Chat]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _5: [Api.User]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.messages.Dialogs.dialogsSlice(Cons_dialogsSlice(count: _1!, dialogs: _2!, messages: _3!, chats: _4!, users: _5!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum DiscussionMessage: TypeConstructorDescription {
        class Cons_discussionMessage: TypeConstructorDescription {
            var flags: Int32
            var messages: [Api.Message]
            var maxId: Int32?
            var readInboxMaxId: Int32?
            var readOutboxMaxId: Int32?
            var unreadCount: Int32
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, messages: [Api.Message], maxId: Int32?, readInboxMaxId: Int32?, readOutboxMaxId: Int32?, unreadCount: Int32, chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.messages = messages
                self.maxId = maxId
                self.readInboxMaxId = readInboxMaxId
                self.readOutboxMaxId = readOutboxMaxId
                self.unreadCount = unreadCount
                self.chats = chats
                self.users = users
            }
        }
        case discussionMessage(Cons_discussionMessage)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .discussionMessage(let _data):
                if boxed {
                    buffer.appendInt32(-1506535550)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.maxId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.readInboxMaxId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.readOutboxMaxId!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.unreadCount, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_discussionMessage(_ reader: BufferReader) -> DiscussionMessage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.Message]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Message.self)
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _5 = reader.readInt32()
            }
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: [Api.Chat]?
            if let _ = reader.readInt32() {
                _7 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _8: [Api.User]?
            if let _ = reader.readInt32() {
                _8 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.messages.DiscussionMessage.discussionMessage(Cons_discussionMessage(flags: _1!, messages: _2!, maxId: _3, readInboxMaxId: _4, readOutboxMaxId: _5, unreadCount: _6!, chats: _7!, users: _8!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum EmojiGameInfo: TypeConstructorDescription {
        class Cons_emojiGameDiceInfo: TypeConstructorDescription {
            var flags: Int32
            var gameHash: String
            var prevStake: Int64
            var currentStreak: Int32
            var params: [Int32]
            var playsLeft: Int32?
            init(flags: Int32, gameHash: String, prevStake: Int64, currentStreak: Int32, params: [Int32], playsLeft: Int32?) {
                self.flags = flags
                self.gameHash = gameHash
                self.prevStake = prevStake
                self.currentStreak = currentStreak
                self.params = params
                self.playsLeft = playsLeft
            }
        }
        case emojiGameDiceInfo(Cons_emojiGameDiceInfo)
        case emojiGameUnavailable

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .emojiGameDiceInfo(let _data):
                if boxed {
                    buffer.appendInt32(1155883043)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.gameHash, buffer: buffer, boxed: false)
                serializeInt64(_data.prevStake, buffer: buffer, boxed: false)
                serializeInt32(_data.currentStreak, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.params.count))
                for item in _data.params {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.playsLeft!, buffer: buffer, boxed: false)
                }
                break
            case .emojiGameUnavailable:
                if boxed {
                    buffer.appendInt32(1508266805)
                }
                break
            }
        }

        static func parse_emojiGameDiceInfo(_ reader: BufferReader) -> EmojiGameInfo? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: [Int32]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _6 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.messages.EmojiGameInfo.emojiGameDiceInfo(Cons_emojiGameDiceInfo(flags: _1!, gameHash: _2!, prevStake: _3!, currentStreak: _4!, params: _5!, playsLeft: _6))
            }
            else {
                return nil
            }
        }
        static func parse_emojiGameUnavailable(_ reader: BufferReader) -> EmojiGameInfo? {
            return Api.messages.EmojiGameInfo.emojiGameUnavailable
        }
    }
}
extension Api.messages {
    enum EmojiGameOutcome: TypeConstructorDescription {
        class Cons_emojiGameOutcome: TypeConstructorDescription {
            var seed: Buffer
            var stakeTonAmount: Int64
            var tonAmount: Int64
            init(seed: Buffer, stakeTonAmount: Int64, tonAmount: Int64) {
                self.seed = seed
                self.stakeTonAmount = stakeTonAmount
                self.tonAmount = tonAmount
            }
        }
        case emojiGameOutcome(Cons_emojiGameOutcome)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .emojiGameOutcome(let _data):
                if boxed {
                    buffer.appendInt32(-634726841)
                }
                serializeBytes(_data.seed, buffer: buffer, boxed: false)
                serializeInt64(_data.stakeTonAmount, buffer: buffer, boxed: false)
                serializeInt64(_data.tonAmount, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_emojiGameOutcome(_ reader: BufferReader) -> EmojiGameOutcome? {
            var _1: Buffer?
            _1 = parseBytes(reader)
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.messages.EmojiGameOutcome.emojiGameOutcome(Cons_emojiGameOutcome(seed: _1!, stakeTonAmount: _2!, tonAmount: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum ForumTopics: TypeConstructorDescription {
        class Cons_forumTopics: TypeConstructorDescription {
            var flags: Int32
            var count: Int32
            var topics: [Api.ForumTopic]
            var messages: [Api.Message]
            var chats: [Api.Chat]
            var users: [Api.User]
            var pts: Int32
            init(flags: Int32, count: Int32, topics: [Api.ForumTopic], messages: [Api.Message], chats: [Api.Chat], users: [Api.User], pts: Int32) {
                self.flags = flags
                self.count = count
                self.topics = topics
                self.messages = messages
                self.chats = chats
                self.users = users
                self.pts = pts
            }
        }
        case forumTopics(Cons_forumTopics)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .forumTopics(let _data):
                if boxed {
                    buffer.appendInt32(913709011)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.topics.count))
                for item in _data.topics {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_forumTopics(_ reader: BufferReader) -> ForumTopics? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: [Api.ForumTopic]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.ForumTopic.self)
            }
            var _4: [Api.Message]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Message.self)
            }
            var _5: [Api.Chat]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _6: [Api.User]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
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
                return Api.messages.ForumTopics.forumTopics(Cons_forumTopics(flags: _1!, count: _2!, topics: _3!, messages: _4!, chats: _5!, users: _6!, pts: _7!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum InactiveChats: TypeConstructorDescription {
        class Cons_inactiveChats: TypeConstructorDescription {
            var dates: [Int32]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(dates: [Int32], chats: [Api.Chat], users: [Api.User]) {
                self.dates = dates
                self.chats = chats
                self.users = users
            }
        }
        case inactiveChats(Cons_inactiveChats)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inactiveChats(let _data):
                if boxed {
                    buffer.appendInt32(-1456996667)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.dates.count))
                for item in _data.dates {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_inactiveChats(_ reader: BufferReader) -> InactiveChats? {
            var _1: [Int32]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            var _2: [Api.Chat]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _3: [Api.User]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.messages.InactiveChats.inactiveChats(Cons_inactiveChats(dates: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum MessageReactionsList: TypeConstructorDescription {
        class Cons_messageReactionsList: TypeConstructorDescription {
            var flags: Int32
            var count: Int32
            var reactions: [Api.MessagePeerReaction]
            var chats: [Api.Chat]
            var users: [Api.User]
            var nextOffset: String?
            init(flags: Int32, count: Int32, reactions: [Api.MessagePeerReaction], chats: [Api.Chat], users: [Api.User], nextOffset: String?) {
                self.flags = flags
                self.count = count
                self.reactions = reactions
                self.chats = chats
                self.users = users
                self.nextOffset = nextOffset
            }
        }
        case messageReactionsList(Cons_messageReactionsList)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .messageReactionsList(let _data):
                if boxed {
                    buffer.appendInt32(834488621)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.reactions.count))
                for item in _data.reactions {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.nextOffset!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_messageReactionsList(_ reader: BufferReader) -> MessageReactionsList? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: [Api.MessagePeerReaction]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessagePeerReaction.self)
            }
            var _4: [Api.Chat]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _5: [Api.User]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
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
                return Api.messages.MessageReactionsList.messageReactionsList(Cons_messageReactionsList(flags: _1!, count: _2!, reactions: _3!, chats: _4!, users: _5!, nextOffset: _6))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum MessageViews: TypeConstructorDescription {
        class Cons_messageViews: TypeConstructorDescription {
            var views: [Api.MessageViews]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(views: [Api.MessageViews], chats: [Api.Chat], users: [Api.User]) {
                self.views = views
                self.chats = chats
                self.users = users
            }
        }
        case messageViews(Cons_messageViews)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .messageViews(let _data):
                if boxed {
                    buffer.appendInt32(-1228606141)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.views.count))
                for item in _data.views {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_messageViews(_ reader: BufferReader) -> MessageViews? {
            var _1: [Api.MessageViews]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageViews.self)
            }
            var _2: [Api.Chat]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _3: [Api.User]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.messages.MessageViews.messageViews(Cons_messageViews(views: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum Messages: TypeConstructorDescription {
        class Cons_channelMessages: TypeConstructorDescription {
            var flags: Int32
            var pts: Int32
            var count: Int32
            var offsetIdOffset: Int32?
            var messages: [Api.Message]
            var topics: [Api.ForumTopic]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, pts: Int32, count: Int32, offsetIdOffset: Int32?, messages: [Api.Message], topics: [Api.ForumTopic], chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.pts = pts
                self.count = count
                self.offsetIdOffset = offsetIdOffset
                self.messages = messages
                self.topics = topics
                self.chats = chats
                self.users = users
            }
        }
        class Cons_messages: TypeConstructorDescription {
            var messages: [Api.Message]
            var topics: [Api.ForumTopic]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(messages: [Api.Message], topics: [Api.ForumTopic], chats: [Api.Chat], users: [Api.User]) {
                self.messages = messages
                self.topics = topics
                self.chats = chats
                self.users = users
            }
        }
        class Cons_messagesNotModified: TypeConstructorDescription {
            var count: Int32
            init(count: Int32) {
                self.count = count
            }
        }
        class Cons_messagesSlice: TypeConstructorDescription {
            var flags: Int32
            var count: Int32
            var nextRate: Int32?
            var offsetIdOffset: Int32?
            var searchFlood: Api.SearchPostsFlood?
            var messages: [Api.Message]
            var topics: [Api.ForumTopic]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, count: Int32, nextRate: Int32?, offsetIdOffset: Int32?, searchFlood: Api.SearchPostsFlood?, messages: [Api.Message], topics: [Api.ForumTopic], chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.count = count
                self.nextRate = nextRate
                self.offsetIdOffset = offsetIdOffset
                self.searchFlood = searchFlood
                self.messages = messages
                self.topics = topics
                self.chats = chats
                self.users = users
            }
        }
        case channelMessages(Cons_channelMessages)
        case messages(Cons_messages)
        case messagesNotModified(Cons_messagesNotModified)
        case messagesSlice(Cons_messagesSlice)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .channelMessages(let _data):
                if boxed {
                    buffer.appendInt32(-948520370)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.offsetIdOffset!, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.topics.count))
                for item in _data.topics {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                break
            case .messages(let _data):
                if boxed {
                    buffer.appendInt32(494135274)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.topics.count))
                for item in _data.topics {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                break
            case .messagesNotModified(let _data):
                if boxed {
                    buffer.appendInt32(1951620897)
                }
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                break
            case .messagesSlice(let _data):
                if boxed {
                    buffer.appendInt32(1595959062)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.nextRate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.offsetIdOffset!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.searchFlood!.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.topics.count))
                for item in _data.topics {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_channelMessages(_ reader: BufferReader) -> Messages? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _4 = reader.readInt32()
            }
            var _5: [Api.Message]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Message.self)
            }
            var _6: [Api.ForumTopic]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.ForumTopic.self)
            }
            var _7: [Api.Chat]?
            if let _ = reader.readInt32() {
                _7 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _8: [Api.User]?
            if let _ = reader.readInt32() {
                _8 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.messages.Messages.channelMessages(Cons_channelMessages(flags: _1!, pts: _2!, count: _3!, offsetIdOffset: _4, messages: _5!, topics: _6!, chats: _7!, users: _8!))
            }
            else {
                return nil
            }
        }
        static func parse_messages(_ reader: BufferReader) -> Messages? {
            var _1: [Api.Message]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Message.self)
            }
            var _2: [Api.ForumTopic]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.ForumTopic.self)
            }
            var _3: [Api.Chat]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _4: [Api.User]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.messages.Messages.messages(Cons_messages(messages: _1!, topics: _2!, chats: _3!, users: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_messagesNotModified(_ reader: BufferReader) -> Messages? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.messages.Messages.messagesNotModified(Cons_messagesNotModified(count: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messagesSlice(_ reader: BufferReader) -> Messages? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Api.SearchPostsFlood?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.SearchPostsFlood
                }
            }
            var _6: [Api.Message]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Message.self)
            }
            var _7: [Api.ForumTopic]?
            if let _ = reader.readInt32() {
                _7 = Api.parseVector(reader, elementSignature: 0, elementType: Api.ForumTopic.self)
            }
            var _8: [Api.Chat]?
            if let _ = reader.readInt32() {
                _8 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _9: [Api.User]?
            if let _ = reader.readInt32() {
                _9 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            let _c9 = _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.messages.Messages.messagesSlice(Cons_messagesSlice(flags: _1!, count: _2!, nextRate: _3, offsetIdOffset: _4, searchFlood: _5, messages: _6!, topics: _7!, chats: _8!, users: _9!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum PeerDialogs: TypeConstructorDescription {
        class Cons_peerDialogs: TypeConstructorDescription {
            var dialogs: [Api.Dialog]
            var messages: [Api.Message]
            var chats: [Api.Chat]
            var users: [Api.User]
            var state: Api.updates.State
            init(dialogs: [Api.Dialog], messages: [Api.Message], chats: [Api.Chat], users: [Api.User], state: Api.updates.State) {
                self.dialogs = dialogs
                self.messages = messages
                self.chats = chats
                self.users = users
                self.state = state
            }
        }
        case peerDialogs(Cons_peerDialogs)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .peerDialogs(let _data):
                if boxed {
                    buffer.appendInt32(863093588)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.dialogs.count))
                for item in _data.dialogs {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.messages.count))
                for item in _data.messages {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                _data.state.serialize(buffer, true)
                break
            }
        }

        static func parse_peerDialogs(_ reader: BufferReader) -> PeerDialogs? {
            var _1: [Api.Dialog]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Dialog.self)
            }
            var _2: [Api.Message]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Message.self)
            }
            var _3: [Api.Chat]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _4: [Api.User]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            var _5: Api.updates.State?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.updates.State
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.messages.PeerDialogs.peerDialogs(Cons_peerDialogs(dialogs: _1!, messages: _2!, chats: _3!, users: _4!, state: _5!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum PeerSettings: TypeConstructorDescription {
        class Cons_peerSettings: TypeConstructorDescription {
            var settings: Api.PeerSettings
            var chats: [Api.Chat]
            var users: [Api.User]
            init(settings: Api.PeerSettings, chats: [Api.Chat], users: [Api.User]) {
                self.settings = settings
                self.chats = chats
                self.users = users
            }
        }
        case peerSettings(Cons_peerSettings)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .peerSettings(let _data):
                if boxed {
                    buffer.appendInt32(1753266509)
                }
                _data.settings.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_peerSettings(_ reader: BufferReader) -> PeerSettings? {
            var _1: Api.PeerSettings?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.PeerSettings
            }
            var _2: [Api.Chat]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _3: [Api.User]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.messages.PeerSettings.peerSettings(Cons_peerSettings(settings: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
