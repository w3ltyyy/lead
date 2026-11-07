extension Api {
    enum WallPaper: TypeConstructorDescription {
        class Cons_wallPaper: TypeConstructorDescription {
            var id: Int64
            var flags: Int32
            var accessHash: Int64
            var slug: String
            var document: Api.Document
            var settings: Api.WallPaperSettings?
            init(id: Int64, flags: Int32, accessHash: Int64, slug: String, document: Api.Document, settings: Api.WallPaperSettings?) {
                self.id = id
                self.flags = flags
                self.accessHash = accessHash
                self.slug = slug
                self.document = document
                self.settings = settings
            }
        }
        class Cons_wallPaperNoFile: TypeConstructorDescription {
            var id: Int64
            var flags: Int32
            var settings: Api.WallPaperSettings?
            init(id: Int64, flags: Int32, settings: Api.WallPaperSettings?) {
                self.id = id
                self.flags = flags
                self.settings = settings
            }
        }
        case wallPaper(Cons_wallPaper)
        case wallPaperNoFile(Cons_wallPaperNoFile)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .wallPaper(let _data):
                if boxed {
                    buffer.appendInt32(-1539849235)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeString(_data.slug, buffer: buffer, boxed: false)
                _data.document.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.settings!.serialize(buffer, true)
                }
                break
            case .wallPaperNoFile(let _data):
                if boxed {
                    buffer.appendInt32(-528465642)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.settings!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_wallPaper(_ reader: BufferReader) -> WallPaper? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: String?
            _4 = parseString(reader)
            var _5: Api.Document?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.Document
            }
            var _6: Api.WallPaperSettings?
            if Int(_2 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.WallPaperSettings
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_2 ?? 0) & Int(1 << 2) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.WallPaper.wallPaper(Cons_wallPaper(id: _1!, flags: _2!, accessHash: _3!, slug: _4!, document: _5!, settings: _6))
            }
            else {
                return nil
            }
        }
        static func parse_wallPaperNoFile(_ reader: BufferReader) -> WallPaper? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.WallPaperSettings?
            if Int(_2 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.WallPaperSettings
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_2 ?? 0) & Int(1 << 2) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.WallPaper.wallPaperNoFile(Cons_wallPaperNoFile(id: _1!, flags: _2!, settings: _3))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum WallPaperSettings: TypeConstructorDescription {
        class Cons_wallPaperSettings: TypeConstructorDescription {
            var flags: Int32
            var backgroundColor: Int32?
            var secondBackgroundColor: Int32?
            var thirdBackgroundColor: Int32?
            var fourthBackgroundColor: Int32?
            var intensity: Int32?
            var rotation: Int32?
            var emoticon: String?
            init(flags: Int32, backgroundColor: Int32?, secondBackgroundColor: Int32?, thirdBackgroundColor: Int32?, fourthBackgroundColor: Int32?, intensity: Int32?, rotation: Int32?, emoticon: String?) {
                self.flags = flags
                self.backgroundColor = backgroundColor
                self.secondBackgroundColor = secondBackgroundColor
                self.thirdBackgroundColor = thirdBackgroundColor
                self.fourthBackgroundColor = fourthBackgroundColor
                self.intensity = intensity
                self.rotation = rotation
                self.emoticon = emoticon
            }
        }
        case wallPaperSettings(Cons_wallPaperSettings)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .wallPaperSettings(let _data):
                if boxed {
                    buffer.appendInt32(925826256)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.backgroundColor!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.secondBackgroundColor!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeInt32(_data.thirdBackgroundColor!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    serializeInt32(_data.fourthBackgroundColor!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.intensity!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.rotation!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    serializeString(_data.emoticon!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_wallPaperSettings(_ reader: BufferReader) -> WallPaperSettings? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt32()
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                _5 = reader.readInt32()
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _6 = reader.readInt32()
            }
            var _7: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _7 = reader.readInt32()
            }
            var _8: String?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                _8 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.WallPaperSettings.wallPaperSettings(Cons_wallPaperSettings(flags: _1!, backgroundColor: _2, secondBackgroundColor: _3, thirdBackgroundColor: _4, fourthBackgroundColor: _5, intensity: _6, rotation: _7, emoticon: _8))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum WalletState: TypeConstructorDescription {
        class Cons_walletState: TypeConstructorDescription {
            var flags: Int32
            var address: String
            var publicKey: Buffer
            var balance: Int64
            init(flags: Int32, address: String, publicKey: Buffer, balance: Int64) {
                self.flags = flags
                self.address = address
                self.publicKey = publicKey
                self.balance = balance
            }
        }
        class Cons_walletStateEmpty: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        case walletState(Cons_walletState)
        case walletStateEmpty(Cons_walletStateEmpty)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .walletState(let _data):
                if boxed {
                    buffer.appendInt32(-1782238101)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.address, buffer: buffer, boxed: false)
                serializeBytes(_data.publicKey, buffer: buffer, boxed: false)
                serializeInt64(_data.balance, buffer: buffer, boxed: false)
                break
            case .walletStateEmpty(let _data):
                if boxed {
                    buffer.appendInt32(-1665551636)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_walletState(_ reader: BufferReader) -> WalletState? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Buffer?
            _3 = parseBytes(reader)
            var _4: Int64?
            _4 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.WalletState.walletState(Cons_walletState(flags: _1!, address: _2!, publicKey: _3!, balance: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_walletStateEmpty(_ reader: BufferReader) -> WalletState? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.WalletState.walletStateEmpty(Cons_walletStateEmpty(flags: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum WalletTransaction: TypeConstructorDescription {
        class Cons_walletTransaction: TypeConstructorDescription {
            var flags: Int32
            var id: String
            var amount: Int64
            var fee: Int64
            var date: Int32
            var peer: Api.WalletTransactionPeer
            var comment: String?
            var txHash: String?
            var nft: Api.wallet.NftItem?
            init(flags: Int32, id: String, amount: Int64, fee: Int64, date: Int32, peer: Api.WalletTransactionPeer, comment: String?, txHash: String?, nft: Api.wallet.NftItem?) {
                self.flags = flags
                self.id = id
                self.amount = amount
                self.fee = fee
                self.date = date
                self.peer = peer
                self.comment = comment
                self.txHash = txHash
                self.nft = nft
            }
        }
        case walletTransaction(Cons_walletTransaction)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .walletTransaction(let _data):
                if boxed {
                    buffer.appendInt32(-1792163517)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.amount, buffer: buffer, boxed: false)
                serializeInt64(_data.fee, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.comment!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeString(_data.txHash!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    _data.nft!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_walletTransaction(_ reader: BufferReader) -> WalletTransaction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Api.WalletTransactionPeer?
            if let signature = reader.readInt32() {
                _6 = Api.parse(reader, signature: signature) as? Api.WalletTransactionPeer
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _7 = parseString(reader)
            }
            var _8: String?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _8 = parseString(reader)
            }
            var _9: Api.wallet.NftItem?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.wallet.NftItem
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.WalletTransaction.walletTransaction(Cons_walletTransaction(flags: _1!, id: _2!, amount: _3!, fee: _4!, date: _5!, peer: _6!, comment: _7, txHash: _8, nft: _9))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum WalletTransactionPeer: TypeConstructorDescription {
        class Cons_walletTransactionPeerAddress: TypeConstructorDescription {
            var flags: Int32
            var address: String
            var domain: String?
            init(flags: Int32, address: String, domain: String?) {
                self.flags = flags
                self.address = address
                self.domain = domain
            }
        }
        class Cons_walletTransactionPeerChannel: TypeConstructorDescription {
            var flags: Int32
            var channelId: Int64
            var address: String
            var domain: String?
            init(flags: Int32, channelId: Int64, address: String, domain: String?) {
                self.flags = flags
                self.channelId = channelId
                self.address = address
                self.domain = domain
            }
        }
        class Cons_walletTransactionPeerOnramp: TypeConstructorDescription {
            var flags: Int32
            var address: String
            var domain: String?
            var providerName: String
            init(flags: Int32, address: String, domain: String?, providerName: String) {
                self.flags = flags
                self.address = address
                self.domain = domain
                self.providerName = providerName
            }
        }
        class Cons_walletTransactionPeerTelegramGift: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        class Cons_walletTransactionPeerUser: TypeConstructorDescription {
            var flags: Int32
            var userId: Int64
            var address: String
            var domain: String?
            init(flags: Int32, userId: Int64, address: String, domain: String?) {
                self.flags = flags
                self.userId = userId
                self.address = address
                self.domain = domain
            }
        }
        case walletTransactionPeerAddress(Cons_walletTransactionPeerAddress)
        case walletTransactionPeerChannel(Cons_walletTransactionPeerChannel)
        case walletTransactionPeerOnramp(Cons_walletTransactionPeerOnramp)
        case walletTransactionPeerTelegramGift(Cons_walletTransactionPeerTelegramGift)
        case walletTransactionPeerUnsupported
        case walletTransactionPeerUser(Cons_walletTransactionPeerUser)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .walletTransactionPeerAddress(let _data):
                if boxed {
                    buffer.appendInt32(103596476)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.address, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.domain!, buffer: buffer, boxed: false)
                }
                break
            case .walletTransactionPeerChannel(let _data):
                if boxed {
                    buffer.appendInt32(1424428081)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                serializeString(_data.address, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.domain!, buffer: buffer, boxed: false)
                }
                break
            case .walletTransactionPeerOnramp(let _data):
                if boxed {
                    buffer.appendInt32(-443213714)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.address, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.domain!, buffer: buffer, boxed: false)
                }
                serializeString(_data.providerName, buffer: buffer, boxed: false)
                break
            case .walletTransactionPeerTelegramGift(let _data):
                if boxed {
                    buffer.appendInt32(-193817447)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            case .walletTransactionPeerUnsupported:
                if boxed {
                    buffer.appendInt32(1921772890)
                }
                break
            case .walletTransactionPeerUser(let _data):
                if boxed {
                    buffer.appendInt32(-722833299)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeString(_data.address, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.domain!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_walletTransactionPeerAddress(_ reader: BufferReader) -> WalletTransactionPeer? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.WalletTransactionPeer.walletTransactionPeerAddress(Cons_walletTransactionPeerAddress(flags: _1!, address: _2!, domain: _3))
            }
            else {
                return nil
            }
        }
        static func parse_walletTransactionPeerChannel(_ reader: BufferReader) -> WalletTransactionPeer? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            _3 = parseString(reader)
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.WalletTransactionPeer.walletTransactionPeerChannel(Cons_walletTransactionPeerChannel(flags: _1!, channelId: _2!, address: _3!, domain: _4))
            }
            else {
                return nil
            }
        }
        static func parse_walletTransactionPeerOnramp(_ reader: BufferReader) -> WalletTransactionPeer? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = parseString(reader)
            }
            var _4: String?
            _4 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.WalletTransactionPeer.walletTransactionPeerOnramp(Cons_walletTransactionPeerOnramp(flags: _1!, address: _2!, domain: _3, providerName: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_walletTransactionPeerTelegramGift(_ reader: BufferReader) -> WalletTransactionPeer? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.WalletTransactionPeer.walletTransactionPeerTelegramGift(Cons_walletTransactionPeerTelegramGift(flags: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_walletTransactionPeerUnsupported(_ reader: BufferReader) -> WalletTransactionPeer? {
            return Api.WalletTransactionPeer.walletTransactionPeerUnsupported
        }
        static func parse_walletTransactionPeerUser(_ reader: BufferReader) -> WalletTransactionPeer? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            _3 = parseString(reader)
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.WalletTransactionPeer.walletTransactionPeerUser(Cons_walletTransactionPeerUser(flags: _1!, userId: _2!, address: _3!, domain: _4))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum WebDocument: TypeConstructorDescription {
        class Cons_webDocument: TypeConstructorDescription {
            var url: String
            var accessHash: Int64
            var size: Int32
            var mimeType: String
            var attributes: [Api.DocumentAttribute]
            init(url: String, accessHash: Int64, size: Int32, mimeType: String, attributes: [Api.DocumentAttribute]) {
                self.url = url
                self.accessHash = accessHash
                self.size = size
                self.mimeType = mimeType
                self.attributes = attributes
            }
        }
        class Cons_webDocumentNoProxy: TypeConstructorDescription {
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
        case webDocument(Cons_webDocument)
        case webDocumentNoProxy(Cons_webDocumentNoProxy)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .webDocument(let _data):
                if boxed {
                    buffer.appendInt32(475467473)
                }
                serializeString(_data.url, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeInt32(_data.size, buffer: buffer, boxed: false)
                serializeString(_data.mimeType, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.attributes.count))
                for item in _data.attributes {
                    item.serialize(buffer, true)
                }
                break
            case .webDocumentNoProxy(let _data):
                if boxed {
                    buffer.appendInt32(-104284986)
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

        static func parse_webDocument(_ reader: BufferReader) -> WebDocument? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: String?
            _4 = parseString(reader)
            var _5: [Api.DocumentAttribute]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.DocumentAttribute.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.WebDocument.webDocument(Cons_webDocument(url: _1!, accessHash: _2!, size: _3!, mimeType: _4!, attributes: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_webDocumentNoProxy(_ reader: BufferReader) -> WebDocument? {
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
                return Api.WebDocument.webDocumentNoProxy(Cons_webDocumentNoProxy(url: _1!, size: _2!, mimeType: _3!, attributes: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum WebDomainException: TypeConstructorDescription {
        class Cons_webDomainException: TypeConstructorDescription {
            var flags: Int32
            var domain: String
            var url: String
            var title: String
            var favicon: Int64?
            init(flags: Int32, domain: String, url: String, title: String, favicon: Int64?) {
                self.flags = flags
                self.domain = domain
                self.url = url
                self.title = title
                self.favicon = favicon
            }
        }
        case webDomainException(Cons_webDomainException)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .webDomainException(let _data):
                if boxed {
                    buffer.appendInt32(-1824741993)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.domain, buffer: buffer, boxed: false)
                serializeString(_data.url, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.favicon!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_webDomainException(_ reader: BufferReader) -> WebDomainException? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            _3 = parseString(reader)
            var _4: String?
            _4 = parseString(reader)
            var _5: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = reader.readInt64()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.WebDomainException.webDomainException(Cons_webDomainException(flags: _1!, domain: _2!, url: _3!, title: _4!, favicon: _5))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum WebPage: TypeConstructorDescription {
        class Cons_webPage: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var url: String
            var displayUrl: String
            var hash: Int32
            var type: String?
            var siteName: String?
            var title: String?
            var description: String?
            var photo: Api.Photo?
            var embedUrl: String?
            var embedType: String?
            var embedWidth: Int32?
            var embedHeight: Int32?
            var duration: Int32?
            var author: String?
            var document: Api.Document?
            var cachedPage: Api.Page?
            var attributes: [Api.WebPageAttribute]?
            init(flags: Int32, id: Int64, url: String, displayUrl: String, hash: Int32, type: String?, siteName: String?, title: String?, description: String?, photo: Api.Photo?, embedUrl: String?, embedType: String?, embedWidth: Int32?, embedHeight: Int32?, duration: Int32?, author: String?, document: Api.Document?, cachedPage: Api.Page?, attributes: [Api.WebPageAttribute]?) {
                self.flags = flags
                self.id = id
                self.url = url
                self.displayUrl = displayUrl
                self.hash = hash
                self.type = type
                self.siteName = siteName
                self.title = title
                self.description = description
                self.photo = photo
                self.embedUrl = embedUrl
                self.embedType = embedType
                self.embedWidth = embedWidth
                self.embedHeight = embedHeight
                self.duration = duration
                self.author = author
                self.document = document
                self.cachedPage = cachedPage
                self.attributes = attributes
            }
        }
        class Cons_webPageEmpty: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var url: String?
            init(flags: Int32, id: Int64, url: String?) {
                self.flags = flags
                self.id = id
                self.url = url
            }
        }
        class Cons_webPageNotModified: TypeConstructorDescription {
            var flags: Int32
            var cachedPageViews: Int32?
            init(flags: Int32, cachedPageViews: Int32?) {
                self.flags = flags
                self.cachedPageViews = cachedPageViews
            }
        }
        class Cons_webPagePending: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var url: String?
            var date: Int32
            init(flags: Int32, id: Int64, url: String?, date: Int32) {
                self.flags = flags
                self.id = id
                self.url = url
                self.date = date
            }
        }
        case webPage(Cons_webPage)
        case webPageEmpty(Cons_webPageEmpty)
        case webPageNotModified(Cons_webPageNotModified)
        case webPagePending(Cons_webPagePending)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .webPage(let _data):
                if boxed {
                    buffer.appendInt32(-392411726)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeString(_data.url, buffer: buffer, boxed: false)
                serializeString(_data.displayUrl, buffer: buffer, boxed: false)
                serializeInt32(_data.hash, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.type!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.siteName!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.title!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.description!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    _data.photo!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeString(_data.embedUrl!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeString(_data.embedType!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    serializeInt32(_data.embedWidth!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    serializeInt32(_data.embedHeight!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    serializeInt32(_data.duration!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    serializeString(_data.author!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    _data.document!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    _data.cachedPage!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 12) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.attributes!.count))
                    for item in _data.attributes! {
                        item.serialize(buffer, true)
                    }
                }
                break
            case .webPageEmpty(let _data):
                if boxed {
                    buffer.appendInt32(555358088)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.url!, buffer: buffer, boxed: false)
                }
                break
            case .webPageNotModified(let _data):
                if boxed {
                    buffer.appendInt32(1930545681)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.cachedPageViews!, buffer: buffer, boxed: false)
                }
                break
            case .webPagePending(let _data):
                if boxed {
                    buffer.appendInt32(-1328464313)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.url!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_webPage(_ reader: BufferReader) -> WebPage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            _3 = parseString(reader)
            var _4: String?
            _4 = parseString(reader)
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _6 = parseString(reader)
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _7 = parseString(reader)
            }
            var _8: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _8 = parseString(reader)
            }
            var _9: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _9 = parseString(reader)
            }
            var _10: Api.Photo?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _10 = Api.parse(reader, signature: signature) as? Api.Photo
                }
            }
            var _11: String?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _11 = parseString(reader)
            }
            var _12: String?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _12 = parseString(reader)
            }
            var _13: Int32?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                _13 = reader.readInt32()
            }
            var _14: Int32?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                _14 = reader.readInt32()
            }
            var _15: Int32?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                _15 = reader.readInt32()
            }
            var _16: String?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                _16 = parseString(reader)
            }
            var _17: Api.Document?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                if let signature = reader.readInt32() {
                    _17 = Api.parse(reader, signature: signature) as? Api.Document
                }
            }
            var _18: Api.Page?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                if let signature = reader.readInt32() {
                    _18 = Api.parse(reader, signature: signature) as? Api.Page
                }
            }
            var _19: [Api.WebPageAttribute]?
            if Int(_1 ?? 0) & Int(1 << 12) != 0 {
                if let _ = reader.readInt32() {
                    _19 = Api.parseVector(reader, elementSignature: 0, elementType: Api.WebPageAttribute.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _13 != nil
            let _c14 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _14 != nil
            let _c15 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _15 != nil
            let _c16 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _16 != nil
            let _c17 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _17 != nil
            let _c18 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _18 != nil
            let _c19 = (Int(_1 ?? 0) & Int(1 << 12) == 0) || _19 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 && _c15 && _c16 && _c17 && _c18 && _c19 {
                return Api.WebPage.webPage(Cons_webPage(flags: _1!, id: _2!, url: _3!, displayUrl: _4!, hash: _5!, type: _6, siteName: _7, title: _8, description: _9, photo: _10, embedUrl: _11, embedType: _12, embedWidth: _13, embedHeight: _14, duration: _15, author: _16, document: _17, cachedPage: _18, attributes: _19))
            }
            else {
                return nil
            }
        }
        static func parse_webPageEmpty(_ reader: BufferReader) -> WebPage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.WebPage.webPageEmpty(Cons_webPageEmpty(flags: _1!, id: _2!, url: _3))
            }
            else {
                return nil
            }
        }
        static func parse_webPageNotModified(_ reader: BufferReader) -> WebPage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            if _c1 && _c2 {
                return Api.WebPage.webPageNotModified(Cons_webPageNotModified(flags: _1!, cachedPageViews: _2))
            }
            else {
                return nil
            }
        }
        static func parse_webPagePending(_ reader: BufferReader) -> WebPage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = parseString(reader)
            }
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.WebPage.webPagePending(Cons_webPagePending(flags: _1!, id: _2!, url: _3, date: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum WebPageAttribute: TypeConstructorDescription {
        class Cons_webPageAttributeAiComposeTone: TypeConstructorDescription {
            var emojiId: Int64
            init(emojiId: Int64) {
                self.emojiId = emojiId
            }
        }
        class Cons_webPageAttributeStarGiftAuction: TypeConstructorDescription {
            var gift: Api.StarGift
            var endDate: Int32
            init(gift: Api.StarGift, endDate: Int32) {
                self.gift = gift
                self.endDate = endDate
            }
        }
        class Cons_webPageAttributeStarGiftCollection: TypeConstructorDescription {
            var icons: [Api.Document]
            init(icons: [Api.Document]) {
                self.icons = icons
            }
        }
        class Cons_webPageAttributeStickerSet: TypeConstructorDescription {
            var flags: Int32
            var stickers: [Api.Document]
            init(flags: Int32, stickers: [Api.Document]) {
                self.flags = flags
                self.stickers = stickers
            }
        }
        class Cons_webPageAttributeStory: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var id: Int32
            var story: Api.StoryItem?
            init(flags: Int32, peer: Api.Peer, id: Int32, story: Api.StoryItem?) {
                self.flags = flags
                self.peer = peer
                self.id = id
                self.story = story
            }
        }
        class Cons_webPageAttributeTheme: TypeConstructorDescription {
            var flags: Int32
            var documents: [Api.Document]?
            var settings: Api.ThemeSettings?
            init(flags: Int32, documents: [Api.Document]?, settings: Api.ThemeSettings?) {
                self.flags = flags
                self.documents = documents
                self.settings = settings
            }
        }
        class Cons_webPageAttributeUniqueStarGift: TypeConstructorDescription {
            var gift: Api.StarGift
            init(gift: Api.StarGift) {
                self.gift = gift
            }
        }
        case webPageAttributeAiComposeTone(Cons_webPageAttributeAiComposeTone)
        case webPageAttributeStarGiftAuction(Cons_webPageAttributeStarGiftAuction)
        case webPageAttributeStarGiftCollection(Cons_webPageAttributeStarGiftCollection)
        case webPageAttributeStickerSet(Cons_webPageAttributeStickerSet)
        case webPageAttributeStory(Cons_webPageAttributeStory)
        case webPageAttributeTheme(Cons_webPageAttributeTheme)
        case webPageAttributeUniqueStarGift(Cons_webPageAttributeUniqueStarGift)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .webPageAttributeAiComposeTone(let _data):
                if boxed {
                    buffer.appendInt32(2005007896)
                }
                serializeInt64(_data.emojiId, buffer: buffer, boxed: false)
                break
            case .webPageAttributeStarGiftAuction(let _data):
                if boxed {
                    buffer.appendInt32(29770178)
                }
                _data.gift.serialize(buffer, true)
                serializeInt32(_data.endDate, buffer: buffer, boxed: false)
                break
            case .webPageAttributeStarGiftCollection(let _data):
                if boxed {
                    buffer.appendInt32(835375875)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.icons.count))
                for item in _data.icons {
                    item.serialize(buffer, true)
                }
                break
            case .webPageAttributeStickerSet(let _data):
                if boxed {
                    buffer.appendInt32(1355547603)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.stickers.count))
                for item in _data.stickers {
                    item.serialize(buffer, true)
                }
                break
            case .webPageAttributeStory(let _data):
                if boxed {
                    buffer.appendInt32(781501415)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.story!.serialize(buffer, true)
                }
                break
            case .webPageAttributeTheme(let _data):
                if boxed {
                    buffer.appendInt32(1421174295)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.documents!.count))
                    for item in _data.documents! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.settings!.serialize(buffer, true)
                }
                break
            case .webPageAttributeUniqueStarGift(let _data):
                if boxed {
                    buffer.appendInt32(-814781000)
                }
                _data.gift.serialize(buffer, true)
                break
            }
        }

        static func parse_webPageAttributeAiComposeTone(_ reader: BufferReader) -> WebPageAttribute? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.WebPageAttribute.webPageAttributeAiComposeTone(Cons_webPageAttributeAiComposeTone(emojiId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_webPageAttributeStarGiftAuction(_ reader: BufferReader) -> WebPageAttribute? {
            var _1: Api.StarGift?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.StarGift
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.WebPageAttribute.webPageAttributeStarGiftAuction(Cons_webPageAttributeStarGiftAuction(gift: _1!, endDate: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_webPageAttributeStarGiftCollection(_ reader: BufferReader) -> WebPageAttribute? {
            var _1: [Api.Document]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Document.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.WebPageAttribute.webPageAttributeStarGiftCollection(Cons_webPageAttributeStarGiftCollection(icons: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_webPageAttributeStickerSet(_ reader: BufferReader) -> WebPageAttribute? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.Document]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Document.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.WebPageAttribute.webPageAttributeStickerSet(Cons_webPageAttributeStickerSet(flags: _1!, stickers: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_webPageAttributeStory(_ reader: BufferReader) -> WebPageAttribute? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Api.StoryItem?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.StoryItem
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.WebPageAttribute.webPageAttributeStory(Cons_webPageAttributeStory(flags: _1!, peer: _2!, id: _3!, story: _4))
            }
            else {
                return nil
            }
        }
        static func parse_webPageAttributeTheme(_ reader: BufferReader) -> WebPageAttribute? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.Document]?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Document.self)
                }
            }
            var _3: Api.ThemeSettings?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.ThemeSettings
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.WebPageAttribute.webPageAttributeTheme(Cons_webPageAttributeTheme(flags: _1!, documents: _2, settings: _3))
            }
            else {
                return nil
            }
        }
        static func parse_webPageAttributeUniqueStarGift(_ reader: BufferReader) -> WebPageAttribute? {
            var _1: Api.StarGift?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.StarGift
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.WebPageAttribute.webPageAttributeUniqueStarGift(Cons_webPageAttributeUniqueStarGift(gift: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum WidgetQueryType: TypeConstructorDescription {
        class Cons_widgetQueryTypeData: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        class Cons_widgetQueryTypeSentTransaction: TypeConstructorDescription {
            var wallet: Api.UserWallet
            var msgHash: String
            init(wallet: Api.UserWallet, msgHash: String) {
                self.wallet = wallet
                self.msgHash = msgHash
            }
        }
        class Cons_widgetQueryTypeSignData: TypeConstructorDescription {
            var wallet: Api.UserWallet
            var signData: Api.DataJSON
            init(wallet: Api.UserWallet, signData: Api.DataJSON) {
                self.wallet = wallet
                self.signData = signData
            }
        }
        case widgetQueryTypeData(Cons_widgetQueryTypeData)
        case widgetQueryTypeSentTransaction(Cons_widgetQueryTypeSentTransaction)
        case widgetQueryTypeSignData(Cons_widgetQueryTypeSignData)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .widgetQueryTypeData(let _data):
                if boxed {
                    buffer.appendInt32(383307531)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            case .widgetQueryTypeSentTransaction(let _data):
                if boxed {
                    buffer.appendInt32(-12897356)
                }
                _data.wallet.serialize(buffer, true)
                serializeString(_data.msgHash, buffer: buffer, boxed: false)
                break
            case .widgetQueryTypeSignData(let _data):
                if boxed {
                    buffer.appendInt32(421545948)
                }
                _data.wallet.serialize(buffer, true)
                _data.signData.serialize(buffer, true)
                break
            }
        }

        static func parse_widgetQueryTypeData(_ reader: BufferReader) -> WidgetQueryType? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.WidgetQueryType.widgetQueryTypeData(Cons_widgetQueryTypeData(flags: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_widgetQueryTypeSentTransaction(_ reader: BufferReader) -> WidgetQueryType? {
            var _1: Api.UserWallet?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.UserWallet
            }
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.WidgetQueryType.widgetQueryTypeSentTransaction(Cons_widgetQueryTypeSentTransaction(wallet: _1!, msgHash: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_widgetQueryTypeSignData(_ reader: BufferReader) -> WidgetQueryType? {
            var _1: Api.UserWallet?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.UserWallet
            }
            var _2: Api.DataJSON?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.DataJSON
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.WidgetQueryType.widgetQueryTypeSignData(Cons_widgetQueryTypeSignData(wallet: _1!, signData: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.account {
    enum AutoSaveSettings: TypeConstructorDescription {
        class Cons_autoSaveSettings: TypeConstructorDescription {
            var usersSettings: Api.AutoSaveSettings
            var chatsSettings: Api.AutoSaveSettings
            var broadcastsSettings: Api.AutoSaveSettings
            var exceptions: [Api.AutoSaveException]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(usersSettings: Api.AutoSaveSettings, chatsSettings: Api.AutoSaveSettings, broadcastsSettings: Api.AutoSaveSettings, exceptions: [Api.AutoSaveException], chats: [Api.Chat], users: [Api.User]) {
                self.usersSettings = usersSettings
                self.chatsSettings = chatsSettings
                self.broadcastsSettings = broadcastsSettings
                self.exceptions = exceptions
                self.chats = chats
                self.users = users
            }
        }
        case autoSaveSettings(Cons_autoSaveSettings)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .autoSaveSettings(let _data):
                if boxed {
                    buffer.appendInt32(1279133341)
                }
                _data.usersSettings.serialize(buffer, true)
                _data.chatsSettings.serialize(buffer, true)
                _data.broadcastsSettings.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.exceptions.count))
                for item in _data.exceptions {
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

        static func parse_autoSaveSettings(_ reader: BufferReader) -> AutoSaveSettings? {
            var _1: Api.AutoSaveSettings?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.AutoSaveSettings
            }
            var _2: Api.AutoSaveSettings?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.AutoSaveSettings
            }
            var _3: Api.AutoSaveSettings?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.AutoSaveSettings
            }
            var _4: [Api.AutoSaveException]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.AutoSaveException.self)
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
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.account.AutoSaveSettings.autoSaveSettings(Cons_autoSaveSettings(usersSettings: _1!, chatsSettings: _2!, broadcastsSettings: _3!, exceptions: _4!, chats: _5!, users: _6!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.account {
    enum BusinessChatLinks: TypeConstructorDescription {
        class Cons_businessChatLinks: TypeConstructorDescription {
            var links: [Api.BusinessChatLink]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(links: [Api.BusinessChatLink], chats: [Api.Chat], users: [Api.User]) {
                self.links = links
                self.chats = chats
                self.users = users
            }
        }
        case businessChatLinks(Cons_businessChatLinks)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .businessChatLinks(let _data):
                if boxed {
                    buffer.appendInt32(-331111727)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.links.count))
                for item in _data.links {
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

        static func parse_businessChatLinks(_ reader: BufferReader) -> BusinessChatLinks? {
            var _1: [Api.BusinessChatLink]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.BusinessChatLink.self)
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
                return Api.account.BusinessChatLinks.businessChatLinks(Cons_businessChatLinks(links: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.account {
    enum ChatThemes: TypeConstructorDescription {
        class Cons_chatThemes: TypeConstructorDescription {
            var flags: Int32
            var hash: Int64
            var themes: [Api.ChatTheme]
            var chats: [Api.Chat]
            var users: [Api.User]
            var nextOffset: String?
            init(flags: Int32, hash: Int64, themes: [Api.ChatTheme], chats: [Api.Chat], users: [Api.User], nextOffset: String?) {
                self.flags = flags
                self.hash = hash
                self.themes = themes
                self.chats = chats
                self.users = users
                self.nextOffset = nextOffset
            }
        }
        case chatThemes(Cons_chatThemes)
        case chatThemesNotModified

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .chatThemes(let _data):
                if boxed {
                    buffer.appendInt32(-1106673293)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.hash, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.themes.count))
                for item in _data.themes {
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
            case .chatThemesNotModified:
                if boxed {
                    buffer.appendInt32(-535699004)
                }
                break
            }
        }

        static func parse_chatThemes(_ reader: BufferReader) -> ChatThemes? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: [Api.ChatTheme]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.ChatTheme.self)
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
                return Api.account.ChatThemes.chatThemes(Cons_chatThemes(flags: _1!, hash: _2!, themes: _3!, chats: _4!, users: _5!, nextOffset: _6))
            }
            else {
                return nil
            }
        }
        static func parse_chatThemesNotModified(_ reader: BufferReader) -> ChatThemes? {
            return Api.account.ChatThemes.chatThemesNotModified
        }
    }
}
extension Api.account {
    enum PrivacyRules: TypeConstructorDescription {
        class Cons_privacyRules: TypeConstructorDescription {
            var rules: [Api.PrivacyRule]
            var chats: [Api.Chat]
            var users: [Api.User]
            init(rules: [Api.PrivacyRule], chats: [Api.Chat], users: [Api.User]) {
                self.rules = rules
                self.chats = chats
                self.users = users
            }
        }
        case privacyRules(Cons_privacyRules)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .privacyRules(let _data):
                if boxed {
                    buffer.appendInt32(1352683077)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.rules.count))
                for item in _data.rules {
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

        static func parse_privacyRules(_ reader: BufferReader) -> PrivacyRules? {
            var _1: [Api.PrivacyRule]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PrivacyRule.self)
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
                return Api.account.PrivacyRules.privacyRules(Cons_privacyRules(rules: _1!, chats: _2!, users: _3!))
            }
            else {
                return nil
            }
        }
    }
}
