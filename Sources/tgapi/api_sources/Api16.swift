extension Api {
    enum PhoneCallDiscardReason: TypeConstructorDescription {
        class Cons_phoneCallDiscardReasonMigrateConferenceCall: TypeConstructorDescription {
            var slug: String
            init(slug: String) {
                self.slug = slug
            }
        }
        case phoneCallDiscardReasonBusy
        case phoneCallDiscardReasonDisconnect
        case phoneCallDiscardReasonHangup
        case phoneCallDiscardReasonMigrateConferenceCall(Cons_phoneCallDiscardReasonMigrateConferenceCall)
        case phoneCallDiscardReasonMissed

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .phoneCallDiscardReasonBusy:
                if boxed {
                    buffer.appendInt32(-84416311)
                }
                break
            case .phoneCallDiscardReasonDisconnect:
                if boxed {
                    buffer.appendInt32(-527056480)
                }
                break
            case .phoneCallDiscardReasonHangup:
                if boxed {
                    buffer.appendInt32(1471006352)
                }
                break
            case .phoneCallDiscardReasonMigrateConferenceCall(let _data):
                if boxed {
                    buffer.appendInt32(-1615072777)
                }
                serializeString(_data.slug, buffer: buffer, boxed: false)
                break
            case .phoneCallDiscardReasonMissed:
                if boxed {
                    buffer.appendInt32(-2048646399)
                }
                break
            }
        }

        static func parse_phoneCallDiscardReasonBusy(_ reader: BufferReader) -> PhoneCallDiscardReason? {
            return Api.PhoneCallDiscardReason.phoneCallDiscardReasonBusy
        }
        static func parse_phoneCallDiscardReasonDisconnect(_ reader: BufferReader) -> PhoneCallDiscardReason? {
            return Api.PhoneCallDiscardReason.phoneCallDiscardReasonDisconnect
        }
        static func parse_phoneCallDiscardReasonHangup(_ reader: BufferReader) -> PhoneCallDiscardReason? {
            return Api.PhoneCallDiscardReason.phoneCallDiscardReasonHangup
        }
        static func parse_phoneCallDiscardReasonMigrateConferenceCall(_ reader: BufferReader) -> PhoneCallDiscardReason? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.PhoneCallDiscardReason.phoneCallDiscardReasonMigrateConferenceCall(Cons_phoneCallDiscardReasonMigrateConferenceCall(slug: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_phoneCallDiscardReasonMissed(_ reader: BufferReader) -> PhoneCallDiscardReason? {
            return Api.PhoneCallDiscardReason.phoneCallDiscardReasonMissed
        }
    }
}
extension Api {
    enum PhoneCallProtocol: TypeConstructorDescription {
        class Cons_phoneCallProtocol: TypeConstructorDescription {
            var flags: Int32
            var minLayer: Int32
            var maxLayer: Int32
            var libraryVersions: [String]
            init(flags: Int32, minLayer: Int32, maxLayer: Int32, libraryVersions: [String]) {
                self.flags = flags
                self.minLayer = minLayer
                self.maxLayer = maxLayer
                self.libraryVersions = libraryVersions
            }
        }
        case phoneCallProtocol(Cons_phoneCallProtocol)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .phoneCallProtocol(let _data):
                if boxed {
                    buffer.appendInt32(-58224696)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.minLayer, buffer: buffer, boxed: false)
                serializeInt32(_data.maxLayer, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.libraryVersions.count))
                for item in _data.libraryVersions {
                    serializeString(item, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_phoneCallProtocol(_ reader: BufferReader) -> PhoneCallProtocol? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: [String]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: -1255641564, elementType: String.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.PhoneCallProtocol.phoneCallProtocol(Cons_phoneCallProtocol(flags: _1!, minLayer: _2!, maxLayer: _3!, libraryVersions: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PhoneConnection: TypeConstructorDescription {
        class Cons_phoneConnection: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var ip: String
            var ipv6: String
            var port: Int32
            var peerTag: Buffer
            init(flags: Int32, id: Int64, ip: String, ipv6: String, port: Int32, peerTag: Buffer) {
                self.flags = flags
                self.id = id
                self.ip = ip
                self.ipv6 = ipv6
                self.port = port
                self.peerTag = peerTag
            }
        }
        class Cons_phoneConnectionWebrtc: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var ip: String
            var ipv6: String
            var port: Int32
            var username: String
            var password: String
            init(flags: Int32, id: Int64, ip: String, ipv6: String, port: Int32, username: String, password: String) {
                self.flags = flags
                self.id = id
                self.ip = ip
                self.ipv6 = ipv6
                self.port = port
                self.username = username
                self.password = password
            }
        }
        case phoneConnection(Cons_phoneConnection)
        case phoneConnectionWebrtc(Cons_phoneConnectionWebrtc)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .phoneConnection(let _data):
                if boxed {
                    buffer.appendInt32(-1665063993)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeString(_data.ip, buffer: buffer, boxed: false)
                serializeString(_data.ipv6, buffer: buffer, boxed: false)
                serializeInt32(_data.port, buffer: buffer, boxed: false)
                serializeBytes(_data.peerTag, buffer: buffer, boxed: false)
                break
            case .phoneConnectionWebrtc(let _data):
                if boxed {
                    buffer.appendInt32(1667228533)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeString(_data.ip, buffer: buffer, boxed: false)
                serializeString(_data.ipv6, buffer: buffer, boxed: false)
                serializeInt32(_data.port, buffer: buffer, boxed: false)
                serializeString(_data.username, buffer: buffer, boxed: false)
                serializeString(_data.password, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_phoneConnection(_ reader: BufferReader) -> PhoneConnection? {
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
            var _6: Buffer?
            _6 = parseBytes(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.PhoneConnection.phoneConnection(Cons_phoneConnection(flags: _1!, id: _2!, ip: _3!, ipv6: _4!, port: _5!, peerTag: _6!))
            }
            else {
                return nil
            }
        }
        static func parse_phoneConnectionWebrtc(_ reader: BufferReader) -> PhoneConnection? {
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
                return Api.PhoneConnection.phoneConnectionWebrtc(Cons_phoneConnectionWebrtc(flags: _1!, id: _2!, ip: _3!, ipv6: _4!, port: _5!, username: _6!, password: _7!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum Photo: TypeConstructorDescription {
        class Cons_photo: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var accessHash: Int64
            var fileReference: Buffer
            var date: Int32
            var sizes: [Api.PhotoSize]
            var videoSizes: [Api.VideoSize]?
            var dcId: Int32
            init(flags: Int32, id: Int64, accessHash: Int64, fileReference: Buffer, date: Int32, sizes: [Api.PhotoSize], videoSizes: [Api.VideoSize]?, dcId: Int32) {
                self.flags = flags
                self.id = id
                self.accessHash = accessHash
                self.fileReference = fileReference
                self.date = date
                self.sizes = sizes
                self.videoSizes = videoSizes
                self.dcId = dcId
            }
        }
        class Cons_photoEmpty: TypeConstructorDescription {
            var id: Int64
            init(id: Int64) {
                self.id = id
            }
        }
        case photo(Cons_photo)
        case photoEmpty(Cons_photoEmpty)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .photo(let _data):
                if boxed {
                    buffer.appendInt32(-82216347)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeBytes(_data.fileReference, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.sizes.count))
                for item in _data.sizes {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.videoSizes!.count))
                    for item in _data.videoSizes! {
                        item.serialize(buffer, true)
                    }
                }
                serializeInt32(_data.dcId, buffer: buffer, boxed: false)
                break
            case .photoEmpty(let _data):
                if boxed {
                    buffer.appendInt32(590459437)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_photo(_ reader: BufferReader) -> Photo? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Buffer?
            _4 = parseBytes(reader)
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: [Api.PhotoSize]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PhotoSize.self)
            }
            var _7: [Api.VideoSize]?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let _ = reader.readInt32() {
                    _7 = Api.parseVector(reader, elementSignature: 0, elementType: Api.VideoSize.self)
                }
            }
            var _8: Int32?
            _8 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _7 != nil
            let _c8 = _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.Photo.photo(Cons_photo(flags: _1!, id: _2!, accessHash: _3!, fileReference: _4!, date: _5!, sizes: _6!, videoSizes: _7, dcId: _8!))
            }
            else {
                return nil
            }
        }
        static func parse_photoEmpty(_ reader: BufferReader) -> Photo? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.Photo.photoEmpty(Cons_photoEmpty(id: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PhotoSize: TypeConstructorDescription {
        class Cons_photoCachedSize: TypeConstructorDescription {
            var type: String
            var w: Int32
            var h: Int32
            var bytes: Buffer
            init(type: String, w: Int32, h: Int32, bytes: Buffer) {
                self.type = type
                self.w = w
                self.h = h
                self.bytes = bytes
            }
        }
        class Cons_photoPathSize: TypeConstructorDescription {
            var type: String
            var bytes: Buffer
            init(type: String, bytes: Buffer) {
                self.type = type
                self.bytes = bytes
            }
        }
        class Cons_photoSize: TypeConstructorDescription {
            var type: String
            var w: Int32
            var h: Int32
            var size: Int32
            init(type: String, w: Int32, h: Int32, size: Int32) {
                self.type = type
                self.w = w
                self.h = h
                self.size = size
            }
        }
        class Cons_photoSizeEmpty: TypeConstructorDescription {
            var type: String
            init(type: String) {
                self.type = type
            }
        }
        class Cons_photoSizeProgressive: TypeConstructorDescription {
            var type: String
            var w: Int32
            var h: Int32
            var sizes: [Int32]
            init(type: String, w: Int32, h: Int32, sizes: [Int32]) {
                self.type = type
                self.w = w
                self.h = h
                self.sizes = sizes
            }
        }
        class Cons_photoStrippedSize: TypeConstructorDescription {
            var type: String
            var bytes: Buffer
            init(type: String, bytes: Buffer) {
                self.type = type
                self.bytes = bytes
            }
        }
        case photoCachedSize(Cons_photoCachedSize)
        case photoPathSize(Cons_photoPathSize)
        case photoSize(Cons_photoSize)
        case photoSizeEmpty(Cons_photoSizeEmpty)
        case photoSizeProgressive(Cons_photoSizeProgressive)
        case photoStrippedSize(Cons_photoStrippedSize)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .photoCachedSize(let _data):
                if boxed {
                    buffer.appendInt32(35527382)
                }
                serializeString(_data.type, buffer: buffer, boxed: false)
                serializeInt32(_data.w, buffer: buffer, boxed: false)
                serializeInt32(_data.h, buffer: buffer, boxed: false)
                serializeBytes(_data.bytes, buffer: buffer, boxed: false)
                break
            case .photoPathSize(let _data):
                if boxed {
                    buffer.appendInt32(-668906175)
                }
                serializeString(_data.type, buffer: buffer, boxed: false)
                serializeBytes(_data.bytes, buffer: buffer, boxed: false)
                break
            case .photoSize(let _data):
                if boxed {
                    buffer.appendInt32(1976012384)
                }
                serializeString(_data.type, buffer: buffer, boxed: false)
                serializeInt32(_data.w, buffer: buffer, boxed: false)
                serializeInt32(_data.h, buffer: buffer, boxed: false)
                serializeInt32(_data.size, buffer: buffer, boxed: false)
                break
            case .photoSizeEmpty(let _data):
                if boxed {
                    buffer.appendInt32(236446268)
                }
                serializeString(_data.type, buffer: buffer, boxed: false)
                break
            case .photoSizeProgressive(let _data):
                if boxed {
                    buffer.appendInt32(-96535659)
                }
                serializeString(_data.type, buffer: buffer, boxed: false)
                serializeInt32(_data.w, buffer: buffer, boxed: false)
                serializeInt32(_data.h, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.sizes.count))
                for item in _data.sizes {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                break
            case .photoStrippedSize(let _data):
                if boxed {
                    buffer.appendInt32(-525288402)
                }
                serializeString(_data.type, buffer: buffer, boxed: false)
                serializeBytes(_data.bytes, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_photoCachedSize(_ reader: BufferReader) -> PhotoSize? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Buffer?
            _4 = parseBytes(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.PhotoSize.photoCachedSize(Cons_photoCachedSize(type: _1!, w: _2!, h: _3!, bytes: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_photoPathSize(_ reader: BufferReader) -> PhotoSize? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Buffer?
            _2 = parseBytes(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PhotoSize.photoPathSize(Cons_photoPathSize(type: _1!, bytes: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_photoSize(_ reader: BufferReader) -> PhotoSize? {
            var _1: String?
            _1 = parseString(reader)
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
                return Api.PhotoSize.photoSize(Cons_photoSize(type: _1!, w: _2!, h: _3!, size: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_photoSizeEmpty(_ reader: BufferReader) -> PhotoSize? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.PhotoSize.photoSizeEmpty(Cons_photoSizeEmpty(type: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_photoSizeProgressive(_ reader: BufferReader) -> PhotoSize? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: [Int32]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.PhotoSize.photoSizeProgressive(Cons_photoSizeProgressive(type: _1!, w: _2!, h: _3!, sizes: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_photoStrippedSize(_ reader: BufferReader) -> PhotoSize? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Buffer?
            _2 = parseBytes(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PhotoSize.photoStrippedSize(Cons_photoStrippedSize(type: _1!, bytes: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum Poll: TypeConstructorDescription {
        class Cons_poll: TypeConstructorDescription {
            var id: Int64
            var flags: Int32
            var question: Api.TextWithEntities
            var answers: [Api.PollAnswer]
            var closePeriod: Int32?
            var closeDate: Int32?
            var countriesIso2: [String]?
            var hash: Int64
            init(id: Int64, flags: Int32, question: Api.TextWithEntities, answers: [Api.PollAnswer], closePeriod: Int32?, closeDate: Int32?, countriesIso2: [String]?, hash: Int64) {
                self.id = id
                self.flags = flags
                self.question = question
                self.answers = answers
                self.closePeriod = closePeriod
                self.closeDate = closeDate
                self.countriesIso2 = countriesIso2
                self.hash = hash
            }
        }
        case poll(Cons_poll)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .poll(let _data):
                if boxed {
                    buffer.appendInt32(-1771164225)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.question.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.answers.count))
                for item in _data.answers {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.closePeriod!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeInt32(_data.closeDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 12) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.countriesIso2!.count))
                    for item in _data.countriesIso2! {
                        serializeString(item, buffer: buffer, boxed: false)
                    }
                }
                serializeInt64(_data.hash, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_poll(_ reader: BufferReader) -> Poll? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.TextWithEntities?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
            }
            var _4: [Api.PollAnswer]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PollAnswer.self)
            }
            var _5: Int32?
            if Int(_2 ?? 0) & Int(1 << 4) != 0 {
                _5 = reader.readInt32()
            }
            var _6: Int32?
            if Int(_2 ?? 0) & Int(1 << 5) != 0 {
                _6 = reader.readInt32()
            }
            var _7: [String]?
            if Int(_2 ?? 0) & Int(1 << 12) != 0 {
                if let _ = reader.readInt32() {
                    _7 = Api.parseVector(reader, elementSignature: -1255641564, elementType: String.self)
                }
            }
            var _8: Int64?
            _8 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_2 ?? 0) & Int(1 << 4) == 0) || _5 != nil
            let _c6 = (Int(_2 ?? 0) & Int(1 << 5) == 0) || _6 != nil
            let _c7 = (Int(_2 ?? 0) & Int(1 << 12) == 0) || _7 != nil
            let _c8 = _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.Poll.poll(Cons_poll(id: _1!, flags: _2!, question: _3!, answers: _4!, closePeriod: _5, closeDate: _6, countriesIso2: _7, hash: _8!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum PollAnswer: TypeConstructorDescription {
        class Cons_inputPollAnswer: TypeConstructorDescription {
            var flags: Int32
            var text: Api.TextWithEntities
            var media: Api.InputMedia?
            init(flags: Int32, text: Api.TextWithEntities, media: Api.InputMedia?) {
                self.flags = flags
                self.text = text
                self.media = media
            }
        }
        class Cons_pollAnswer: TypeConstructorDescription {
            var flags: Int32
            var text: Api.TextWithEntities
            var option: Buffer
            var media: Api.MessageMedia?
            var addedBy: Api.Peer?
            var date: Int32?
            init(flags: Int32, text: Api.TextWithEntities, option: Buffer, media: Api.MessageMedia?, addedBy: Api.Peer?, date: Int32?) {
                self.flags = flags
                self.text = text
                self.option = option
                self.media = media
                self.addedBy = addedBy
                self.date = date
            }
        }
        case inputPollAnswer(Cons_inputPollAnswer)
        case pollAnswer(Cons_pollAnswer)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputPollAnswer(let _data):
                if boxed {
                    buffer.appendInt32(429911446)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.text.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.media!.serialize(buffer, true)
                }
                break
            case .pollAnswer(let _data):
                if boxed {
                    buffer.appendInt32(1266514026)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.text.serialize(buffer, true)
                serializeBytes(_data.option, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.media!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.addedBy!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.date!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_inputPollAnswer(_ reader: BufferReader) -> PollAnswer? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.TextWithEntities?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
            }
            var _3: Api.InputMedia?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.InputMedia
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.PollAnswer.inputPollAnswer(Cons_inputPollAnswer(flags: _1!, text: _2!, media: _3))
            }
            else {
                return nil
            }
        }
        static func parse_pollAnswer(_ reader: BufferReader) -> PollAnswer? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.TextWithEntities?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
            }
            var _3: Buffer?
            _3 = parseBytes(reader)
            var _4: Api.MessageMedia?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.MessageMedia
                }
            }
            var _5: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _6 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.PollAnswer.pollAnswer(Cons_pollAnswer(flags: _1!, text: _2!, option: _3!, media: _4, addedBy: _5, date: _6))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PollAnswerVoters: TypeConstructorDescription {
        class Cons_pollAnswerVoters: TypeConstructorDescription {
            var flags: Int32
            var option: Buffer
            var voters: Int32?
            var recentVoters: [Api.Peer]?
            init(flags: Int32, option: Buffer, voters: Int32?, recentVoters: [Api.Peer]?) {
                self.flags = flags
                self.option = option
                self.voters = voters
                self.recentVoters = recentVoters
            }
        }
        case pollAnswerVoters(Cons_pollAnswerVoters)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .pollAnswerVoters(let _data):
                if boxed {
                    buffer.appendInt32(910500618)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeBytes(_data.option, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.voters!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.recentVoters!.count))
                    for item in _data.recentVoters! {
                        item.serialize(buffer, true)
                    }
                }
                break
            }
        }

        static func parse_pollAnswerVoters(_ reader: BufferReader) -> PollAnswerVoters? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Buffer?
            _2 = parseBytes(reader)
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _3 = reader.readInt32()
            }
            var _4: [Api.Peer]?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let _ = reader.readInt32() {
                    _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Peer.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.PollAnswerVoters.pollAnswerVoters(Cons_pollAnswerVoters(flags: _1!, option: _2!, voters: _3, recentVoters: _4))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum PollResults: TypeConstructorDescription {
        class Cons_pollResults: TypeConstructorDescription {
            var flags: Int32
            var results: [Api.PollAnswerVoters]?
            var totalVoters: Int32?
            var recentVoters: [Api.Peer]?
            var solution: String?
            var solutionEntities: [Api.MessageEntity]?
            var solutionMedia: Api.MessageMedia?
            init(flags: Int32, results: [Api.PollAnswerVoters]?, totalVoters: Int32?, recentVoters: [Api.Peer]?, solution: String?, solutionEntities: [Api.MessageEntity]?, solutionMedia: Api.MessageMedia?) {
                self.flags = flags
                self.results = results
                self.totalVoters = totalVoters
                self.recentVoters = recentVoters
                self.solution = solution
                self.solutionEntities = solutionEntities
                self.solutionMedia = solutionMedia
            }
        }
        case pollResults(Cons_pollResults)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .pollResults(let _data):
                if boxed {
                    buffer.appendInt32(-1166298786)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.results!.count))
                    for item in _data.results! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.totalVoters!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.recentVoters!.count))
                    for item in _data.recentVoters! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeString(_data.solution!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.solutionEntities!.count))
                    for item in _data.solutionEntities! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    _data.solutionMedia!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_pollResults(_ reader: BufferReader) -> PollResults? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.PollAnswerVoters]?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let _ = reader.readInt32() {
                    _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PollAnswerVoters.self)
                }
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _3 = reader.readInt32()
            }
            var _4: [Api.Peer]?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let _ = reader.readInt32() {
                    _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Peer.self)
                }
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _5 = parseString(reader)
            }
            var _6: [Api.MessageEntity]?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let _ = reader.readInt32() {
                    _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self)
                }
            }
            var _7: Api.MessageMedia?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.MessageMedia
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.PollResults.pollResults(Cons_pollResults(flags: _1!, results: _2, totalVoters: _3, recentVoters: _4, solution: _5, solutionEntities: _6, solutionMedia: _7))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PostAddress: TypeConstructorDescription {
        class Cons_postAddress: TypeConstructorDescription {
            var streetLine1: String
            var streetLine2: String
            var city: String
            var state: String
            var countryIso2: String
            var postCode: String
            init(streetLine1: String, streetLine2: String, city: String, state: String, countryIso2: String, postCode: String) {
                self.streetLine1 = streetLine1
                self.streetLine2 = streetLine2
                self.city = city
                self.state = state
                self.countryIso2 = countryIso2
                self.postCode = postCode
            }
        }
        case postAddress(Cons_postAddress)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .postAddress(let _data):
                if boxed {
                    buffer.appendInt32(512535275)
                }
                serializeString(_data.streetLine1, buffer: buffer, boxed: false)
                serializeString(_data.streetLine2, buffer: buffer, boxed: false)
                serializeString(_data.city, buffer: buffer, boxed: false)
                serializeString(_data.state, buffer: buffer, boxed: false)
                serializeString(_data.countryIso2, buffer: buffer, boxed: false)
                serializeString(_data.postCode, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_postAddress(_ reader: BufferReader) -> PostAddress? {
            var _1: String?
            _1 = parseString(reader)
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            _3 = parseString(reader)
            var _4: String?
            _4 = parseString(reader)
            var _5: String?
            _5 = parseString(reader)
            var _6: String?
            _6 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.PostAddress.postAddress(Cons_postAddress(streetLine1: _1!, streetLine2: _2!, city: _3!, state: _4!, countryIso2: _5!, postCode: _6!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PrivacyKey: TypeConstructorDescription {
        case privacyKeyAbout
        case privacyKeyAddedByPhone
        case privacyKeyBirthday
        case privacyKeyChatInvite
        case privacyKeyForwards
        case privacyKeyNoPaidMessages
        case privacyKeyPhoneCall
        case privacyKeyPhoneNumber
        case privacyKeyPhoneP2P
        case privacyKeyProfilePhoto
        case privacyKeySavedMusic
        case privacyKeyStarGiftsAutoSave
        case privacyKeyStatusTimestamp
        case privacyKeyVoiceMessages

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .privacyKeyAbout:
                if boxed {
                    buffer.appendInt32(-1534675103)
                }
                break
            case .privacyKeyAddedByPhone:
                if boxed {
                    buffer.appendInt32(1124062251)
                }
                break
            case .privacyKeyBirthday:
                if boxed {
                    buffer.appendInt32(536913176)
                }
                break
            case .privacyKeyChatInvite:
                if boxed {
                    buffer.appendInt32(1343122938)
                }
                break
            case .privacyKeyForwards:
                if boxed {
                    buffer.appendInt32(1777096355)
                }
                break
            case .privacyKeyNoPaidMessages:
                if boxed {
                    buffer.appendInt32(399722706)
                }
                break
            case .privacyKeyPhoneCall:
                if boxed {
                    buffer.appendInt32(1030105979)
                }
                break
            case .privacyKeyPhoneNumber:
                if boxed {
                    buffer.appendInt32(-778378131)
                }
                break
            case .privacyKeyPhoneP2P:
                if boxed {
                    buffer.appendInt32(961092808)
                }
                break
            case .privacyKeyProfilePhoto:
                if boxed {
                    buffer.appendInt32(-1777000467)
                }
                break
            case .privacyKeySavedMusic:
                if boxed {
                    buffer.appendInt32(-8759525)
                }
                break
            case .privacyKeyStarGiftsAutoSave:
                if boxed {
                    buffer.appendInt32(749010424)
                }
                break
            case .privacyKeyStatusTimestamp:
                if boxed {
                    buffer.appendInt32(-1137792208)
                }
                break
            case .privacyKeyVoiceMessages:
                if boxed {
                    buffer.appendInt32(110621716)
                }
                break
            }
        }

        static func parse_privacyKeyAbout(_ reader: BufferReader) -> PrivacyKey? {
            return Api.PrivacyKey.privacyKeyAbout
        }
        static func parse_privacyKeyAddedByPhone(_ reader: BufferReader) -> PrivacyKey? {
            return Api.PrivacyKey.privacyKeyAddedByPhone
        }
        static func parse_privacyKeyBirthday(_ reader: BufferReader) -> PrivacyKey? {
            return Api.PrivacyKey.privacyKeyBirthday
        }
        static func parse_privacyKeyChatInvite(_ reader: BufferReader) -> PrivacyKey? {
            return Api.PrivacyKey.privacyKeyChatInvite
        }
        static func parse_privacyKeyForwards(_ reader: BufferReader) -> PrivacyKey? {
            return Api.PrivacyKey.privacyKeyForwards
        }
        static func parse_privacyKeyNoPaidMessages(_ reader: BufferReader) -> PrivacyKey? {
            return Api.PrivacyKey.privacyKeyNoPaidMessages
        }
        static func parse_privacyKeyPhoneCall(_ reader: BufferReader) -> PrivacyKey? {
            return Api.PrivacyKey.privacyKeyPhoneCall
        }
        static func parse_privacyKeyPhoneNumber(_ reader: BufferReader) -> PrivacyKey? {
            return Api.PrivacyKey.privacyKeyPhoneNumber
        }
        static func parse_privacyKeyPhoneP2P(_ reader: BufferReader) -> PrivacyKey? {
            return Api.PrivacyKey.privacyKeyPhoneP2P
        }
        static func parse_privacyKeyProfilePhoto(_ reader: BufferReader) -> PrivacyKey? {
            return Api.PrivacyKey.privacyKeyProfilePhoto
        }
        static func parse_privacyKeySavedMusic(_ reader: BufferReader) -> PrivacyKey? {
            return Api.PrivacyKey.privacyKeySavedMusic
        }
        static func parse_privacyKeyStarGiftsAutoSave(_ reader: BufferReader) -> PrivacyKey? {
            return Api.PrivacyKey.privacyKeyStarGiftsAutoSave
        }
        static func parse_privacyKeyStatusTimestamp(_ reader: BufferReader) -> PrivacyKey? {
            return Api.PrivacyKey.privacyKeyStatusTimestamp
        }
        static func parse_privacyKeyVoiceMessages(_ reader: BufferReader) -> PrivacyKey? {
            return Api.PrivacyKey.privacyKeyVoiceMessages
        }
    }
}
extension Api {
    enum PrivacyRule: TypeConstructorDescription {
        class Cons_privacyValueAllowChatParticipants: TypeConstructorDescription {
            var chats: [Int64]
            init(chats: [Int64]) {
                self.chats = chats
            }
        }
        class Cons_privacyValueAllowUsers: TypeConstructorDescription {
            var users: [Int64]
            init(users: [Int64]) {
                self.users = users
            }
        }
        class Cons_privacyValueDisallowChatParticipants: TypeConstructorDescription {
            var chats: [Int64]
            init(chats: [Int64]) {
                self.chats = chats
            }
        }
        class Cons_privacyValueDisallowUsers: TypeConstructorDescription {
            var users: [Int64]
            init(users: [Int64]) {
                self.users = users
            }
        }
        case privacyValueAllowAll
        case privacyValueAllowBots
        case privacyValueAllowChatParticipants(Cons_privacyValueAllowChatParticipants)
        case privacyValueAllowCloseFriends
        case privacyValueAllowContacts
        case privacyValueAllowPremium
        case privacyValueAllowUsers(Cons_privacyValueAllowUsers)
        case privacyValueDisallowAll
        case privacyValueDisallowBots
        case privacyValueDisallowChatParticipants(Cons_privacyValueDisallowChatParticipants)
        case privacyValueDisallowContacts
        case privacyValueDisallowUsers(Cons_privacyValueDisallowUsers)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .privacyValueAllowAll:
                if boxed {
                    buffer.appendInt32(1698855810)
                }
                break
            case .privacyValueAllowBots:
                if boxed {
                    buffer.appendInt32(558242653)
                }
                break
            case .privacyValueAllowChatParticipants(let _data):
                if boxed {
                    buffer.appendInt32(1796427406)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    serializeInt64(item, buffer: buffer, boxed: false)
                }
                break
            case .privacyValueAllowCloseFriends:
                if boxed {
                    buffer.appendInt32(-135735141)
                }
                break
            case .privacyValueAllowContacts:
                if boxed {
                    buffer.appendInt32(-123988)
                }
                break
            case .privacyValueAllowPremium:
                if boxed {
                    buffer.appendInt32(-320241333)
                }
                break
            case .privacyValueAllowUsers(let _data):
                if boxed {
                    buffer.appendInt32(-1198497870)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    serializeInt64(item, buffer: buffer, boxed: false)
                }
                break
            case .privacyValueDisallowAll:
                if boxed {
                    buffer.appendInt32(-1955338397)
                }
                break
            case .privacyValueDisallowBots:
                if boxed {
                    buffer.appendInt32(-156895185)
                }
                break
            case .privacyValueDisallowChatParticipants(let _data):
                if boxed {
                    buffer.appendInt32(1103656293)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.chats.count))
                for item in _data.chats {
                    serializeInt64(item, buffer: buffer, boxed: false)
                }
                break
            case .privacyValueDisallowContacts:
                if boxed {
                    buffer.appendInt32(-125240806)
                }
                break
            case .privacyValueDisallowUsers(let _data):
                if boxed {
                    buffer.appendInt32(-463335103)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.users.count))
                for item in _data.users {
                    serializeInt64(item, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_privacyValueAllowAll(_ reader: BufferReader) -> PrivacyRule? {
            return Api.PrivacyRule.privacyValueAllowAll
        }
        static func parse_privacyValueAllowBots(_ reader: BufferReader) -> PrivacyRule? {
            return Api.PrivacyRule.privacyValueAllowBots
        }
        static func parse_privacyValueAllowChatParticipants(_ reader: BufferReader) -> PrivacyRule? {
            var _1: [Int64]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PrivacyRule.privacyValueAllowChatParticipants(Cons_privacyValueAllowChatParticipants(chats: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_privacyValueAllowCloseFriends(_ reader: BufferReader) -> PrivacyRule? {
            return Api.PrivacyRule.privacyValueAllowCloseFriends
        }
        static func parse_privacyValueAllowContacts(_ reader: BufferReader) -> PrivacyRule? {
            return Api.PrivacyRule.privacyValueAllowContacts
        }
        static func parse_privacyValueAllowPremium(_ reader: BufferReader) -> PrivacyRule? {
            return Api.PrivacyRule.privacyValueAllowPremium
        }
        static func parse_privacyValueAllowUsers(_ reader: BufferReader) -> PrivacyRule? {
            var _1: [Int64]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PrivacyRule.privacyValueAllowUsers(Cons_privacyValueAllowUsers(users: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_privacyValueDisallowAll(_ reader: BufferReader) -> PrivacyRule? {
            return Api.PrivacyRule.privacyValueDisallowAll
        }
        static func parse_privacyValueDisallowBots(_ reader: BufferReader) -> PrivacyRule? {
            return Api.PrivacyRule.privacyValueDisallowBots
        }
        static func parse_privacyValueDisallowChatParticipants(_ reader: BufferReader) -> PrivacyRule? {
            var _1: [Int64]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PrivacyRule.privacyValueDisallowChatParticipants(Cons_privacyValueDisallowChatParticipants(chats: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_privacyValueDisallowContacts(_ reader: BufferReader) -> PrivacyRule? {
            return Api.PrivacyRule.privacyValueDisallowContacts
        }
        static func parse_privacyValueDisallowUsers(_ reader: BufferReader) -> PrivacyRule? {
            var _1: [Int64]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PrivacyRule.privacyValueDisallowUsers(Cons_privacyValueDisallowUsers(users: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum ProfileTab: TypeConstructorDescription {
        case profileTabFiles
        case profileTabGifs
        case profileTabGifts
        case profileTabLinks
        case profileTabMedia
        case profileTabMusic
        case profileTabPosts
        case profileTabVoice

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .profileTabFiles:
                if boxed {
                    buffer.appendInt32(-1422681088)
                }
                break
            case .profileTabGifs:
                if boxed {
                    buffer.appendInt32(-1564412267)
                }
                break
            case .profileTabGifts:
                if boxed {
                    buffer.appendInt32(1296815210)
                }
                break
            case .profileTabLinks:
                if boxed {
                    buffer.appendInt32(-748329831)
                }
                break
            case .profileTabMedia:
                if boxed {
                    buffer.appendInt32(1925597525)
                }
                break
            case .profileTabMusic:
                if boxed {
                    buffer.appendInt32(-1624780178)
                }
                break
            case .profileTabPosts:
                if boxed {
                    buffer.appendInt32(-1181952362)
                }
                break
            case .profileTabVoice:
                if boxed {
                    buffer.appendInt32(-461960914)
                }
                break
            }
        }

        static func parse_profileTabFiles(_ reader: BufferReader) -> ProfileTab? {
            return Api.ProfileTab.profileTabFiles
        }
        static func parse_profileTabGifs(_ reader: BufferReader) -> ProfileTab? {
            return Api.ProfileTab.profileTabGifs
        }
        static func parse_profileTabGifts(_ reader: BufferReader) -> ProfileTab? {
            return Api.ProfileTab.profileTabGifts
        }
        static func parse_profileTabLinks(_ reader: BufferReader) -> ProfileTab? {
            return Api.ProfileTab.profileTabLinks
        }
        static func parse_profileTabMedia(_ reader: BufferReader) -> ProfileTab? {
            return Api.ProfileTab.profileTabMedia
        }
        static func parse_profileTabMusic(_ reader: BufferReader) -> ProfileTab? {
            return Api.ProfileTab.profileTabMusic
        }
        static func parse_profileTabPosts(_ reader: BufferReader) -> ProfileTab? {
            return Api.ProfileTab.profileTabPosts
        }
        static func parse_profileTabVoice(_ reader: BufferReader) -> ProfileTab? {
            return Api.ProfileTab.profileTabVoice
        }
    }
}
extension Api {
    enum PublicForward: TypeConstructorDescription {
        class Cons_publicForwardMessage: TypeConstructorDescription {
            var message: Api.Message
            init(message: Api.Message) {
                self.message = message
            }
        }
        class Cons_publicForwardStory: TypeConstructorDescription {
            var peer: Api.Peer
            var story: Api.StoryItem
            init(peer: Api.Peer, story: Api.StoryItem) {
                self.peer = peer
                self.story = story
            }
        }
        case publicForwardMessage(Cons_publicForwardMessage)
        case publicForwardStory(Cons_publicForwardStory)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .publicForwardMessage(let _data):
                if boxed {
                    buffer.appendInt32(32685898)
                }
                _data.message.serialize(buffer, true)
                break
            case .publicForwardStory(let _data):
                if boxed {
                    buffer.appendInt32(-302797360)
                }
                _data.peer.serialize(buffer, true)
                _data.story.serialize(buffer, true)
                break
            }
        }

        static func parse_publicForwardMessage(_ reader: BufferReader) -> PublicForward? {
            var _1: Api.Message?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Message
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PublicForward.publicForwardMessage(Cons_publicForwardMessage(message: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_publicForwardStory(_ reader: BufferReader) -> PublicForward? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Api.StoryItem?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.StoryItem
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PublicForward.publicForwardStory(Cons_publicForwardStory(peer: _1!, story: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum QuickReply: TypeConstructorDescription {
        class Cons_quickReply: TypeConstructorDescription {
            var shortcutId: Int32
            var shortcut: String
            var topMessage: Int32
            var count: Int32
            init(shortcutId: Int32, shortcut: String, topMessage: Int32, count: Int32) {
                self.shortcutId = shortcutId
                self.shortcut = shortcut
                self.topMessage = topMessage
                self.count = count
            }
        }
        case quickReply(Cons_quickReply)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .quickReply(let _data):
                if boxed {
                    buffer.appendInt32(110563371)
                }
                serializeInt32(_data.shortcutId, buffer: buffer, boxed: false)
                serializeString(_data.shortcut, buffer: buffer, boxed: false)
                serializeInt32(_data.topMessage, buffer: buffer, boxed: false)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_quickReply(_ reader: BufferReader) -> QuickReply? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.QuickReply.quickReply(Cons_quickReply(shortcutId: _1!, shortcut: _2!, topMessage: _3!, count: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum Reaction: TypeConstructorDescription {
        class Cons_reactionCustomEmoji: TypeConstructorDescription {
            var documentId: Int64
            init(documentId: Int64) {
                self.documentId = documentId
            }
        }
        class Cons_reactionEmoji: TypeConstructorDescription {
            var emoticon: String
            init(emoticon: String) {
                self.emoticon = emoticon
            }
        }
        case reactionCustomEmoji(Cons_reactionCustomEmoji)
        case reactionEmoji(Cons_reactionEmoji)
        case reactionEmpty
        case reactionPaid

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .reactionCustomEmoji(let _data):
                if boxed {
                    buffer.appendInt32(-1992950669)
                }
                serializeInt64(_data.documentId, buffer: buffer, boxed: false)
                break
            case .reactionEmoji(let _data):
                if boxed {
                    buffer.appendInt32(455247544)
                }
                serializeString(_data.emoticon, buffer: buffer, boxed: false)
                break
            case .reactionEmpty:
                if boxed {
                    buffer.appendInt32(2046153753)
                }
                break
            case .reactionPaid:
                if boxed {
                    buffer.appendInt32(1379771627)
                }
                break
            }
        }

        static func parse_reactionCustomEmoji(_ reader: BufferReader) -> Reaction? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.Reaction.reactionCustomEmoji(Cons_reactionCustomEmoji(documentId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_reactionEmoji(_ reader: BufferReader) -> Reaction? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.Reaction.reactionEmoji(Cons_reactionEmoji(emoticon: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_reactionEmpty(_ reader: BufferReader) -> Reaction? {
            return Api.Reaction.reactionEmpty
        }
        static func parse_reactionPaid(_ reader: BufferReader) -> Reaction? {
            return Api.Reaction.reactionPaid
        }
    }
}
extension Api {
    enum ReactionCount: TypeConstructorDescription {
        class Cons_reactionCount: TypeConstructorDescription {
            var flags: Int32
            var chosenOrder: Int32?
            var reaction: Api.Reaction
            var count: Int32
            init(flags: Int32, chosenOrder: Int32?, reaction: Api.Reaction, count: Int32) {
                self.flags = flags
                self.chosenOrder = chosenOrder
                self.reaction = reaction
                self.count = count
            }
        }
        case reactionCount(Cons_reactionCount)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .reactionCount(let _data):
                if boxed {
                    buffer.appendInt32(-1546531968)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.chosenOrder!, buffer: buffer, boxed: false)
                }
                _data.reaction.serialize(buffer, true)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_reactionCount(_ reader: BufferReader) -> ReactionCount? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt32()
            }
            var _3: Api.Reaction?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Reaction
            }
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.ReactionCount.reactionCount(Cons_reactionCount(flags: _1!, chosenOrder: _2, reaction: _3!, count: _4!))
            }
            else {
                return nil
            }
        }
    }
}
