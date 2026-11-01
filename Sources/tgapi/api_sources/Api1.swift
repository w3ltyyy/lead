extension Api {
    enum AuctionBidLevel: TypeConstructorDescription {
        class Cons_auctionBidLevel: TypeConstructorDescription {
            var pos: Int32
            var amount: Int64
            var date: Int32
            init(pos: Int32, amount: Int64, date: Int32) {
                self.pos = pos
                self.amount = amount
                self.date = date
            }
        }
        case auctionBidLevel(Cons_auctionBidLevel)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .auctionBidLevel(let _data):
                if boxed {
                    buffer.appendInt32(822231244)
                }
                serializeInt32(_data.pos, buffer: buffer, boxed: false)
                serializeInt64(_data.amount, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_auctionBidLevel(_ reader: BufferReader) -> AuctionBidLevel? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.AuctionBidLevel.auctionBidLevel(Cons_auctionBidLevel(pos: _1!, amount: _2!, date: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum AutoSaveException: TypeConstructorDescription {
        class Cons_autoSaveException: TypeConstructorDescription {
            var peer: Api.Peer
            var settings: Api.AutoSaveSettings
            init(peer: Api.Peer, settings: Api.AutoSaveSettings) {
                self.peer = peer
                self.settings = settings
            }
        }
        case autoSaveException(Cons_autoSaveException)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .autoSaveException(let _data):
                if boxed {
                    buffer.appendInt32(-2124403385)
                }
                _data.peer.serialize(buffer, true)
                _data.settings.serialize(buffer, true)
                break
            }
        }

        static func parse_autoSaveException(_ reader: BufferReader) -> AutoSaveException? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Api.AutoSaveSettings?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.AutoSaveSettings
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.AutoSaveException.autoSaveException(Cons_autoSaveException(peer: _1!, settings: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum AutoSaveSettings: TypeConstructorDescription {
        class Cons_autoSaveSettings: TypeConstructorDescription {
            var flags: Int32
            var videoMaxSize: Int64?
            init(flags: Int32, videoMaxSize: Int64?) {
                self.flags = flags
                self.videoMaxSize = videoMaxSize
            }
        }
        case autoSaveSettings(Cons_autoSaveSettings)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .autoSaveSettings(let _data):
                if boxed {
                    buffer.appendInt32(-934791986)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt64(_data.videoMaxSize!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_autoSaveSettings(_ reader: BufferReader) -> AutoSaveSettings? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _2 = reader.readInt64()
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _2 != nil
            if _c1 && _c2 {
                return Api.AutoSaveSettings.autoSaveSettings(Cons_autoSaveSettings(flags: _1!, videoMaxSize: _2))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BaseTheme: TypeConstructorDescription {
        case baseThemeArctic
        case baseThemeClassic
        case baseThemeDay
        case baseThemeNight
        case baseThemeTinted

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .baseThemeArctic:
                if boxed {
                    buffer.appendInt32(1527845466)
                }
                break
            case .baseThemeClassic:
                if boxed {
                    buffer.appendInt32(-1012849566)
                }
                break
            case .baseThemeDay:
                if boxed {
                    buffer.appendInt32(-69724536)
                }
                break
            case .baseThemeNight:
                if boxed {
                    buffer.appendInt32(-1212997976)
                }
                break
            case .baseThemeTinted:
                if boxed {
                    buffer.appendInt32(1834973166)
                }
                break
            }
        }

        static func parse_baseThemeArctic(_ reader: BufferReader) -> BaseTheme? {
            return Api.BaseTheme.baseThemeArctic
        }
        static func parse_baseThemeClassic(_ reader: BufferReader) -> BaseTheme? {
            return Api.BaseTheme.baseThemeClassic
        }
        static func parse_baseThemeDay(_ reader: BufferReader) -> BaseTheme? {
            return Api.BaseTheme.baseThemeDay
        }
        static func parse_baseThemeNight(_ reader: BufferReader) -> BaseTheme? {
            return Api.BaseTheme.baseThemeNight
        }
        static func parse_baseThemeTinted(_ reader: BufferReader) -> BaseTheme? {
            return Api.BaseTheme.baseThemeTinted
        }
    }
}
extension Api {
    enum Birthday: TypeConstructorDescription {
        class Cons_birthday: TypeConstructorDescription {
            var flags: Int32
            var day: Int32
            var month: Int32
            var year: Int32?
            init(flags: Int32, day: Int32, month: Int32, year: Int32?) {
                self.flags = flags
                self.day = day
                self.month = month
                self.year = year
            }
        }
        case birthday(Cons_birthday)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .birthday(let _data):
                if boxed {
                    buffer.appendInt32(1821253126)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.day, buffer: buffer, boxed: false)
                serializeInt32(_data.month, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.year!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_birthday(_ reader: BufferReader) -> Birthday? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.Birthday.birthday(Cons_birthday(flags: _1!, day: _2!, month: _3!, year: _4))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum Bool: TypeConstructorDescription {
        case boolFalse
        case boolTrue

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .boolFalse:
                if boxed {
                    buffer.appendInt32(-1132882121)
                }
                break
            case .boolTrue:
                if boxed {
                    buffer.appendInt32(-1720552011)
                }
                break
            }
        }

        static func parse_boolFalse(_ reader: BufferReader) -> Bool? {
            return Api.Bool.boolFalse
        }
        static func parse_boolTrue(_ reader: BufferReader) -> Bool? {
            return Api.Bool.boolTrue
        }
    }
}
extension Api {
    enum Boost: TypeConstructorDescription {
        class Cons_boost: TypeConstructorDescription {
            var flags: Int32
            var id: String
            var userId: Int64?
            var giveawayMsgId: Int32?
            var date: Int32
            var expires: Int32
            var usedGiftSlug: String?
            var multiplier: Int32?
            var stars: Int64?
            init(flags: Int32, id: String, userId: Int64?, giveawayMsgId: Int32?, date: Int32, expires: Int32, usedGiftSlug: String?, multiplier: Int32?, stars: Int64?) {
                self.flags = flags
                self.id = id
                self.userId = userId
                self.giveawayMsgId = giveawayMsgId
                self.date = date
                self.expires = expires
                self.usedGiftSlug = usedGiftSlug
                self.multiplier = multiplier
                self.stars = stars
            }
        }
        case boost(Cons_boost)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .boost(let _data):
                if boxed {
                    buffer.appendInt32(1262359766)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.userId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.giveawayMsgId!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt32(_data.expires, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeString(_data.usedGiftSlug!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeInt32(_data.multiplier!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    serializeInt64(_data.stars!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_boost(_ reader: BufferReader) -> Boost? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt64()
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _7 = parseString(reader)
            }
            var _8: Int32?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _8 = reader.readInt32()
            }
            var _9: Int64?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                _9 = reader.readInt64()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.Boost.boost(Cons_boost(flags: _1!, id: _2!, userId: _3, giveawayMsgId: _4, date: _5!, expires: _6!, usedGiftSlug: _7, multiplier: _8, stars: _9))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BotApp: TypeConstructorDescription {
        class Cons_botApp: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var accessHash: Int64
            var shortName: String
            var title: String
            var description: String
            var photo: Api.Photo
            var document: Api.Document?
            var hash: Int64
            init(flags: Int32, id: Int64, accessHash: Int64, shortName: String, title: String, description: String, photo: Api.Photo, document: Api.Document?, hash: Int64) {
                self.flags = flags
                self.id = id
                self.accessHash = accessHash
                self.shortName = shortName
                self.title = title
                self.description = description
                self.photo = photo
                self.document = document
                self.hash = hash
            }
        }
        case botApp(Cons_botApp)
        case botAppNotModified

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .botApp(let _data):
                if boxed {
                    buffer.appendInt32(-1778593322)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeString(_data.shortName, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeString(_data.description, buffer: buffer, boxed: false)
                _data.photo.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.document!.serialize(buffer, true)
                }
                serializeInt64(_data.hash, buffer: buffer, boxed: false)
                break
            case .botAppNotModified:
                if boxed {
                    buffer.appendInt32(1571189943)
                }
                break
            }
        }

        static func parse_botApp(_ reader: BufferReader) -> BotApp? {
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
            var _6: String?
            _6 = parseString(reader)
            var _7: Api.Photo?
            if let signature = reader.readInt32() {
                _7 = Api.parse(reader, signature: signature) as? Api.Photo
            }
            var _8: Api.Document?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.Document
                }
            }
            var _9: Int64?
            _9 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _8 != nil
            let _c9 = _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.BotApp.botApp(Cons_botApp(flags: _1!, id: _2!, accessHash: _3!, shortName: _4!, title: _5!, description: _6!, photo: _7!, document: _8, hash: _9!))
            }
            else {
                return nil
            }
        }
        static func parse_botAppNotModified(_ reader: BufferReader) -> BotApp? {
            return Api.BotApp.botAppNotModified
        }
    }
}
extension Api {
    enum BotAppSettings: TypeConstructorDescription {
        class Cons_botAppSettings: TypeConstructorDescription {
            var flags: Int32
            var placeholderPath: Buffer?
            var backgroundColor: Int32?
            var backgroundDarkColor: Int32?
            var headerColor: Int32?
            var headerDarkColor: Int32?
            init(flags: Int32, placeholderPath: Buffer?, backgroundColor: Int32?, backgroundDarkColor: Int32?, headerColor: Int32?, headerDarkColor: Int32?) {
                self.flags = flags
                self.placeholderPath = placeholderPath
                self.backgroundColor = backgroundColor
                self.backgroundDarkColor = backgroundDarkColor
                self.headerColor = headerColor
                self.headerDarkColor = headerDarkColor
            }
        }
        case botAppSettings(Cons_botAppSettings)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .botAppSettings(let _data):
                if boxed {
                    buffer.appendInt32(-912582320)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeBytes(_data.placeholderPath!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.backgroundColor!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.backgroundDarkColor!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.headerColor!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.headerDarkColor!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_botAppSettings(_ reader: BufferReader) -> BotAppSettings? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Buffer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = parseBytes(reader)
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _5 = reader.readInt32()
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _6 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.BotAppSettings.botAppSettings(Cons_botAppSettings(flags: _1!, placeholderPath: _2, backgroundColor: _3, backgroundDarkColor: _4, headerColor: _5, headerDarkColor: _6))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BotBusinessConnection: TypeConstructorDescription {
        class Cons_botBusinessConnection: TypeConstructorDescription {
            var flags: Int32
            var connectionId: String
            var userId: Int64
            var dcId: Int32
            var date: Int32
            var rights: Api.BusinessBotRights?
            init(flags: Int32, connectionId: String, userId: Int64, dcId: Int32, date: Int32, rights: Api.BusinessBotRights?) {
                self.flags = flags
                self.connectionId = connectionId
                self.userId = userId
                self.dcId = dcId
                self.date = date
                self.rights = rights
            }
        }
        case botBusinessConnection(Cons_botBusinessConnection)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .botBusinessConnection(let _data):
                if boxed {
                    buffer.appendInt32(-1892371723)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.connectionId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeInt32(_data.dcId, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.rights!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_botBusinessConnection(_ reader: BufferReader) -> BotBusinessConnection? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Api.BusinessBotRights?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.BusinessBotRights
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.BotBusinessConnection.botBusinessConnection(Cons_botBusinessConnection(flags: _1!, connectionId: _2!, userId: _3!, dcId: _4!, date: _5!, rights: _6))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BotCommand: TypeConstructorDescription {
        class Cons_botCommand: TypeConstructorDescription {
            var flags: Int32
            var command: String
            var description: String
            init(flags: Int32, command: String, description: String) {
                self.flags = flags
                self.command = command
                self.description = description
            }
        }
        case botCommand(Cons_botCommand)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .botCommand(let _data):
                if boxed {
                    buffer.appendInt32(-1739401518)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.command, buffer: buffer, boxed: false)
                serializeString(_data.description, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_botCommand(_ reader: BufferReader) -> BotCommand? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            _3 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.BotCommand.botCommand(Cons_botCommand(flags: _1!, command: _2!, description: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BotInfo: TypeConstructorDescription {
        class Cons_botInfo: TypeConstructorDescription {
            var flags: Int32
            var userId: Int64?
            var description: String?
            var descriptionPhoto: Api.Photo?
            var descriptionDocument: Api.Document?
            var commands: [Api.BotCommand]?
            var menuButton: Api.BotMenuButton?
            var privacyPolicyUrl: String?
            var appSettings: Api.BotAppSettings?
            var verifierSettings: Api.BotVerifierSettings?
            init(flags: Int32, userId: Int64?, description: String?, descriptionPhoto: Api.Photo?, descriptionDocument: Api.Document?, commands: [Api.BotCommand]?, menuButton: Api.BotMenuButton?, privacyPolicyUrl: String?, appSettings: Api.BotAppSettings?, verifierSettings: Api.BotVerifierSettings?) {
                self.flags = flags
                self.userId = userId
                self.description = description
                self.descriptionPhoto = descriptionPhoto
                self.descriptionDocument = descriptionDocument
                self.commands = commands
                self.menuButton = menuButton
                self.privacyPolicyUrl = privacyPolicyUrl
                self.appSettings = appSettings
                self.verifierSettings = verifierSettings
            }
        }
        case botInfo(Cons_botInfo)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .botInfo(let _data):
                if boxed {
                    buffer.appendInt32(1300890265)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.userId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.description!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    _data.descriptionPhoto!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    _data.descriptionDocument!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.commands!.count))
                    for item in _data.commands! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.menuButton!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    serializeString(_data.privacyPolicyUrl!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    _data.appSettings!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    _data.verifierSettings!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_botInfo(_ reader: BufferReader) -> BotInfo? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt64()
            }
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _3 = parseString(reader)
            }
            var _4: Api.Photo?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.Photo
                }
            }
            var _5: Api.Document?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.Document
                }
            }
            var _6: [Api.BotCommand]?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let _ = reader.readInt32() {
                    _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.BotCommand.self)
                }
            }
            var _7: Api.BotMenuButton?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.BotMenuButton
                }
            }
            var _8: String?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                _8 = parseString(reader)
            }
            var _9: Api.BotAppSettings?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.BotAppSettings
                }
            }
            var _10: Api.BotVerifierSettings?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                if let signature = reader.readInt32() {
                    _10 = Api.parse(reader, signature: signature) as? Api.BotVerifierSettings
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _10 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 {
                return Api.BotInfo.botInfo(Cons_botInfo(flags: _1!, userId: _2, description: _3, descriptionPhoto: _4, descriptionDocument: _5, commands: _6, menuButton: _7, privacyPolicyUrl: _8, appSettings: _9, verifierSettings: _10))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BotMenuButton: TypeConstructorDescription {
        class Cons_botMenuButton: TypeConstructorDescription {
            var text: String
            var url: String
            init(text: String, url: String) {
                self.text = text
                self.url = url
            }
        }
        case botMenuButton(Cons_botMenuButton)
        case botMenuButtonCommands
        case botMenuButtonDefault

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .botMenuButton(let _data):
                if boxed {
                    buffer.appendInt32(-944407322)
                }
                serializeString(_data.text, buffer: buffer, boxed: false)
                serializeString(_data.url, buffer: buffer, boxed: false)
                break
            case .botMenuButtonCommands:
                if boxed {
                    buffer.appendInt32(1113113093)
                }
                break
            case .botMenuButtonDefault:
                if boxed {
                    buffer.appendInt32(1966318984)
                }
                break
            }
        }

        static func parse_botMenuButton(_ reader: BufferReader) -> BotMenuButton? {
            var _1: String?
            _1 = parseString(reader)
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.BotMenuButton.botMenuButton(Cons_botMenuButton(text: _1!, url: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_botMenuButtonCommands(_ reader: BufferReader) -> BotMenuButton? {
            return Api.BotMenuButton.botMenuButtonCommands
        }
        static func parse_botMenuButtonDefault(_ reader: BufferReader) -> BotMenuButton? {
            return Api.BotMenuButton.botMenuButtonDefault
        }
    }
}
extension Api {
    enum BotVerification: TypeConstructorDescription {
        class Cons_botVerification: TypeConstructorDescription {
            var botId: Int64
            var icon: Int64
            var description: Api.TextWithEntities
            init(botId: Int64, icon: Int64, description: Api.TextWithEntities) {
                self.botId = botId
                self.icon = icon
                self.description = description
            }
        }
        case botVerification(Cons_botVerification)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .botVerification(let _data):
                if boxed {
                    buffer.appendInt32(-147976487)
                }
                serializeInt64(_data.botId, buffer: buffer, boxed: false)
                serializeInt64(_data.icon, buffer: buffer, boxed: false)
                _data.description.serialize(buffer, true)
                break
            }
        }

        static func parse_botVerification(_ reader: BufferReader) -> BotVerification? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.TextWithEntities?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.BotVerification.botVerification(Cons_botVerification(botId: _1!, icon: _2!, description: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BotVerifierSettings: TypeConstructorDescription {
        class Cons_botVerifierSettings: TypeConstructorDescription {
            var flags: Int32
            var icon: Int64
            var company: String
            var customDescription: Api.TextWithEntities?
            init(flags: Int32, icon: Int64, company: String, customDescription: Api.TextWithEntities?) {
                self.flags = flags
                self.icon = icon
                self.company = company
                self.customDescription = customDescription
            }
        }
        case botVerifierSettings(Cons_botVerifierSettings)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .botVerifierSettings(let _data):
                if boxed {
                    buffer.appendInt32(-1591021569)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.icon, buffer: buffer, boxed: false)
                serializeString(_data.company, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.customDescription!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_botVerifierSettings(_ reader: BufferReader) -> BotVerifierSettings? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            _3 = parseString(reader)
            var _4: Api.TextWithEntities?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.BotVerifierSettings.botVerifierSettings(Cons_botVerifierSettings(flags: _1!, icon: _2!, company: _3!, customDescription: _4))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BusinessAwayMessage: TypeConstructorDescription {
        class Cons_businessAwayMessage: TypeConstructorDescription {
            var flags: Int32
            var shortcutId: Int32
            var schedule: Api.BusinessAwayMessageSchedule
            var recipients: Api.BusinessRecipients
            init(flags: Int32, shortcutId: Int32, schedule: Api.BusinessAwayMessageSchedule, recipients: Api.BusinessRecipients) {
                self.flags = flags
                self.shortcutId = shortcutId
                self.schedule = schedule
                self.recipients = recipients
            }
        }
        case businessAwayMessage(Cons_businessAwayMessage)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .businessAwayMessage(let _data):
                if boxed {
                    buffer.appendInt32(-283809188)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.shortcutId, buffer: buffer, boxed: false)
                _data.schedule.serialize(buffer, true)
                _data.recipients.serialize(buffer, true)
                break
            }
        }

        static func parse_businessAwayMessage(_ reader: BufferReader) -> BusinessAwayMessage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.BusinessAwayMessageSchedule?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.BusinessAwayMessageSchedule
            }
            var _4: Api.BusinessRecipients?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.BusinessRecipients
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.BusinessAwayMessage.businessAwayMessage(Cons_businessAwayMessage(flags: _1!, shortcutId: _2!, schedule: _3!, recipients: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BusinessAwayMessageSchedule: TypeConstructorDescription {
        class Cons_businessAwayMessageScheduleCustom: TypeConstructorDescription {
            var startDate: Int32
            var endDate: Int32
            init(startDate: Int32, endDate: Int32) {
                self.startDate = startDate
                self.endDate = endDate
            }
        }
        case businessAwayMessageScheduleAlways
        case businessAwayMessageScheduleCustom(Cons_businessAwayMessageScheduleCustom)
        case businessAwayMessageScheduleOutsideWorkHours

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .businessAwayMessageScheduleAlways:
                if boxed {
                    buffer.appendInt32(-910564679)
                }
                break
            case .businessAwayMessageScheduleCustom(let _data):
                if boxed {
                    buffer.appendInt32(-867328308)
                }
                serializeInt32(_data.startDate, buffer: buffer, boxed: false)
                serializeInt32(_data.endDate, buffer: buffer, boxed: false)
                break
            case .businessAwayMessageScheduleOutsideWorkHours:
                if boxed {
                    buffer.appendInt32(-1007487743)
                }
                break
            }
        }

        static func parse_businessAwayMessageScheduleAlways(_ reader: BufferReader) -> BusinessAwayMessageSchedule? {
            return Api.BusinessAwayMessageSchedule.businessAwayMessageScheduleAlways
        }
        static func parse_businessAwayMessageScheduleCustom(_ reader: BufferReader) -> BusinessAwayMessageSchedule? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.BusinessAwayMessageSchedule.businessAwayMessageScheduleCustom(Cons_businessAwayMessageScheduleCustom(startDate: _1!, endDate: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_businessAwayMessageScheduleOutsideWorkHours(_ reader: BufferReader) -> BusinessAwayMessageSchedule? {
            return Api.BusinessAwayMessageSchedule.businessAwayMessageScheduleOutsideWorkHours
        }
    }
}
extension Api {
    enum BusinessBotRights: TypeConstructorDescription {
        class Cons_businessBotRights: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        case businessBotRights(Cons_businessBotRights)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .businessBotRights(let _data):
                if boxed {
                    buffer.appendInt32(-1604170505)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_businessBotRights(_ reader: BufferReader) -> BusinessBotRights? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.BusinessBotRights.businessBotRights(Cons_businessBotRights(flags: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BusinessChatLink: TypeConstructorDescription {
        class Cons_businessChatLink: TypeConstructorDescription {
            var flags: Int32
            var link: String
            var message: String
            var entities: [Api.MessageEntity]?
            var title: String?
            var views: Int32
            init(flags: Int32, link: String, message: String, entities: [Api.MessageEntity]?, title: String?, views: Int32) {
                self.flags = flags
                self.link = link
                self.message = message
                self.entities = entities
                self.title = title
                self.views = views
            }
        }
        case businessChatLink(Cons_businessChatLink)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .businessChatLink(let _data):
                if boxed {
                    buffer.appendInt32(-1263638929)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.link, buffer: buffer, boxed: false)
                serializeString(_data.message, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.entities!.count))
                    for item in _data.entities! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.title!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.views, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_businessChatLink(_ reader: BufferReader) -> BusinessChatLink? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            _3 = parseString(reader)
            var _4: [Api.MessageEntity]?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self)
                }
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _5 = parseString(reader)
            }
            var _6: Int32?
            _6 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.BusinessChatLink.businessChatLink(Cons_businessChatLink(flags: _1!, link: _2!, message: _3!, entities: _4, title: _5, views: _6!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BusinessGreetingMessage: TypeConstructorDescription {
        class Cons_businessGreetingMessage: TypeConstructorDescription {
            var shortcutId: Int32
            var recipients: Api.BusinessRecipients
            var noActivityDays: Int32
            init(shortcutId: Int32, recipients: Api.BusinessRecipients, noActivityDays: Int32) {
                self.shortcutId = shortcutId
                self.recipients = recipients
                self.noActivityDays = noActivityDays
            }
        }
        case businessGreetingMessage(Cons_businessGreetingMessage)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .businessGreetingMessage(let _data):
                if boxed {
                    buffer.appendInt32(-451302485)
                }
                serializeInt32(_data.shortcutId, buffer: buffer, boxed: false)
                _data.recipients.serialize(buffer, true)
                serializeInt32(_data.noActivityDays, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_businessGreetingMessage(_ reader: BufferReader) -> BusinessGreetingMessage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.BusinessRecipients?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.BusinessRecipients
            }
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.BusinessGreetingMessage.businessGreetingMessage(Cons_businessGreetingMessage(shortcutId: _1!, recipients: _2!, noActivityDays: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BusinessIntro: TypeConstructorDescription {
        class Cons_businessIntro: TypeConstructorDescription {
            var flags: Int32
            var title: String
            var description: String
            var sticker: Api.Document?
            init(flags: Int32, title: String, description: String, sticker: Api.Document?) {
                self.flags = flags
                self.title = title
                self.description = description
                self.sticker = sticker
            }
        }
        case businessIntro(Cons_businessIntro)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .businessIntro(let _data):
                if boxed {
                    buffer.appendInt32(1510606445)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeString(_data.description, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.sticker!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_businessIntro(_ reader: BufferReader) -> BusinessIntro? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            _3 = parseString(reader)
            var _4: Api.Document?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.Document
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.BusinessIntro.businessIntro(Cons_businessIntro(flags: _1!, title: _2!, description: _3!, sticker: _4))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BusinessLocation: TypeConstructorDescription {
        class Cons_businessLocation: TypeConstructorDescription {
            var flags: Int32
            var geoPoint: Api.GeoPoint?
            var address: String
            init(flags: Int32, geoPoint: Api.GeoPoint?, address: String) {
                self.flags = flags
                self.geoPoint = geoPoint
                self.address = address
            }
        }
        case businessLocation(Cons_businessLocation)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .businessLocation(let _data):
                if boxed {
                    buffer.appendInt32(-1403249929)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.geoPoint!.serialize(buffer, true)
                }
                serializeString(_data.address, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_businessLocation(_ reader: BufferReader) -> BusinessLocation? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.GeoPoint?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.GeoPoint
                }
            }
            var _3: String?
            _3 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.BusinessLocation.businessLocation(Cons_businessLocation(flags: _1!, geoPoint: _2, address: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BusinessRecipients: TypeConstructorDescription {
        class Cons_businessRecipients: TypeConstructorDescription {
            var flags: Int32
            var users: [Int64]?
            init(flags: Int32, users: [Int64]?) {
                self.flags = flags
                self.users = users
            }
        }
        case businessRecipients(Cons_businessRecipients)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .businessRecipients(let _data):
                if boxed {
                    buffer.appendInt32(554733559)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.users!.count))
                    for item in _data.users! {
                        serializeInt64(item, buffer: buffer, boxed: false)
                    }
                }
                break
            }
        }

        static func parse_businessRecipients(_ reader: BufferReader) -> BusinessRecipients? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Int64]?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let _ = reader.readInt32() {
                    _2 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _2 != nil
            if _c1 && _c2 {
                return Api.BusinessRecipients.businessRecipients(Cons_businessRecipients(flags: _1!, users: _2))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BusinessWeeklyOpen: TypeConstructorDescription {
        class Cons_businessWeeklyOpen: TypeConstructorDescription {
            var startMinute: Int32
            var endMinute: Int32
            init(startMinute: Int32, endMinute: Int32) {
                self.startMinute = startMinute
                self.endMinute = endMinute
            }
        }
        case businessWeeklyOpen(Cons_businessWeeklyOpen)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .businessWeeklyOpen(let _data):
                if boxed {
                    buffer.appendInt32(302717625)
                }
                serializeInt32(_data.startMinute, buffer: buffer, boxed: false)
                serializeInt32(_data.endMinute, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_businessWeeklyOpen(_ reader: BufferReader) -> BusinessWeeklyOpen? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.BusinessWeeklyOpen.businessWeeklyOpen(Cons_businessWeeklyOpen(startMinute: _1!, endMinute: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum BusinessWorkHours: TypeConstructorDescription {
        class Cons_businessWorkHours: TypeConstructorDescription {
            var flags: Int32
            var timezoneId: String
            var weeklyOpen: [Api.BusinessWeeklyOpen]
            init(flags: Int32, timezoneId: String, weeklyOpen: [Api.BusinessWeeklyOpen]) {
                self.flags = flags
                self.timezoneId = timezoneId
                self.weeklyOpen = weeklyOpen
            }
        }
        case businessWorkHours(Cons_businessWorkHours)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .businessWorkHours(let _data):
                if boxed {
                    buffer.appendInt32(-1936543592)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.timezoneId, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.weeklyOpen.count))
                for item in _data.weeklyOpen {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_businessWorkHours(_ reader: BufferReader) -> BusinessWorkHours? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: [Api.BusinessWeeklyOpen]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.BusinessWeeklyOpen.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.BusinessWorkHours.businessWorkHours(Cons_businessWorkHours(flags: _1!, timezoneId: _2!, weeklyOpen: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum ButtonType: TypeConstructorDescription {
        class Cons_buttonTypeRequestPeer: TypeConstructorDescription {
            var flags: Int32
            var buttonId: Int32
            var peerType: Api.RequestPeerType
            var maxQuantity: Int32
            init(flags: Int32, buttonId: Int32, peerType: Api.RequestPeerType, maxQuantity: Int32) {
                self.flags = flags
                self.buttonId = buttonId
                self.peerType = peerType
                self.maxQuantity = maxQuantity
            }
        }
        class Cons_buttonTypeRequestPoll: TypeConstructorDescription {
            var flags: Int32
            var quiz: Api.Bool?
            init(flags: Int32, quiz: Api.Bool?) {
                self.flags = flags
                self.quiz = quiz
            }
        }
        class Cons_buttonTypeSimpleWebView: TypeConstructorDescription {
            var url: String
            init(url: String) {
                self.url = url
            }
        }
        class Cons_inputButtonTypeRequestPeer: TypeConstructorDescription {
            var flags: Int32
            var buttonId: Int32
            var peerType: Api.RequestPeerType
            var maxQuantity: Int32
            init(flags: Int32, buttonId: Int32, peerType: Api.RequestPeerType, maxQuantity: Int32) {
                self.flags = flags
                self.buttonId = buttonId
                self.peerType = peerType
                self.maxQuantity = maxQuantity
            }
        }
        case buttonTypeDefault
        case buttonTypeRequestGeoLocation
        case buttonTypeRequestPeer(Cons_buttonTypeRequestPeer)
        case buttonTypeRequestPhone
        case buttonTypeRequestPoll(Cons_buttonTypeRequestPoll)
        case buttonTypeSimpleWebView(Cons_buttonTypeSimpleWebView)
        case inputButtonTypeRequestPeer(Cons_inputButtonTypeRequestPeer)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .buttonTypeDefault:
                if boxed {
                    buffer.appendInt32(-908226327)
                }
                break
            case .buttonTypeRequestGeoLocation:
                if boxed {
                    buffer.appendInt32(-1678843584)
                }
                break
            case .buttonTypeRequestPeer(let _data):
                if boxed {
                    buffer.appendInt32(1331208759)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.buttonId, buffer: buffer, boxed: false)
                _data.peerType.serialize(buffer, true)
                serializeInt32(_data.maxQuantity, buffer: buffer, boxed: false)
                break
            case .buttonTypeRequestPhone:
                if boxed {
                    buffer.appendInt32(-549636359)
                }
                break
            case .buttonTypeRequestPoll(let _data):
                if boxed {
                    buffer.appendInt32(-1429209212)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.quiz!.serialize(buffer, true)
                }
                break
            case .buttonTypeSimpleWebView(let _data):
                if boxed {
                    buffer.appendInt32(-1072014982)
                }
                serializeString(_data.url, buffer: buffer, boxed: false)
                break
            case .inputButtonTypeRequestPeer(let _data):
                if boxed {
                    buffer.appendInt32(1071802622)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.buttonId, buffer: buffer, boxed: false)
                _data.peerType.serialize(buffer, true)
                serializeInt32(_data.maxQuantity, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_buttonTypeDefault(_ reader: BufferReader) -> ButtonType? {
            return Api.ButtonType.buttonTypeDefault
        }
        static func parse_buttonTypeRequestGeoLocation(_ reader: BufferReader) -> ButtonType? {
            return Api.ButtonType.buttonTypeRequestGeoLocation
        }
        static func parse_buttonTypeRequestPeer(_ reader: BufferReader) -> ButtonType? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.RequestPeerType?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.RequestPeerType
            }
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.ButtonType.buttonTypeRequestPeer(Cons_buttonTypeRequestPeer(flags: _1!, buttonId: _2!, peerType: _3!, maxQuantity: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_buttonTypeRequestPhone(_ reader: BufferReader) -> ButtonType? {
            return Api.ButtonType.buttonTypeRequestPhone
        }
        static func parse_buttonTypeRequestPoll(_ reader: BufferReader) -> ButtonType? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            if _c1 && _c2 {
                return Api.ButtonType.buttonTypeRequestPoll(Cons_buttonTypeRequestPoll(flags: _1!, quiz: _2))
            }
            else {
                return nil
            }
        }
        static func parse_buttonTypeSimpleWebView(_ reader: BufferReader) -> ButtonType? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.ButtonType.buttonTypeSimpleWebView(Cons_buttonTypeSimpleWebView(url: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inputButtonTypeRequestPeer(_ reader: BufferReader) -> ButtonType? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.RequestPeerType?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.RequestPeerType
            }
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.ButtonType.inputButtonTypeRequestPeer(Cons_inputButtonTypeRequestPeer(flags: _1!, buttonId: _2!, peerType: _3!, maxQuantity: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum ChannelAdminLogEvent: TypeConstructorDescription {
        class Cons_channelAdminLogEvent: TypeConstructorDescription {
            var id: Int64
            var date: Int32
            var userId: Int64
            var action: Api.ChannelAdminLogEventAction
            init(id: Int64, date: Int32, userId: Int64, action: Api.ChannelAdminLogEventAction) {
                self.id = id
                self.date = date
                self.userId = userId
                self.action = action
            }
        }
        case channelAdminLogEvent(Cons_channelAdminLogEvent)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .channelAdminLogEvent(let _data):
                if boxed {
                    buffer.appendInt32(531458253)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                _data.action.serialize(buffer, true)
                break
            }
        }

        static func parse_channelAdminLogEvent(_ reader: BufferReader) -> ChannelAdminLogEvent? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Api.ChannelAdminLogEventAction?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.ChannelAdminLogEventAction
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.ChannelAdminLogEvent.channelAdminLogEvent(Cons_channelAdminLogEvent(id: _1!, date: _2!, userId: _3!, action: _4!))
            }
            else {
                return nil
            }
        }
    }
}
