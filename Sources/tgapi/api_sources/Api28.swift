extension Api.phone {
    enum GroupParticipants: TypeConstructorDescription {
        class Cons_groupParticipants: TypeConstructorDescription {
            var count: Int32
            var participants: [Api.GroupCallParticipant]
            var nextOffset: String
            var chats: [Api.Chat]
            var users: [Api.User]
            var version: Int32
            init(count: Int32, participants: [Api.GroupCallParticipant], nextOffset: String, chats: [Api.Chat], users: [Api.User], version: Int32) {
                self.count = count
                self.participants = participants
                self.nextOffset = nextOffset
                self.chats = chats
                self.users = users
                self.version = version
            }
        }
        case groupParticipants(Cons_groupParticipants)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .groupParticipants(let _data):
                if boxed {
                    buffer.appendInt32(-193506890)
                }
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.participants.count))
                for item in _data.participants {
                    item.serialize(buffer, true)
                }
                serializeString(_data.nextOffset, buffer: buffer, boxed: false)
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
                serializeInt32(_data.version, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_groupParticipants(_ reader: BufferReader) -> GroupParticipants? {
            var _1: Int32?
            _1 = reader.readInt32()
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
            var _6: Int32?
            _6 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.phone.GroupParticipants.groupParticipants(Cons_groupParticipants(count: _1!, participants: _2!, nextOffset: _3!, chats: _4!, users: _5!, version: _6!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.phone {
    enum JoinAsPeers: TypeConstructorDescription {
        class Cons_joinAsPeers: TypeConstructorDescription {
            var peers: [Api.Peer]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(peers: [Api.Peer], chats: [Api.Chat], users: [Api.User]) {
                self.peers = peers
                self.chats = chats
                self.users = users
            }
        }
        case joinAsPeers(Cons_joinAsPeers)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .joinAsPeers(let _data):
                if boxed {
                    buffer.appendInt32(-1343921601)
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
            }
        }

        static func parse_joinAsPeers(_ reader: BufferReader) -> JoinAsPeers? {
            var _1: [Api.Peer]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Peer.self)
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
                return Api.phone.JoinAsPeers.joinAsPeers(Cons_joinAsPeers(peers: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.premium {
    enum MyBoosts: TypeConstructorDescription {
        class Cons_myBoosts: TypeConstructorDescription {
            var myBoosts: [Api.MyBoost]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(myBoosts: [Api.MyBoost], chats: [Api.Chat], users: [Api.User]) {
                self.myBoosts = myBoosts
                self.chats = chats
                self.users = users
            }
        }
        case myBoosts(Cons_myBoosts)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .myBoosts(let _data):
                if boxed {
                    buffer.appendInt32(-1696454430)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.myBoosts.count))
                for item in _data.myBoosts {
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

        static func parse_myBoosts(_ reader: BufferReader) -> MyBoosts? {
            var _1: [Api.MyBoost]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MyBoost.self)
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
                return Api.premium.MyBoosts.myBoosts(Cons_myBoosts(myBoosts: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.stats {
    enum PublicForwards: TypeConstructorDescription {
        class Cons_publicForwards: TypeConstructorDescription {
            var flags: Int32
            var count: Int32
            var forwards: [Api.PublicForward]
            var nextOffset: String?
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, count: Int32, forwards: [Api.PublicForward], nextOffset: String?, chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.count = count
                self.forwards = forwards
                self.nextOffset = nextOffset
                self.chats = chats
                self.users = users
            }
        }
        case publicForwards(Cons_publicForwards)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .publicForwards(let _data):
                if boxed {
                    buffer.appendInt32(-1828487648)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.forwards.count))
                for item in _data.forwards {
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

        static func parse_publicForwards(_ reader: BufferReader) -> PublicForwards? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: [Api.PublicForward]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PublicForward.self)
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            var _5: [Api.Chat]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _6: [Api.User]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.stats.PublicForwards.publicForwards(Cons_publicForwards(flags: _1!, count: _2!, forwards: _3!, nextOffset: _4, chats: _5!, users: _6!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.stories {
    enum AllStories: TypeConstructorDescription {
        class Cons_allStories: TypeConstructorDescription {
            var flags: Int32
            var count: Int32
            var state: String
            var peerStories: [Api.PeerStories]
            var chats: [Api.Chat]
            var users: [Api.User]
            var stealthMode: Api.StoriesStealthMode
            init(flags: Int32, count: Int32, state: String, peerStories: [Api.PeerStories], chats: [Api.Chat], users: [Api.User], stealthMode: Api.StoriesStealthMode) {
                self.flags = flags
                self.count = count
                self.state = state
                self.peerStories = peerStories
                self.chats = chats
                self.users = users
                self.stealthMode = stealthMode
            }
        }
        class Cons_allStoriesNotModified: TypeConstructorDescription {
            var flags: Int32
            var state: String
            var stealthMode: Api.StoriesStealthMode
            init(flags: Int32, state: String, stealthMode: Api.StoriesStealthMode) {
                self.flags = flags
                self.state = state
                self.stealthMode = stealthMode
            }
        }
        case allStories(Cons_allStories)
        case allStoriesNotModified(Cons_allStoriesNotModified)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .allStories(let _data):
                if boxed {
                    buffer.appendInt32(1862033025)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                serializeString(_data.state, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.peerStories.count))
                for item in _data.peerStories {
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
                _data.stealthMode.serialize(buffer, true)
                break
            case .allStoriesNotModified(let _data):
                if boxed {
                    buffer.appendInt32(291044926)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.state, buffer: buffer, boxed: false)
                _data.stealthMode.serialize(buffer, true)
                break
            }
        }

        static func parse_allStories(_ reader: BufferReader) -> AllStories? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: String?
            _3 = parseString(reader)
            var _4: [Api.PeerStories]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PeerStories.self)
            }
            var _5: [Api.Chat]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _6: [Api.User]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            var _7: Api.StoriesStealthMode?
            if let signature = reader.readInt32() {
                _7 = Api.parse(reader, signature: signature) as? Api.StoriesStealthMode
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.stories.AllStories.allStories(Cons_allStories(flags: _1!, count: _2!, state: _3!, peerStories: _4!, chats: _5!, users: _6!, stealthMode: _7!))
            }
            else {
                return nil
            }
        }
        static func parse_allStoriesNotModified(_ reader: BufferReader) -> AllStories? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Api.StoriesStealthMode?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.StoriesStealthMode
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.stories.AllStories.allStoriesNotModified(Cons_allStoriesNotModified(flags: _1!, state: _2!, stealthMode: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.stories {
    enum FoundStories: TypeConstructorDescription {
        class Cons_foundStories: TypeConstructorDescription {
            var flags: Int32
            var count: Int32
            var stories: [Api.FoundStory]
            var nextOffset: String?
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, count: Int32, stories: [Api.FoundStory], nextOffset: String?, chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.count = count
                self.stories = stories
                self.nextOffset = nextOffset
                self.chats = chats
                self.users = users
            }
        }
        case foundStories(Cons_foundStories)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .foundStories(let _data):
                if boxed {
                    buffer.appendInt32(-488736969)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.stories.count))
                for item in _data.stories {
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

        static func parse_foundStories(_ reader: BufferReader) -> FoundStories? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: [Api.FoundStory]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.FoundStory.self)
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            var _5: [Api.Chat]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _6: [Api.User]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.stories.FoundStories.foundStories(Cons_foundStories(flags: _1!, count: _2!, stories: _3!, nextOffset: _4, chats: _5!, users: _6!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.stories {
    enum PeerStories: TypeConstructorDescription {
        class Cons_peerStories: TypeConstructorDescription {
            var stories: Api.PeerStories
            var chats: [Api.Chat]
            var users: [Api.User]
            init(stories: Api.PeerStories, chats: [Api.Chat], users: [Api.User]) {
                self.stories = stories
                self.chats = chats
                self.users = users
            }
        }
        case peerStories(Cons_peerStories)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .peerStories(let _data):
                if boxed {
                    buffer.appendInt32(-890861720)
                }
                _data.stories.serialize(buffer, true)
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

        static func parse_peerStories(_ reader: BufferReader) -> PeerStories? {
            var _1: Api.PeerStories?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.PeerStories
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
                return Api.stories.PeerStories.peerStories(Cons_peerStories(stories: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.stories {
    enum Stories: TypeConstructorDescription {
        class Cons_stories: TypeConstructorDescription {
            var flags: Int32
            var count: Int32
            var stories: [Api.StoryItem]
            var pinnedToTop: [Int32]?
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, count: Int32, stories: [Api.StoryItem], pinnedToTop: [Int32]?, chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.count = count
                self.stories = stories
                self.pinnedToTop = pinnedToTop
                self.chats = chats
                self.users = users
            }
        }
        case stories(Cons_stories)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .stories(let _data):
                if boxed {
                    buffer.appendInt32(1673780490)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.stories.count))
                for item in _data.stories {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.pinnedToTop!.count))
                    for item in _data.pinnedToTop! {
                        serializeInt32(item, buffer: buffer, boxed: false)
                    }
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

        static func parse_stories(_ reader: BufferReader) -> Stories? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: [Api.StoryItem]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StoryItem.self)
            }
            var _4: [Int32]?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _4 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
                }
            }
            var _5: [Api.Chat]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _6: [Api.User]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.stories.Stories.stories(Cons_stories(flags: _1!, count: _2!, stories: _3!, pinnedToTop: _4, chats: _5!, users: _6!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.stories {
    enum StoryReactionsList: TypeConstructorDescription {
        class Cons_storyReactionsList: TypeConstructorDescription {
            var flags: Int32
            var count: Int32
            var reactions: [Api.StoryReaction]
            var chats: [Api.Chat]
            var users: [Api.User]
            var nextOffset: String?
            init(flags: Int32, count: Int32, reactions: [Api.StoryReaction], chats: [Api.Chat], users: [Api.User], nextOffset: String?) {
                self.flags = flags
                self.count = count
                self.reactions = reactions
                self.chats = chats
                self.users = users
                self.nextOffset = nextOffset
            }
        }
        case storyReactionsList(Cons_storyReactionsList)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .storyReactionsList(let _data):
                if boxed {
                    buffer.appendInt32(-1436583780)
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

        static func parse_storyReactionsList(_ reader: BufferReader) -> StoryReactionsList? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: [Api.StoryReaction]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StoryReaction.self)
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
                return Api.stories.StoryReactionsList.storyReactionsList(Cons_storyReactionsList(flags: _1!, count: _2!, reactions: _3!, chats: _4!, users: _5!, nextOffset: _6))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.stories {
    enum StoryViewsList: TypeConstructorDescription {
        class Cons_storyViewsList: TypeConstructorDescription {
            var flags: Int32
            var count: Int32
            var viewsCount: Int32
            var forwardsCount: Int32
            var reactionsCount: Int32
            var views: [Api.StoryView]
            var chats: [Api.Chat]
            var users: [Api.User]
            var nextOffset: String?
            init(flags: Int32, count: Int32, viewsCount: Int32, forwardsCount: Int32, reactionsCount: Int32, views: [Api.StoryView], chats: [Api.Chat], users: [Api.User], nextOffset: String?) {
                self.flags = flags
                self.count = count
                self.viewsCount = viewsCount
                self.forwardsCount = forwardsCount
                self.reactionsCount = reactionsCount
                self.views = views
                self.chats = chats
                self.users = users
                self.nextOffset = nextOffset
            }
        }
        case storyViewsList(Cons_storyViewsList)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .storyViewsList(let _data):
                if boxed {
                    buffer.appendInt32(1507299269)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                serializeInt32(_data.viewsCount, buffer: buffer, boxed: false)
                serializeInt32(_data.forwardsCount, buffer: buffer, boxed: false)
                serializeInt32(_data.reactionsCount, buffer: buffer, boxed: false)
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
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.nextOffset!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_storyViewsList(_ reader: BufferReader) -> StoryViewsList? {
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
            var _6: [Api.StoryView]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StoryView.self)
            }
            var _7: [Api.Chat]?
            if let _ = reader.readInt32() {
                _7 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _8: [Api.User]?
            if let _ = reader.readInt32() {
                _8 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            var _9: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _9 = parseString(reader)
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
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.stories.StoryViewsList.storyViewsList(Cons_storyViewsList(flags: _1!, count: _2!, viewsCount: _3!, forwardsCount: _4!, reactionsCount: _5!, views: _6!, chats: _7!, users: _8!, nextOffset: _9))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.updates {
    indirect enum ChannelDifference: TypeConstructorDescription {
        class Cons_channelDifference: TypeConstructorDescription {
            var flags: Int32
            var pts: Int32
            var timeout: Int32?
            var newMessages: [Api.Message]
            var otherUpdates: [Api.Update]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, pts: Int32, timeout: Int32?, newMessages: [Api.Message], otherUpdates: [Api.Update], chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.pts = pts
                self.timeout = timeout
                self.newMessages = newMessages
                self.otherUpdates = otherUpdates
                self.chats = chats
                self.users = users
            }
        }
        class Cons_channelDifferenceEmpty: TypeConstructorDescription {
            var flags: Int32
            var pts: Int32
            var timeout: Int32?
            init(flags: Int32, pts: Int32, timeout: Int32?) {
                self.flags = flags
                self.pts = pts
                self.timeout = timeout
            }
        }
        class Cons_channelDifferenceTooLong: TypeConstructorDescription {
            var flags: Int32
            var timeout: Int32?
            var dialog: Api.Dialog
            var messages: [Api.Message]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, timeout: Int32?, dialog: Api.Dialog, messages: [Api.Message], chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.timeout = timeout
                self.dialog = dialog
                self.messages = messages
                self.chats = chats
                self.users = users
            }
        }
        case channelDifference(Cons_channelDifference)
        case channelDifferenceEmpty(Cons_channelDifferenceEmpty)
        case channelDifferenceTooLong(Cons_channelDifferenceTooLong)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .channelDifference(let _data):
                if boxed {
                    buffer.appendInt32(543450958)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.timeout!, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.newMessages.count))
                for item in _data.newMessages {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.otherUpdates.count))
                for item in _data.otherUpdates {
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
            case .channelDifferenceEmpty(let _data):
                if boxed {
                    buffer.appendInt32(1041346555)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.timeout!, buffer: buffer, boxed: false)
                }
                break
            case .channelDifferenceTooLong(let _data):
                if boxed {
                    buffer.appendInt32(-1531132162)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.timeout!, buffer: buffer, boxed: false)
                }
                _data.dialog.serialize(buffer, true)
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

        static func parse_channelDifference(_ reader: BufferReader) -> ChannelDifference? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _3 = reader.readInt32()
            }
            var _4: [Api.Message]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Message.self)
            }
            var _5: [Api.Update]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Update.self)
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
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.updates.ChannelDifference.channelDifference(Cons_channelDifference(flags: _1!, pts: _2!, timeout: _3, newMessages: _4!, otherUpdates: _5!, chats: _6!, users: _7!))
            }
            else {
                return nil
            }
        }
        static func parse_channelDifferenceEmpty(_ reader: BufferReader) -> ChannelDifference? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _3 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.updates.ChannelDifference.channelDifferenceEmpty(Cons_channelDifferenceEmpty(flags: _1!, pts: _2!, timeout: _3))
            }
            else {
                return nil
            }
        }
        static func parse_channelDifferenceTooLong(_ reader: BufferReader) -> ChannelDifference? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _2 = reader.readInt32()
            }
            var _3: Api.Dialog?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Dialog
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
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.updates.ChannelDifference.channelDifferenceTooLong(Cons_channelDifferenceTooLong(flags: _1!, timeout: _2, dialog: _3!, messages: _4!, chats: _5!, users: _6!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.updates {
    enum Difference: TypeConstructorDescription {
        class Cons_difference: TypeConstructorDescription {
            var newMessages: [Api.Message]
            var newEncryptedMessages: [Api.EncryptedMessage]
            var otherUpdates: [Api.Update]
            var chats: [Api.Chat]
            var users: [Api.User]
            var state: Api.updates.State
            init(newMessages: [Api.Message], newEncryptedMessages: [Api.EncryptedMessage], otherUpdates: [Api.Update], chats: [Api.Chat], users: [Api.User], state: Api.updates.State) {
                self.newMessages = newMessages
                self.newEncryptedMessages = newEncryptedMessages
                self.otherUpdates = otherUpdates
                self.chats = chats
                self.users = users
                self.state = state
            }
        }
        class Cons_differenceEmpty: TypeConstructorDescription {
            var date: Int32
            var seq: Int32
            init(date: Int32, seq: Int32) {
                self.date = date
                self.seq = seq
            }
        }
        class Cons_differenceSlice: TypeConstructorDescription {
            var newMessages: [Api.Message]
            var newEncryptedMessages: [Api.EncryptedMessage]
            var otherUpdates: [Api.Update]
            var chats: [Api.Chat]
            var users: [Api.User]
            var intermediateState: Api.updates.State
            init(newMessages: [Api.Message], newEncryptedMessages: [Api.EncryptedMessage], otherUpdates: [Api.Update], chats: [Api.Chat], users: [Api.User], intermediateState: Api.updates.State) {
                self.newMessages = newMessages
                self.newEncryptedMessages = newEncryptedMessages
                self.otherUpdates = otherUpdates
                self.chats = chats
                self.users = users
                self.intermediateState = intermediateState
            }
        }
        class Cons_differenceTooLong: TypeConstructorDescription {
            var pts: Int32
            init(pts: Int32) {
                self.pts = pts
            }
        }
        case difference(Cons_difference)
        case differenceEmpty(Cons_differenceEmpty)
        case differenceSlice(Cons_differenceSlice)
        case differenceTooLong(Cons_differenceTooLong)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .difference(let _data):
                if boxed {
                    buffer.appendInt32(16030880)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.newMessages.count))
                for item in _data.newMessages {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.newEncryptedMessages.count))
                for item in _data.newEncryptedMessages {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.otherUpdates.count))
                for item in _data.otherUpdates {
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
            case .differenceEmpty(let _data):
                if boxed {
                    buffer.appendInt32(1567990072)
                }
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt32(_data.seq, buffer: buffer, boxed: false)
                break
            case .differenceSlice(let _data):
                if boxed {
                    buffer.appendInt32(-1459938943)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.newMessages.count))
                for item in _data.newMessages {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.newEncryptedMessages.count))
                for item in _data.newEncryptedMessages {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.otherUpdates.count))
                for item in _data.otherUpdates {
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
                _data.intermediateState.serialize(buffer, true)
                break
            case .differenceTooLong(let _data):
                if boxed {
                    buffer.appendInt32(1258196845)
                }
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_difference(_ reader: BufferReader) -> Difference? {
            var _1: [Api.Message]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Message.self)
            }
            var _2: [Api.EncryptedMessage]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.EncryptedMessage.self)
            }
            var _3: [Api.Update]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Update.self)
            }
            var _4: [Api.Chat]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _5: [Api.User]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            var _6: Api.updates.State?
            if let signature = reader.readInt32() {
                _6 = Api.parse(reader, signature: signature) as? Api.updates.State
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.updates.Difference.difference(Cons_difference(newMessages: _1!, newEncryptedMessages: _2!, otherUpdates: _3!, chats: _4!, users: _5!, state: _6!))
            }
            else {
                return nil
            }
        }
        static func parse_differenceEmpty(_ reader: BufferReader) -> Difference? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.updates.Difference.differenceEmpty(Cons_differenceEmpty(date: _1!, seq: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_differenceSlice(_ reader: BufferReader) -> Difference? {
            var _1: [Api.Message]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Message.self)
            }
            var _2: [Api.EncryptedMessage]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.EncryptedMessage.self)
            }
            var _3: [Api.Update]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Update.self)
            }
            var _4: [Api.Chat]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Chat.self)
            }
            var _5: [Api.User]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
            }
            var _6: Api.updates.State?
            if let signature = reader.readInt32() {
                _6 = Api.parse(reader, signature: signature) as? Api.updates.State
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.updates.Difference.differenceSlice(Cons_differenceSlice(newMessages: _1!, newEncryptedMessages: _2!, otherUpdates: _3!, chats: _4!, users: _5!, intermediateState: _6!))
            }
            else {
                return nil
            }
        }
        static func parse_differenceTooLong(_ reader: BufferReader) -> Difference? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.updates.Difference.differenceTooLong(Cons_differenceTooLong(pts: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.updates {
    enum State: TypeConstructorDescription {
        class Cons_state: TypeConstructorDescription {
            var pts: Int32
            var qts: Int32
            var date: Int32
            var seq: Int32
            var unreadCount: Int32
            init(pts: Int32, qts: Int32, date: Int32, seq: Int32, unreadCount: Int32) {
                self.pts = pts
                self.qts = qts
                self.date = date
                self.seq = seq
                self.unreadCount = unreadCount
            }
        }
        case state(Cons_state)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .state(let _data):
                if boxed {
                    buffer.appendInt32(-1519637954)
                }
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                serializeInt32(_data.qts, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt32(_data.seq, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadCount, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_state(_ reader: BufferReader) -> State? {
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
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.updates.State.state(Cons_state(pts: _1!, qts: _2!, date: _3!, seq: _4!, unreadCount: _5!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.users {
    enum UserFull: TypeConstructorDescription {
        class Cons_userFull: TypeConstructorDescription {
            var fullUser: Api.UserFull
            var chats: [Api.Chat]
            var users: [Api.User]
            init(fullUser: Api.UserFull, chats: [Api.Chat], users: [Api.User]) {
                self.fullUser = fullUser
                self.chats = chats
                self.users = users
            }
        }
        case userFull(Cons_userFull)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .userFull(let _data):
                if boxed {
                    buffer.appendInt32(997004590)
                }
                _data.fullUser.serialize(buffer, true)
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

        static func parse_userFull(_ reader: BufferReader) -> UserFull? {
            var _1: Api.UserFull?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.UserFull
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
                return Api.users.UserFull.userFull(Cons_userFull(fullUser: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.wallet {
    enum Card: TypeConstructorDescription {
        class Cons_card: TypeConstructorDescription {
            var flags: Int32
            var stickers: [Api.wallet.CardSticker]?
            var bgNftItem: Api.wallet.NftItem?
            var address: String
            var balance: Int64
            init(flags: Int32, stickers: [Api.wallet.CardSticker]?, bgNftItem: Api.wallet.NftItem?, address: String, balance: Int64) {
                self.flags = flags
                self.stickers = stickers
                self.bgNftItem = bgNftItem
                self.address = address
                self.balance = balance
            }
        }
        case card(Cons_card)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .card(let _data):
                if boxed {
                    buffer.appendInt32(-1898953807)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.stickers!.count))
                    for item in _data.stickers! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.bgNftItem!.serialize(buffer, true)
                }
                serializeString(_data.address, buffer: buffer, boxed: false)
                serializeInt64(_data.balance, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_card(_ reader: BufferReader) -> Card? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.wallet.CardSticker]?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.wallet.CardSticker.self)
                }
            }
            var _3: Api.wallet.NftItem?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.wallet.NftItem
                }
            }
            var _4: String?
            _4 = parseString(reader)
            var _5: Int64?
            _5 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.wallet.Card.card(Cons_card(flags: _1!, stickers: _2, bgNftItem: _3, address: _4!, balance: _5!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.wallet {
    enum CardSticker: TypeConstructorDescription {
        class Cons_cardSticker: TypeConstructorDescription {
            var coordinates: Api.MediaAreaCoordinates
            var nft: Api.wallet.NftItem
            init(coordinates: Api.MediaAreaCoordinates, nft: Api.wallet.NftItem) {
                self.coordinates = coordinates
                self.nft = nft
            }
        }
        case cardSticker(Cons_cardSticker)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .cardSticker(let _data):
                if boxed {
                    buffer.appendInt32(-218035014)
                }
                _data.coordinates.serialize(buffer, true)
                _data.nft.serialize(buffer, true)
                break
            }
        }

        static func parse_cardSticker(_ reader: BufferReader) -> CardSticker? {
            var _1: Api.MediaAreaCoordinates?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.MediaAreaCoordinates
            }
            var _2: Api.wallet.NftItem?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.wallet.NftItem
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.wallet.CardSticker.cardSticker(Cons_cardSticker(coordinates: _1!, nft: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.wallet {
    enum NftAttribute: TypeConstructorDescription {
        class Cons_nftAttribute: TypeConstructorDescription {
            var traitType: String
            var value: String
            init(traitType: String, value: String) {
                self.traitType = traitType
                self.value = value
            }
        }
        case nftAttribute(Cons_nftAttribute)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .nftAttribute(let _data):
                if boxed {
                    buffer.appendInt32(1277096206)
                }
                serializeString(_data.traitType, buffer: buffer, boxed: false)
                serializeString(_data.value, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_nftAttribute(_ reader: BufferReader) -> NftAttribute? {
            var _1: String?
            _1 = parseString(reader)
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.wallet.NftAttribute.nftAttribute(Cons_nftAttribute(traitType: _1!, value: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.wallet {
    enum NftItem: TypeConstructorDescription {
        class Cons_nftItem: TypeConstructorDescription {
            var flags: Int32
            var collectionAddress: String?
            var address: String
            var ownerAddress: String
            var index: String
            var name: String?
            var description: String?
            var image: Api.WebDocument?
            var imageSmall: Api.WebDocument?
            var contentUrl: Api.WebDocument?
            var lottie: Api.WebDocument?
            var attributes: [Api.wallet.NftAttribute]?
            var extra: Api.DataJSON?
            var gift: Api.StarGift?
            init(flags: Int32, collectionAddress: String?, address: String, ownerAddress: String, index: String, name: String?, description: String?, image: Api.WebDocument?, imageSmall: Api.WebDocument?, contentUrl: Api.WebDocument?, lottie: Api.WebDocument?, attributes: [Api.wallet.NftAttribute]?, extra: Api.DataJSON?, gift: Api.StarGift?) {
                self.flags = flags
                self.collectionAddress = collectionAddress
                self.address = address
                self.ownerAddress = ownerAddress
                self.index = index
                self.name = name
                self.description = description
                self.image = image
                self.imageSmall = imageSmall
                self.contentUrl = contentUrl
                self.lottie = lottie
                self.attributes = attributes
                self.extra = extra
                self.gift = gift
            }
        }
        case nftItem(Cons_nftItem)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .nftItem(let _data):
                if boxed {
                    buffer.appendInt32(389937907)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.collectionAddress!, buffer: buffer, boxed: false)
                }
                serializeString(_data.address, buffer: buffer, boxed: false)
                serializeString(_data.ownerAddress, buffer: buffer, boxed: false)
                serializeString(_data.index, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.name!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.description!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.image!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    _data.imageSmall!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    _data.contentUrl!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    _data.lottie!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.attributes!.count))
                    for item in _data.attributes! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    _data.extra!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    _data.gift!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_nftItem(_ reader: BufferReader) -> NftItem? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = parseString(reader)
            }
            var _3: String?
            _3 = parseString(reader)
            var _4: String?
            _4 = parseString(reader)
            var _5: String?
            _5 = parseString(reader)
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _6 = parseString(reader)
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _7 = parseString(reader)
            }
            var _8: Api.WebDocument?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.WebDocument
                }
            }
            var _9: Api.WebDocument?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.WebDocument
                }
            }
            var _10: Api.WebDocument?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                if let signature = reader.readInt32() {
                    _10 = Api.parse(reader, signature: signature) as? Api.WebDocument
                }
            }
            var _11: Api.WebDocument?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                if let signature = reader.readInt32() {
                    _11 = Api.parse(reader, signature: signature) as? Api.WebDocument
                }
            }
            var _12: [Api.wallet.NftAttribute]?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                if let _ = reader.readInt32() {
                    _12 = Api.parseVector(reader, elementSignature: 0, elementType: Api.wallet.NftAttribute.self)
                }
            }
            var _13: Api.DataJSON?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                if let signature = reader.readInt32() {
                    _13 = Api.parse(reader, signature: signature) as? Api.DataJSON
                }
            }
            var _14: Api.StarGift?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                if let signature = reader.readInt32() {
                    _14 = Api.parse(reader, signature: signature) as? Api.StarGift
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _13 != nil
            let _c14 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _14 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 {
                return Api.wallet.NftItem.nftItem(Cons_nftItem(flags: _1!, collectionAddress: _2, address: _3!, ownerAddress: _4!, index: _5!, name: _6, description: _7, image: _8, imageSmall: _9, contentUrl: _10, lottie: _11, attributes: _12, extra: _13, gift: _14))
            }
            else {
                return nil
            }
        }
    }
}
