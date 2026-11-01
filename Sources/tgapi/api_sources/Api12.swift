extension Api {
    indirect enum MessageEntity: TypeConstructorDescription {
        class Cons_inputMessageEntityMentionName: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            var userId: Api.InputUser
            init(offset: Int32, length: Int32, userId: Api.InputUser) {
                self.offset = offset
                self.length = length
                self.userId = userId
            }
        }
        class Cons_messageEntityBankCard: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityBlockquote: TypeConstructorDescription {
            var flags: Int32
            var offset: Int32
            var length: Int32
            init(flags: Int32, offset: Int32, length: Int32) {
                self.flags = flags
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityBold: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityBotCommand: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityCashtag: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityCode: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityCustomEmoji: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            var documentId: Int64
            init(offset: Int32, length: Int32, documentId: Int64) {
                self.offset = offset
                self.length = length
                self.documentId = documentId
            }
        }
        class Cons_messageEntityDiffDelete: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityDiffInsert: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityDiffReplace: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            var oldText: String
            init(offset: Int32, length: Int32, oldText: String) {
                self.offset = offset
                self.length = length
                self.oldText = oldText
            }
        }
        class Cons_messageEntityEmail: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityFormattedDate: TypeConstructorDescription {
            var flags: Int32
            var offset: Int32
            var length: Int32
            var date: Int32
            init(flags: Int32, offset: Int32, length: Int32, date: Int32) {
                self.flags = flags
                self.offset = offset
                self.length = length
                self.date = date
            }
        }
        class Cons_messageEntityHashtag: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityItalic: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityMention: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityMentionName: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            var userId: Int64
            init(offset: Int32, length: Int32, userId: Int64) {
                self.offset = offset
                self.length = length
                self.userId = userId
            }
        }
        class Cons_messageEntityPhone: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityPre: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            var language: String
            init(offset: Int32, length: Int32, language: String) {
                self.offset = offset
                self.length = length
                self.language = language
            }
        }
        class Cons_messageEntitySpoiler: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityStrike: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityTextUrl: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            var url: String
            init(offset: Int32, length: Int32, url: String) {
                self.offset = offset
                self.length = length
                self.url = url
            }
        }
        class Cons_messageEntityTonAddress: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityUnderline: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityUnknown: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        class Cons_messageEntityUrl: TypeConstructorDescription {
            var offset: Int32
            var length: Int32
            init(offset: Int32, length: Int32) {
                self.offset = offset
                self.length = length
            }
        }
        case inputMessageEntityMentionName(Cons_inputMessageEntityMentionName)
        case messageEntityBankCard(Cons_messageEntityBankCard)
        case messageEntityBlockquote(Cons_messageEntityBlockquote)
        case messageEntityBold(Cons_messageEntityBold)
        case messageEntityBotCommand(Cons_messageEntityBotCommand)
        case messageEntityCashtag(Cons_messageEntityCashtag)
        case messageEntityCode(Cons_messageEntityCode)
        case messageEntityCustomEmoji(Cons_messageEntityCustomEmoji)
        case messageEntityDiffDelete(Cons_messageEntityDiffDelete)
        case messageEntityDiffInsert(Cons_messageEntityDiffInsert)
        case messageEntityDiffReplace(Cons_messageEntityDiffReplace)
        case messageEntityEmail(Cons_messageEntityEmail)
        case messageEntityFormattedDate(Cons_messageEntityFormattedDate)
        case messageEntityHashtag(Cons_messageEntityHashtag)
        case messageEntityItalic(Cons_messageEntityItalic)
        case messageEntityMention(Cons_messageEntityMention)
        case messageEntityMentionName(Cons_messageEntityMentionName)
        case messageEntityPhone(Cons_messageEntityPhone)
        case messageEntityPre(Cons_messageEntityPre)
        case messageEntitySpoiler(Cons_messageEntitySpoiler)
        case messageEntityStrike(Cons_messageEntityStrike)
        case messageEntityTextUrl(Cons_messageEntityTextUrl)
        case messageEntityTonAddress(Cons_messageEntityTonAddress)
        case messageEntityUnderline(Cons_messageEntityUnderline)
        case messageEntityUnknown(Cons_messageEntityUnknown)
        case messageEntityUrl(Cons_messageEntityUrl)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputMessageEntityMentionName(let _data):
                if boxed {
                    buffer.appendInt32(546203849)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                _data.userId.serialize(buffer, true)
                break
            case .messageEntityBankCard(let _data):
                if boxed {
                    buffer.appendInt32(1981704948)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityBlockquote(let _data):
                if boxed {
                    buffer.appendInt32(-238245204)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityBold(let _data):
                if boxed {
                    buffer.appendInt32(-1117713463)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityBotCommand(let _data):
                if boxed {
                    buffer.appendInt32(1827637959)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityCashtag(let _data):
                if boxed {
                    buffer.appendInt32(1280209983)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityCode(let _data):
                if boxed {
                    buffer.appendInt32(681706865)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityCustomEmoji(let _data):
                if boxed {
                    buffer.appendInt32(-925956616)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                serializeInt64(_data.documentId, buffer: buffer, boxed: false)
                break
            case .messageEntityDiffDelete(let _data):
                if boxed {
                    buffer.appendInt32(106086853)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityDiffInsert(let _data):
                if boxed {
                    buffer.appendInt32(1903653142)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityDiffReplace(let _data):
                if boxed {
                    buffer.appendInt32(-960371289)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                serializeString(_data.oldText, buffer: buffer, boxed: false)
                break
            case .messageEntityEmail(let _data):
                if boxed {
                    buffer.appendInt32(1692693954)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityFormattedDate(let _data):
                if boxed {
                    buffer.appendInt32(-1874147385)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                break
            case .messageEntityHashtag(let _data):
                if boxed {
                    buffer.appendInt32(1868782349)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityItalic(let _data):
                if boxed {
                    buffer.appendInt32(-2106619040)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityMention(let _data):
                if boxed {
                    buffer.appendInt32(-100378723)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityMentionName(let _data):
                if boxed {
                    buffer.appendInt32(-595914432)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                break
            case .messageEntityPhone(let _data):
                if boxed {
                    buffer.appendInt32(-1687559349)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityPre(let _data):
                if boxed {
                    buffer.appendInt32(1938967520)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                serializeString(_data.language, buffer: buffer, boxed: false)
                break
            case .messageEntitySpoiler(let _data):
                if boxed {
                    buffer.appendInt32(852137487)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityStrike(let _data):
                if boxed {
                    buffer.appendInt32(-1090087980)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityTextUrl(let _data):
                if boxed {
                    buffer.appendInt32(1990644519)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                serializeString(_data.url, buffer: buffer, boxed: false)
                break
            case .messageEntityTonAddress(let _data):
                if boxed {
                    buffer.appendInt32(-39075891)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityUnderline(let _data):
                if boxed {
                    buffer.appendInt32(-1672577397)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityUnknown(let _data):
                if boxed {
                    buffer.appendInt32(-1148011883)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .messageEntityUrl(let _data):
                if boxed {
                    buffer.appendInt32(1859134776)
                }
                serializeInt32(_data.offset, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_inputMessageEntityMentionName(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.InputUser?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.InputUser
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessageEntity.inputMessageEntityMentionName(Cons_inputMessageEntityMentionName(offset: _1!, length: _2!, userId: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityBankCard(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityBankCard(Cons_messageEntityBankCard(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityBlockquote(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessageEntity.messageEntityBlockquote(Cons_messageEntityBlockquote(flags: _1!, offset: _2!, length: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityBold(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityBold(Cons_messageEntityBold(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityBotCommand(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityBotCommand(Cons_messageEntityBotCommand(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityCashtag(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityCashtag(Cons_messageEntityCashtag(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityCode(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityCode(Cons_messageEntityCode(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityCustomEmoji(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int64?
            _3 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessageEntity.messageEntityCustomEmoji(Cons_messageEntityCustomEmoji(offset: _1!, length: _2!, documentId: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityDiffDelete(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityDiffDelete(Cons_messageEntityDiffDelete(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityDiffInsert(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityDiffInsert(Cons_messageEntityDiffInsert(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityDiffReplace(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: String?
            _3 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessageEntity.messageEntityDiffReplace(Cons_messageEntityDiffReplace(offset: _1!, length: _2!, oldText: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityEmail(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityEmail(Cons_messageEntityEmail(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityFormattedDate(_ reader: BufferReader) -> MessageEntity? {
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
                return Api.MessageEntity.messageEntityFormattedDate(Cons_messageEntityFormattedDate(flags: _1!, offset: _2!, length: _3!, date: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityHashtag(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityHashtag(Cons_messageEntityHashtag(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityItalic(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityItalic(Cons_messageEntityItalic(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityMention(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityMention(Cons_messageEntityMention(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityMentionName(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int64?
            _3 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessageEntity.messageEntityMentionName(Cons_messageEntityMentionName(offset: _1!, length: _2!, userId: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityPhone(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityPhone(Cons_messageEntityPhone(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityPre(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: String?
            _3 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessageEntity.messageEntityPre(Cons_messageEntityPre(offset: _1!, length: _2!, language: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntitySpoiler(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntitySpoiler(Cons_messageEntitySpoiler(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityStrike(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityStrike(Cons_messageEntityStrike(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityTextUrl(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: String?
            _3 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.MessageEntity.messageEntityTextUrl(Cons_messageEntityTextUrl(offset: _1!, length: _2!, url: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityTonAddress(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityTonAddress(Cons_messageEntityTonAddress(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityUnderline(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityUnderline(Cons_messageEntityUnderline(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityUnknown(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityUnknown(Cons_messageEntityUnknown(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_messageEntityUrl(_ reader: BufferReader) -> MessageEntity? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.MessageEntity.messageEntityUrl(Cons_messageEntityUrl(offset: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum MessageExtendedMedia: TypeConstructorDescription {
        class Cons_messageExtendedMedia: TypeConstructorDescription {
            var media: Api.MessageMedia
            init(media: Api.MessageMedia) {
                self.media = media
            }
        }
        class Cons_messageExtendedMediaPreview: TypeConstructorDescription {
            var flags: Int32
            var w: Int32?
            var h: Int32?
            var thumb: Api.PhotoSize?
            var videoDuration: Int32?
            init(flags: Int32, w: Int32?, h: Int32?, thumb: Api.PhotoSize?, videoDuration: Int32?) {
                self.flags = flags
                self.w = w
                self.h = h
                self.thumb = thumb
                self.videoDuration = videoDuration
            }
        }
        case messageExtendedMedia(Cons_messageExtendedMedia)
        case messageExtendedMediaPreview(Cons_messageExtendedMediaPreview)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .messageExtendedMedia(let _data):
                if boxed {
                    buffer.appendInt32(-297296796)
                }
                _data.media.serialize(buffer, true)
                break
            case .messageExtendedMediaPreview(let _data):
                if boxed {
                    buffer.appendInt32(-1386050360)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.w!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.h!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.thumb!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.videoDuration!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_messageExtendedMedia(_ reader: BufferReader) -> MessageExtendedMedia? {
            var _1: Api.MessageMedia?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.MessageMedia
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.MessageExtendedMedia.messageExtendedMedia(Cons_messageExtendedMedia(media: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_messageExtendedMediaPreview(_ reader: BufferReader) -> MessageExtendedMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt32()
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Api.PhotoSize?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.PhotoSize
                }
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _5 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.MessageExtendedMedia.messageExtendedMediaPreview(Cons_messageExtendedMediaPreview(flags: _1!, w: _2, h: _3, thumb: _4, videoDuration: _5))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum MessageFwdHeader: TypeConstructorDescription {
        class Cons_messageFwdHeader: TypeConstructorDescription {
            var flags: Int32
            var fromId: Api.Peer?
            var fromName: String?
            var date: Int32
            var channelPost: Int32?
            var postAuthor: String?
            var savedFromPeer: Api.Peer?
            var savedFromMsgId: Int32?
            var savedFromId: Api.Peer?
            var savedFromName: String?
            var savedDate: Int32?
            var psaType: String?
            init(flags: Int32, fromId: Api.Peer?, fromName: String?, date: Int32, channelPost: Int32?, postAuthor: String?, savedFromPeer: Api.Peer?, savedFromMsgId: Int32?, savedFromId: Api.Peer?, savedFromName: String?, savedDate: Int32?, psaType: String?) {
                self.flags = flags
                self.fromId = fromId
                self.fromName = fromName
                self.date = date
                self.channelPost = channelPost
                self.postAuthor = postAuthor
                self.savedFromPeer = savedFromPeer
                self.savedFromMsgId = savedFromMsgId
                self.savedFromId = savedFromId
                self.savedFromName = savedFromName
                self.savedDate = savedDate
                self.psaType = psaType
            }
        }
        case messageFwdHeader(Cons_messageFwdHeader)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .messageFwdHeader(let _data):
                if boxed {
                    buffer.appendInt32(1313731771)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.fromId!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeString(_data.fromName!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.channelPost!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.postAuthor!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    _data.savedFromPeer!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.savedFromMsgId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    _data.savedFromId!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    serializeString(_data.savedFromName!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    serializeInt32(_data.savedDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    serializeString(_data.psaType!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_messageFwdHeader(_ reader: BufferReader) -> MessageFwdHeader? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _3 = parseString(reader)
            }
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _5 = reader.readInt32()
            }
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _6 = parseString(reader)
            }
            var _7: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _8: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _8 = reader.readInt32()
            }
            var _9: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _10: String?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                _10 = parseString(reader)
            }
            var _11: Int32?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                _11 = reader.readInt32()
            }
            var _12: String?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                _12 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _12 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 {
                return Api.MessageFwdHeader.messageFwdHeader(Cons_messageFwdHeader(flags: _1!, fromId: _2, fromName: _3, date: _4!, channelPost: _5, postAuthor: _6, savedFromPeer: _7, savedFromMsgId: _8, savedFromId: _9, savedFromName: _10, savedDate: _11, psaType: _12))
            }
            else {
                return nil
            }
        }
    }
}
