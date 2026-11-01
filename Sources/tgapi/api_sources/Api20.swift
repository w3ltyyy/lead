extension Api {
    enum StarGiftAttributeId: TypeConstructorDescription {
        class Cons_starGiftAttributeIdBackdrop: TypeConstructorDescription {
            var backdropId: Int32
            init(backdropId: Int32) {
                self.backdropId = backdropId
            }
        }
        class Cons_starGiftAttributeIdModel: TypeConstructorDescription {
            var documentId: Int64
            init(documentId: Int64) {
                self.documentId = documentId
            }
        }
        class Cons_starGiftAttributeIdPattern: TypeConstructorDescription {
            var documentId: Int64
            init(documentId: Int64) {
                self.documentId = documentId
            }
        }
        case starGiftAttributeIdBackdrop(Cons_starGiftAttributeIdBackdrop)
        case starGiftAttributeIdModel(Cons_starGiftAttributeIdModel)
        case starGiftAttributeIdPattern(Cons_starGiftAttributeIdPattern)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starGiftAttributeIdBackdrop(let _data):
                if boxed {
                    buffer.appendInt32(520210263)
                }
                serializeInt32(_data.backdropId, buffer: buffer, boxed: false)
                break
            case .starGiftAttributeIdModel(let _data):
                if boxed {
                    buffer.appendInt32(1219145276)
                }
                serializeInt64(_data.documentId, buffer: buffer, boxed: false)
                break
            case .starGiftAttributeIdPattern(let _data):
                if boxed {
                    buffer.appendInt32(1242965043)
                }
                serializeInt64(_data.documentId, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_starGiftAttributeIdBackdrop(_ reader: BufferReader) -> StarGiftAttributeId? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.StarGiftAttributeId.starGiftAttributeIdBackdrop(Cons_starGiftAttributeIdBackdrop(backdropId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_starGiftAttributeIdModel(_ reader: BufferReader) -> StarGiftAttributeId? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.StarGiftAttributeId.starGiftAttributeIdModel(Cons_starGiftAttributeIdModel(documentId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_starGiftAttributeIdPattern(_ reader: BufferReader) -> StarGiftAttributeId? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.StarGiftAttributeId.starGiftAttributeIdPattern(Cons_starGiftAttributeIdPattern(documentId: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarGiftAttributeRarity: TypeConstructorDescription {
        class Cons_starGiftAttributeRarity: TypeConstructorDescription {
            var permille: Int32
            init(permille: Int32) {
                self.permille = permille
            }
        }
        case starGiftAttributeRarity(Cons_starGiftAttributeRarity)
        case starGiftAttributeRarityEpic
        case starGiftAttributeRarityLegendary
        case starGiftAttributeRarityRare
        case starGiftAttributeRarityUncommon

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starGiftAttributeRarity(let _data):
                if boxed {
                    buffer.appendInt32(910391095)
                }
                serializeInt32(_data.permille, buffer: buffer, boxed: false)
                break
            case .starGiftAttributeRarityEpic:
                if boxed {
                    buffer.appendInt32(2029777832)
                }
                break
            case .starGiftAttributeRarityLegendary:
                if boxed {
                    buffer.appendInt32(-822614104)
                }
                break
            case .starGiftAttributeRarityRare:
                if boxed {
                    buffer.appendInt32(-259174037)
                }
                break
            case .starGiftAttributeRarityUncommon:
                if boxed {
                    buffer.appendInt32(-607231095)
                }
                break
            }
        }

        static func parse_starGiftAttributeRarity(_ reader: BufferReader) -> StarGiftAttributeRarity? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.StarGiftAttributeRarity.starGiftAttributeRarity(Cons_starGiftAttributeRarity(permille: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_starGiftAttributeRarityEpic(_ reader: BufferReader) -> StarGiftAttributeRarity? {
            return Api.StarGiftAttributeRarity.starGiftAttributeRarityEpic
        }
        static func parse_starGiftAttributeRarityLegendary(_ reader: BufferReader) -> StarGiftAttributeRarity? {
            return Api.StarGiftAttributeRarity.starGiftAttributeRarityLegendary
        }
        static func parse_starGiftAttributeRarityRare(_ reader: BufferReader) -> StarGiftAttributeRarity? {
            return Api.StarGiftAttributeRarity.starGiftAttributeRarityRare
        }
        static func parse_starGiftAttributeRarityUncommon(_ reader: BufferReader) -> StarGiftAttributeRarity? {
            return Api.StarGiftAttributeRarity.starGiftAttributeRarityUncommon
        }
    }
}
extension Api {
    enum StarGiftAuctionAcquiredGift: TypeConstructorDescription {
        class Cons_starGiftAuctionAcquiredGift: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var date: Int32
            var bidAmount: Int64
            var round: Int32
            var pos: Int32
            var message: Api.TextWithEntities?
            var giftNum: Int32?
            init(flags: Int32, peer: Api.Peer, date: Int32, bidAmount: Int64, round: Int32, pos: Int32, message: Api.TextWithEntities?, giftNum: Int32?) {
                self.flags = flags
                self.peer = peer
                self.date = date
                self.bidAmount = bidAmount
                self.round = round
                self.pos = pos
                self.message = message
                self.giftNum = giftNum
            }
        }
        case starGiftAuctionAcquiredGift(Cons_starGiftAuctionAcquiredGift)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starGiftAuctionAcquiredGift(let _data):
                if boxed {
                    buffer.appendInt32(1118831432)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt64(_data.bidAmount, buffer: buffer, boxed: false)
                serializeInt32(_data.round, buffer: buffer, boxed: false)
                serializeInt32(_data.pos, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.message!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.giftNum!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_starGiftAuctionAcquiredGift(_ reader: BufferReader) -> StarGiftAuctionAcquiredGift? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: Api.TextWithEntities?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
                }
            }
            var _8: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _8 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.StarGiftAuctionAcquiredGift.starGiftAuctionAcquiredGift(Cons_starGiftAuctionAcquiredGift(flags: _1!, peer: _2!, date: _3!, bidAmount: _4!, round: _5!, pos: _6!, message: _7, giftNum: _8))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarGiftAuctionRound: TypeConstructorDescription {
        class Cons_starGiftAuctionRound: TypeConstructorDescription {
            var num: Int32
            var duration: Int32
            init(num: Int32, duration: Int32) {
                self.num = num
                self.duration = duration
            }
        }
        class Cons_starGiftAuctionRoundExtendable: TypeConstructorDescription {
            var num: Int32
            var duration: Int32
            var extendTop: Int32
            var extendWindow: Int32
            init(num: Int32, duration: Int32, extendTop: Int32, extendWindow: Int32) {
                self.num = num
                self.duration = duration
                self.extendTop = extendTop
                self.extendWindow = extendWindow
            }
        }
        case starGiftAuctionRound(Cons_starGiftAuctionRound)
        case starGiftAuctionRoundExtendable(Cons_starGiftAuctionRoundExtendable)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starGiftAuctionRound(let _data):
                if boxed {
                    buffer.appendInt32(984483112)
                }
                serializeInt32(_data.num, buffer: buffer, boxed: false)
                serializeInt32(_data.duration, buffer: buffer, boxed: false)
                break
            case .starGiftAuctionRoundExtendable(let _data):
                if boxed {
                    buffer.appendInt32(178266597)
                }
                serializeInt32(_data.num, buffer: buffer, boxed: false)
                serializeInt32(_data.duration, buffer: buffer, boxed: false)
                serializeInt32(_data.extendTop, buffer: buffer, boxed: false)
                serializeInt32(_data.extendWindow, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_starGiftAuctionRound(_ reader: BufferReader) -> StarGiftAuctionRound? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.StarGiftAuctionRound.starGiftAuctionRound(Cons_starGiftAuctionRound(num: _1!, duration: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_starGiftAuctionRoundExtendable(_ reader: BufferReader) -> StarGiftAuctionRound? {
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
                return Api.StarGiftAuctionRound.starGiftAuctionRoundExtendable(Cons_starGiftAuctionRoundExtendable(num: _1!, duration: _2!, extendTop: _3!, extendWindow: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarGiftAuctionState: TypeConstructorDescription {
        class Cons_starGiftAuctionState: TypeConstructorDescription {
            var version: Int32
            var startDate: Int32
            var endDate: Int32
            var minBidAmount: Int64
            var bidLevels: [Api.AuctionBidLevel]
            var topBidders: [Int64]
            var nextRoundAt: Int32
            var lastGiftNum: Int32
            var giftsLeft: Int32
            var currentRound: Int32
            var totalRounds: Int32
            var rounds: [Api.StarGiftAuctionRound]
            init(version: Int32, startDate: Int32, endDate: Int32, minBidAmount: Int64, bidLevels: [Api.AuctionBidLevel], topBidders: [Int64], nextRoundAt: Int32, lastGiftNum: Int32, giftsLeft: Int32, currentRound: Int32, totalRounds: Int32, rounds: [Api.StarGiftAuctionRound]) {
                self.version = version
                self.startDate = startDate
                self.endDate = endDate
                self.minBidAmount = minBidAmount
                self.bidLevels = bidLevels
                self.topBidders = topBidders
                self.nextRoundAt = nextRoundAt
                self.lastGiftNum = lastGiftNum
                self.giftsLeft = giftsLeft
                self.currentRound = currentRound
                self.totalRounds = totalRounds
                self.rounds = rounds
            }
        }
        class Cons_starGiftAuctionStateFinished: TypeConstructorDescription {
            var flags: Int32
            var startDate: Int32
            var endDate: Int32
            var averagePrice: Int64
            var listedCount: Int32?
            var fragmentListedCount: Int32?
            var fragmentListedUrl: String?
            init(flags: Int32, startDate: Int32, endDate: Int32, averagePrice: Int64, listedCount: Int32?, fragmentListedCount: Int32?, fragmentListedUrl: String?) {
                self.flags = flags
                self.startDate = startDate
                self.endDate = endDate
                self.averagePrice = averagePrice
                self.listedCount = listedCount
                self.fragmentListedCount = fragmentListedCount
                self.fragmentListedUrl = fragmentListedUrl
            }
        }
        case starGiftAuctionState(Cons_starGiftAuctionState)
        case starGiftAuctionStateFinished(Cons_starGiftAuctionStateFinished)
        case starGiftAuctionStateNotModified

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starGiftAuctionState(let _data):
                if boxed {
                    buffer.appendInt32(1998212710)
                }
                serializeInt32(_data.version, buffer: buffer, boxed: false)
                serializeInt32(_data.startDate, buffer: buffer, boxed: false)
                serializeInt32(_data.endDate, buffer: buffer, boxed: false)
                serializeInt64(_data.minBidAmount, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.bidLevels.count))
                for item in _data.bidLevels {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.topBidders.count))
                for item in _data.topBidders {
                    serializeInt64(item, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.nextRoundAt, buffer: buffer, boxed: false)
                serializeInt32(_data.lastGiftNum, buffer: buffer, boxed: false)
                serializeInt32(_data.giftsLeft, buffer: buffer, boxed: false)
                serializeInt32(_data.currentRound, buffer: buffer, boxed: false)
                serializeInt32(_data.totalRounds, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.rounds.count))
                for item in _data.rounds {
                    item.serialize(buffer, true)
                }
                break
            case .starGiftAuctionStateFinished(let _data):
                if boxed {
                    buffer.appendInt32(-1758614593)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.startDate, buffer: buffer, boxed: false)
                serializeInt32(_data.endDate, buffer: buffer, boxed: false)
                serializeInt64(_data.averagePrice, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.listedCount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.fragmentListedCount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.fragmentListedUrl!, buffer: buffer, boxed: false)
                }
                break
            case .starGiftAuctionStateNotModified:
                if boxed {
                    buffer.appendInt32(-30197422)
                }
                break
            }
        }

        static func parse_starGiftAuctionState(_ reader: BufferReader) -> StarGiftAuctionState? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: [Api.AuctionBidLevel]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.AuctionBidLevel.self)
            }
            var _6: [Int64]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
            }
            var _7: Int32?
            _7 = reader.readInt32()
            var _8: Int32?
            _8 = reader.readInt32()
            var _9: Int32?
            _9 = reader.readInt32()
            var _10: Int32?
            _10 = reader.readInt32()
            var _11: Int32?
            _11 = reader.readInt32()
            var _12: [Api.StarGiftAuctionRound]?
            if let _ = reader.readInt32() {
                _12 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StarGiftAuctionRound.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            let _c9 = _9 != nil
            let _c10 = _10 != nil
            let _c11 = _11 != nil
            let _c12 = _12 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 {
                return Api.StarGiftAuctionState.starGiftAuctionState(Cons_starGiftAuctionState(version: _1!, startDate: _2!, endDate: _3!, minBidAmount: _4!, bidLevels: _5!, topBidders: _6!, nextRoundAt: _7!, lastGiftNum: _8!, giftsLeft: _9!, currentRound: _10!, totalRounds: _11!, rounds: _12!))
            }
            else {
                return nil
            }
        }
        static func parse_starGiftAuctionStateFinished(_ reader: BufferReader) -> StarGiftAuctionState? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = reader.readInt32()
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _6 = reader.readInt32()
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _7 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.StarGiftAuctionState.starGiftAuctionStateFinished(Cons_starGiftAuctionStateFinished(flags: _1!, startDate: _2!, endDate: _3!, averagePrice: _4!, listedCount: _5, fragmentListedCount: _6, fragmentListedUrl: _7))
            }
            else {
                return nil
            }
        }
        static func parse_starGiftAuctionStateNotModified(_ reader: BufferReader) -> StarGiftAuctionState? {
            return Api.StarGiftAuctionState.starGiftAuctionStateNotModified
        }
    }
}
extension Api {
    enum StarGiftAuctionUserState: TypeConstructorDescription {
        class Cons_starGiftAuctionUserState: TypeConstructorDescription {
            var flags: Int32
            var bidAmount: Int64?
            var bidDate: Int32?
            var minBidAmount: Int64?
            var bidPeer: Api.Peer?
            var acquiredCount: Int32
            init(flags: Int32, bidAmount: Int64?, bidDate: Int32?, minBidAmount: Int64?, bidPeer: Api.Peer?, acquiredCount: Int32) {
                self.flags = flags
                self.bidAmount = bidAmount
                self.bidDate = bidDate
                self.minBidAmount = minBidAmount
                self.bidPeer = bidPeer
                self.acquiredCount = acquiredCount
            }
        }
        case starGiftAuctionUserState(Cons_starGiftAuctionUserState)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starGiftAuctionUserState(let _data):
                if boxed {
                    buffer.appendInt32(787403204)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.bidAmount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.bidDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.minBidAmount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.bidPeer!.serialize(buffer, true)
                }
                serializeInt32(_data.acquiredCount, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_starGiftAuctionUserState(_ reader: BufferReader) -> StarGiftAuctionUserState? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt64()
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = reader.readInt64()
            }
            var _5: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _6: Int32?
            _6 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.StarGiftAuctionUserState.starGiftAuctionUserState(Cons_starGiftAuctionUserState(flags: _1!, bidAmount: _2, bidDate: _3, minBidAmount: _4, bidPeer: _5, acquiredCount: _6!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarGiftBackground: TypeConstructorDescription {
        class Cons_starGiftBackground: TypeConstructorDescription {
            var centerColor: Int32
            var edgeColor: Int32
            var textColor: Int32
            init(centerColor: Int32, edgeColor: Int32, textColor: Int32) {
                self.centerColor = centerColor
                self.edgeColor = edgeColor
                self.textColor = textColor
            }
        }
        case starGiftBackground(Cons_starGiftBackground)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starGiftBackground(let _data):
                if boxed {
                    buffer.appendInt32(-1342872680)
                }
                serializeInt32(_data.centerColor, buffer: buffer, boxed: false)
                serializeInt32(_data.edgeColor, buffer: buffer, boxed: false)
                serializeInt32(_data.textColor, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_starGiftBackground(_ reader: BufferReader) -> StarGiftBackground? {
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
                return Api.StarGiftBackground.starGiftBackground(Cons_starGiftBackground(centerColor: _1!, edgeColor: _2!, textColor: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarRefProgram: TypeConstructorDescription {
        class Cons_starRefProgram: TypeConstructorDescription {
            var flags: Int32
            var botId: Int64
            var commissionPermille: Int32
            var durationMonths: Int32?
            var endDate: Int32?
            var dailyRevenuePerUser: Api.StarsAmount?
            init(flags: Int32, botId: Int64, commissionPermille: Int32, durationMonths: Int32?, endDate: Int32?, dailyRevenuePerUser: Api.StarsAmount?) {
                self.flags = flags
                self.botId = botId
                self.commissionPermille = commissionPermille
                self.durationMonths = durationMonths
                self.endDate = endDate
                self.dailyRevenuePerUser = dailyRevenuePerUser
            }
        }
        case starRefProgram(Cons_starRefProgram)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starRefProgram(let _data):
                if boxed {
                    buffer.appendInt32(-586389774)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.botId, buffer: buffer, boxed: false)
                serializeInt32(_data.commissionPermille, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.durationMonths!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.endDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.dailyRevenuePerUser!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_starRefProgram(_ reader: BufferReader) -> StarRefProgram? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _5 = reader.readInt32()
            }
            var _6: Api.StarsAmount?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.StarsAmount
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.StarRefProgram.starRefProgram(Cons_starRefProgram(flags: _1!, botId: _2!, commissionPermille: _3!, durationMonths: _4, endDate: _5, dailyRevenuePerUser: _6))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarsAmount: TypeConstructorDescription {
        class Cons_starsAmount: TypeConstructorDescription {
            var amount: Int64
            var nanos: Int32
            init(amount: Int64, nanos: Int32) {
                self.amount = amount
                self.nanos = nanos
            }
        }
        class Cons_starsTonAmount: TypeConstructorDescription {
            var amount: Int64
            init(amount: Int64) {
                self.amount = amount
            }
        }
        case starsAmount(Cons_starsAmount)
        case starsTonAmount(Cons_starsTonAmount)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starsAmount(let _data):
                if boxed {
                    buffer.appendInt32(-1145654109)
                }
                serializeInt64(_data.amount, buffer: buffer, boxed: false)
                serializeInt32(_data.nanos, buffer: buffer, boxed: false)
                break
            case .starsTonAmount(let _data):
                if boxed {
                    buffer.appendInt32(1957618656)
                }
                serializeInt64(_data.amount, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_starsAmount(_ reader: BufferReader) -> StarsAmount? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.StarsAmount.starsAmount(Cons_starsAmount(amount: _1!, nanos: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_starsTonAmount(_ reader: BufferReader) -> StarsAmount? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.StarsAmount.starsTonAmount(Cons_starsTonAmount(amount: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarsRating: TypeConstructorDescription {
        class Cons_starsRating: TypeConstructorDescription {
            var flags: Int32
            var level: Int32
            var currentLevelStars: Int64
            var stars: Int64
            var nextLevelStars: Int64?
            init(flags: Int32, level: Int32, currentLevelStars: Int64, stars: Int64, nextLevelStars: Int64?) {
                self.flags = flags
                self.level = level
                self.currentLevelStars = currentLevelStars
                self.stars = stars
                self.nextLevelStars = nextLevelStars
            }
        }
        case starsRating(Cons_starsRating)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starsRating(let _data):
                if boxed {
                    buffer.appendInt32(453922567)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.level, buffer: buffer, boxed: false)
                serializeInt64(_data.currentLevelStars, buffer: buffer, boxed: false)
                serializeInt64(_data.stars, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.nextLevelStars!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_starsRating(_ reader: BufferReader) -> StarsRating? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int64?
            _4 = reader.readInt64()
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
                return Api.StarsRating.starsRating(Cons_starsRating(flags: _1!, level: _2!, currentLevelStars: _3!, stars: _4!, nextLevelStars: _5))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarsRevenueStatus: TypeConstructorDescription {
        class Cons_starsRevenueStatus: TypeConstructorDescription {
            var flags: Int32
            var currentBalance: Api.StarsAmount
            var availableBalance: Api.StarsAmount
            var overallRevenue: Api.StarsAmount
            var nextWithdrawalAt: Int32?
            init(flags: Int32, currentBalance: Api.StarsAmount, availableBalance: Api.StarsAmount, overallRevenue: Api.StarsAmount, nextWithdrawalAt: Int32?) {
                self.flags = flags
                self.currentBalance = currentBalance
                self.availableBalance = availableBalance
                self.overallRevenue = overallRevenue
                self.nextWithdrawalAt = nextWithdrawalAt
            }
        }
        case starsRevenueStatus(Cons_starsRevenueStatus)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starsRevenueStatus(let _data):
                if boxed {
                    buffer.appendInt32(-21080943)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.currentBalance.serialize(buffer, true)
                _data.availableBalance.serialize(buffer, true)
                _data.overallRevenue.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.nextWithdrawalAt!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_starsRevenueStatus(_ reader: BufferReader) -> StarsRevenueStatus? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.StarsAmount?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.StarsAmount
            }
            var _3: Api.StarsAmount?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.StarsAmount
            }
            var _4: Api.StarsAmount?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.StarsAmount
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
                return Api.StarsRevenueStatus.starsRevenueStatus(Cons_starsRevenueStatus(flags: _1!, currentBalance: _2!, availableBalance: _3!, overallRevenue: _4!, nextWithdrawalAt: _5))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarsSubscription: TypeConstructorDescription {
        class Cons_starsSubscription: TypeConstructorDescription {
            var flags: Int32
            var id: String
            var peer: Api.Peer
            var untilDate: Int32
            var pricing: Api.StarsSubscriptionPricing
            var chatInviteHash: String?
            var title: String?
            var photo: Api.WebDocument?
            var invoiceSlug: String?
            init(flags: Int32, id: String, peer: Api.Peer, untilDate: Int32, pricing: Api.StarsSubscriptionPricing, chatInviteHash: String?, title: String?, photo: Api.WebDocument?, invoiceSlug: String?) {
                self.flags = flags
                self.id = id
                self.peer = peer
                self.untilDate = untilDate
                self.pricing = pricing
                self.chatInviteHash = chatInviteHash
                self.title = title
                self.photo = photo
                self.invoiceSlug = invoiceSlug
            }
        }
        case starsSubscription(Cons_starsSubscription)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starsSubscription(let _data):
                if boxed {
                    buffer.appendInt32(779004698)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.id, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.untilDate, buffer: buffer, boxed: false)
                _data.pricing.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.chatInviteHash!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeString(_data.title!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    _data.photo!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    serializeString(_data.invoiceSlug!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_starsSubscription(_ reader: BufferReader) -> StarsSubscription? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Api.Peer?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Api.StarsSubscriptionPricing?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.StarsSubscriptionPricing
            }
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _6 = parseString(reader)
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _7 = parseString(reader)
            }
            var _8: Api.WebDocument?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.WebDocument
                }
            }
            var _9: String?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                _9 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.StarsSubscription.starsSubscription(Cons_starsSubscription(flags: _1!, id: _2!, peer: _3!, untilDate: _4!, pricing: _5!, chatInviteHash: _6, title: _7, photo: _8, invoiceSlug: _9))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarsSubscriptionPricing: TypeConstructorDescription {
        class Cons_starsSubscriptionPricing: TypeConstructorDescription {
            var period: Int32
            var amount: Int64
            init(period: Int32, amount: Int64) {
                self.period = period
                self.amount = amount
            }
        }
        case starsSubscriptionPricing(Cons_starsSubscriptionPricing)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starsSubscriptionPricing(let _data):
                if boxed {
                    buffer.appendInt32(88173912)
                }
                serializeInt32(_data.period, buffer: buffer, boxed: false)
                serializeInt64(_data.amount, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_starsSubscriptionPricing(_ reader: BufferReader) -> StarsSubscriptionPricing? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.StarsSubscriptionPricing.starsSubscriptionPricing(Cons_starsSubscriptionPricing(period: _1!, amount: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarsTransaction: TypeConstructorDescription {
        class Cons_starsTransaction: TypeConstructorDescription {
            var flags: Int32
            var id: String
            var amount: Api.StarsAmount
            var date: Int32
            var peer: Api.StarsTransactionPeer
            var title: String?
            var description: String?
            var photo: Api.WebDocument?
            var transactionDate: Int32?
            var transactionUrl: String?
            var botPayload: Buffer?
            var msgId: Int32?
            var extendedMedia: [Api.MessageMedia]?
            var subscriptionPeriod: Int32?
            var giveawayPostId: Int32?
            var stargift: Api.StarGift?
            var floodskipNumber: Int32?
            var starrefCommissionPermille: Int32?
            var starrefPeer: Api.Peer?
            var starrefAmount: Api.StarsAmount?
            var paidMessages: Int32?
            var premiumGiftMonths: Int32?
            var adsProceedsFromDate: Int32?
            var adsProceedsToDate: Int32?
            init(flags: Int32, id: String, amount: Api.StarsAmount, date: Int32, peer: Api.StarsTransactionPeer, title: String?, description: String?, photo: Api.WebDocument?, transactionDate: Int32?, transactionUrl: String?, botPayload: Buffer?, msgId: Int32?, extendedMedia: [Api.MessageMedia]?, subscriptionPeriod: Int32?, giveawayPostId: Int32?, stargift: Api.StarGift?, floodskipNumber: Int32?, starrefCommissionPermille: Int32?, starrefPeer: Api.Peer?, starrefAmount: Api.StarsAmount?, paidMessages: Int32?, premiumGiftMonths: Int32?, adsProceedsFromDate: Int32?, adsProceedsToDate: Int32?) {
                self.flags = flags
                self.id = id
                self.amount = amount
                self.date = date
                self.peer = peer
                self.title = title
                self.description = description
                self.photo = photo
                self.transactionDate = transactionDate
                self.transactionUrl = transactionUrl
                self.botPayload = botPayload
                self.msgId = msgId
                self.extendedMedia = extendedMedia
                self.subscriptionPeriod = subscriptionPeriod
                self.giveawayPostId = giveawayPostId
                self.stargift = stargift
                self.floodskipNumber = floodskipNumber
                self.starrefCommissionPermille = starrefCommissionPermille
                self.starrefPeer = starrefPeer
                self.starrefAmount = starrefAmount
                self.paidMessages = paidMessages
                self.premiumGiftMonths = premiumGiftMonths
                self.adsProceedsFromDate = adsProceedsFromDate
                self.adsProceedsToDate = adsProceedsToDate
            }
        }
        case starsTransaction(Cons_starsTransaction)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starsTransaction(let _data):
                if boxed {
                    buffer.appendInt32(325426864)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.id, buffer: buffer, boxed: false)
                _data.amount.serialize(buffer, true)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.title!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.description!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.photo!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeInt32(_data.transactionDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeString(_data.transactionUrl!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    serializeBytes(_data.botPayload!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    serializeInt32(_data.msgId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.extendedMedia!.count))
                    for item in _data.extendedMedia! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 12) != 0 {
                    serializeInt32(_data.subscriptionPeriod!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 13) != 0 {
                    serializeInt32(_data.giveawayPostId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 14) != 0 {
                    _data.stargift!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 15) != 0 {
                    serializeInt32(_data.floodskipNumber!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 16) != 0 {
                    serializeInt32(_data.starrefCommissionPermille!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 17) != 0 {
                    _data.starrefPeer!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 17) != 0 {
                    _data.starrefAmount!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 19) != 0 {
                    serializeInt32(_data.paidMessages!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 20) != 0 {
                    serializeInt32(_data.premiumGiftMonths!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 23) != 0 {
                    serializeInt32(_data.adsProceedsFromDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 23) != 0 {
                    serializeInt32(_data.adsProceedsToDate!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_starsTransaction(_ reader: BufferReader) -> StarsTransaction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Api.StarsAmount?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.StarsAmount
            }
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Api.StarsTransactionPeer?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.StarsTransactionPeer
            }
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _6 = parseString(reader)
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _7 = parseString(reader)
            }
            var _8: Api.WebDocument?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.WebDocument
                }
            }
            var _9: Int32?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _9 = reader.readInt32()
            }
            var _10: String?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _10 = parseString(reader)
            }
            var _11: Buffer?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                _11 = parseBytes(reader)
            }
            var _12: Int32?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                _12 = reader.readInt32()
            }
            var _13: [Api.MessageMedia]?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                if let _ = reader.readInt32() {
                    _13 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageMedia.self)
                }
            }
            var _14: Int32?
            if Int(_1 ?? 0) & Int(1 << 12) != 0 {
                _14 = reader.readInt32()
            }
            var _15: Int32?
            if Int(_1 ?? 0) & Int(1 << 13) != 0 {
                _15 = reader.readInt32()
            }
            var _16: Api.StarGift?
            if Int(_1 ?? 0) & Int(1 << 14) != 0 {
                if let signature = reader.readInt32() {
                    _16 = Api.parse(reader, signature: signature) as? Api.StarGift
                }
            }
            var _17: Int32?
            if Int(_1 ?? 0) & Int(1 << 15) != 0 {
                _17 = reader.readInt32()
            }
            var _18: Int32?
            if Int(_1 ?? 0) & Int(1 << 16) != 0 {
                _18 = reader.readInt32()
            }
            var _19: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 17) != 0 {
                if let signature = reader.readInt32() {
                    _19 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _20: Api.StarsAmount?
            if Int(_1 ?? 0) & Int(1 << 17) != 0 {
                if let signature = reader.readInt32() {
                    _20 = Api.parse(reader, signature: signature) as? Api.StarsAmount
                }
            }
            var _21: Int32?
            if Int(_1 ?? 0) & Int(1 << 19) != 0 {
                _21 = reader.readInt32()
            }
            var _22: Int32?
            if Int(_1 ?? 0) & Int(1 << 20) != 0 {
                _22 = reader.readInt32()
            }
            var _23: Int32?
            if Int(_1 ?? 0) & Int(1 << 23) != 0 {
                _23 = reader.readInt32()
            }
            var _24: Int32?
            if Int(_1 ?? 0) & Int(1 << 23) != 0 {
                _24 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _13 != nil
            let _c14 = (Int(_1 ?? 0) & Int(1 << 12) == 0) || _14 != nil
            let _c15 = (Int(_1 ?? 0) & Int(1 << 13) == 0) || _15 != nil
            let _c16 = (Int(_1 ?? 0) & Int(1 << 14) == 0) || _16 != nil
            let _c17 = (Int(_1 ?? 0) & Int(1 << 15) == 0) || _17 != nil
            let _c18 = (Int(_1 ?? 0) & Int(1 << 16) == 0) || _18 != nil
            let _c19 = (Int(_1 ?? 0) & Int(1 << 17) == 0) || _19 != nil
            let _c20 = (Int(_1 ?? 0) & Int(1 << 17) == 0) || _20 != nil
            let _c21 = (Int(_1 ?? 0) & Int(1 << 19) == 0) || _21 != nil
            let _c22 = (Int(_1 ?? 0) & Int(1 << 20) == 0) || _22 != nil
            let _c23 = (Int(_1 ?? 0) & Int(1 << 23) == 0) || _23 != nil
            let _c24 = (Int(_1 ?? 0) & Int(1 << 23) == 0) || _24 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 && _c15 && _c16 && _c17 && _c18 && _c19 && _c20 && _c21 && _c22 && _c23 && _c24 {
                return Api.StarsTransaction.starsTransaction(Cons_starsTransaction(flags: _1!, id: _2!, amount: _3!, date: _4!, peer: _5!, title: _6, description: _7, photo: _8, transactionDate: _9, transactionUrl: _10, botPayload: _11, msgId: _12, extendedMedia: _13, subscriptionPeriod: _14, giveawayPostId: _15, stargift: _16, floodskipNumber: _17, starrefCommissionPermille: _18, starrefPeer: _19, starrefAmount: _20, paidMessages: _21, premiumGiftMonths: _22, adsProceedsFromDate: _23, adsProceedsToDate: _24))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarsTransactionPeer: TypeConstructorDescription {
        class Cons_starsTransactionPeer: TypeConstructorDescription {
            var peer: Api.Peer
            init(peer: Api.Peer) {
                self.peer = peer
            }
        }
        case starsTransactionPeer(Cons_starsTransactionPeer)
        case starsTransactionPeerAPI
        case starsTransactionPeerAds
        case starsTransactionPeerAppStore
        case starsTransactionPeerFragment
        case starsTransactionPeerPlayMarket
        case starsTransactionPeerPremiumBot
        case starsTransactionPeerUnsupported

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starsTransactionPeer(let _data):
                if boxed {
                    buffer.appendInt32(-670195363)
                }
                _data.peer.serialize(buffer, true)
                break
            case .starsTransactionPeerAPI:
                if boxed {
                    buffer.appendInt32(-110658899)
                }
                break
            case .starsTransactionPeerAds:
                if boxed {
                    buffer.appendInt32(1617438738)
                }
                break
            case .starsTransactionPeerAppStore:
                if boxed {
                    buffer.appendInt32(-1269320843)
                }
                break
            case .starsTransactionPeerFragment:
                if boxed {
                    buffer.appendInt32(-382740222)
                }
                break
            case .starsTransactionPeerPlayMarket:
                if boxed {
                    buffer.appendInt32(2069236235)
                }
                break
            case .starsTransactionPeerPremiumBot:
                if boxed {
                    buffer.appendInt32(621656824)
                }
                break
            case .starsTransactionPeerUnsupported:
                if boxed {
                    buffer.appendInt32(-1779253276)
                }
                break
            }
        }

        static func parse_starsTransactionPeer(_ reader: BufferReader) -> StarsTransactionPeer? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.StarsTransactionPeer.starsTransactionPeer(Cons_starsTransactionPeer(peer: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_starsTransactionPeerAPI(_ reader: BufferReader) -> StarsTransactionPeer? {
            return Api.StarsTransactionPeer.starsTransactionPeerAPI
        }
        static func parse_starsTransactionPeerAds(_ reader: BufferReader) -> StarsTransactionPeer? {
            return Api.StarsTransactionPeer.starsTransactionPeerAds
        }
        static func parse_starsTransactionPeerAppStore(_ reader: BufferReader) -> StarsTransactionPeer? {
            return Api.StarsTransactionPeer.starsTransactionPeerAppStore
        }
        static func parse_starsTransactionPeerFragment(_ reader: BufferReader) -> StarsTransactionPeer? {
            return Api.StarsTransactionPeer.starsTransactionPeerFragment
        }
        static func parse_starsTransactionPeerPlayMarket(_ reader: BufferReader) -> StarsTransactionPeer? {
            return Api.StarsTransactionPeer.starsTransactionPeerPlayMarket
        }
        static func parse_starsTransactionPeerPremiumBot(_ reader: BufferReader) -> StarsTransactionPeer? {
            return Api.StarsTransactionPeer.starsTransactionPeerPremiumBot
        }
        static func parse_starsTransactionPeerUnsupported(_ reader: BufferReader) -> StarsTransactionPeer? {
            return Api.StarsTransactionPeer.starsTransactionPeerUnsupported
        }
    }
}
extension Api {
    enum StickerKeyword: TypeConstructorDescription {
        class Cons_stickerKeyword: TypeConstructorDescription {
            var documentId: Int64
            var keyword: [String]
            init(documentId: Int64, keyword: [String]) {
                self.documentId = documentId
                self.keyword = keyword
            }
        }
        case stickerKeyword(Cons_stickerKeyword)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .stickerKeyword(let _data):
                if boxed {
                    buffer.appendInt32(-50416996)
                }
                serializeInt64(_data.documentId, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.keyword.count))
                for item in _data.keyword {
                    serializeString(item, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_stickerKeyword(_ reader: BufferReader) -> StickerKeyword? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: [String]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: -1255641564, elementType: String.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.StickerKeyword.stickerKeyword(Cons_stickerKeyword(documentId: _1!, keyword: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StickerPack: TypeConstructorDescription {
        class Cons_stickerPack: TypeConstructorDescription {
            var emoticon: String
            var documents: [Int64]
            init(emoticon: String, documents: [Int64]) {
                self.emoticon = emoticon
                self.documents = documents
            }
        }
        case stickerPack(Cons_stickerPack)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .stickerPack(let _data):
                if boxed {
                    buffer.appendInt32(313694676)
                }
                serializeString(_data.emoticon, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.documents.count))
                for item in _data.documents {
                    serializeInt64(item, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_stickerPack(_ reader: BufferReader) -> StickerPack? {
            var _1: String?
            _1 = parseString(reader)
            var _2: [Int64]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.StickerPack.stickerPack(Cons_stickerPack(emoticon: _1!, documents: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StickerSet: TypeConstructorDescription {
        class Cons_stickerSet: TypeConstructorDescription {
            var flags: Int32
            var installedDate: Int32?
            var id: Int64
            var accessHash: Int64
            var title: String
            var shortName: String
            var thumbs: [Api.PhotoSize]?
            var thumbDcId: Int32?
            var thumbVersion: Int32?
            var thumbDocumentId: Int64?
            var count: Int32
            var hash: Int32
            init(flags: Int32, installedDate: Int32?, id: Int64, accessHash: Int64, title: String, shortName: String, thumbs: [Api.PhotoSize]?, thumbDcId: Int32?, thumbVersion: Int32?, thumbDocumentId: Int64?, count: Int32, hash: Int32) {
                self.flags = flags
                self.installedDate = installedDate
                self.id = id
                self.accessHash = accessHash
                self.title = title
                self.shortName = shortName
                self.thumbs = thumbs
                self.thumbDcId = thumbDcId
                self.thumbVersion = thumbVersion
                self.thumbDocumentId = thumbDocumentId
                self.count = count
                self.hash = hash
            }
        }
        case stickerSet(Cons_stickerSet)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .stickerSet(let _data):
                if boxed {
                    buffer.appendInt32(768691932)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.installedDate!, buffer: buffer, boxed: false)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeString(_data.shortName, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.thumbs!.count))
                    for item in _data.thumbs! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.thumbDcId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.thumbVersion!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    serializeInt64(_data.thumbDocumentId!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                serializeInt32(_data.hash, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_stickerSet(_ reader: BufferReader) -> StickerSet? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt32()
            }
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: String?
            _5 = parseString(reader)
            var _6: String?
            _6 = parseString(reader)
            var _7: [Api.PhotoSize]?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let _ = reader.readInt32() {
                    _7 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PhotoSize.self)
                }
            }
            var _8: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _8 = reader.readInt32()
            }
            var _9: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _9 = reader.readInt32()
            }
            var _10: Int64?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                _10 = reader.readInt64()
            }
            var _11: Int32?
            _11 = reader.readInt32()
            var _12: Int32?
            _12 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _10 != nil
            let _c11 = _11 != nil
            let _c12 = _12 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 {
                return Api.StickerSet.stickerSet(Cons_stickerSet(flags: _1!, installedDate: _2, id: _3!, accessHash: _4!, title: _5!, shortName: _6!, thumbs: _7, thumbDcId: _8, thumbVersion: _9, thumbDocumentId: _10, count: _11!, hash: _12!))
            }
            else {
                return nil
            }
        }
    }
}
