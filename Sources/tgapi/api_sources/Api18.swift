extension Api {
    indirect enum RichText: TypeConstructorDescription {
        class Cons_textAnchor: TypeConstructorDescription {
            var text: Api.RichText
            var name: String
            init(text: Api.RichText, name: String) {
                self.text = text
                self.name = name
            }
        }
        class Cons_textAutoEmail: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textAutoPhone: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textAutoUrl: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textBankCard: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textBold: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textBotCommand: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textButton: TypeConstructorDescription {
            var flags: Int32
            var text: Api.RichText
            var type: Api.InlineButtonType
            var style: Api.RichButtonStyle?
            init(flags: Int32, text: Api.RichText, type: Api.InlineButtonType, style: Api.RichButtonStyle?) {
                self.flags = flags
                self.text = text
                self.type = type
                self.style = style
            }
        }
        class Cons_textCashtag: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textConcat: TypeConstructorDescription {
            var texts: [Api.RichText]
            init(texts: [Api.RichText]) {
                self.texts = texts
            }
        }
        class Cons_textCustomEmoji: TypeConstructorDescription {
            var documentId: Int64
            var alt: String
            init(documentId: Int64, alt: String) {
                self.documentId = documentId
                self.alt = alt
            }
        }
        class Cons_textDate: TypeConstructorDescription {
            var flags: Int32
            var text: Api.RichText
            var date: Int32
            init(flags: Int32, text: Api.RichText, date: Int32) {
                self.flags = flags
                self.text = text
                self.date = date
            }
        }
        class Cons_textDiff: TypeConstructorDescription {
            var text: Api.RichText
            var oldText: Api.RichText
            init(text: Api.RichText, oldText: Api.RichText) {
                self.text = text
                self.oldText = oldText
            }
        }
        class Cons_textEmail: TypeConstructorDescription {
            var text: Api.RichText
            var email: String
            init(text: Api.RichText, email: String) {
                self.text = text
                self.email = email
            }
        }
        class Cons_textFixed: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textHashtag: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textImage: TypeConstructorDescription {
            var documentId: Int64
            var w: Int32
            var h: Int32
            init(documentId: Int64, w: Int32, h: Int32) {
                self.documentId = documentId
                self.w = w
                self.h = h
            }
        }
        class Cons_textItalic: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textMarked: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textMath: TypeConstructorDescription {
            var source: String
            init(source: String) {
                self.source = source
            }
        }
        class Cons_textMention: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textMentionName: TypeConstructorDescription {
            var text: Api.RichText
            var userId: Int64
            init(text: Api.RichText, userId: Int64) {
                self.text = text
                self.userId = userId
            }
        }
        class Cons_textPhone: TypeConstructorDescription {
            var text: Api.RichText
            var phone: String
            init(text: Api.RichText, phone: String) {
                self.text = text
                self.phone = phone
            }
        }
        class Cons_textPlain: TypeConstructorDescription {
            var text: String
            init(text: String) {
                self.text = text
            }
        }
        class Cons_textSpoiler: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textStrike: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textSubscript: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textSuperscript: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textTonAddress: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textUnderline: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_textUrl: TypeConstructorDescription {
            var text: Api.RichText
            var url: String
            var webpageId: Int64
            init(text: Api.RichText, url: String, webpageId: Int64) {
                self.text = text
                self.url = url
                self.webpageId = webpageId
            }
        }
        case textAnchor(Cons_textAnchor)
        case textAutoEmail(Cons_textAutoEmail)
        case textAutoPhone(Cons_textAutoPhone)
        case textAutoUrl(Cons_textAutoUrl)
        case textBankCard(Cons_textBankCard)
        case textBold(Cons_textBold)
        case textBotCommand(Cons_textBotCommand)
        case textButton(Cons_textButton)
        case textCashtag(Cons_textCashtag)
        case textConcat(Cons_textConcat)
        case textCustomEmoji(Cons_textCustomEmoji)
        case textDate(Cons_textDate)
        case textDiff(Cons_textDiff)
        case textEmail(Cons_textEmail)
        case textEmpty
        case textFixed(Cons_textFixed)
        case textHashtag(Cons_textHashtag)
        case textImage(Cons_textImage)
        case textItalic(Cons_textItalic)
        case textMarked(Cons_textMarked)
        case textMath(Cons_textMath)
        case textMention(Cons_textMention)
        case textMentionName(Cons_textMentionName)
        case textPhone(Cons_textPhone)
        case textPlain(Cons_textPlain)
        case textSpoiler(Cons_textSpoiler)
        case textStrike(Cons_textStrike)
        case textSubscript(Cons_textSubscript)
        case textSuperscript(Cons_textSuperscript)
        case textTonAddress(Cons_textTonAddress)
        case textUnderline(Cons_textUnderline)
        case textUrl(Cons_textUrl)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .textAnchor(let _data):
                if boxed {
                    buffer.appendInt32(894777186)
                }
                _data.text.serialize(buffer, true)
                serializeString(_data.name, buffer: buffer, boxed: false)
                break
            case .textAutoEmail(let _data):
                if boxed {
                    buffer.appendInt32(-984177571)
                }
                _data.text.serialize(buffer, true)
                break
            case .textAutoPhone(let _data):
                if boxed {
                    buffer.appendInt32(616720265)
                }
                _data.text.serialize(buffer, true)
                break
            case .textAutoUrl(let _data):
                if boxed {
                    buffer.appendInt32(-1402305622)
                }
                _data.text.serialize(buffer, true)
                break
            case .textBankCard(let _data):
                if boxed {
                    buffer.appendInt32(-1185513171)
                }
                _data.text.serialize(buffer, true)
                break
            case .textBold(let _data):
                if boxed {
                    buffer.appendInt32(1730456516)
                }
                _data.text.serialize(buffer, true)
                break
            case .textBotCommand(let _data):
                if boxed {
                    buffer.appendInt32(50276819)
                }
                _data.text.serialize(buffer, true)
                break
            case .textButton(let _data):
                if boxed {
                    buffer.appendInt32(-1345872682)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.text.serialize(buffer, true)
                _data.type.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.style!.serialize(buffer, true)
                }
                break
            case .textCashtag(let _data):
                if boxed {
                    buffer.appendInt32(2073958401)
                }
                _data.text.serialize(buffer, true)
                break
            case .textConcat(let _data):
                if boxed {
                    buffer.appendInt32(2120376535)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.texts.count))
                for item in _data.texts {
                    item.serialize(buffer, true)
                }
                break
            case .textCustomEmoji(let _data):
                if boxed {
                    buffer.appendInt32(-1570679104)
                }
                serializeInt64(_data.documentId, buffer: buffer, boxed: false)
                serializeString(_data.alt, buffer: buffer, boxed: false)
                break
            case .textDate(let _data):
                if boxed {
                    buffer.appendInt32(-1514906069)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.text.serialize(buffer, true)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                break
            case .textDiff(let _data):
                if boxed {
                    buffer.appendInt32(-1769551024)
                }
                _data.text.serialize(buffer, true)
                _data.oldText.serialize(buffer, true)
                break
            case .textEmail(let _data):
                if boxed {
                    buffer.appendInt32(-564523562)
                }
                _data.text.serialize(buffer, true)
                serializeString(_data.email, buffer: buffer, boxed: false)
                break
            case .textEmpty:
                if boxed {
                    buffer.appendInt32(-599948721)
                }
                break
            case .textFixed(let _data):
                if boxed {
                    buffer.appendInt32(1816074681)
                }
                _data.text.serialize(buffer, true)
                break
            case .textHashtag(let _data):
                if boxed {
                    buffer.appendInt32(1368728810)
                }
                _data.text.serialize(buffer, true)
                break
            case .textImage(let _data):
                if boxed {
                    buffer.appendInt32(136105807)
                }
                serializeInt64(_data.documentId, buffer: buffer, boxed: false)
                serializeInt32(_data.w, buffer: buffer, boxed: false)
                serializeInt32(_data.h, buffer: buffer, boxed: false)
                break
            case .textItalic(let _data):
                if boxed {
                    buffer.appendInt32(-653089380)
                }
                _data.text.serialize(buffer, true)
                break
            case .textMarked(let _data):
                if boxed {
                    buffer.appendInt32(55281185)
                }
                _data.text.serialize(buffer, true)
                break
            case .textMath(let _data):
                if boxed {
                    buffer.appendInt32(-1657885545)
                }
                serializeString(_data.source, buffer: buffer, boxed: false)
                break
            case .textMention(let _data):
                if boxed {
                    buffer.appendInt32(-853225660)
                }
                _data.text.serialize(buffer, true)
                break
            case .textMentionName(let _data):
                if boxed {
                    buffer.appendInt32(27917308)
                }
                _data.text.serialize(buffer, true)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                break
            case .textPhone(let _data):
                if boxed {
                    buffer.appendInt32(483104362)
                }
                _data.text.serialize(buffer, true)
                serializeString(_data.phone, buffer: buffer, boxed: false)
                break
            case .textPlain(let _data):
                if boxed {
                    buffer.appendInt32(1950782688)
                }
                serializeString(_data.text, buffer: buffer, boxed: false)
                break
            case .textSpoiler(let _data):
                if boxed {
                    buffer.appendInt32(1277844834)
                }
                _data.text.serialize(buffer, true)
                break
            case .textStrike(let _data):
                if boxed {
                    buffer.appendInt32(-1678197867)
                }
                _data.text.serialize(buffer, true)
                break
            case .textSubscript(let _data):
                if boxed {
                    buffer.appendInt32(-311786236)
                }
                _data.text.serialize(buffer, true)
                break
            case .textSuperscript(let _data):
                if boxed {
                    buffer.appendInt32(-939827711)
                }
                _data.text.serialize(buffer, true)
                break
            case .textTonAddress(let _data):
                if boxed {
                    buffer.appendInt32(1020437354)
                }
                _data.text.serialize(buffer, true)
                break
            case .textUnderline(let _data):
                if boxed {
                    buffer.appendInt32(-1054465340)
                }
                _data.text.serialize(buffer, true)
                break
            case .textUrl(let _data):
                if boxed {
                    buffer.appendInt32(1009288385)
                }
                _data.text.serialize(buffer, true)
                serializeString(_data.url, buffer: buffer, boxed: false)
                serializeInt64(_data.webpageId, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_textAnchor(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.RichText.textAnchor(Cons_textAnchor(text: _1!, name: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_textAutoEmail(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textAutoEmail(Cons_textAutoEmail(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textAutoPhone(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textAutoPhone(Cons_textAutoPhone(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textAutoUrl(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textAutoUrl(Cons_textAutoUrl(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textBankCard(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textBankCard(Cons_textBankCard(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textBold(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textBold(Cons_textBold(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textBotCommand(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textBotCommand(Cons_textBotCommand(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textButton(_ reader: BufferReader) -> RichText? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.RichText?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            var _3: Api.InlineButtonType?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.InlineButtonType
            }
            var _4: Api.RichButtonStyle?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.RichButtonStyle
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.RichText.textButton(Cons_textButton(flags: _1!, text: _2!, type: _3!, style: _4))
            }
            else {
                return nil
            }
        }
        static func parse_textCashtag(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textCashtag(Cons_textCashtag(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textConcat(_ reader: BufferReader) -> RichText? {
            var _1: [Api.RichText]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.RichText.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textConcat(Cons_textConcat(texts: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textCustomEmoji(_ reader: BufferReader) -> RichText? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.RichText.textCustomEmoji(Cons_textCustomEmoji(documentId: _1!, alt: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_textDate(_ reader: BufferReader) -> RichText? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.RichText?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.RichText.textDate(Cons_textDate(flags: _1!, text: _2!, date: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_textDiff(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            var _2: Api.RichText?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.RichText.textDiff(Cons_textDiff(text: _1!, oldText: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_textEmail(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.RichText.textEmail(Cons_textEmail(text: _1!, email: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_textEmpty(_ reader: BufferReader) -> RichText? {
            return Api.RichText.textEmpty
        }
        static func parse_textFixed(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textFixed(Cons_textFixed(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textHashtag(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textHashtag(Cons_textHashtag(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textImage(_ reader: BufferReader) -> RichText? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.RichText.textImage(Cons_textImage(documentId: _1!, w: _2!, h: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_textItalic(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textItalic(Cons_textItalic(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textMarked(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textMarked(Cons_textMarked(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textMath(_ reader: BufferReader) -> RichText? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textMath(Cons_textMath(source: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textMention(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textMention(Cons_textMention(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textMentionName(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.RichText.textMentionName(Cons_textMentionName(text: _1!, userId: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_textPhone(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.RichText.textPhone(Cons_textPhone(text: _1!, phone: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_textPlain(_ reader: BufferReader) -> RichText? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textPlain(Cons_textPlain(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textSpoiler(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textSpoiler(Cons_textSpoiler(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textStrike(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textStrike(Cons_textStrike(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textSubscript(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textSubscript(Cons_textSubscript(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textSuperscript(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textSuperscript(Cons_textSuperscript(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textTonAddress(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textTonAddress(Cons_textTonAddress(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textUnderline(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.RichText.textUnderline(Cons_textUnderline(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_textUrl(_ reader: BufferReader) -> RichText? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            var _2: String?
            _2 = parseString(reader)
            var _3: Int64?
            _3 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.RichText.textUrl(Cons_textUrl(text: _1!, url: _2!, webpageId: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum SavedDialog: TypeConstructorDescription {
        class Cons_monoForumDialog: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var topMessage: Int32
            var readInboxMaxId: Int32
            var readOutboxMaxId: Int32
            var unreadCount: Int32
            var unreadReactionsCount: Int32
            var draft: Api.DraftMessage?
            init(flags: Int32, peer: Api.Peer, topMessage: Int32, readInboxMaxId: Int32, readOutboxMaxId: Int32, unreadCount: Int32, unreadReactionsCount: Int32, draft: Api.DraftMessage?) {
                self.flags = flags
                self.peer = peer
                self.topMessage = topMessage
                self.readInboxMaxId = readInboxMaxId
                self.readOutboxMaxId = readOutboxMaxId
                self.unreadCount = unreadCount
                self.unreadReactionsCount = unreadReactionsCount
                self.draft = draft
            }
        }
        class Cons_savedDialog: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var topMessage: Int32
            init(flags: Int32, peer: Api.Peer, topMessage: Int32) {
                self.flags = flags
                self.peer = peer
                self.topMessage = topMessage
            }
        }
        case monoForumDialog(Cons_monoForumDialog)
        case savedDialog(Cons_savedDialog)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .monoForumDialog(let _data):
                if boxed {
                    buffer.appendInt32(1681948327)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.topMessage, buffer: buffer, boxed: false)
                serializeInt32(_data.readInboxMaxId, buffer: buffer, boxed: false)
                serializeInt32(_data.readOutboxMaxId, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadCount, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadReactionsCount, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.draft!.serialize(buffer, true)
                }
                break
            case .savedDialog(let _data):
                if boxed {
                    buffer.appendInt32(-1115174036)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.topMessage, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_monoForumDialog(_ reader: BufferReader) -> SavedDialog? {
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
            var _8: Api.DraftMessage?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.DraftMessage
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.SavedDialog.monoForumDialog(Cons_monoForumDialog(flags: _1!, peer: _2!, topMessage: _3!, readInboxMaxId: _4!, readOutboxMaxId: _5!, unreadCount: _6!, unreadReactionsCount: _7!, draft: _8))
            }
            else {
                return nil
            }
        }
        static func parse_savedDialog(_ reader: BufferReader) -> SavedDialog? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.SavedDialog.savedDialog(Cons_savedDialog(flags: _1!, peer: _2!, topMessage: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum SavedStarGift: TypeConstructorDescription {
        class Cons_savedStarGift: TypeConstructorDescription {
            var flags: Int32
            var fromId: Api.Peer?
            var date: Int32
            var gift: Api.StarGift
            var message: Api.TextWithEntities?
            var msgId: Int32?
            var savedId: Int64?
            var convertStars: Int64?
            var upgradeStars: Int64?
            var canExportAt: Int32?
            var transferStars: Int64?
            var canTransferAt: Int32?
            var canResellAt: Int32?
            var collectionId: [Int32]?
            var prepaidUpgradeHash: String?
            var dropOriginalDetailsStars: Int64?
            var giftNum: Int32?
            var canCraftAt: Int32?
            init(flags: Int32, fromId: Api.Peer?, date: Int32, gift: Api.StarGift, message: Api.TextWithEntities?, msgId: Int32?, savedId: Int64?, convertStars: Int64?, upgradeStars: Int64?, canExportAt: Int32?, transferStars: Int64?, canTransferAt: Int32?, canResellAt: Int32?, collectionId: [Int32]?, prepaidUpgradeHash: String?, dropOriginalDetailsStars: Int64?, giftNum: Int32?, canCraftAt: Int32?) {
                self.flags = flags
                self.fromId = fromId
                self.date = date
                self.gift = gift
                self.message = message
                self.msgId = msgId
                self.savedId = savedId
                self.convertStars = convertStars
                self.upgradeStars = upgradeStars
                self.canExportAt = canExportAt
                self.transferStars = transferStars
                self.canTransferAt = canTransferAt
                self.canResellAt = canResellAt
                self.collectionId = collectionId
                self.prepaidUpgradeHash = prepaidUpgradeHash
                self.dropOriginalDetailsStars = dropOriginalDetailsStars
                self.giftNum = giftNum
                self.canCraftAt = canCraftAt
            }
        }
        case savedStarGift(Cons_savedStarGift)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .savedStarGift(let _data):
                if boxed {
                    buffer.appendInt32(1105150972)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.fromId!.serialize(buffer, true)
                }
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                _data.gift.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.message!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.msgId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    serializeInt64(_data.savedId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt64(_data.convertStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    serializeInt64(_data.upgradeStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    serializeInt32(_data.canExportAt!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    serializeInt64(_data.transferStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 13) != 0 {
                    serializeInt32(_data.canTransferAt!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 14) != 0 {
                    serializeInt32(_data.canResellAt!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 15) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.collectionId!.count))
                    for item in _data.collectionId! {
                        serializeInt32(item, buffer: buffer, boxed: false)
                    }
                }
                if Int(_data.flags) & Int(1 << 16) != 0 {
                    serializeString(_data.prepaidUpgradeHash!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 18) != 0 {
                    serializeInt64(_data.dropOriginalDetailsStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 19) != 0 {
                    serializeInt32(_data.giftNum!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 20) != 0 {
                    serializeInt32(_data.canCraftAt!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_savedStarGift(_ reader: BufferReader) -> SavedStarGift? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Api.StarGift?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.StarGift
            }
            var _5: Api.TextWithEntities?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
                }
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _6 = reader.readInt32()
            }
            var _7: Int64?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                _7 = reader.readInt64()
            }
            var _8: Int64?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _8 = reader.readInt64()
            }
            var _9: Int64?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                _9 = reader.readInt64()
            }
            var _10: Int32?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                _10 = reader.readInt32()
            }
            var _11: Int64?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                _11 = reader.readInt64()
            }
            var _12: Int32?
            if Int(_1 ?? 0) & Int(1 << 13) != 0 {
                _12 = reader.readInt32()
            }
            var _13: Int32?
            if Int(_1 ?? 0) & Int(1 << 14) != 0 {
                _13 = reader.readInt32()
            }
            var _14: [Int32]?
            if Int(_1 ?? 0) & Int(1 << 15) != 0 {
                if let _ = reader.readInt32() {
                    _14 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
                }
            }
            var _15: String?
            if Int(_1 ?? 0) & Int(1 << 16) != 0 {
                _15 = parseString(reader)
            }
            var _16: Int64?
            if Int(_1 ?? 0) & Int(1 << 18) != 0 {
                _16 = reader.readInt64()
            }
            var _17: Int32?
            if Int(_1 ?? 0) & Int(1 << 19) != 0 {
                _17 = reader.readInt32()
            }
            var _18: Int32?
            if Int(_1 ?? 0) & Int(1 << 20) != 0 {
                _18 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 13) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 14) == 0) || _13 != nil
            let _c14 = (Int(_1 ?? 0) & Int(1 << 15) == 0) || _14 != nil
            let _c15 = (Int(_1 ?? 0) & Int(1 << 16) == 0) || _15 != nil
            let _c16 = (Int(_1 ?? 0) & Int(1 << 18) == 0) || _16 != nil
            let _c17 = (Int(_1 ?? 0) & Int(1 << 19) == 0) || _17 != nil
            let _c18 = (Int(_1 ?? 0) & Int(1 << 20) == 0) || _18 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 && _c15 && _c16 && _c17 && _c18 {
                return Api.SavedStarGift.savedStarGift(Cons_savedStarGift(flags: _1!, fromId: _2, date: _3!, gift: _4!, message: _5, msgId: _6, savedId: _7, convertStars: _8, upgradeStars: _9, canExportAt: _10, transferStars: _11, canTransferAt: _12, canResellAt: _13, collectionId: _14, prepaidUpgradeHash: _15, dropOriginalDetailsStars: _16, giftNum: _17, canCraftAt: _18))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum SearchPostsFlood: TypeConstructorDescription {
        class Cons_searchPostsFlood: TypeConstructorDescription {
            var flags: Int32
            var totalDaily: Int32
            var remains: Int32
            var waitTill: Int32?
            var starsAmount: Int64
            init(flags: Int32, totalDaily: Int32, remains: Int32, waitTill: Int32?, starsAmount: Int64) {
                self.flags = flags
                self.totalDaily = totalDaily
                self.remains = remains
                self.waitTill = waitTill
                self.starsAmount = starsAmount
            }
        }
        case searchPostsFlood(Cons_searchPostsFlood)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .searchPostsFlood(let _data):
                if boxed {
                    buffer.appendInt32(1040931690)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.totalDaily, buffer: buffer, boxed: false)
                serializeInt32(_data.remains, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.waitTill!, buffer: buffer, boxed: false)
                }
                serializeInt64(_data.starsAmount, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_searchPostsFlood(_ reader: BufferReader) -> SearchPostsFlood? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Int64?
            _5 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.SearchPostsFlood.searchPostsFlood(Cons_searchPostsFlood(flags: _1!, totalDaily: _2!, remains: _3!, waitTill: _4, starsAmount: _5!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum SearchResultsCalendarPeriod: TypeConstructorDescription {
        class Cons_searchResultsCalendarPeriod: TypeConstructorDescription {
            var date: Int32
            var minMsgId: Int32
            var maxMsgId: Int32
            var count: Int32
            init(date: Int32, minMsgId: Int32, maxMsgId: Int32, count: Int32) {
                self.date = date
                self.minMsgId = minMsgId
                self.maxMsgId = maxMsgId
                self.count = count
            }
        }
        case searchResultsCalendarPeriod(Cons_searchResultsCalendarPeriod)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .searchResultsCalendarPeriod(let _data):
                if boxed {
                    buffer.appendInt32(-911191137)
                }
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt32(_data.minMsgId, buffer: buffer, boxed: false)
                serializeInt32(_data.maxMsgId, buffer: buffer, boxed: false)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_searchResultsCalendarPeriod(_ reader: BufferReader) -> SearchResultsCalendarPeriod? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.SearchResultsCalendarPeriod.searchResultsCalendarPeriod(Cons_searchResultsCalendarPeriod(date: _1!, minMsgId: _2!, maxMsgId: _3!, count: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum SecureCredentialsEncrypted: TypeConstructorDescription {
        class Cons_secureCredentialsEncrypted: TypeConstructorDescription {
            var data: Buffer
            var hash: Buffer
            var secret: Buffer
            init(data: Buffer, hash: Buffer, secret: Buffer) {
                self.data = data
                self.hash = hash
                self.secret = secret
            }
        }
        case secureCredentialsEncrypted(Cons_secureCredentialsEncrypted)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .secureCredentialsEncrypted(let _data):
                if boxed {
                    buffer.appendInt32(871426631)
                }
                serializeBytes(_data.data, buffer: buffer, boxed: false)
                serializeBytes(_data.hash, buffer: buffer, boxed: false)
                serializeBytes(_data.secret, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_secureCredentialsEncrypted(_ reader: BufferReader) -> SecureCredentialsEncrypted? {
            var _1: Buffer?
            _1 = parseBytes(reader)
            var _2: Buffer?
            _2 = parseBytes(reader)
            var _3: Buffer?
            _3 = parseBytes(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.SecureCredentialsEncrypted.secureCredentialsEncrypted(Cons_secureCredentialsEncrypted(data: _1!, hash: _2!, secret: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum SecureData: TypeConstructorDescription {
        class Cons_secureData: TypeConstructorDescription {
            var data: Buffer
            var dataHash: Buffer
            var secret: Buffer
            init(data: Buffer, dataHash: Buffer, secret: Buffer) {
                self.data = data
                self.dataHash = dataHash
                self.secret = secret
            }
        }
        case secureData(Cons_secureData)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .secureData(let _data):
                if boxed {
                    buffer.appendInt32(-1964327229)
                }
                serializeBytes(_data.data, buffer: buffer, boxed: false)
                serializeBytes(_data.dataHash, buffer: buffer, boxed: false)
                serializeBytes(_data.secret, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_secureData(_ reader: BufferReader) -> SecureData? {
            var _1: Buffer?
            _1 = parseBytes(reader)
            var _2: Buffer?
            _2 = parseBytes(reader)
            var _3: Buffer?
            _3 = parseBytes(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.SecureData.secureData(Cons_secureData(data: _1!, dataHash: _2!, secret: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum SecureFile: TypeConstructorDescription {
        class Cons_secureFile: TypeConstructorDescription {
            var id: Int64
            var accessHash: Int64
            var size: Int64
            var dcId: Int32
            var date: Int32
            var fileHash: Buffer
            var secret: Buffer
            init(id: Int64, accessHash: Int64, size: Int64, dcId: Int32, date: Int32, fileHash: Buffer, secret: Buffer) {
                self.id = id
                self.accessHash = accessHash
                self.size = size
                self.dcId = dcId
                self.date = date
                self.fileHash = fileHash
                self.secret = secret
            }
        }
        case secureFile(Cons_secureFile)
        case secureFileEmpty

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .secureFile(let _data):
                if boxed {
                    buffer.appendInt32(2097791614)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeInt64(_data.size, buffer: buffer, boxed: false)
                serializeInt32(_data.dcId, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeBytes(_data.fileHash, buffer: buffer, boxed: false)
                serializeBytes(_data.secret, buffer: buffer, boxed: false)
                break
            case .secureFileEmpty:
                if boxed {
                    buffer.appendInt32(1679398724)
                }
                break
            }
        }

        static func parse_secureFile(_ reader: BufferReader) -> SecureFile? {
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
            var _6: Buffer?
            _6 = parseBytes(reader)
            var _7: Buffer?
            _7 = parseBytes(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.SecureFile.secureFile(Cons_secureFile(id: _1!, accessHash: _2!, size: _3!, dcId: _4!, date: _5!, fileHash: _6!, secret: _7!))
            }
            else {
                return nil
            }
        }
        static func parse_secureFileEmpty(_ reader: BufferReader) -> SecureFile? {
            return Api.SecureFile.secureFileEmpty
        }
    }
}
extension Api {
    enum SecurePlainData: TypeConstructorDescription {
        class Cons_securePlainEmail: TypeConstructorDescription {
            var email: String
            init(email: String) {
                self.email = email
            }
        }
        class Cons_securePlainPhone: TypeConstructorDescription {
            var phone: String
            init(phone: String) {
                self.phone = phone
            }
        }
        case securePlainEmail(Cons_securePlainEmail)
        case securePlainPhone(Cons_securePlainPhone)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .securePlainEmail(let _data):
                if boxed {
                    buffer.appendInt32(569137759)
                }
                serializeString(_data.email, buffer: buffer, boxed: false)
                break
            case .securePlainPhone(let _data):
                if boxed {
                    buffer.appendInt32(2103482845)
                }
                serializeString(_data.phone, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_securePlainEmail(_ reader: BufferReader) -> SecurePlainData? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.SecurePlainData.securePlainEmail(Cons_securePlainEmail(email: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_securePlainPhone(_ reader: BufferReader) -> SecurePlainData? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.SecurePlainData.securePlainPhone(Cons_securePlainPhone(phone: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum SecureValue: TypeConstructorDescription {
        class Cons_secureValue: TypeConstructorDescription {
            var flags: Int32
            var type: Api.SecureValueType
            var data: Api.SecureData?
            var frontSide: Api.SecureFile?
            var reverseSide: Api.SecureFile?
            var selfie: Api.SecureFile?
            var translation: [Api.SecureFile]?
            var files: [Api.SecureFile]?
            var plainData: Api.SecurePlainData?
            var hash: Buffer
            init(flags: Int32, type: Api.SecureValueType, data: Api.SecureData?, frontSide: Api.SecureFile?, reverseSide: Api.SecureFile?, selfie: Api.SecureFile?, translation: [Api.SecureFile]?, files: [Api.SecureFile]?, plainData: Api.SecurePlainData?, hash: Buffer) {
                self.flags = flags
                self.type = type
                self.data = data
                self.frontSide = frontSide
                self.reverseSide = reverseSide
                self.selfie = selfie
                self.translation = translation
                self.files = files
                self.plainData = plainData
                self.hash = hash
            }
        }
        case secureValue(Cons_secureValue)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .secureValue(let _data):
                if boxed {
                    buffer.appendInt32(411017418)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.type.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.data!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.frontSide!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.reverseSide!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.selfie!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.translation!.count))
                    for item in _data.translation! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.files!.count))
                    for item in _data.files! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    _data.plainData!.serialize(buffer, true)
                }
                serializeBytes(_data.hash, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_secureValue(_ reader: BufferReader) -> SecureValue? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.SecureValueType?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.SecureValueType
            }
            var _3: Api.SecureData?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.SecureData
                }
            }
            var _4: Api.SecureFile?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.SecureFile
                }
            }
            var _5: Api.SecureFile?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.SecureFile
                }
            }
            var _6: Api.SecureFile?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.SecureFile
                }
            }
            var _7: [Api.SecureFile]?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                if let _ = reader.readInt32() {
                    _7 = Api.parseVector(reader, elementSignature: 0, elementType: Api.SecureFile.self)
                }
            }
            var _8: [Api.SecureFile]?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let _ = reader.readInt32() {
                    _8 = Api.parseVector(reader, elementSignature: 0, elementType: Api.SecureFile.self)
                }
            }
            var _9: Api.SecurePlainData?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.SecurePlainData
                }
            }
            var _10: Buffer?
            _10 = parseBytes(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _9 != nil
            let _c10 = _10 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 {
                return Api.SecureValue.secureValue(Cons_secureValue(flags: _1!, type: _2!, data: _3, frontSide: _4, reverseSide: _5, selfie: _6, translation: _7, files: _8, plainData: _9, hash: _10!))
            }
            else {
                return nil
            }
        }
    }
}
