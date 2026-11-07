extension Api.messages {
    enum QuickReplies: TypeConstructorDescription {
        class Cons_quickReplies: TypeConstructorDescription {
            var quickReplies: [Api.QuickReply]
            var messages: [Api.Message]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(quickReplies: [Api.QuickReply], messages: [Api.Message], chats: [Api.Chat], users: [Api.User]) {
                self.quickReplies = quickReplies
                self.messages = messages
                self.chats = chats
                self.users = users
            }
        }
        case quickReplies(Cons_quickReplies)
        case quickRepliesNotModified

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .quickReplies(let _data):
                if boxed {
                    buffer.appendInt32(-963811691)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.quickReplies.count))
                for item in _data.quickReplies {
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
            case .quickRepliesNotModified:
                if boxed {
                    buffer.appendInt32(1603398491)
                }
                break
            }
        }

        static func parse_quickReplies(_ reader: BufferReader) -> QuickReplies? {
            var _1: [Api.QuickReply]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.QuickReply.self)
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
                return Api.messages.QuickReplies.quickReplies(Cons_quickReplies(quickReplies: _1!, messages: _2!, chats: _3!, users: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_quickRepliesNotModified(_ reader: BufferReader) -> QuickReplies? {
            return Api.messages.QuickReplies.quickRepliesNotModified
        }
    }
}
extension Api.messages {
    enum SavedDialogs: TypeConstructorDescription {
        class Cons_savedDialogs: TypeConstructorDescription {
            var dialogs: [Api.SavedDialog]
            var messages: [Api.Message]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(dialogs: [Api.SavedDialog], messages: [Api.Message], chats: [Api.Chat], users: [Api.User]) {
                self.dialogs = dialogs
                self.messages = messages
                self.chats = chats
                self.users = users
            }
        }
        class Cons_savedDialogsNotModified: TypeConstructorDescription {
            var count: Int32
            init(count: Int32) {
                self.count = count
            }
        }
        class Cons_savedDialogsSlice: TypeConstructorDescription {
            var count: Int32
            var dialogs: [Api.SavedDialog]
            var messages: [Api.Message]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(count: Int32, dialogs: [Api.SavedDialog], messages: [Api.Message], chats: [Api.Chat], users: [Api.User]) {
                self.count = count
                self.dialogs = dialogs
                self.messages = messages
                self.chats = chats
                self.users = users
            }
        }
        case savedDialogs(Cons_savedDialogs)
        case savedDialogsNotModified(Cons_savedDialogsNotModified)
        case savedDialogsSlice(Cons_savedDialogsSlice)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .savedDialogs(let _data):
                if boxed {
                    buffer.appendInt32(-130358751)
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
            case .savedDialogsNotModified(let _data):
                if boxed {
                    buffer.appendInt32(-1071681560)
                }
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                break
            case .savedDialogsSlice(let _data):
                if boxed {
                    buffer.appendInt32(1153080793)
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

        static func parse_savedDialogs(_ reader: BufferReader) -> SavedDialogs? {
            var _1: [Api.SavedDialog]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.SavedDialog.self)
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
                return Api.messages.SavedDialogs.savedDialogs(Cons_savedDialogs(dialogs: _1!, messages: _2!, chats: _3!, users: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_savedDialogsNotModified(_ reader: BufferReader) -> SavedDialogs? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.messages.SavedDialogs.savedDialogsNotModified(Cons_savedDialogsNotModified(count: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_savedDialogsSlice(_ reader: BufferReader) -> SavedDialogs? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.SavedDialog]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.SavedDialog.self)
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
                return Api.messages.SavedDialogs.savedDialogsSlice(Cons_savedDialogsSlice(count: _1!, dialogs: _2!, messages: _3!, chats: _4!, users: _5!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum SearchResultsCalendar: TypeConstructorDescription {
        class Cons_searchResultsCalendar: TypeConstructorDescription {
            var flags: Int32
            var count: Int32
            var minDate: Int32
            var minMsgId: Int32
            var offsetIdOffset: Int32?
            var periods: [Api.SearchResultsCalendarPeriod]
            var messages: [Api.Message]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, count: Int32, minDate: Int32, minMsgId: Int32, offsetIdOffset: Int32?, periods: [Api.SearchResultsCalendarPeriod], messages: [Api.Message], chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.count = count
                self.minDate = minDate
                self.minMsgId = minMsgId
                self.offsetIdOffset = offsetIdOffset
                self.periods = periods
                self.messages = messages
                self.chats = chats
                self.users = users
            }
        }
        case searchResultsCalendar(Cons_searchResultsCalendar)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .searchResultsCalendar(let _data):
                if boxed {
                    buffer.appendInt32(343859772)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                serializeInt32(_data.minDate, buffer: buffer, boxed: false)
                serializeInt32(_data.minMsgId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.offsetIdOffset!, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.periods.count))
                for item in _data.periods {
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

        static func parse_searchResultsCalendar(_ reader: BufferReader) -> SearchResultsCalendar? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _5 = reader.readInt32()
            }
            var _6: [Api.SearchResultsCalendarPeriod]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.SearchResultsCalendarPeriod.self)
            }
            var _7: [Api.Message]?
            if let _ = reader.readInt32() {
                _7 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Message.self)
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
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            let _c9 = _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.messages.SearchResultsCalendar.searchResultsCalendar(Cons_searchResultsCalendar(flags: _1!, count: _2!, minDate: _3!, minMsgId: _4!, offsetIdOffset: _5, periods: _6!, messages: _7!, chats: _8!, users: _9!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum SponsoredMessages: TypeConstructorDescription {
        class Cons_sponsoredMessages: TypeConstructorDescription {
            var flags: Int32
            var postsBetween: Int32?
            var startDelay: Int32?
            var betweenDelay: Int32?
            var messages: [Api.SponsoredMessage]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, postsBetween: Int32?, startDelay: Int32?, betweenDelay: Int32?, messages: [Api.SponsoredMessage], chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.postsBetween = postsBetween
                self.startDelay = startDelay
                self.betweenDelay = betweenDelay
                self.messages = messages
                self.chats = chats
                self.users = users
            }
        }
        case sponsoredMessages(Cons_sponsoredMessages)
        case sponsoredMessagesEmpty

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .sponsoredMessages(let _data):
                if boxed {
                    buffer.appendInt32(-2464403)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.postsBetween!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.startDelay!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.betweenDelay!, buffer: buffer, boxed: false)
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
            case .sponsoredMessagesEmpty:
                if boxed {
                    buffer.appendInt32(406407439)
                }
                break
            }
        }

        static func parse_sponsoredMessages(_ reader: BufferReader) -> SponsoredMessages? {
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
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _4 = reader.readInt32()
            }
            var _5: [Api.SponsoredMessage]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.SponsoredMessage.self)
            }
            var _6: [Api.Chat]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _7: [Api.User]?
            if let _ = reader.readInt32() {
                _7 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.messages.SponsoredMessages.sponsoredMessages(Cons_sponsoredMessages(flags: _1!, postsBetween: _2, startDelay: _3, betweenDelay: _4, messages: _5!, chats: _6!, users: _7!))
            }
            else {
                return nil
            }
        }
        static func parse_sponsoredMessagesEmpty(_ reader: BufferReader) -> SponsoredMessages? {
            return Api.messages.SponsoredMessages.sponsoredMessagesEmpty
        }
    }
}
extension Api.messages {
    enum StickerSet: TypeConstructorDescription {
        class Cons_stickerSet: TypeConstructorDescription {
            var set: Api.StickerSet
            var packs: [Api.StickerPack]
            var keywords: [Api.StickerKeyword]
            var documents: [Api.Document]
            init(set: Api.StickerSet, packs: [Api.StickerPack], keywords: [Api.StickerKeyword], documents: [Api.Document]) {
                self.set = set
                self.packs = packs
                self.keywords = keywords
                self.documents = documents
            }
        }
        case stickerSet(Cons_stickerSet)
        case stickerSetNotModified

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .stickerSet(let _data):
                if boxed {
                    buffer.appendInt32(1846886166)
                }
                _data.set.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.packs.count))
                for item in _data.packs {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.keywords.count))
                for item in _data.keywords {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.documents.count))
                for item in _data.documents {
                    item.serialize(buffer, true)
                }
                break
            case .stickerSetNotModified:
                if boxed {
                    buffer.appendInt32(-738646805)
                }
                break
            }
        }

        static func parse_stickerSet(_ reader: BufferReader) -> StickerSet? {
            var _1: Api.StickerSet?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.StickerSet
            }
            var _2: [Api.StickerPack]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StickerPack.self)
            }
            var _3: [Api.StickerKeyword]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StickerKeyword.self)
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
                return Api.messages.StickerSet.stickerSet(Cons_stickerSet(set: _1!, packs: _2!, keywords: _3!, documents: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_stickerSetNotModified(_ reader: BufferReader) -> StickerSet? {
            return Api.messages.StickerSet.stickerSetNotModified
        }
    }
}
extension Api.messages {
    enum VotesList: TypeConstructorDescription {
        class Cons_votesList: TypeConstructorDescription {
            var flags: Int32
            var count: Int32
            var votes: [Api.MessagePeerVote]
            var chats: [Api.Chat]
            var users: [Api.User]
            var nextOffset: String?
            init(flags: Int32, count: Int32, votes: [Api.MessagePeerVote], chats: [Api.Chat], users: [Api.User], nextOffset: String?) {
                self.flags = flags
                self.count = count
                self.votes = votes
                self.chats = chats
                self.users = users
                self.nextOffset = nextOffset
            }
        }
        case votesList(Cons_votesList)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .votesList(let _data):
                if boxed {
                    buffer.appendInt32(1218005070)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.votes.count))
                for item in _data.votes {
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

        static func parse_votesList(_ reader: BufferReader) -> VotesList? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: [Api.MessagePeerVote]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessagePeerVote.self)
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
                return Api.messages.VotesList.votesList(Cons_votesList(flags: _1!, count: _2!, votes: _3!, chats: _4!, users: _5!, nextOffset: _6))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum WebPage: TypeConstructorDescription {
        class Cons_webPage: TypeConstructorDescription {
            var webpage: Api.WebPage
            var chats: [Api.Chat]
            var users: [Api.User]
            init(webpage: Api.WebPage, chats: [Api.Chat], users: [Api.User]) {
                self.webpage = webpage
                self.chats = chats
                self.users = users
            }
        }
        case webPage(Cons_webPage)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .webPage(let _data):
                if boxed {
                    buffer.appendInt32(-44166467)
                }
                _data.webpage.serialize(buffer, true)
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

        static func parse_webPage(_ reader: BufferReader) -> WebPage? {
            var _1: Api.WebPage?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.WebPage
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
                return Api.messages.WebPage.webPage(Cons_webPage(webpage: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.messages {
    enum WebPagePreview: TypeConstructorDescription {
        class Cons_webPagePreview: TypeConstructorDescription {
            var media: Api.MessageMedia
            var chats: [Api.Chat]
            var users: [Api.User]
            init(media: Api.MessageMedia, chats: [Api.Chat], users: [Api.User]) {
                self.media = media
                self.chats = chats
                self.users = users
            }
        }
        case webPagePreview(Cons_webPagePreview)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .webPagePreview(let _data):
                if boxed {
                    buffer.appendInt32(-1936029524)
                }
                _data.media.serialize(buffer, true)
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

        static func parse_webPagePreview(_ reader: BufferReader) -> WebPagePreview? {
            var _1: Api.MessageMedia?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.MessageMedia
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
                return Api.messages.WebPagePreview.webPagePreview(Cons_webPagePreview(media: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.payments {
    enum CheckedGiftCode: TypeConstructorDescription {
        class Cons_checkedGiftCode: TypeConstructorDescription {
            var flags: Int32
            var fromId: Api.Peer?
            var giveawayMsgId: Int32?
            var toId: Int64?
            var date: Int32
            var days: Int32
            var usedDate: Int32?
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, fromId: Api.Peer?, giveawayMsgId: Int32?, toId: Int64?, date: Int32, days: Int32, usedDate: Int32?, chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.fromId = fromId
                self.giveawayMsgId = giveawayMsgId
                self.toId = toId
                self.date = date
                self.days = days
                self.usedDate = usedDate
                self.chats = chats
                self.users = users
            }
        }
        case checkedGiftCode(Cons_checkedGiftCode)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .checkedGiftCode(let _data):
                if boxed {
                    buffer.appendInt32(-342343793)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    _data.fromId!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.giveawayMsgId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.toId!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt32(_data.days, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.usedDate!, buffer: buffer, boxed: false)
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

        static func parse_checkedGiftCode(_ reader: BufferReader) -> CheckedGiftCode? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = reader.readInt64()
            }
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _7 = reader.readInt32()
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
            let _c2 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _7 != nil
            let _c8 = _8 != nil
            let _c9 = _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.payments.CheckedGiftCode.checkedGiftCode(Cons_checkedGiftCode(flags: _1!, fromId: _2, giveawayMsgId: _3, toId: _4, date: _5!, days: _6!, usedDate: _7, chats: _8!, users: _9!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.payments {
    enum ResaleStarGifts: TypeConstructorDescription {
        class Cons_resaleStarGifts: TypeConstructorDescription {
            var flags: Int32
            var count: Int32
            var gifts: [Api.StarGift]
            var nextOffset: String?
            var attributes: [Api.StarGiftAttribute]?
            var attributesHash: Int64?
            var chats: [Api.Chat]
            var counters: [Api.StarGiftAttributeCounter]?
            var users: [Api.User]
            init(flags: Int32, count: Int32, gifts: [Api.StarGift], nextOffset: String?, attributes: [Api.StarGiftAttribute]?, attributesHash: Int64?, chats: [Api.Chat], counters: [Api.StarGiftAttributeCounter]?, users: [Api.User]) {
                self.flags = flags
                self.count = count
                self.gifts = gifts
                self.nextOffset = nextOffset
                self.attributes = attributes
                self.attributesHash = attributesHash
                self.chats = chats
                self.counters = counters
                self.users = users
            }
        }
        case resaleStarGifts(Cons_resaleStarGifts)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .resaleStarGifts(let _data):
                if boxed {
                    buffer.appendInt32(-1803939105)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.gifts.count))
                for item in _data.gifts {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.nextOffset!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.attributes!.count))
                    for item in _data.attributes! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt64(_data.attributesHash!, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.counters!.count))
                    for item in _data.counters! {
                        item.serialize(buffer, true)
                    }
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_resaleStarGifts(_ reader: BufferReader) -> ResaleStarGifts? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: [Api.StarGift]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StarGift.self)
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            var _5: [Api.StarGiftAttribute]?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let _ = reader.readInt32() {
                    _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StarGiftAttribute.self)
                }
            }
            var _6: Int64?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _6 = reader.readInt64()
            }
            var _7: [Api.Chat]?
            if let _ = reader.readInt32() {
                _7 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _8: [Api.StarGiftAttributeCounter]?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let _ = reader.readInt32() {
                    _8 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StarGiftAttributeCounter.self)
                }
            }
            var _9: [Api.User]?
            if let _ = reader.readInt32() {
                _9 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            let _c7 = _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _8 != nil
            let _c9 = _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.payments.ResaleStarGifts.resaleStarGifts(Cons_resaleStarGifts(flags: _1!, count: _2!, gifts: _3!, nextOffset: _4, attributes: _5, attributesHash: _6, chats: _7!, counters: _8, users: _9!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.payments {
    enum SavedStarGifts: TypeConstructorDescription {
        class Cons_savedStarGifts: TypeConstructorDescription {
            var flags: Int32
            var count: Int32
            var chatNotificationsEnabled: Api.Bool?
            var gifts: [Api.SavedStarGift]
            var nextOffset: String?
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, count: Int32, chatNotificationsEnabled: Api.Bool?, gifts: [Api.SavedStarGift], nextOffset: String?, chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.count = count
                self.chatNotificationsEnabled = chatNotificationsEnabled
                self.gifts = gifts
                self.nextOffset = nextOffset
                self.chats = chats
                self.users = users
            }
        }
        case savedStarGifts(Cons_savedStarGifts)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .savedStarGifts(let _data):
                if boxed {
                    buffer.appendInt32(-1779201615)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.chatNotificationsEnabled!.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.gifts.count))
                for item in _data.gifts {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.nextOffset!, buffer: buffer, boxed: false)
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

        static func parse_savedStarGifts(_ reader: BufferReader) -> SavedStarGifts? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            var _4: [Api.SavedStarGift]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.SavedStarGift.self)
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = parseString(reader)
            }
            var _6: [Api.Chat]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _7: [Api.User]?
            if let _ = reader.readInt32() {
                _7 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.payments.SavedStarGifts.savedStarGifts(Cons_savedStarGifts(flags: _1!, count: _2!, chatNotificationsEnabled: _3, gifts: _4!, nextOffset: _5, chats: _6!, users: _7!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.payments {
    enum StarGiftActiveAuctions: TypeConstructorDescription {
        class Cons_starGiftActiveAuctions: TypeConstructorDescription {
            var auctions: [Api.StarGiftActiveAuctionState]
            var users: [Api.User]
            var chats: [Api.Chat]
            init(auctions: [Api.StarGiftActiveAuctionState], users: [Api.User], chats: [Api.Chat]) {
                self.auctions = auctions
                self.users = users
                self.chats = chats
            }
        }
        case starGiftActiveAuctions(Cons_starGiftActiveAuctions)
        case starGiftActiveAuctionsNotModified

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starGiftActiveAuctions(let _data):
                if boxed {
                    buffer.appendInt32(-1359565892)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.auctions.count))
                for item in _data.auctions {
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
                break
            case .starGiftActiveAuctionsNotModified:
                if boxed {
                    buffer.appendInt32(-617358640)
                }
                break
            }
        }

        static func parse_starGiftActiveAuctions(_ reader: BufferReader) -> StarGiftActiveAuctions? {
            var _1: [Api.StarGiftActiveAuctionState]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StarGiftActiveAuctionState.self)
            }
            var _2: [Api.User]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            var _3: [Api.Chat]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.payments.StarGiftActiveAuctions.starGiftActiveAuctions(Cons_starGiftActiveAuctions(auctions: _1!, users: _2!, chats: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_starGiftActiveAuctionsNotModified(_ reader: BufferReader) -> StarGiftActiveAuctions? {
            return Api.payments.StarGiftActiveAuctions.starGiftActiveAuctionsNotModified
        }
    }
}
extension Api.payments {
    enum StarGiftAuctionAcquiredGifts: TypeConstructorDescription {
        class Cons_starGiftAuctionAcquiredGifts: TypeConstructorDescription {
            var gifts: [Api.StarGiftAuctionAcquiredGift]
            var users: [Api.User]
            var chats: [Api.Chat]
            init(gifts: [Api.StarGiftAuctionAcquiredGift], users: [Api.User], chats: [Api.Chat]) {
                self.gifts = gifts
                self.users = users
                self.chats = chats
            }
        }
        case starGiftAuctionAcquiredGifts(Cons_starGiftAuctionAcquiredGifts)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starGiftAuctionAcquiredGifts(let _data):
                if boxed {
                    buffer.appendInt32(2103169520)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.gifts.count))
                for item in _data.gifts {
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
                break
            }
        }

        static func parse_starGiftAuctionAcquiredGifts(_ reader: BufferReader) -> StarGiftAuctionAcquiredGifts? {
            var _1: [Api.StarGiftAuctionAcquiredGift]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StarGiftAuctionAcquiredGift.self)
            }
            var _2: [Api.User]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            var _3: [Api.Chat]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.payments.StarGiftAuctionAcquiredGifts.starGiftAuctionAcquiredGifts(Cons_starGiftAuctionAcquiredGifts(gifts: _1!, users: _2!, chats: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.payments {
    enum StarGiftAuctionState: TypeConstructorDescription {
        class Cons_starGiftAuctionState: TypeConstructorDescription {
            var gift: Api.StarGift
            var state: Api.StarGiftAuctionState
            var userState: Api.StarGiftAuctionUserState
            var timeout: Int32
            var users: [Api.User]
            var chats: [Api.Chat]
            init(gift: Api.StarGift, state: Api.StarGiftAuctionState, userState: Api.StarGiftAuctionUserState, timeout: Int32, users: [Api.User], chats: [Api.Chat]) {
                self.gift = gift
                self.state = state
                self.userState = userState
                self.timeout = timeout
                self.users = users
                self.chats = chats
            }
        }
        case starGiftAuctionState(Cons_starGiftAuctionState)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starGiftAuctionState(let _data):
                if boxed {
                    buffer.appendInt32(1798960364)
                }
                _data.gift.serialize(buffer, true)
                _data.state.serialize(buffer, true)
                _data.userState.serialize(buffer, true)
                serializeInt32(_data.timeout, buffer: buffer, boxed: false)
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
                break
            }
        }

        static func parse_starGiftAuctionState(_ reader: BufferReader) -> StarGiftAuctionState? {
            var _1: Api.StarGift?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.StarGift
            }
            var _2: Api.StarGiftAuctionState?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.StarGiftAuctionState
            }
            var _3: Api.StarGiftAuctionUserState?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.StarGiftAuctionUserState
            }
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: [Api.User]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            var _6: [Api.Chat]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.payments.StarGiftAuctionState.starGiftAuctionState(Cons_starGiftAuctionState(gift: _1!, state: _2!, userState: _3!, timeout: _4!, users: _5!, chats: _6!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.payments {
    enum StarGifts: TypeConstructorDescription {
        class Cons_starGifts: TypeConstructorDescription {
            var hash: Int32
            var gifts: [Api.StarGift]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(hash: Int32, gifts: [Api.StarGift], chats: [Api.Chat], users: [Api.User]) {
                self.hash = hash
                self.gifts = gifts
                self.chats = chats
                self.users = users
            }
        }
        case starGifts(Cons_starGifts)
        case starGiftsNotModified

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starGifts(let _data):
                if boxed {
                    buffer.appendInt32(785918357)
                }
                serializeInt32(_data.hash, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.gifts.count))
                for item in _data.gifts {
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
            case .starGiftsNotModified:
                if boxed {
                    buffer.appendInt32(-1551326360)
                }
                break
            }
        }

        static func parse_starGifts(_ reader: BufferReader) -> StarGifts? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.StarGift]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StarGift.self)
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
                return Api.payments.StarGifts.starGifts(Cons_starGifts(hash: _1!, gifts: _2!, chats: _3!, users: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_starGiftsNotModified(_ reader: BufferReader) -> StarGifts? {
            return Api.payments.StarGifts.starGiftsNotModified
        }
    }
}
extension Api.payments {
    enum StarsStatus: TypeConstructorDescription {
        class Cons_starsStatus: TypeConstructorDescription {
            var flags: Int32
            var balance: Api.StarsAmount
            var subscriptions: [Api.StarsSubscription]?
            var subscriptionsNextOffset: String?
            var subscriptionsMissingBalance: Int64?
            var history: [Api.StarsTransaction]?
            var nextOffset: String?
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, balance: Api.StarsAmount, subscriptions: [Api.StarsSubscription]?, subscriptionsNextOffset: String?, subscriptionsMissingBalance: Int64?, history: [Api.StarsTransaction]?, nextOffset: String?, chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.balance = balance
                self.subscriptions = subscriptions
                self.subscriptionsNextOffset = subscriptionsNextOffset
                self.subscriptionsMissingBalance = subscriptionsMissingBalance
                self.history = history
                self.nextOffset = nextOffset
                self.chats = chats
                self.users = users
            }
        }
        case starsStatus(Cons_starsStatus)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starsStatus(let _data):
                if boxed {
                    buffer.appendInt32(1822222573)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.balance.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.subscriptions!.count))
                    for item in _data.subscriptions! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.subscriptionsNextOffset!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt64(_data.subscriptionsMissingBalance!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.history!.count))
                    for item in _data.history! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.nextOffset!, buffer: buffer, boxed: false)
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

        static func parse_starsStatus(_ reader: BufferReader) -> StarsStatus? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.StarsAmount?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.StarsAmount
            }
            var _3: [Api.StarsSubscription]?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let _ = reader.readInt32() {
                    _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StarsSubscription.self)
                }
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _4 = parseString(reader)
            }
            var _5: Int64?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _5 = reader.readInt64()
            }
            var _6: [Api.StarsTransaction]?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let _ = reader.readInt32() {
                    _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StarsTransaction.self)
                }
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _7 = parseString(reader)
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
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _7 != nil
            let _c8 = _8 != nil
            let _c9 = _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.payments.StarsStatus.starsStatus(Cons_starsStatus(flags: _1!, balance: _2!, subscriptions: _3, subscriptionsNextOffset: _4, subscriptionsMissingBalance: _5, history: _6, nextOffset: _7, chats: _8!, users: _9!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.payments {
    enum UniqueStarGift: TypeConstructorDescription {
        class Cons_uniqueStarGift: TypeConstructorDescription {
            var gift: Api.StarGift
            var chats: [Api.Chat]
            var users: [Api.User]
            init(gift: Api.StarGift, chats: [Api.Chat], users: [Api.User]) {
                self.gift = gift
                self.chats = chats
                self.users = users
            }
        }
        case uniqueStarGift(Cons_uniqueStarGift)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .uniqueStarGift(let _data):
                if boxed {
                    buffer.appendInt32(1097619176)
                }
                _data.gift.serialize(buffer, true)
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

        static func parse_uniqueStarGift(_ reader: BufferReader) -> UniqueStarGift? {
            var _1: Api.StarGift?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.StarGift
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
                return Api.payments.UniqueStarGift.uniqueStarGift(Cons_uniqueStarGift(gift: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.phone {
    enum GroupCall: TypeConstructorDescription {
        class Cons_groupCall: TypeConstructorDescription {
            var call: Api.GroupCall
            var participants: [Api.GroupCallParticipant]
            var participantsNextOffset: String
            var chats: [Api.Chat]
            var users: [Api.User]
            init(call: Api.GroupCall, participants: [Api.GroupCallParticipant], participantsNextOffset: String, chats: [Api.Chat], users: [Api.User]) {
                self.call = call
                self.participants = participants
                self.participantsNextOffset = participantsNextOffset
                self.chats = chats
                self.users = users
            }
        }
        case groupCall(Cons_groupCall)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .groupCall(let _data):
                if boxed {
                    buffer.appendInt32(-1636664659)
                }
                _data.call.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.participants.count))
                for item in _data.participants {
                    item.serialize(buffer, true)
                }
                serializeString(_data.participantsNextOffset, buffer: buffer, boxed: false)
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

        static func parse_groupCall(_ reader: BufferReader) -> GroupCall? {
            var _1: Api.GroupCall?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.GroupCall
            }
            var _2: [Api.GroupCallParticipant]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.GroupCallParticipant.self)
            }
            var _3: String?
            _3 = parseString(reader)
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
                return Api.phone.GroupCall.groupCall(Cons_groupCall(call: _1!, participants: _2!, participantsNextOffset: _3!, chats: _4!, users: _5!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.phone {
    enum GroupCallStars: TypeConstructorDescription {
        class Cons_groupCallStars: TypeConstructorDescription {
            var totalStars: Int64
            var topDonors: [Api.GroupCallDonor]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(totalStars: Int64, topDonors: [Api.GroupCallDonor], chats: [Api.Chat], users: [Api.User]) {
                self.totalStars = totalStars
                self.topDonors = topDonors
                self.chats = chats
                self.users = users
            }
        }
        case groupCallStars(Cons_groupCallStars)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .groupCallStars(let _data):
                if boxed {
                    buffer.appendInt32(-1658995418)
                }
                serializeInt64(_data.totalStars, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.topDonors.count))
                for item in _data.topDonors {
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

        static func parse_groupCallStars(_ reader: BufferReader) -> GroupCallStars? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: [Api.GroupCallDonor]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.GroupCallDonor.self)
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
                return Api.phone.GroupCallStars.groupCallStars(Cons_groupCallStars(totalStars: _1!, topDonors: _2!, chats: _3!, users: _4!))
            }
            else {
                return nil
            }
        }
    }
}
