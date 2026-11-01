extension Api {
    indirect enum InlineButtonType: TypeConstructorDescription {
        class Cons_inlineButtonTypeCallback: TypeConstructorDescription {
            var flags: Int32
            var data: Buffer
            init(flags: Int32, data: Buffer) {
                self.flags = flags
                self.data = data
            }
        }
        class Cons_inlineButtonTypeCopy: TypeConstructorDescription {
            var copyText: String
            init(copyText: String) {
                self.copyText = copyText
            }
        }
        class Cons_inlineButtonTypeSwitchInline: TypeConstructorDescription {
            var flags: Int32
            var query: String
            var peerTypes: [Api.InlineQueryPeerType]?
            init(flags: Int32, query: String, peerTypes: [Api.InlineQueryPeerType]?) {
                self.flags = flags
                self.query = query
                self.peerTypes = peerTypes
            }
        }
        class Cons_inlineButtonTypeUrl: TypeConstructorDescription {
            var url: String
            init(url: String) {
                self.url = url
            }
        }
        class Cons_inlineButtonTypeUrlAuth: TypeConstructorDescription {
            var flags: Int32
            var fwdText: String?
            var url: String
            var buttonId: Int32
            init(flags: Int32, fwdText: String?, url: String, buttonId: Int32) {
                self.flags = flags
                self.fwdText = fwdText
                self.url = url
                self.buttonId = buttonId
            }
        }
        class Cons_inlineButtonTypeUserProfile: TypeConstructorDescription {
            var userId: Int64
            init(userId: Int64) {
                self.userId = userId
            }
        }
        class Cons_inlineButtonTypeWebView: TypeConstructorDescription {
            var url: String
            init(url: String) {
                self.url = url
            }
        }
        class Cons_inputInlineButtonTypeUrlAuth: TypeConstructorDescription {
            var flags: Int32
            var fwdText: String?
            var url: String
            var bot: Api.InputUser?
            init(flags: Int32, fwdText: String?, url: String, bot: Api.InputUser?) {
                self.flags = flags
                self.fwdText = fwdText
                self.url = url
                self.bot = bot
            }
        }
        class Cons_inputInlineButtonTypeUserProfile: TypeConstructorDescription {
            var userId: Api.InputUser
            init(userId: Api.InputUser) {
                self.userId = userId
            }
        }
        case inlineButtonTypeBuy
        case inlineButtonTypeCallback(Cons_inlineButtonTypeCallback)
        case inlineButtonTypeCopy(Cons_inlineButtonTypeCopy)
        case inlineButtonTypeDisabled
        case inlineButtonTypeGame
        case inlineButtonTypeSwitchInline(Cons_inlineButtonTypeSwitchInline)
        case inlineButtonTypeUrl(Cons_inlineButtonTypeUrl)
        case inlineButtonTypeUrlAuth(Cons_inlineButtonTypeUrlAuth)
        case inlineButtonTypeUserProfile(Cons_inlineButtonTypeUserProfile)
        case inlineButtonTypeWebView(Cons_inlineButtonTypeWebView)
        case inputInlineButtonTypeUrlAuth(Cons_inputInlineButtonTypeUrlAuth)
        case inputInlineButtonTypeUserProfile(Cons_inputInlineButtonTypeUserProfile)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inlineButtonTypeBuy:
                if boxed {
                    buffer.appendInt32(1220204453)
                }
                break
            case .inlineButtonTypeCallback(let _data):
                if boxed {
                    buffer.appendInt32(693484600)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeBytes(_data.data, buffer: buffer, boxed: false)
                break
            case .inlineButtonTypeCopy(let _data):
                if boxed {
                    buffer.appendInt32(-1273154958)
                }
                serializeString(_data.copyText, buffer: buffer, boxed: false)
                break
            case .inlineButtonTypeDisabled:
                if boxed {
                    buffer.appendInt32(-1539808867)
                }
                break
            case .inlineButtonTypeGame:
                if boxed {
                    buffer.appendInt32(1557360797)
                }
                break
            case .inlineButtonTypeSwitchInline(let _data):
                if boxed {
                    buffer.appendInt32(-1820901387)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.query, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.peerTypes!.count))
                    for item in _data.peerTypes! {
                        item.serialize(buffer, true)
                    }
                }
                break
            case .inlineButtonTypeUrl(let _data):
                if boxed {
                    buffer.appendInt32(-324732716)
                }
                serializeString(_data.url, buffer: buffer, boxed: false)
                break
            case .inlineButtonTypeUrlAuth(let _data):
                if boxed {
                    buffer.appendInt32(-1076875870)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.fwdText!, buffer: buffer, boxed: false)
                }
                serializeString(_data.url, buffer: buffer, boxed: false)
                serializeInt32(_data.buttonId, buffer: buffer, boxed: false)
                break
            case .inlineButtonTypeUserProfile(let _data):
                if boxed {
                    buffer.appendInt32(1067663311)
                }
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                break
            case .inlineButtonTypeWebView(let _data):
                if boxed {
                    buffer.appendInt32(1003140532)
                }
                serializeString(_data.url, buffer: buffer, boxed: false)
                break
            case .inputInlineButtonTypeUrlAuth(let _data):
                if boxed {
                    buffer.appendInt32(-1721647948)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.fwdText!, buffer: buffer, boxed: false)
                }
                serializeString(_data.url, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.bot!.serialize(buffer, true)
                }
                break
            case .inputInlineButtonTypeUserProfile(let _data):
                if boxed {
                    buffer.appendInt32(1408487002)
                }
                _data.userId.serialize(buffer, true)
                break
            }
        }

        static func parse_inlineButtonTypeBuy(_ reader: BufferReader) -> InlineButtonType? {
            return Api.InlineButtonType.inlineButtonTypeBuy
        }
        static func parse_inlineButtonTypeCallback(_ reader: BufferReader) -> InlineButtonType? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Buffer?
            _2 = parseBytes(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.InlineButtonType.inlineButtonTypeCallback(Cons_inlineButtonTypeCallback(flags: _1!, data: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_inlineButtonTypeCopy(_ reader: BufferReader) -> InlineButtonType? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.InlineButtonType.inlineButtonTypeCopy(Cons_inlineButtonTypeCopy(copyText: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inlineButtonTypeDisabled(_ reader: BufferReader) -> InlineButtonType? {
            return Api.InlineButtonType.inlineButtonTypeDisabled
        }
        static func parse_inlineButtonTypeGame(_ reader: BufferReader) -> InlineButtonType? {
            return Api.InlineButtonType.inlineButtonTypeGame
        }
        static func parse_inlineButtonTypeSwitchInline(_ reader: BufferReader) -> InlineButtonType? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: [Api.InlineQueryPeerType]?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let _ = reader.readInt32() {
                    _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.InlineQueryPeerType.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.InlineButtonType.inlineButtonTypeSwitchInline(Cons_inlineButtonTypeSwitchInline(flags: _1!, query: _2!, peerTypes: _3))
            }
            else {
                return nil
            }
        }
        static func parse_inlineButtonTypeUrl(_ reader: BufferReader) -> InlineButtonType? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.InlineButtonType.inlineButtonTypeUrl(Cons_inlineButtonTypeUrl(url: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inlineButtonTypeUrlAuth(_ reader: BufferReader) -> InlineButtonType? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = parseString(reader)
            }
            var _3: String?
            _3 = parseString(reader)
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.InlineButtonType.inlineButtonTypeUrlAuth(Cons_inlineButtonTypeUrlAuth(flags: _1!, fwdText: _2, url: _3!, buttonId: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_inlineButtonTypeUserProfile(_ reader: BufferReader) -> InlineButtonType? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.InlineButtonType.inlineButtonTypeUserProfile(Cons_inlineButtonTypeUserProfile(userId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inlineButtonTypeWebView(_ reader: BufferReader) -> InlineButtonType? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.InlineButtonType.inlineButtonTypeWebView(Cons_inlineButtonTypeWebView(url: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inputInlineButtonTypeUrlAuth(_ reader: BufferReader) -> InlineButtonType? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _2 = parseString(reader)
            }
            var _3: String?
            _3 = parseString(reader)
            var _4: Api.InputUser?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.InputUser
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.InlineButtonType.inputInlineButtonTypeUrlAuth(Cons_inputInlineButtonTypeUrlAuth(flags: _1!, fwdText: _2, url: _3!, bot: _4))
            }
            else {
                return nil
            }
        }
        static func parse_inputInlineButtonTypeUserProfile(_ reader: BufferReader) -> InlineButtonType? {
            var _1: Api.InputUser?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputUser
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.InlineButtonType.inputInlineButtonTypeUserProfile(Cons_inputInlineButtonTypeUserProfile(userId: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum InlineQueryPeerType: TypeConstructorDescription {
        case inlineQueryPeerTypeBotPM
        case inlineQueryPeerTypeBroadcast
        case inlineQueryPeerTypeChat
        case inlineQueryPeerTypeMegagroup
        case inlineQueryPeerTypePM
        case inlineQueryPeerTypeSameBotPM

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inlineQueryPeerTypeBotPM:
                if boxed {
                    buffer.appendInt32(238759180)
                }
                break
            case .inlineQueryPeerTypeBroadcast:
                if boxed {
                    buffer.appendInt32(1664413338)
                }
                break
            case .inlineQueryPeerTypeChat:
                if boxed {
                    buffer.appendInt32(-681130742)
                }
                break
            case .inlineQueryPeerTypeMegagroup:
                if boxed {
                    buffer.appendInt32(1589952067)
                }
                break
            case .inlineQueryPeerTypePM:
                if boxed {
                    buffer.appendInt32(-2093215828)
                }
                break
            case .inlineQueryPeerTypeSameBotPM:
                if boxed {
                    buffer.appendInt32(813821341)
                }
                break
            }
        }

        static func parse_inlineQueryPeerTypeBotPM(_ reader: BufferReader) -> InlineQueryPeerType? {
            return Api.InlineQueryPeerType.inlineQueryPeerTypeBotPM
        }
        static func parse_inlineQueryPeerTypeBroadcast(_ reader: BufferReader) -> InlineQueryPeerType? {
            return Api.InlineQueryPeerType.inlineQueryPeerTypeBroadcast
        }
        static func parse_inlineQueryPeerTypeChat(_ reader: BufferReader) -> InlineQueryPeerType? {
            return Api.InlineQueryPeerType.inlineQueryPeerTypeChat
        }
        static func parse_inlineQueryPeerTypeMegagroup(_ reader: BufferReader) -> InlineQueryPeerType? {
            return Api.InlineQueryPeerType.inlineQueryPeerTypeMegagroup
        }
        static func parse_inlineQueryPeerTypePM(_ reader: BufferReader) -> InlineQueryPeerType? {
            return Api.InlineQueryPeerType.inlineQueryPeerTypePM
        }
        static func parse_inlineQueryPeerTypeSameBotPM(_ reader: BufferReader) -> InlineQueryPeerType? {
            return Api.InlineQueryPeerType.inlineQueryPeerTypeSameBotPM
        }
    }
}
extension Api {
    enum InputBotInlineMessageID: TypeConstructorDescription {
        class Cons_inputBotInlineMessageID: TypeConstructorDescription {
            var dcId: Int32
            var id: Int64
            var accessHash: Int64
            init(dcId: Int32, id: Int64, accessHash: Int64) {
                self.dcId = dcId
                self.id = id
                self.accessHash = accessHash
            }
        }
        class Cons_inputBotInlineMessageID64: TypeConstructorDescription {
            var dcId: Int32
            var ownerId: Int64
            var id: Int32
            var accessHash: Int64
            init(dcId: Int32, ownerId: Int64, id: Int32, accessHash: Int64) {
                self.dcId = dcId
                self.ownerId = ownerId
                self.id = id
                self.accessHash = accessHash
            }
        }
        case inputBotInlineMessageID(Cons_inputBotInlineMessageID)
        case inputBotInlineMessageID64(Cons_inputBotInlineMessageID64)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputBotInlineMessageID(let _data):
                if boxed {
                    buffer.appendInt32(-1995686519)
                }
                serializeInt32(_data.dcId, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                break
            case .inputBotInlineMessageID64(let _data):
                if boxed {
                    buffer.appendInt32(-1227287081)
                }
                serializeInt32(_data.dcId, buffer: buffer, boxed: false)
                serializeInt64(_data.ownerId, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_inputBotInlineMessageID(_ reader: BufferReader) -> InputBotInlineMessageID? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.InputBotInlineMessageID.inputBotInlineMessageID(Cons_inputBotInlineMessageID(dcId: _1!, id: _2!, accessHash: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_inputBotInlineMessageID64(_ reader: BufferReader) -> InputBotInlineMessageID? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int64?
            _4 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.InputBotInlineMessageID.inputBotInlineMessageID64(Cons_inputBotInlineMessageID64(dcId: _1!, ownerId: _2!, id: _3!, accessHash: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum InputChannel: TypeConstructorDescription {
        class Cons_inputChannel: TypeConstructorDescription {
            var channelId: Int64
            var accessHash: Int64
            init(channelId: Int64, accessHash: Int64) {
                self.channelId = channelId
                self.accessHash = accessHash
            }
        }
        class Cons_inputChannelFromMessage: TypeConstructorDescription {
            var peer: Api.InputPeer
            var msgId: Int32
            var channelId: Int64
            init(peer: Api.InputPeer, msgId: Int32, channelId: Int64) {
                self.peer = peer
                self.msgId = msgId
                self.channelId = channelId
            }
        }
        case inputChannel(Cons_inputChannel)
        case inputChannelEmpty
        case inputChannelFromMessage(Cons_inputChannelFromMessage)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputChannel(let _data):
                if boxed {
                    buffer.appendInt32(-212145112)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                break
            case .inputChannelEmpty:
                if boxed {
                    buffer.appendInt32(-292807034)
                }
                break
            case .inputChannelFromMessage(let _data):
                if boxed {
                    buffer.appendInt32(1536380829)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_inputChannel(_ reader: BufferReader) -> InputChannel? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.InputChannel.inputChannel(Cons_inputChannel(channelId: _1!, accessHash: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_inputChannelEmpty(_ reader: BufferReader) -> InputChannel? {
            return Api.InputChannel.inputChannelEmpty
        }
        static func parse_inputChannelFromMessage(_ reader: BufferReader) -> InputChannel? {
            var _1: Api.InputPeer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputPeer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int64?
            _3 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.InputChannel.inputChannelFromMessage(Cons_inputChannelFromMessage(peer: _1!, msgId: _2!, channelId: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum InputDocument: TypeConstructorDescription {
        class Cons_inputDocument: TypeConstructorDescription {
            var id: Int64
            var accessHash: Int64
            var fileReference: Buffer
            init(id: Int64, accessHash: Int64, fileReference: Buffer) {
                self.id = id
                self.accessHash = accessHash
                self.fileReference = fileReference
            }
        }
        case inputDocument(Cons_inputDocument)
        case inputDocumentEmpty

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputDocument(let _data):
                if boxed {
                    buffer.appendInt32(448771445)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeBytes(_data.fileReference, buffer: buffer, boxed: false)
                break
            case .inputDocumentEmpty:
                if boxed {
                    buffer.appendInt32(1928391342)
                }
                break
            }
        }

        static func parse_inputDocument(_ reader: BufferReader) -> InputDocument? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Buffer?
            _3 = parseBytes(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.InputDocument.inputDocument(Cons_inputDocument(id: _1!, accessHash: _2!, fileReference: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_inputDocumentEmpty(_ reader: BufferReader) -> InputDocument? {
            return Api.InputDocument.inputDocumentEmpty
        }
    }
}
extension Api {
    enum InputFile: TypeConstructorDescription {
        class Cons_inputFile: TypeConstructorDescription {
            var id: Int64
            var parts: Int32
            var name: String
            var md5Checksum: String
            init(id: Int64, parts: Int32, name: String, md5Checksum: String) {
                self.id = id
                self.parts = parts
                self.name = name
                self.md5Checksum = md5Checksum
            }
        }
        class Cons_inputFileBig: TypeConstructorDescription {
            var id: Int64
            var parts: Int32
            var name: String
            init(id: Int64, parts: Int32, name: String) {
                self.id = id
                self.parts = parts
                self.name = name
            }
        }
        class Cons_inputFileStoryDocument: TypeConstructorDescription {
            var id: Api.InputDocument
            init(id: Api.InputDocument) {
                self.id = id
            }
        }
        case inputFile(Cons_inputFile)
        case inputFileBig(Cons_inputFileBig)
        case inputFileStoryDocument(Cons_inputFileStoryDocument)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputFile(let _data):
                if boxed {
                    buffer.appendInt32(-181407105)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt32(_data.parts, buffer: buffer, boxed: false)
                serializeString(_data.name, buffer: buffer, boxed: false)
                serializeString(_data.md5Checksum, buffer: buffer, boxed: false)
                break
            case .inputFileBig(let _data):
                if boxed {
                    buffer.appendInt32(-95482955)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt32(_data.parts, buffer: buffer, boxed: false)
                serializeString(_data.name, buffer: buffer, boxed: false)
                break
            case .inputFileStoryDocument(let _data):
                if boxed {
                    buffer.appendInt32(1658620744)
                }
                _data.id.serialize(buffer, true)
                break
            }
        }

        static func parse_inputFile(_ reader: BufferReader) -> InputFile? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: String?
            _3 = parseString(reader)
            var _4: String?
            _4 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.InputFile.inputFile(Cons_inputFile(id: _1!, parts: _2!, name: _3!, md5Checksum: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_inputFileBig(_ reader: BufferReader) -> InputFile? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: String?
            _3 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.InputFile.inputFileBig(Cons_inputFileBig(id: _1!, parts: _2!, name: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_inputFileStoryDocument(_ reader: BufferReader) -> InputFile? {
            var _1: Api.InputDocument?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputDocument
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputFile.inputFileStoryDocument(Cons_inputFileStoryDocument(id: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum InputGame: TypeConstructorDescription {
        class Cons_inputGameID: TypeConstructorDescription {
            var id: Int64
            var accessHash: Int64
            init(id: Int64, accessHash: Int64) {
                self.id = id
                self.accessHash = accessHash
            }
        }
        class Cons_inputGameShortName: TypeConstructorDescription {
            var botId: Api.InputUser
            var shortName: String
            init(botId: Api.InputUser, shortName: String) {
                self.botId = botId
                self.shortName = shortName
            }
        }
        case inputGameID(Cons_inputGameID)
        case inputGameShortName(Cons_inputGameShortName)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputGameID(let _data):
                if boxed {
                    buffer.appendInt32(53231223)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                break
            case .inputGameShortName(let _data):
                if boxed {
                    buffer.appendInt32(-1020139510)
                }
                _data.botId.serialize(buffer, true)
                serializeString(_data.shortName, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_inputGameID(_ reader: BufferReader) -> InputGame? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.InputGame.inputGameID(Cons_inputGameID(id: _1!, accessHash: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_inputGameShortName(_ reader: BufferReader) -> InputGame? {
            var _1: Api.InputUser?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputUser
            }
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.InputGame.inputGameShortName(Cons_inputGameShortName(botId: _1!, shortName: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum InputGeoPoint: TypeConstructorDescription {
        class Cons_inputGeoPoint: TypeConstructorDescription {
            var flags: Int32
            var lat: Double
            var long: Double
            var accuracyRadius: Int32?
            init(flags: Int32, lat: Double, long: Double, accuracyRadius: Int32?) {
                self.flags = flags
                self.lat = lat
                self.long = long
                self.accuracyRadius = accuracyRadius
            }
        }
        case inputGeoPoint(Cons_inputGeoPoint)
        case inputGeoPointEmpty

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputGeoPoint(let _data):
                if boxed {
                    buffer.appendInt32(1210199983)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeDouble(_data.lat, buffer: buffer, boxed: false)
                serializeDouble(_data.long, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.accuracyRadius!, buffer: buffer, boxed: false)
                }
                break
            case .inputGeoPointEmpty:
                if boxed {
                    buffer.appendInt32(-457104426)
                }
                break
            }
        }

        static func parse_inputGeoPoint(_ reader: BufferReader) -> InputGeoPoint? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Double?
            _2 = reader.readDouble()
            var _3: Double?
            _3 = reader.readDouble()
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.InputGeoPoint.inputGeoPoint(Cons_inputGeoPoint(flags: _1!, lat: _2!, long: _3!, accuracyRadius: _4))
            }
            else {
                return nil
            }
        }
        static func parse_inputGeoPointEmpty(_ reader: BufferReader) -> InputGeoPoint? {
            return Api.InputGeoPoint.inputGeoPointEmpty
        }
    }
}
extension Api {
    enum InputGroupCall: TypeConstructorDescription {
        class Cons_inputGroupCall: TypeConstructorDescription {
            var id: Int64
            var accessHash: Int64
            init(id: Int64, accessHash: Int64) {
                self.id = id
                self.accessHash = accessHash
            }
        }
        class Cons_inputGroupCallInviteMessage: TypeConstructorDescription {
            var msgId: Int32
            init(msgId: Int32) {
                self.msgId = msgId
            }
        }
        class Cons_inputGroupCallSlug: TypeConstructorDescription {
            var slug: String
            init(slug: String) {
                self.slug = slug
            }
        }
        case inputGroupCall(Cons_inputGroupCall)
        case inputGroupCallInviteMessage(Cons_inputGroupCallInviteMessage)
        case inputGroupCallSlug(Cons_inputGroupCallSlug)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputGroupCall(let _data):
                if boxed {
                    buffer.appendInt32(-659913713)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                break
            case .inputGroupCallInviteMessage(let _data):
                if boxed {
                    buffer.appendInt32(-1945083841)
                }
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                break
            case .inputGroupCallSlug(let _data):
                if boxed {
                    buffer.appendInt32(-33127873)
                }
                serializeString(_data.slug, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_inputGroupCall(_ reader: BufferReader) -> InputGroupCall? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.InputGroupCall.inputGroupCall(Cons_inputGroupCall(id: _1!, accessHash: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_inputGroupCallInviteMessage(_ reader: BufferReader) -> InputGroupCall? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputGroupCall.inputGroupCallInviteMessage(Cons_inputGroupCallInviteMessage(msgId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inputGroupCallSlug(_ reader: BufferReader) -> InputGroupCall? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputGroupCall.inputGroupCallSlug(Cons_inputGroupCallSlug(slug: _1!))
            }
            else {
                return nil
            }
        }
    }
}
