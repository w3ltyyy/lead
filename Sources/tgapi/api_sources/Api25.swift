extension Api.account {
    enum ResolvedBusinessChatLinks: TypeConstructorDescription {
        class Cons_resolvedBusinessChatLinks: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var message: String
            var entities: [Api.MessageEntity]?
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, peer: Api.Peer, message: String, entities: [Api.MessageEntity]?, chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.peer = peer
                self.message = message
                self.entities = entities
                self.chats = chats
                self.users = users
            }
        }
        case resolvedBusinessChatLinks(Cons_resolvedBusinessChatLinks)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .resolvedBusinessChatLinks(let _data):
                if boxed {
                    buffer.appendInt32(-1708937439)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeString(_data.message, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.entities!.count))
                    for item in _data.entities! {
                        item.serialize(buffer, true)
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

        static func parse_resolvedBusinessChatLinks(_ reader: BufferReader) -> ResolvedBusinessChatLinks? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: String?
            _3 = parseString(reader)
            var _4: [Api.MessageEntity]?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self)
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
                return Api.account.ResolvedBusinessChatLinks.resolvedBusinessChatLinks(Cons_resolvedBusinessChatLinks(flags: _1!, peer: _2!, message: _3!, entities: _4, chats: _5!, users: _6!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.auth {
    enum Authorization: TypeConstructorDescription {
        class Cons_authorization: TypeConstructorDescription {
            var flags: Int32
            var otherwiseReloginDays: Int32?
            var tmpSessions: Int32?
            var futureAuthToken: Buffer?
            var user: Api.User
            init(flags: Int32, otherwiseReloginDays: Int32?, tmpSessions: Int32?, futureAuthToken: Buffer?, user: Api.User) {
                self.flags = flags
                self.otherwiseReloginDays = otherwiseReloginDays
                self.tmpSessions = tmpSessions
                self.futureAuthToken = futureAuthToken
                self.user = user
            }
        }
        class Cons_authorizationSignUpRequired: TypeConstructorDescription {
            var flags: Int32
            var termsOfService: Api.help.TermsOfService?
            init(flags: Int32, termsOfService: Api.help.TermsOfService?) {
                self.flags = flags
                self.termsOfService = termsOfService
            }
        }
        case authorization(Cons_authorization)
        case authorizationSignUpRequired(Cons_authorizationSignUpRequired)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .authorization(let _data):
                if boxed {
                    buffer.appendInt32(782418132)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.otherwiseReloginDays!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.tmpSessions!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeBytes(_data.futureAuthToken!, buffer: buffer, boxed: false)
                }
                _data.user.serialize(buffer, true)
                break
            case .authorizationSignUpRequired(let _data):
                if boxed {
                    buffer.appendInt32(1148485274)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.termsOfService!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_authorization(_ reader: BufferReader) -> Authorization? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _2 = reader.readInt32()
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Buffer?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _4 = parseBytes(reader)
            }
            var _5: Api.User?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.User
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.auth.Authorization.authorization(Cons_authorization(flags: _1!, otherwiseReloginDays: _2, tmpSessions: _3, futureAuthToken: _4, user: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_authorizationSignUpRequired(_ reader: BufferReader) -> Authorization? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.help.TermsOfService?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.help.TermsOfService
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            if _c1 && _c2 {
                return Api.auth.Authorization.authorizationSignUpRequired(Cons_authorizationSignUpRequired(flags: _1!, termsOfService: _2))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.auth {
    enum CodeType: TypeConstructorDescription {
        case codeTypeCall
        case codeTypeFlashCall
        case codeTypeFragmentSms
        case codeTypeMissedCall
        case codeTypeSms

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .codeTypeCall:
                if boxed {
                    buffer.appendInt32(1948046307)
                }
                break
            case .codeTypeFlashCall:
                if boxed {
                    buffer.appendInt32(577556219)
                }
                break
            case .codeTypeFragmentSms:
                if boxed {
                    buffer.appendInt32(116234636)
                }
                break
            case .codeTypeMissedCall:
                if boxed {
                    buffer.appendInt32(-702884114)
                }
                break
            case .codeTypeSms:
                if boxed {
                    buffer.appendInt32(1923290508)
                }
                break
            }
        }

        static func parse_codeTypeCall(_ reader: BufferReader) -> CodeType? {
            return Api.auth.CodeType.codeTypeCall
        }
        static func parse_codeTypeFlashCall(_ reader: BufferReader) -> CodeType? {
            return Api.auth.CodeType.codeTypeFlashCall
        }
        static func parse_codeTypeFragmentSms(_ reader: BufferReader) -> CodeType? {
            return Api.auth.CodeType.codeTypeFragmentSms
        }
        static func parse_codeTypeMissedCall(_ reader: BufferReader) -> CodeType? {
            return Api.auth.CodeType.codeTypeMissedCall
        }
        static func parse_codeTypeSms(_ reader: BufferReader) -> CodeType? {
            return Api.auth.CodeType.codeTypeSms
        }
    }
}
extension Api.auth {
    enum SentCode: TypeConstructorDescription {
        class Cons_sentCode: TypeConstructorDescription {
            var flags: Int32
            var type: Api.auth.SentCodeType
            var phoneCodeHash: String
            var nextType: Api.auth.CodeType?
            var timeout: Int32?
            init(flags: Int32, type: Api.auth.SentCodeType, phoneCodeHash: String, nextType: Api.auth.CodeType?, timeout: Int32?) {
                self.flags = flags
                self.type = type
                self.phoneCodeHash = phoneCodeHash
                self.nextType = nextType
                self.timeout = timeout
            }
        }
        class Cons_sentCodePaymentRequired: TypeConstructorDescription {
            var storeProduct: String
            var phoneCodeHash: String
            var supportEmailAddress: String
            var supportEmailSubject: String
            var premiumDays: Int32
            var currency: String
            var amount: Int64
            init(storeProduct: String, phoneCodeHash: String, supportEmailAddress: String, supportEmailSubject: String, premiumDays: Int32, currency: String, amount: Int64) {
                self.storeProduct = storeProduct
                self.phoneCodeHash = phoneCodeHash
                self.supportEmailAddress = supportEmailAddress
                self.supportEmailSubject = supportEmailSubject
                self.premiumDays = premiumDays
                self.currency = currency
                self.amount = amount
            }
        }
        class Cons_sentCodeSuccess: TypeConstructorDescription {
            var authorization: Api.auth.Authorization
            init(authorization: Api.auth.Authorization) {
                self.authorization = authorization
            }
        }
        case sentCode(Cons_sentCode)
        case sentCodePaymentRequired(Cons_sentCodePaymentRequired)
        case sentCodeSuccess(Cons_sentCodeSuccess)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .sentCode(let _data):
                if boxed {
                    buffer.appendInt32(1577067778)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.type.serialize(buffer, true)
                serializeString(_data.phoneCodeHash, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.nextType!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.timeout!, buffer: buffer, boxed: false)
                }
                break
            case .sentCodePaymentRequired(let _data):
                if boxed {
                    buffer.appendInt32(-125665601)
                }
                serializeString(_data.storeProduct, buffer: buffer, boxed: false)
                serializeString(_data.phoneCodeHash, buffer: buffer, boxed: false)
                serializeString(_data.supportEmailAddress, buffer: buffer, boxed: false)
                serializeString(_data.supportEmailSubject, buffer: buffer, boxed: false)
                serializeInt32(_data.premiumDays, buffer: buffer, boxed: false)
                serializeString(_data.currency, buffer: buffer, boxed: false)
                serializeInt64(_data.amount, buffer: buffer, boxed: false)
                break
            case .sentCodeSuccess(let _data):
                if boxed {
                    buffer.appendInt32(596704836)
                }
                _data.authorization.serialize(buffer, true)
                break
            }
        }

        static func parse_sentCode(_ reader: BufferReader) -> SentCode? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.auth.SentCodeType?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.auth.SentCodeType
            }
            var _3: String?
            _3 = parseString(reader)
            var _4: Api.auth.CodeType?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.auth.CodeType
                }
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _5 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.auth.SentCode.sentCode(Cons_sentCode(flags: _1!, type: _2!, phoneCodeHash: _3!, nextType: _4, timeout: _5))
            }
            else {
                return nil
            }
        }
        static func parse_sentCodePaymentRequired(_ reader: BufferReader) -> SentCode? {
            var _1: String?
            _1 = parseString(reader)
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            _3 = parseString(reader)
            var _4: String?
            _4 = parseString(reader)
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: String?
            _6 = parseString(reader)
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
                return Api.auth.SentCode.sentCodePaymentRequired(Cons_sentCodePaymentRequired(storeProduct: _1!, phoneCodeHash: _2!, supportEmailAddress: _3!, supportEmailSubject: _4!, premiumDays: _5!, currency: _6!, amount: _7!))
            }
            else {
                return nil
            }
        }
        static func parse_sentCodeSuccess(_ reader: BufferReader) -> SentCode? {
            var _1: Api.auth.Authorization?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.auth.Authorization
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.auth.SentCode.sentCodeSuccess(Cons_sentCodeSuccess(authorization: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.auth {
    enum SentCodeType: TypeConstructorDescription {
        class Cons_sentCodeTypeApp: TypeConstructorDescription {
            var length: Int32
            init(length: Int32) {
                self.length = length
            }
        }
        class Cons_sentCodeTypeCall: TypeConstructorDescription {
            var length: Int32
            init(length: Int32) {
                self.length = length
            }
        }
        class Cons_sentCodeTypeEmailCode: TypeConstructorDescription {
            var flags: Int32
            var emailPattern: String
            var length: Int32
            var resetAvailablePeriod: Int32?
            var resetPendingDate: Int32?
            init(flags: Int32, emailPattern: String, length: Int32, resetAvailablePeriod: Int32?, resetPendingDate: Int32?) {
                self.flags = flags
                self.emailPattern = emailPattern
                self.length = length
                self.resetAvailablePeriod = resetAvailablePeriod
                self.resetPendingDate = resetPendingDate
            }
        }
        class Cons_sentCodeTypeFirebaseSms: TypeConstructorDescription {
            var flags: Int32
            var nonce: Buffer?
            var playIntegrityProjectId: Int64?
            var playIntegrityNonce: Buffer?
            var receipt: String?
            var pushTimeout: Int32?
            var length: Int32
            init(flags: Int32, nonce: Buffer?, playIntegrityProjectId: Int64?, playIntegrityNonce: Buffer?, receipt: String?, pushTimeout: Int32?, length: Int32) {
                self.flags = flags
                self.nonce = nonce
                self.playIntegrityProjectId = playIntegrityProjectId
                self.playIntegrityNonce = playIntegrityNonce
                self.receipt = receipt
                self.pushTimeout = pushTimeout
                self.length = length
            }
        }
        class Cons_sentCodeTypeFlashCall: TypeConstructorDescription {
            var pattern: String
            init(pattern: String) {
                self.pattern = pattern
            }
        }
        class Cons_sentCodeTypeFragmentSms: TypeConstructorDescription {
            var url: String
            var length: Int32
            init(url: String, length: Int32) {
                self.url = url
                self.length = length
            }
        }
        class Cons_sentCodeTypeMissedCall: TypeConstructorDescription {
            var prefix: String
            var length: Int32
            init(prefix: String, length: Int32) {
                self.prefix = prefix
                self.length = length
            }
        }
        class Cons_sentCodeTypeSetUpEmailRequired: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        class Cons_sentCodeTypeSms: TypeConstructorDescription {
            var length: Int32
            init(length: Int32) {
                self.length = length
            }
        }
        class Cons_sentCodeTypeSmsPhrase: TypeConstructorDescription {
            var flags: Int32
            var beginning: String?
            init(flags: Int32, beginning: String?) {
                self.flags = flags
                self.beginning = beginning
            }
        }
        class Cons_sentCodeTypeSmsWord: TypeConstructorDescription {
            var flags: Int32
            var beginning: String?
            init(flags: Int32, beginning: String?) {
                self.flags = flags
                self.beginning = beginning
            }
        }
        case sentCodeTypeApp(Cons_sentCodeTypeApp)
        case sentCodeTypeCall(Cons_sentCodeTypeCall)
        case sentCodeTypeEmailCode(Cons_sentCodeTypeEmailCode)
        case sentCodeTypeFirebaseSms(Cons_sentCodeTypeFirebaseSms)
        case sentCodeTypeFlashCall(Cons_sentCodeTypeFlashCall)
        case sentCodeTypeFragmentSms(Cons_sentCodeTypeFragmentSms)
        case sentCodeTypeMissedCall(Cons_sentCodeTypeMissedCall)
        case sentCodeTypeSetUpEmailRequired(Cons_sentCodeTypeSetUpEmailRequired)
        case sentCodeTypeSms(Cons_sentCodeTypeSms)
        case sentCodeTypeSmsPhrase(Cons_sentCodeTypeSmsPhrase)
        case sentCodeTypeSmsWord(Cons_sentCodeTypeSmsWord)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .sentCodeTypeApp(let _data):
                if boxed {
                    buffer.appendInt32(1035688326)
                }
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .sentCodeTypeCall(let _data):
                if boxed {
                    buffer.appendInt32(1398007207)
                }
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .sentCodeTypeEmailCode(let _data):
                if boxed {
                    buffer.appendInt32(-196020837)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.emailPattern, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.resetAvailablePeriod!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.resetPendingDate!, buffer: buffer, boxed: false)
                }
                break
            case .sentCodeTypeFirebaseSms(let _data):
                if boxed {
                    buffer.appendInt32(10475318)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeBytes(_data.nonce!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt64(_data.playIntegrityProjectId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeBytes(_data.playIntegrityNonce!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.receipt!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.pushTimeout!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .sentCodeTypeFlashCall(let _data):
                if boxed {
                    buffer.appendInt32(-1425815847)
                }
                serializeString(_data.pattern, buffer: buffer, boxed: false)
                break
            case .sentCodeTypeFragmentSms(let _data):
                if boxed {
                    buffer.appendInt32(-648651719)
                }
                serializeString(_data.url, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .sentCodeTypeMissedCall(let _data):
                if boxed {
                    buffer.appendInt32(-2113903484)
                }
                serializeString(_data.prefix, buffer: buffer, boxed: false)
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .sentCodeTypeSetUpEmailRequired(let _data):
                if boxed {
                    buffer.appendInt32(-1521934870)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            case .sentCodeTypeSms(let _data):
                if boxed {
                    buffer.appendInt32(-1073693790)
                }
                serializeInt32(_data.length, buffer: buffer, boxed: false)
                break
            case .sentCodeTypeSmsPhrase(let _data):
                if boxed {
                    buffer.appendInt32(-1284008785)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.beginning!, buffer: buffer, boxed: false)
                }
                break
            case .sentCodeTypeSmsWord(let _data):
                if boxed {
                    buffer.appendInt32(-1542017919)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.beginning!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_sentCodeTypeApp(_ reader: BufferReader) -> SentCodeType? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.auth.SentCodeType.sentCodeTypeApp(Cons_sentCodeTypeApp(length: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_sentCodeTypeCall(_ reader: BufferReader) -> SentCodeType? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.auth.SentCodeType.sentCodeTypeCall(Cons_sentCodeTypeCall(length: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_sentCodeTypeEmailCode(_ reader: BufferReader) -> SentCodeType? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _5 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.auth.SentCodeType.sentCodeTypeEmailCode(Cons_sentCodeTypeEmailCode(flags: _1!, emailPattern: _2!, length: _3!, resetAvailablePeriod: _4, resetPendingDate: _5))
            }
            else {
                return nil
            }
        }
        static func parse_sentCodeTypeFirebaseSms(_ reader: BufferReader) -> SentCodeType? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Buffer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = parseBytes(reader)
            }
            var _3: Int64?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _3 = reader.readInt64()
            }
            var _4: Buffer?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _4 = parseBytes(reader)
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _5 = parseString(reader)
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _6 = reader.readInt32()
            }
            var _7: Int32?
            _7 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            let _c7 = _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.auth.SentCodeType.sentCodeTypeFirebaseSms(Cons_sentCodeTypeFirebaseSms(flags: _1!, nonce: _2, playIntegrityProjectId: _3, playIntegrityNonce: _4, receipt: _5, pushTimeout: _6, length: _7!))
            }
            else {
                return nil
            }
        }
        static func parse_sentCodeTypeFlashCall(_ reader: BufferReader) -> SentCodeType? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.auth.SentCodeType.sentCodeTypeFlashCall(Cons_sentCodeTypeFlashCall(pattern: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_sentCodeTypeFragmentSms(_ reader: BufferReader) -> SentCodeType? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.auth.SentCodeType.sentCodeTypeFragmentSms(Cons_sentCodeTypeFragmentSms(url: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_sentCodeTypeMissedCall(_ reader: BufferReader) -> SentCodeType? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.auth.SentCodeType.sentCodeTypeMissedCall(Cons_sentCodeTypeMissedCall(prefix: _1!, length: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_sentCodeTypeSetUpEmailRequired(_ reader: BufferReader) -> SentCodeType? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.auth.SentCodeType.sentCodeTypeSetUpEmailRequired(Cons_sentCodeTypeSetUpEmailRequired(flags: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_sentCodeTypeSms(_ reader: BufferReader) -> SentCodeType? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.auth.SentCodeType.sentCodeTypeSms(Cons_sentCodeTypeSms(length: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_sentCodeTypeSmsPhrase(_ reader: BufferReader) -> SentCodeType? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            if _c1 && _c2 {
                return Api.auth.SentCodeType.sentCodeTypeSmsPhrase(Cons_sentCodeTypeSmsPhrase(flags: _1!, beginning: _2))
            }
            else {
                return nil
            }
        }
        static func parse_sentCodeTypeSmsWord(_ reader: BufferReader) -> SentCodeType? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            if _c1 && _c2 {
                return Api.auth.SentCodeType.sentCodeTypeSmsWord(Cons_sentCodeTypeSmsWord(flags: _1!, beginning: _2))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.channels {
    enum AdminLogResults: TypeConstructorDescription {
        class Cons_adminLogResults: TypeConstructorDescription {
            var events: [Api.ChannelAdminLogEvent]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(events: [Api.ChannelAdminLogEvent], chats: [Api.Chat], users: [Api.User]) {
                self.events = events
                self.chats = chats
                self.users = users
            }
        }
        case adminLogResults(Cons_adminLogResults)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .adminLogResults(let _data):
                if boxed {
                    buffer.appendInt32(-309659827)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.events.count))
                for item in _data.events {
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

        static func parse_adminLogResults(_ reader: BufferReader) -> AdminLogResults? {
            var _1: [Api.ChannelAdminLogEvent]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.ChannelAdminLogEvent.self)
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
                return Api.channels.AdminLogResults.adminLogResults(Cons_adminLogResults(events: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.channels {
    enum ChannelParticipant: TypeConstructorDescription {
        class Cons_channelParticipant: TypeConstructorDescription {
            var participant: Api.ChannelParticipant
            var chats: [Api.Chat]
            var users: [Api.User]
            init(participant: Api.ChannelParticipant, chats: [Api.Chat], users: [Api.User]) {
                self.participant = participant
                self.chats = chats
                self.users = users
            }
        }
        case channelParticipant(Cons_channelParticipant)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .channelParticipant(let _data):
                if boxed {
                    buffer.appendInt32(-541588713)
                }
                _data.participant.serialize(buffer, true)
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

        static func parse_channelParticipant(_ reader: BufferReader) -> ChannelParticipant? {
            var _1: Api.ChannelParticipant?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ChannelParticipant
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
                return Api.channels.ChannelParticipant.channelParticipant(Cons_channelParticipant(participant: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.channels {
    enum ChannelParticipants: TypeConstructorDescription {
        class Cons_channelParticipants: TypeConstructorDescription {
            var count: Int32
            var participants: [Api.ChannelParticipant]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(count: Int32, participants: [Api.ChannelParticipant], chats: [Api.Chat], users: [Api.User]) {
                self.count = count
                self.participants = participants
                self.chats = chats
                self.users = users
            }
        }
        case channelParticipants(Cons_channelParticipants)
        case channelParticipantsNotModified

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .channelParticipants(let _data):
                if boxed {
                    buffer.appendInt32(-1699676497)
                }
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.participants.count))
                for item in _data.participants {
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
            case .channelParticipantsNotModified:
                if boxed {
                    buffer.appendInt32(-266911767)
                }
                break
            }
        }

        static func parse_channelParticipants(_ reader: BufferReader) -> ChannelParticipants? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.ChannelParticipant]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.ChannelParticipant.self)
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
                return Api.channels.ChannelParticipants.channelParticipants(Cons_channelParticipants(count: _1!, participants: _2!, chats: _3!, users: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_channelParticipantsNotModified(_ reader: BufferReader) -> ChannelParticipants? {
            return Api.channels.ChannelParticipants.channelParticipantsNotModified
        }
    }
}
extension Api.channels {
    enum SendAsPeers: TypeConstructorDescription {
        class Cons_sendAsPeers: TypeConstructorDescription {
            var peers: [Api.SendAsPeer]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(peers: [Api.SendAsPeer], chats: [Api.Chat], users: [Api.User]) {
                self.peers = peers
                self.chats = chats
                self.users = users
            }
        }
        case sendAsPeers(Cons_sendAsPeers)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .sendAsPeers(let _data):
                if boxed {
                    buffer.appendInt32(-191450938)
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

        static func parse_sendAsPeers(_ reader: BufferReader) -> SendAsPeers? {
            var _1: [Api.SendAsPeer]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.SendAsPeer.self)
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
                return Api.channels.SendAsPeers.sendAsPeers(Cons_sendAsPeers(peers: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.chatlists {
    enum ChatlistInvite: TypeConstructorDescription {
        class Cons_chatlistInvite: TypeConstructorDescription {
            var flags: Int32
            var title: Api.TextWithEntities
            var emoticon: String?
            var peers: [Api.Peer]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, title: Api.TextWithEntities, emoticon: String?, peers: [Api.Peer], chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.title = title
                self.emoticon = emoticon
                self.peers = peers
                self.chats = chats
                self.users = users
            }
        }
        class Cons_chatlistInviteAlready: TypeConstructorDescription {
            var filterId: Int32
            var missingPeers: [Api.Peer]
            var alreadyPeers: [Api.Peer]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(filterId: Int32, missingPeers: [Api.Peer], alreadyPeers: [Api.Peer], chats: [Api.Chat], users: [Api.User]) {
                self.filterId = filterId
                self.missingPeers = missingPeers
                self.alreadyPeers = alreadyPeers
                self.chats = chats
                self.users = users
            }
        }
        case chatlistInvite(Cons_chatlistInvite)
        case chatlistInviteAlready(Cons_chatlistInviteAlready)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .chatlistInvite(let _data):
                if boxed {
                    buffer.appendInt32(-250687953)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.title.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.emoticon!, buffer: buffer, boxed: false)
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
            case .chatlistInviteAlready(let _data):
                if boxed {
                    buffer.appendInt32(-91752871)
                }
                serializeInt32(_data.filterId, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.missingPeers.count))
                for item in _data.missingPeers {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.alreadyPeers.count))
                for item in _data.alreadyPeers {
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

        static func parse_chatlistInvite(_ reader: BufferReader) -> ChatlistInvite? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.TextWithEntities?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
            }
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = parseString(reader)
            }
            var _4: [Api.Peer]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Peer.self)
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
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.chatlists.ChatlistInvite.chatlistInvite(Cons_chatlistInvite(flags: _1!, title: _2!, emoticon: _3, peers: _4!, chats: _5!, users: _6!))
            }
            else {
                return nil
            }
        }
        static func parse_chatlistInviteAlready(_ reader: BufferReader) -> ChatlistInvite? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.Peer]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Peer.self)
            }
            var _3: [Api.Peer]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Peer.self)
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
                return Api.chatlists.ChatlistInvite.chatlistInviteAlready(Cons_chatlistInviteAlready(filterId: _1!, missingPeers: _2!, alreadyPeers: _3!, chats: _4!, users: _5!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.chatlists {
    enum ChatlistUpdates: TypeConstructorDescription {
        class Cons_chatlistUpdates: TypeConstructorDescription {
            var missingPeers: [Api.Peer]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(missingPeers: [Api.Peer], chats: [Api.Chat], users: [Api.User]) {
                self.missingPeers = missingPeers
                self.chats = chats
                self.users = users
            }
        }
        case chatlistUpdates(Cons_chatlistUpdates)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .chatlistUpdates(let _data):
                if boxed {
                    buffer.appendInt32(-1816295539)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.missingPeers.count))
                for item in _data.missingPeers {
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

        static func parse_chatlistUpdates(_ reader: BufferReader) -> ChatlistUpdates? {
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
                return Api.chatlists.ChatlistUpdates.chatlistUpdates(Cons_chatlistUpdates(missingPeers: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.chatlists {
    enum ExportedInvites: TypeConstructorDescription {
        class Cons_exportedInvites: TypeConstructorDescription {
            var invites: [Api.ExportedChatlistInvite]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(invites: [Api.ExportedChatlistInvite], chats: [Api.Chat], users: [Api.User]) {
                self.invites = invites
                self.chats = chats
                self.users = users
            }
        }
        case exportedInvites(Cons_exportedInvites)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .exportedInvites(let _data):
                if boxed {
                    buffer.appendInt32(279670215)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.invites.count))
                for item in _data.invites {
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

        static func parse_exportedInvites(_ reader: BufferReader) -> ExportedInvites? {
            var _1: [Api.ExportedChatlistInvite]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.ExportedChatlistInvite.self)
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
                return Api.chatlists.ExportedInvites.exportedInvites(Cons_exportedInvites(invites: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.communities {
    enum ParticipantJoinedChats: TypeConstructorDescription {
        class Cons_participantJoinedChats: TypeConstructorDescription {
            var creatorChatIds: [Int64]
            var joinedChatIds: [Int64]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(creatorChatIds: [Int64], joinedChatIds: [Int64], chats: [Api.Chat], users: [Api.User]) {
                self.creatorChatIds = creatorChatIds
                self.joinedChatIds = joinedChatIds
                self.chats = chats
                self.users = users
            }
        }
        case participantJoinedChats(Cons_participantJoinedChats)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .participantJoinedChats(let _data):
                if boxed {
                    buffer.appendInt32(-1921494742)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.creatorChatIds.count))
                for item in _data.creatorChatIds {
                    serializeInt64(item, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.joinedChatIds.count))
                for item in _data.joinedChatIds {
                    serializeInt64(item, buffer: buffer, boxed: false)
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

        static func parse_participantJoinedChats(_ reader: BufferReader) -> ParticipantJoinedChats? {
            var _1: [Int64]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
            }
            var _2: [Int64]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
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
                return Api.communities.ParticipantJoinedChats.participantJoinedChats(Cons_participantJoinedChats(creatorChatIds: _1!, joinedChatIds: _2!, chats: _3!, users: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.communities {
    enum PeerLinkRequests: TypeConstructorDescription {
        class Cons_peerLinkRequests: TypeConstructorDescription {
            var flags: Int32
            var totalCount: Int32
            var requests: [Api.CommunityPeerRequest]
            var nextOffset: String?
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, totalCount: Int32, requests: [Api.CommunityPeerRequest], nextOffset: String?, chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.totalCount = totalCount
                self.requests = requests
                self.nextOffset = nextOffset
                self.chats = chats
                self.users = users
            }
        }
        case peerLinkRequests(Cons_peerLinkRequests)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .peerLinkRequests(let _data):
                if boxed {
                    buffer.appendInt32(574926765)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.totalCount, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.requests.count))
                for item in _data.requests {
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

        static func parse_peerLinkRequests(_ reader: BufferReader) -> PeerLinkRequests? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: [Api.CommunityPeerRequest]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.CommunityPeerRequest.self)
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
                return Api.communities.PeerLinkRequests.peerLinkRequests(Cons_peerLinkRequests(flags: _1!, totalCount: _2!, requests: _3!, nextOffset: _4, chats: _5!, users: _6!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.contacts {
    enum Blocked: TypeConstructorDescription {
        class Cons_blocked: TypeConstructorDescription {
            var blocked: [Api.PeerBlocked]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(blocked: [Api.PeerBlocked], chats: [Api.Chat], users: [Api.User]) {
                self.blocked = blocked
                self.chats = chats
                self.users = users
            }
        }
        class Cons_blockedSlice: TypeConstructorDescription {
            var count: Int32
            var blocked: [Api.PeerBlocked]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(count: Int32, blocked: [Api.PeerBlocked], chats: [Api.Chat], users: [Api.User]) {
                self.count = count
                self.blocked = blocked
                self.chats = chats
                self.users = users
            }
        }
        case blocked(Cons_blocked)
        case blockedSlice(Cons_blockedSlice)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .blocked(let _data):
                if boxed {
                    buffer.appendInt32(182326673)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.blocked.count))
                for item in _data.blocked {
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
            case .blockedSlice(let _data):
                if boxed {
                    buffer.appendInt32(-513392236)
                }
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.blocked.count))
                for item in _data.blocked {
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

        static func parse_blocked(_ reader: BufferReader) -> Blocked? {
            var _1: [Api.PeerBlocked]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PeerBlocked.self)
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
                return Api.contacts.Blocked.blocked(Cons_blocked(blocked: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_blockedSlice(_ reader: BufferReader) -> Blocked? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.PeerBlocked]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PeerBlocked.self)
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
                return Api.contacts.Blocked.blockedSlice(Cons_blockedSlice(count: _1!, blocked: _2!, chats: _3!, users: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.contacts {
    enum Found: TypeConstructorDescription {
        class Cons_found: TypeConstructorDescription {
            var myResults: [Api.Peer]
            var results: [Api.Peer]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(myResults: [Api.Peer], results: [Api.Peer], chats: [Api.Chat], users: [Api.User]) {
                self.myResults = myResults
                self.results = results
                self.chats = chats
                self.users = users
            }
        }
        case found(Cons_found)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .found(let _data):
                if boxed {
                    buffer.appendInt32(-1290580579)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.myResults.count))
                for item in _data.myResults {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.results.count))
                for item in _data.results {
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

        static func parse_found(_ reader: BufferReader) -> Found? {
            var _1: [Api.Peer]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Peer.self)
            }
            var _2: [Api.Peer]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Peer.self)
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
                return Api.contacts.Found.found(Cons_found(myResults: _1!, results: _2!, chats: _3!, users: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.contacts {
    enum ResolvedPeer: TypeConstructorDescription {
        class Cons_resolvedPeer: TypeConstructorDescription {
            var peer: Api.Peer
            var chats: [Api.Chat]
            var users: [Api.User]
            init(peer: Api.Peer, chats: [Api.Chat], users: [Api.User]) {
                self.peer = peer
                self.chats = chats
                self.users = users
            }
        }
        case resolvedPeer(Cons_resolvedPeer)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .resolvedPeer(let _data):
                if boxed {
                    buffer.appendInt32(2131196633)
                }
                _data.peer.serialize(buffer, true)
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

        static func parse_resolvedPeer(_ reader: BufferReader) -> ResolvedPeer? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
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
                return Api.contacts.ResolvedPeer.resolvedPeer(Cons_resolvedPeer(peer: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
