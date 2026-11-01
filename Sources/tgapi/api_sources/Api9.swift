extension Api {
    enum InputRichMessage: TypeConstructorDescription {
        class Cons_inputRichMessage: TypeConstructorDescription {
            var flags: Int32
            var blocks: [Api.PageBlock]
            var photos: [Api.InputPhoto]?
            var documents: [Api.InputDocument]?
            var users: [Api.InputUser]?
            init(flags: Int32, blocks: [Api.PageBlock], photos: [Api.InputPhoto]?, documents: [Api.InputDocument]?, users: [Api.InputUser]?) {
                self.flags = flags
                self.blocks = blocks
                self.photos = photos
                self.documents = documents
                self.users = users
            }
        }
        class Cons_inputRichMessageHTML: TypeConstructorDescription {
            var flags: Int32
            var html: String
            var files: [Api.InputRichFile]?
            init(flags: Int32, html: String, files: [Api.InputRichFile]?) {
                self.flags = flags
                self.html = html
                self.files = files
            }
        }
        class Cons_inputRichMessageMarkdown: TypeConstructorDescription {
            var flags: Int32
            var markdown: String
            var files: [Api.InputRichFile]?
            init(flags: Int32, markdown: String, files: [Api.InputRichFile]?) {
                self.flags = flags
                self.markdown = markdown
                self.files = files
            }
        }
        case inputRichMessage(Cons_inputRichMessage)
        case inputRichMessageHTML(Cons_inputRichMessageHTML)
        case inputRichMessageMarkdown(Cons_inputRichMessageMarkdown)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputRichMessage(let _data):
                if boxed {
                    buffer.appendInt32(-456898052)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.blocks.count))
                for item in _data.blocks {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.photos!.count))
                    for item in _data.photos! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.documents!.count))
                    for item in _data.documents! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.users!.count))
                    for item in _data.users! {
                        item.serialize(buffer, true)
                    }
                }
                break
            case .inputRichMessageHTML(let _data):
                if boxed {
                    buffer.appendInt32(-624196758)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.html, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.files!.count))
                    for item in _data.files! {
                        item.serialize(buffer, true)
                    }
                }
                break
            case .inputRichMessageMarkdown(let _data):
                if boxed {
                    buffer.appendInt32(4937516)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.markdown, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.files!.count))
                    for item in _data.files! {
                        item.serialize(buffer, true)
                    }
                }
                break
            }
        }

        static func parse_inputRichMessage(_ reader: BufferReader) -> InputRichMessage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.PageBlock]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageBlock.self)
            }
            var _3: [Api.InputPhoto]?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let _ = reader.readInt32() {
                    _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.InputPhoto.self)
                }
            }
            var _4: [Api.InputDocument]?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let _ = reader.readInt32() {
                    _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.InputDocument.self)
                }
            }
            var _5: [Api.InputUser]?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let _ = reader.readInt32() {
                    _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.InputUser.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.InputRichMessage.inputRichMessage(Cons_inputRichMessage(flags: _1!, blocks: _2!, photos: _3, documents: _4, users: _5))
            }
            else {
                return nil
            }
        }
        static func parse_inputRichMessageHTML(_ reader: BufferReader) -> InputRichMessage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: [Api.InputRichFile]?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let _ = reader.readInt32() {
                    _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.InputRichFile.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.InputRichMessage.inputRichMessageHTML(Cons_inputRichMessageHTML(flags: _1!, html: _2!, files: _3))
            }
            else {
                return nil
            }
        }
        static func parse_inputRichMessageMarkdown(_ reader: BufferReader) -> InputRichMessage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: [Api.InputRichFile]?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let _ = reader.readInt32() {
                    _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.InputRichFile.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.InputRichMessage.inputRichMessageMarkdown(Cons_inputRichMessageMarkdown(flags: _1!, markdown: _2!, files: _3))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum InputSavedStarGift: TypeConstructorDescription {
        class Cons_inputSavedStarGiftChat: TypeConstructorDescription {
            var peer: Api.InputPeer
            var savedId: Int64
            init(peer: Api.InputPeer, savedId: Int64) {
                self.peer = peer
                self.savedId = savedId
            }
        }
        class Cons_inputSavedStarGiftSlug: TypeConstructorDescription {
            var slug: String
            init(slug: String) {
                self.slug = slug
            }
        }
        class Cons_inputSavedStarGiftUser: TypeConstructorDescription {
            var msgId: Int32
            init(msgId: Int32) {
                self.msgId = msgId
            }
        }
        case inputSavedStarGiftChat(Cons_inputSavedStarGiftChat)
        case inputSavedStarGiftSlug(Cons_inputSavedStarGiftSlug)
        case inputSavedStarGiftUser(Cons_inputSavedStarGiftUser)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputSavedStarGiftChat(let _data):
                if boxed {
                    buffer.appendInt32(-251549057)
                }
                _data.peer.serialize(buffer, true)
                serializeInt64(_data.savedId, buffer: buffer, boxed: false)
                break
            case .inputSavedStarGiftSlug(let _data):
                if boxed {
                    buffer.appendInt32(545636920)
                }
                serializeString(_data.slug, buffer: buffer, boxed: false)
                break
            case .inputSavedStarGiftUser(let _data):
                if boxed {
                    buffer.appendInt32(1764202389)
                }
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_inputSavedStarGiftChat(_ reader: BufferReader) -> InputSavedStarGift? {
            var _1: Api.InputPeer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputPeer
            }
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.InputSavedStarGift.inputSavedStarGiftChat(Cons_inputSavedStarGiftChat(peer: _1!, savedId: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_inputSavedStarGiftSlug(_ reader: BufferReader) -> InputSavedStarGift? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputSavedStarGift.inputSavedStarGiftSlug(Cons_inputSavedStarGiftSlug(slug: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inputSavedStarGiftUser(_ reader: BufferReader) -> InputSavedStarGift? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputSavedStarGift.inputSavedStarGiftUser(Cons_inputSavedStarGiftUser(msgId: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum InputStickerSet: TypeConstructorDescription {
        class Cons_inputStickerSetDice: TypeConstructorDescription {
            var emoticon: String
            init(emoticon: String) {
                self.emoticon = emoticon
            }
        }
        class Cons_inputStickerSetID: TypeConstructorDescription {
            var id: Int64
            var accessHash: Int64
            init(id: Int64, accessHash: Int64) {
                self.id = id
                self.accessHash = accessHash
            }
        }
        class Cons_inputStickerSetShortName: TypeConstructorDescription {
            var shortName: String
            init(shortName: String) {
                self.shortName = shortName
            }
        }
        case inputStickerSetAnimatedEmoji
        case inputStickerSetAnimatedEmojiAnimations
        case inputStickerSetDice(Cons_inputStickerSetDice)
        case inputStickerSetEmojiChannelDefaultStatuses
        case inputStickerSetEmojiDefaultStatuses
        case inputStickerSetEmojiDefaultTopicIcons
        case inputStickerSetEmojiGenericAnimations
        case inputStickerSetEmpty
        case inputStickerSetID(Cons_inputStickerSetID)
        case inputStickerSetPremiumGifts
        case inputStickerSetShortName(Cons_inputStickerSetShortName)
        case inputStickerSetTonGifts

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputStickerSetAnimatedEmoji:
                if boxed {
                    buffer.appendInt32(42402760)
                }
                break
            case .inputStickerSetAnimatedEmojiAnimations:
                if boxed {
                    buffer.appendInt32(215889721)
                }
                break
            case .inputStickerSetDice(let _data):
                if boxed {
                    buffer.appendInt32(-427863538)
                }
                serializeString(_data.emoticon, buffer: buffer, boxed: false)
                break
            case .inputStickerSetEmojiChannelDefaultStatuses:
                if boxed {
                    buffer.appendInt32(1232373075)
                }
                break
            case .inputStickerSetEmojiDefaultStatuses:
                if boxed {
                    buffer.appendInt32(701560302)
                }
                break
            case .inputStickerSetEmojiDefaultTopicIcons:
                if boxed {
                    buffer.appendInt32(1153562857)
                }
                break
            case .inputStickerSetEmojiGenericAnimations:
                if boxed {
                    buffer.appendInt32(80008398)
                }
                break
            case .inputStickerSetEmpty:
                if boxed {
                    buffer.appendInt32(-4838507)
                }
                break
            case .inputStickerSetID(let _data):
                if boxed {
                    buffer.appendInt32(-1645763991)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                break
            case .inputStickerSetPremiumGifts:
                if boxed {
                    buffer.appendInt32(-930399486)
                }
                break
            case .inputStickerSetShortName(let _data):
                if boxed {
                    buffer.appendInt32(-2044933984)
                }
                serializeString(_data.shortName, buffer: buffer, boxed: false)
                break
            case .inputStickerSetTonGifts:
                if boxed {
                    buffer.appendInt32(485912992)
                }
                break
            }
        }

        static func parse_inputStickerSetAnimatedEmoji(_ reader: BufferReader) -> InputStickerSet? {
            return Api.InputStickerSet.inputStickerSetAnimatedEmoji
        }
        static func parse_inputStickerSetAnimatedEmojiAnimations(_ reader: BufferReader) -> InputStickerSet? {
            return Api.InputStickerSet.inputStickerSetAnimatedEmojiAnimations
        }
        static func parse_inputStickerSetDice(_ reader: BufferReader) -> InputStickerSet? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputStickerSet.inputStickerSetDice(Cons_inputStickerSetDice(emoticon: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inputStickerSetEmojiChannelDefaultStatuses(_ reader: BufferReader) -> InputStickerSet? {
            return Api.InputStickerSet.inputStickerSetEmojiChannelDefaultStatuses
        }
        static func parse_inputStickerSetEmojiDefaultStatuses(_ reader: BufferReader) -> InputStickerSet? {
            return Api.InputStickerSet.inputStickerSetEmojiDefaultStatuses
        }
        static func parse_inputStickerSetEmojiDefaultTopicIcons(_ reader: BufferReader) -> InputStickerSet? {
            return Api.InputStickerSet.inputStickerSetEmojiDefaultTopicIcons
        }
        static func parse_inputStickerSetEmojiGenericAnimations(_ reader: BufferReader) -> InputStickerSet? {
            return Api.InputStickerSet.inputStickerSetEmojiGenericAnimations
        }
        static func parse_inputStickerSetEmpty(_ reader: BufferReader) -> InputStickerSet? {
            return Api.InputStickerSet.inputStickerSetEmpty
        }
        static func parse_inputStickerSetID(_ reader: BufferReader) -> InputStickerSet? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.InputStickerSet.inputStickerSetID(Cons_inputStickerSetID(id: _1!, accessHash: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_inputStickerSetPremiumGifts(_ reader: BufferReader) -> InputStickerSet? {
            return Api.InputStickerSet.inputStickerSetPremiumGifts
        }
        static func parse_inputStickerSetShortName(_ reader: BufferReader) -> InputStickerSet? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputStickerSet.inputStickerSetShortName(Cons_inputStickerSetShortName(shortName: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inputStickerSetTonGifts(_ reader: BufferReader) -> InputStickerSet? {
            return Api.InputStickerSet.inputStickerSetTonGifts
        }
    }
}
extension Api {
    indirect enum InputUser: TypeConstructorDescription {
        class Cons_inputUser: TypeConstructorDescription {
            var userId: Int64
            var accessHash: Int64
            init(userId: Int64, accessHash: Int64) {
                self.userId = userId
                self.accessHash = accessHash
            }
        }
        class Cons_inputUserFromMessage: TypeConstructorDescription {
            var peer: Api.InputPeer
            var msgId: Int32
            var userId: Int64
            init(peer: Api.InputPeer, msgId: Int32, userId: Int64) {
                self.peer = peer
                self.msgId = msgId
                self.userId = userId
            }
        }
        case inputUser(Cons_inputUser)
        case inputUserEmpty
        case inputUserFromMessage(Cons_inputUserFromMessage)
        case inputUserSelf

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputUser(let _data):
                if boxed {
                    buffer.appendInt32(-233744186)
                }
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                break
            case .inputUserEmpty:
                if boxed {
                    buffer.appendInt32(-1182234929)
                }
                break
            case .inputUserFromMessage(let _data):
                if boxed {
                    buffer.appendInt32(497305826)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                break
            case .inputUserSelf:
                if boxed {
                    buffer.appendInt32(-138301121)
                }
                break
            }
        }

        static func parse_inputUser(_ reader: BufferReader) -> InputUser? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.InputUser.inputUser(Cons_inputUser(userId: _1!, accessHash: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_inputUserEmpty(_ reader: BufferReader) -> InputUser? {
            return Api.InputUser.inputUserEmpty
        }
        static func parse_inputUserFromMessage(_ reader: BufferReader) -> InputUser? {
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
                return Api.InputUser.inputUserFromMessage(Cons_inputUserFromMessage(peer: _1!, msgId: _2!, userId: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_inputUserSelf(_ reader: BufferReader) -> InputUser? {
            return Api.InputUser.inputUserSelf
        }
    }
}
extension Api {
    enum InputWebDocument: TypeConstructorDescription {
        class Cons_inputWebDocument: TypeConstructorDescription {
            var url: String
            var size: Int32
            var mimeType: String
            var attributes: [Api.DocumentAttribute]
            init(url: String, size: Int32, mimeType: String, attributes: [Api.DocumentAttribute]) {
                self.url = url
                self.size = size
                self.mimeType = mimeType
                self.attributes = attributes
            }
        }
        case inputWebDocument(Cons_inputWebDocument)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputWebDocument(let _data):
                if boxed {
                    buffer.appendInt32(-1678949555)
                }
                serializeString(_data.url, buffer: buffer, boxed: false)
                serializeInt32(_data.size, buffer: buffer, boxed: false)
                serializeString(_data.mimeType, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.attributes.count))
                for item in _data.attributes {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_inputWebDocument(_ reader: BufferReader) -> InputWebDocument? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: String?
            _3 = parseString(reader)
            var _4: [Api.DocumentAttribute]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.DocumentAttribute.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.InputWebDocument.inputWebDocument(Cons_inputWebDocument(url: _1!, size: _2!, mimeType: _3!, attributes: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum Invoice: TypeConstructorDescription {
        class Cons_invoice: TypeConstructorDescription {
            var flags: Int32
            var currency: String
            var prices: [Api.LabeledPrice]
            var maxTipAmount: Int64?
            var suggestedTipAmounts: [Int64]?
            var termsUrl: String?
            var subscriptionPeriod: Int32?
            init(flags: Int32, currency: String, prices: [Api.LabeledPrice], maxTipAmount: Int64?, suggestedTipAmounts: [Int64]?, termsUrl: String?, subscriptionPeriod: Int32?) {
                self.flags = flags
                self.currency = currency
                self.prices = prices
                self.maxTipAmount = maxTipAmount
                self.suggestedTipAmounts = suggestedTipAmounts
                self.termsUrl = termsUrl
                self.subscriptionPeriod = subscriptionPeriod
            }
        }
        case invoice(Cons_invoice)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .invoice(let _data):
                if boxed {
                    buffer.appendInt32(77522308)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.currency, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.prices.count))
                for item in _data.prices {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    serializeInt64(_data.maxTipAmount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.suggestedTipAmounts!.count))
                    for item in _data.suggestedTipAmounts! {
                        serializeInt64(item, buffer: buffer, boxed: false)
                    }
                }
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    serializeString(_data.termsUrl!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    serializeInt32(_data.subscriptionPeriod!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_invoice(_ reader: BufferReader) -> Invoice? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: [Api.LabeledPrice]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.LabeledPrice.self)
            }
            var _4: Int64?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                _4 = reader.readInt64()
            }
            var _5: [Int64]?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                if let _ = reader.readInt32() {
                    _5 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
                }
            }
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                _6 = parseString(reader)
            }
            var _7: Int32?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                _7 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.Invoice.invoice(Cons_invoice(flags: _1!, currency: _2!, prices: _3!, maxTipAmount: _4, suggestedTipAmounts: _5, termsUrl: _6, subscriptionPeriod: _7))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum JoinChatBotResult: TypeConstructorDescription {
        class Cons_joinChatBotResultWebView: TypeConstructorDescription {
            var url: String
            init(url: String) {
                self.url = url
            }
        }
        case joinChatBotResultApproved
        case joinChatBotResultDeclined
        case joinChatBotResultQueued
        case joinChatBotResultWebView(Cons_joinChatBotResultWebView)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .joinChatBotResultApproved:
                if boxed {
                    buffer.appendInt32(-1374344599)
                }
                break
            case .joinChatBotResultDeclined:
                if boxed {
                    buffer.appendInt32(251265428)
                }
                break
            case .joinChatBotResultQueued:
                if boxed {
                    buffer.appendInt32(-1734105024)
                }
                break
            case .joinChatBotResultWebView(let _data):
                if boxed {
                    buffer.appendInt32(-689719277)
                }
                serializeString(_data.url, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_joinChatBotResultApproved(_ reader: BufferReader) -> JoinChatBotResult? {
            return Api.JoinChatBotResult.joinChatBotResultApproved
        }
        static func parse_joinChatBotResultDeclined(_ reader: BufferReader) -> JoinChatBotResult? {
            return Api.JoinChatBotResult.joinChatBotResultDeclined
        }
        static func parse_joinChatBotResultQueued(_ reader: BufferReader) -> JoinChatBotResult? {
            return Api.JoinChatBotResult.joinChatBotResultQueued
        }
        static func parse_joinChatBotResultWebView(_ reader: BufferReader) -> JoinChatBotResult? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.JoinChatBotResult.joinChatBotResultWebView(Cons_joinChatBotResultWebView(url: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum KeyboardButton: TypeConstructorDescription {
        class Cons_keyboardButton: TypeConstructorDescription {
            var flags: Int32
            var style: Api.KeyboardButtonStyle?
            var text: String
            var type: Api.ButtonType
            init(flags: Int32, style: Api.KeyboardButtonStyle?, text: String, type: Api.ButtonType) {
                self.flags = flags
                self.style = style
                self.text = text
                self.type = type
            }
        }
        case keyboardButton(Cons_keyboardButton)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .keyboardButton(let _data):
                if boxed {
                    buffer.appendInt32(795322159)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    _data.style!.serialize(buffer, true)
                }
                serializeString(_data.text, buffer: buffer, boxed: false)
                _data.type.serialize(buffer, true)
                break
            }
        }

        static func parse_keyboardButton(_ reader: BufferReader) -> KeyboardButton? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.KeyboardButtonStyle?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.KeyboardButtonStyle
                }
            }
            var _3: String?
            _3 = parseString(reader)
            var _4: Api.ButtonType?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.ButtonType
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.KeyboardButton.keyboardButton(Cons_keyboardButton(flags: _1!, style: _2, text: _3!, type: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum KeyboardButtonRow: TypeConstructorDescription {
        class Cons_keyboardButtonRow: TypeConstructorDescription {
            var buttons: [Api.KeyboardButton]
            init(buttons: [Api.KeyboardButton]) {
                self.buttons = buttons
            }
        }
        case keyboardButtonRow(Cons_keyboardButtonRow)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .keyboardButtonRow(let _data):
                if boxed {
                    buffer.appendInt32(2002815875)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.buttons.count))
                for item in _data.buttons {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_keyboardButtonRow(_ reader: BufferReader) -> KeyboardButtonRow? {
            var _1: [Api.KeyboardButton]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.KeyboardButton.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.KeyboardButtonRow.keyboardButtonRow(Cons_keyboardButtonRow(buttons: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum KeyboardButtonStyle: TypeConstructorDescription {
        class Cons_keyboardButtonStyle: TypeConstructorDescription {
            var flags: Int32
            var icon: Int64?
            init(flags: Int32, icon: Int64?) {
                self.flags = flags
                self.icon = icon
            }
        }
        case keyboardButtonStyle(Cons_keyboardButtonStyle)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .keyboardButtonStyle(let _data):
                if boxed {
                    buffer.appendInt32(1339896880)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt64(_data.icon!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_keyboardButtonStyle(_ reader: BufferReader) -> KeyboardButtonStyle? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _2 = reader.readInt64()
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _2 != nil
            if _c1 && _c2 {
                return Api.KeyboardButtonStyle.keyboardButtonStyle(Cons_keyboardButtonStyle(flags: _1!, icon: _2))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum KeyboardInlineButton: TypeConstructorDescription {
        class Cons_keyboardInlineButton: TypeConstructorDescription {
            var flags: Int32
            var style: Api.KeyboardButtonStyle?
            var text: String
            var type: Api.InlineButtonType
            init(flags: Int32, style: Api.KeyboardButtonStyle?, text: String, type: Api.InlineButtonType) {
                self.flags = flags
                self.style = style
                self.text = text
                self.type = type
            }
        }
        case keyboardInlineButton(Cons_keyboardInlineButton)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .keyboardInlineButton(let _data):
                if boxed {
                    buffer.appendInt32(297902882)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    _data.style!.serialize(buffer, true)
                }
                serializeString(_data.text, buffer: buffer, boxed: false)
                _data.type.serialize(buffer, true)
                break
            }
        }

        static func parse_keyboardInlineButton(_ reader: BufferReader) -> KeyboardInlineButton? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.KeyboardButtonStyle?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.KeyboardButtonStyle
                }
            }
            var _3: String?
            _3 = parseString(reader)
            var _4: Api.InlineButtonType?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.InlineButtonType
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.KeyboardInlineButton.keyboardInlineButton(Cons_keyboardInlineButton(flags: _1!, style: _2, text: _3!, type: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum KeyboardInlineButtonRow: TypeConstructorDescription {
        class Cons_keyboardInlineButtonRow: TypeConstructorDescription {
            var buttons: [Api.KeyboardInlineButton]
            init(buttons: [Api.KeyboardInlineButton]) {
                self.buttons = buttons
            }
        }
        case keyboardInlineButtonRow(Cons_keyboardInlineButtonRow)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .keyboardInlineButtonRow(let _data):
                if boxed {
                    buffer.appendInt32(423758582)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.buttons.count))
                for item in _data.buttons {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_keyboardInlineButtonRow(_ reader: BufferReader) -> KeyboardInlineButtonRow? {
            var _1: [Api.KeyboardInlineButton]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.KeyboardInlineButton.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.KeyboardInlineButtonRow.keyboardInlineButtonRow(Cons_keyboardInlineButtonRow(buttons: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum LabeledPrice: TypeConstructorDescription {
        class Cons_labeledPrice: TypeConstructorDescription {
            var label: String
            var amount: Int64
            init(label: String, amount: Int64) {
                self.label = label
                self.amount = amount
            }
        }
        case labeledPrice(Cons_labeledPrice)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .labeledPrice(let _data):
                if boxed {
                    buffer.appendInt32(-886477832)
                }
                serializeString(_data.label, buffer: buffer, boxed: false)
                serializeInt64(_data.amount, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_labeledPrice(_ reader: BufferReader) -> LabeledPrice? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.LabeledPrice.labeledPrice(Cons_labeledPrice(label: _1!, amount: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum LangPackDifference: TypeConstructorDescription {
        class Cons_langPackDifference: TypeConstructorDescription {
            var langCode: String
            var fromVersion: Int32
            var version: Int32
            var strings: [Api.LangPackString]
            init(langCode: String, fromVersion: Int32, version: Int32, strings: [Api.LangPackString]) {
                self.langCode = langCode
                self.fromVersion = fromVersion
                self.version = version
                self.strings = strings
            }
        }
        case langPackDifference(Cons_langPackDifference)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .langPackDifference(let _data):
                if boxed {
                    buffer.appendInt32(-209337866)
                }
                serializeString(_data.langCode, buffer: buffer, boxed: false)
                serializeInt32(_data.fromVersion, buffer: buffer, boxed: false)
                serializeInt32(_data.version, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.strings.count))
                for item in _data.strings {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_langPackDifference(_ reader: BufferReader) -> LangPackDifference? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: [Api.LangPackString]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.LangPackString.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.LangPackDifference.langPackDifference(Cons_langPackDifference(langCode: _1!, fromVersion: _2!, version: _3!, strings: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum LangPackString: TypeConstructorDescription {
        class Cons_langPackString: TypeConstructorDescription {
            var key: String
            var value: String
            init(key: String, value: String) {
                self.key = key
                self.value = value
            }
        }
        class Cons_langPackStringDeleted: TypeConstructorDescription {
            var key: String
            init(key: String) {
                self.key = key
            }
        }
        class Cons_langPackStringPluralized: TypeConstructorDescription {
            var flags: Int32
            var key: String
            var zeroValue: String?
            var oneValue: String?
            var twoValue: String?
            var fewValue: String?
            var manyValue: String?
            var otherValue: String
            init(flags: Int32, key: String, zeroValue: String?, oneValue: String?, twoValue: String?, fewValue: String?, manyValue: String?, otherValue: String) {
                self.flags = flags
                self.key = key
                self.zeroValue = zeroValue
                self.oneValue = oneValue
                self.twoValue = twoValue
                self.fewValue = fewValue
                self.manyValue = manyValue
                self.otherValue = otherValue
            }
        }
        case langPackString(Cons_langPackString)
        case langPackStringDeleted(Cons_langPackStringDeleted)
        case langPackStringPluralized(Cons_langPackStringPluralized)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .langPackString(let _data):
                if boxed {
                    buffer.appendInt32(-892239370)
                }
                serializeString(_data.key, buffer: buffer, boxed: false)
                serializeString(_data.value, buffer: buffer, boxed: false)
                break
            case .langPackStringDeleted(let _data):
                if boxed {
                    buffer.appendInt32(695856818)
                }
                serializeString(_data.key, buffer: buffer, boxed: false)
                break
            case .langPackStringPluralized(let _data):
                if boxed {
                    buffer.appendInt32(1816636575)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.key, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.zeroValue!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.oneValue!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.twoValue!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.fewValue!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeString(_data.manyValue!, buffer: buffer, boxed: false)
                }
                serializeString(_data.otherValue, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_langPackString(_ reader: BufferReader) -> LangPackString? {
            var _1: String?
            _1 = parseString(reader)
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.LangPackString.langPackString(Cons_langPackString(key: _1!, value: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_langPackStringDeleted(_ reader: BufferReader) -> LangPackString? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.LangPackString.langPackStringDeleted(Cons_langPackStringDeleted(key: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_langPackStringPluralized(_ reader: BufferReader) -> LangPackString? {
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
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _6 = parseString(reader)
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _7 = parseString(reader)
            }
            var _8: String?
            _8 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _7 != nil
            let _c8 = _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.LangPackString.langPackStringPluralized(Cons_langPackStringPluralized(flags: _1!, key: _2!, zeroValue: _3, oneValue: _4, twoValue: _5, fewValue: _6, manyValue: _7, otherValue: _8!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum MaskCoords: TypeConstructorDescription {
        class Cons_maskCoords: TypeConstructorDescription {
            var n: Int32
            var x: Double
            var y: Double
            var zoom: Double
            init(n: Int32, x: Double, y: Double, zoom: Double) {
                self.n = n
                self.x = x
                self.y = y
                self.zoom = zoom
            }
        }
        case maskCoords(Cons_maskCoords)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .maskCoords(let _data):
                if boxed {
                    buffer.appendInt32(-1361650766)
                }
                serializeInt32(_data.n, buffer: buffer, boxed: false)
                serializeDouble(_data.x, buffer: buffer, boxed: false)
                serializeDouble(_data.y, buffer: buffer, boxed: false)
                serializeDouble(_data.zoom, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_maskCoords(_ reader: BufferReader) -> MaskCoords? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Double?
            _2 = reader.readDouble()
            var _3: Double?
            _3 = reader.readDouble()
            var _4: Double?
            _4 = reader.readDouble()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.MaskCoords.maskCoords(Cons_maskCoords(n: _1!, x: _2!, y: _3!, zoom: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum MediaArea: TypeConstructorDescription {
        class Cons_inputMediaAreaChannelPost: TypeConstructorDescription {
            var coordinates: Api.MediaAreaCoordinates
            var channel: Api.InputChannel
            var msgId: Int32
            init(coordinates: Api.MediaAreaCoordinates, channel: Api.InputChannel, msgId: Int32) {
                self.coordinates = coordinates
                self.channel = channel
                self.msgId = msgId
            }
        }
        class Cons_inputMediaAreaVenue: TypeConstructorDescription {
            var coordinates: Api.MediaAreaCoordinates
            var queryId: Int64
            var resultId: String
            init(coordinates: Api.MediaAreaCoordinates, queryId: Int64, resultId: String) {
                self.coordinates = coordinates
                self.queryId = queryId
                self.resultId = resultId
            }
        }
        class Cons_mediaAreaChannelPost: TypeConstructorDescription {
            var coordinates: Api.MediaAreaCoordinates
            var channelId: Int64
            var msgId: Int32
            init(coordinates: Api.MediaAreaCoordinates, channelId: Int64, msgId: Int32) {
                self.coordinates = coordinates
                self.channelId = channelId
                self.msgId = msgId
            }
        }
        class Cons_mediaAreaGeoPoint: TypeConstructorDescription {
            var flags: Int32
            var coordinates: Api.MediaAreaCoordinates
            var geo: Api.GeoPoint
            var address: Api.GeoPointAddress?
            init(flags: Int32, coordinates: Api.MediaAreaCoordinates, geo: Api.GeoPoint, address: Api.GeoPointAddress?) {
                self.flags = flags
                self.coordinates = coordinates
                self.geo = geo
                self.address = address
            }
        }
        class Cons_mediaAreaStarGift: TypeConstructorDescription {
            var coordinates: Api.MediaAreaCoordinates
            var slug: String
            init(coordinates: Api.MediaAreaCoordinates, slug: String) {
                self.coordinates = coordinates
                self.slug = slug
            }
        }
        class Cons_mediaAreaSuggestedReaction: TypeConstructorDescription {
            var flags: Int32
            var coordinates: Api.MediaAreaCoordinates
            var reaction: Api.Reaction
            init(flags: Int32, coordinates: Api.MediaAreaCoordinates, reaction: Api.Reaction) {
                self.flags = flags
                self.coordinates = coordinates
                self.reaction = reaction
            }
        }
        class Cons_mediaAreaUrl: TypeConstructorDescription {
            var coordinates: Api.MediaAreaCoordinates
            var url: String
            init(coordinates: Api.MediaAreaCoordinates, url: String) {
                self.coordinates = coordinates
                self.url = url
            }
        }
        class Cons_mediaAreaVenue: TypeConstructorDescription {
            var coordinates: Api.MediaAreaCoordinates
            var geo: Api.GeoPoint
            var title: String
            var address: String
            var provider: String
            var venueId: String
            var venueType: String
            init(coordinates: Api.MediaAreaCoordinates, geo: Api.GeoPoint, title: String, address: String, provider: String, venueId: String, venueType: String) {
                self.coordinates = coordinates
                self.geo = geo
                self.title = title
                self.address = address
                self.provider = provider
                self.venueId = venueId
                self.venueType = venueType
            }
        }
        class Cons_mediaAreaWeather: TypeConstructorDescription {
            var coordinates: Api.MediaAreaCoordinates
            var emoji: String
            var temperatureC: Double
            var color: Int32
            init(coordinates: Api.MediaAreaCoordinates, emoji: String, temperatureC: Double, color: Int32) {
                self.coordinates = coordinates
                self.emoji = emoji
                self.temperatureC = temperatureC
                self.color = color
            }
        }
        case inputMediaAreaChannelPost(Cons_inputMediaAreaChannelPost)
        case inputMediaAreaVenue(Cons_inputMediaAreaVenue)
        case mediaAreaChannelPost(Cons_mediaAreaChannelPost)
        case mediaAreaGeoPoint(Cons_mediaAreaGeoPoint)
        case mediaAreaStarGift(Cons_mediaAreaStarGift)
        case mediaAreaSuggestedReaction(Cons_mediaAreaSuggestedReaction)
        case mediaAreaUrl(Cons_mediaAreaUrl)
        case mediaAreaVenue(Cons_mediaAreaVenue)
        case mediaAreaWeather(Cons_mediaAreaWeather)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputMediaAreaChannelPost(let _data):
                if boxed {
                    buffer.appendInt32(577893055)
                }
                _data.coordinates.serialize(buffer, true)
                _data.channel.serialize(buffer, true)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                break
            case .inputMediaAreaVenue(let _data):
                if boxed {
                    buffer.appendInt32(-1300094593)
                }
                _data.coordinates.serialize(buffer, true)
                serializeInt64(_data.queryId, buffer: buffer, boxed: false)
                serializeString(_data.resultId, buffer: buffer, boxed: false)
                break
            case .mediaAreaChannelPost(let _data):
                if boxed {
                    buffer.appendInt32(1996756655)
                }
                _data.coordinates.serialize(buffer, true)
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                break
            case .mediaAreaGeoPoint(let _data):
                if boxed {
                    buffer.appendInt32(-891992787)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.coordinates.serialize(buffer, true)
                _data.geo.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.address!.serialize(buffer, true)
                }
                break
            case .mediaAreaStarGift(let _data):
                if boxed {
                    buffer.appendInt32(1468491885)
                }
                _data.coordinates.serialize(buffer, true)
                serializeString(_data.slug, buffer: buffer, boxed: false)
                break
            case .mediaAreaSuggestedReaction(let _data):
                if boxed {
                    buffer.appendInt32(340088945)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.coordinates.serialize(buffer, true)
                _data.reaction.serialize(buffer, true)
                break
            case .mediaAreaUrl(let _data):
                if boxed {
                    buffer.appendInt32(926421125)
                }
                _data.coordinates.serialize(buffer, true)
                serializeString(_data.url, buffer: buffer, boxed: false)
                break
            case .mediaAreaVenue(let _data):
                if boxed {
                    buffer.appendInt32(-1098720356)
                }
                _data.coordinates.serialize(buffer, true)
                _data.geo.serialize(buffer, true)
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeString(_data.address, buffer: buffer, boxed: false)
                serializeString(_data.provider, buffer: buffer, boxed: false)
                serializeString(_data.venueId, buffer: buffer, boxed: false)
                serializeString(_data.venueType, buffer: buffer, boxed: false)
                break
            case .mediaAreaWeather(let _data):
                if boxed {
                    buffer.appendInt32(1235637404)
                }
                _data.coordinates.serialize(buffer, true)
                serializeString(_data.emoji, buffer: buffer, boxed: false)
                serializeDouble(_data.temperatureC, buffer: buffer, boxed: false)
                serializeInt32(_data.color, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_inputMediaAreaChannelPost(_ reader: BufferReader) -> MediaArea? {
            var _1: Api.MediaAreaCoordinates?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.MediaAreaCoordinates
            }
            var _2: Api.InputChannel?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.InputChannel
            }
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MediaArea.inputMediaAreaChannelPost(Cons_inputMediaAreaChannelPost(coordinates: _1!, channel: _2!, msgId: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaAreaVenue(_ reader: BufferReader) -> MediaArea? {
            var _1: Api.MediaAreaCoordinates?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.MediaAreaCoordinates
            }
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            _3 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MediaArea.inputMediaAreaVenue(Cons_inputMediaAreaVenue(coordinates: _1!, queryId: _2!, resultId: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_mediaAreaChannelPost(_ reader: BufferReader) -> MediaArea? {
            var _1: Api.MediaAreaCoordinates?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.MediaAreaCoordinates
            }
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MediaArea.mediaAreaChannelPost(Cons_mediaAreaChannelPost(coordinates: _1!, channelId: _2!, msgId: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_mediaAreaGeoPoint(_ reader: BufferReader) -> MediaArea? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.MediaAreaCoordinates?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.MediaAreaCoordinates
            }
            var _3: Api.GeoPoint?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.GeoPoint
            }
            var _4: Api.GeoPointAddress?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.GeoPointAddress
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.MediaArea.mediaAreaGeoPoint(Cons_mediaAreaGeoPoint(flags: _1!, coordinates: _2!, geo: _3!, address: _4))
            }
            else {
                return nil
            }
        }
        static func parse_mediaAreaStarGift(_ reader: BufferReader) -> MediaArea? {
            var _1: Api.MediaAreaCoordinates?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.MediaAreaCoordinates
            }
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MediaArea.mediaAreaStarGift(Cons_mediaAreaStarGift(coordinates: _1!, slug: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_mediaAreaSuggestedReaction(_ reader: BufferReader) -> MediaArea? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.MediaAreaCoordinates?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.MediaAreaCoordinates
            }
            var _3: Api.Reaction?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Reaction
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MediaArea.mediaAreaSuggestedReaction(Cons_mediaAreaSuggestedReaction(flags: _1!, coordinates: _2!, reaction: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_mediaAreaUrl(_ reader: BufferReader) -> MediaArea? {
            var _1: Api.MediaAreaCoordinates?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.MediaAreaCoordinates
            }
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MediaArea.mediaAreaUrl(Cons_mediaAreaUrl(coordinates: _1!, url: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_mediaAreaVenue(_ reader: BufferReader) -> MediaArea? {
            var _1: Api.MediaAreaCoordinates?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.MediaAreaCoordinates
            }
            var _2: Api.GeoPoint?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.GeoPoint
            }
            var _3: String?
            _3 = parseString(reader)
            var _4: String?
            _4 = parseString(reader)
            var _5: String?
            _5 = parseString(reader)
            var _6: String?
            _6 = parseString(reader)
            var _7: String?
            _7 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.MediaArea.mediaAreaVenue(Cons_mediaAreaVenue(coordinates: _1!, geo: _2!, title: _3!, address: _4!, provider: _5!, venueId: _6!, venueType: _7!))
            }
            else {
                return nil
            }
        }
        static func parse_mediaAreaWeather(_ reader: BufferReader) -> MediaArea? {
            var _1: Api.MediaAreaCoordinates?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.MediaAreaCoordinates
            }
            var _2: String?
            _2 = parseString(reader)
            var _3: Double?
            _3 = reader.readDouble()
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.MediaArea.mediaAreaWeather(Cons_mediaAreaWeather(coordinates: _1!, emoji: _2!, temperatureC: _3!, color: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum MediaAreaCoordinates: TypeConstructorDescription {
        class Cons_mediaAreaCoordinates: TypeConstructorDescription {
            var flags: Int32
            var x: Double
            var y: Double
            var w: Double
            var h: Double
            var rotation: Double
            var radius: Double?
            init(flags: Int32, x: Double, y: Double, w: Double, h: Double, rotation: Double, radius: Double?) {
                self.flags = flags
                self.x = x
                self.y = y
                self.w = w
                self.h = h
                self.rotation = rotation
                self.radius = radius
            }
        }
        case mediaAreaCoordinates(Cons_mediaAreaCoordinates)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .mediaAreaCoordinates(let _data):
                if boxed {
                    buffer.appendInt32(-808853502)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeDouble(_data.x, buffer: buffer, boxed: false)
                serializeDouble(_data.y, buffer: buffer, boxed: false)
                serializeDouble(_data.w, buffer: buffer, boxed: false)
                serializeDouble(_data.h, buffer: buffer, boxed: false)
                serializeDouble(_data.rotation, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeDouble(_data.radius!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_mediaAreaCoordinates(_ reader: BufferReader) -> MediaAreaCoordinates? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Double?
            _2 = reader.readDouble()
            var _3: Double?
            _3 = reader.readDouble()
            var _4: Double?
            _4 = reader.readDouble()
            var _5: Double?
            _5 = reader.readDouble()
            var _6: Double?
            _6 = reader.readDouble()
            var _7: Double?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _7 = reader.readDouble()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.MediaAreaCoordinates.mediaAreaCoordinates(Cons_mediaAreaCoordinates(flags: _1!, x: _2!, y: _3!, w: _4!, h: _5!, rotation: _6!, radius: _7))
            }
            else {
                return nil
            }
        }
    }
}
