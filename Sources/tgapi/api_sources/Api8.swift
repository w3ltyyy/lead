extension Api {
    indirect enum InputMedia: TypeConstructorDescription {
        class Cons_inputMediaContact: TypeConstructorDescription {
            var phoneNumber: String
            var firstName: String
            var lastName: String
            var vcard: String
            init(phoneNumber: String, firstName: String, lastName: String, vcard: String) {
                self.phoneNumber = phoneNumber
                self.firstName = firstName
                self.lastName = lastName
                self.vcard = vcard
            }
        }
        class Cons_inputMediaDice: TypeConstructorDescription {
            var emoticon: String
            init(emoticon: String) {
                self.emoticon = emoticon
            }
        }
        class Cons_inputMediaDocument: TypeConstructorDescription {
            var flags: Int32
            var id: Api.InputDocument
            var videoCover: Api.InputPhoto?
            var videoTimestamp: Int32?
            var ttlSeconds: Int32?
            var query: String?
            init(flags: Int32, id: Api.InputDocument, videoCover: Api.InputPhoto?, videoTimestamp: Int32?, ttlSeconds: Int32?, query: String?) {
                self.flags = flags
                self.id = id
                self.videoCover = videoCover
                self.videoTimestamp = videoTimestamp
                self.ttlSeconds = ttlSeconds
                self.query = query
            }
        }
        class Cons_inputMediaDocumentExternal: TypeConstructorDescription {
            var flags: Int32
            var url: String
            var ttlSeconds: Int32?
            var videoCover: Api.InputPhoto?
            var videoTimestamp: Int32?
            init(flags: Int32, url: String, ttlSeconds: Int32?, videoCover: Api.InputPhoto?, videoTimestamp: Int32?) {
                self.flags = flags
                self.url = url
                self.ttlSeconds = ttlSeconds
                self.videoCover = videoCover
                self.videoTimestamp = videoTimestamp
            }
        }
        class Cons_inputMediaGame: TypeConstructorDescription {
            var id: Api.InputGame
            init(id: Api.InputGame) {
                self.id = id
            }
        }
        class Cons_inputMediaGeoLive: TypeConstructorDescription {
            var flags: Int32
            var geoPoint: Api.InputGeoPoint
            var heading: Int32?
            var period: Int32?
            var proximityNotificationRadius: Int32?
            init(flags: Int32, geoPoint: Api.InputGeoPoint, heading: Int32?, period: Int32?, proximityNotificationRadius: Int32?) {
                self.flags = flags
                self.geoPoint = geoPoint
                self.heading = heading
                self.period = period
                self.proximityNotificationRadius = proximityNotificationRadius
            }
        }
        class Cons_inputMediaGeoPoint: TypeConstructorDescription {
            var geoPoint: Api.InputGeoPoint
            init(geoPoint: Api.InputGeoPoint) {
                self.geoPoint = geoPoint
            }
        }
        class Cons_inputMediaInvoice: TypeConstructorDescription {
            var flags: Int32
            var title: String
            var description: String
            var photo: Api.InputWebDocument?
            var invoice: Api.Invoice
            var payload: Buffer
            var provider: String?
            var providerData: Api.DataJSON
            var startParam: String?
            var extendedMedia: Api.InputMedia?
            init(flags: Int32, title: String, description: String, photo: Api.InputWebDocument?, invoice: Api.Invoice, payload: Buffer, provider: String?, providerData: Api.DataJSON, startParam: String?, extendedMedia: Api.InputMedia?) {
                self.flags = flags
                self.title = title
                self.description = description
                self.photo = photo
                self.invoice = invoice
                self.payload = payload
                self.provider = provider
                self.providerData = providerData
                self.startParam = startParam
                self.extendedMedia = extendedMedia
            }
        }
        class Cons_inputMediaPaidMedia: TypeConstructorDescription {
            var flags: Int32
            var starsAmount: Int64
            var extendedMedia: [Api.InputMedia]
            var payload: String?
            init(flags: Int32, starsAmount: Int64, extendedMedia: [Api.InputMedia], payload: String?) {
                self.flags = flags
                self.starsAmount = starsAmount
                self.extendedMedia = extendedMedia
                self.payload = payload
            }
        }
        class Cons_inputMediaPhoto: TypeConstructorDescription {
            var flags: Int32
            var id: Api.InputPhoto
            var ttlSeconds: Int32?
            var video: Api.InputDocument?
            init(flags: Int32, id: Api.InputPhoto, ttlSeconds: Int32?, video: Api.InputDocument?) {
                self.flags = flags
                self.id = id
                self.ttlSeconds = ttlSeconds
                self.video = video
            }
        }
        class Cons_inputMediaPhotoExternal: TypeConstructorDescription {
            var flags: Int32
            var url: String
            var ttlSeconds: Int32?
            init(flags: Int32, url: String, ttlSeconds: Int32?) {
                self.flags = flags
                self.url = url
                self.ttlSeconds = ttlSeconds
            }
        }
        class Cons_inputMediaPoll: TypeConstructorDescription {
            var flags: Int32
            var poll: Api.Poll
            var correctAnswers: [Int32]?
            var attachedMedia: Api.InputMedia?
            var solution: String?
            var solutionEntities: [Api.MessageEntity]?
            var solutionMedia: Api.InputMedia?
            init(flags: Int32, poll: Api.Poll, correctAnswers: [Int32]?, attachedMedia: Api.InputMedia?, solution: String?, solutionEntities: [Api.MessageEntity]?, solutionMedia: Api.InputMedia?) {
                self.flags = flags
                self.poll = poll
                self.correctAnswers = correctAnswers
                self.attachedMedia = attachedMedia
                self.solution = solution
                self.solutionEntities = solutionEntities
                self.solutionMedia = solutionMedia
            }
        }
        class Cons_inputMediaStakeDice: TypeConstructorDescription {
            var gameHash: String
            var tonAmount: Int64
            var clientSeed: Buffer
            init(gameHash: String, tonAmount: Int64, clientSeed: Buffer) {
                self.gameHash = gameHash
                self.tonAmount = tonAmount
                self.clientSeed = clientSeed
            }
        }
        class Cons_inputMediaStory: TypeConstructorDescription {
            var peer: Api.InputPeer
            var id: Int32
            init(peer: Api.InputPeer, id: Int32) {
                self.peer = peer
                self.id = id
            }
        }
        class Cons_inputMediaTodo: TypeConstructorDescription {
            var todo: Api.TodoList
            init(todo: Api.TodoList) {
                self.todo = todo
            }
        }
        class Cons_inputMediaUploadedDocument: TypeConstructorDescription {
            var flags: Int32
            var file: Api.InputFile
            var thumb: Api.InputFile?
            var mimeType: String
            var attributes: [Api.DocumentAttribute]
            var stickers: [Api.InputDocument]?
            var videoCover: Api.InputPhoto?
            var videoTimestamp: Int32?
            var ttlSeconds: Int32?
            init(flags: Int32, file: Api.InputFile, thumb: Api.InputFile?, mimeType: String, attributes: [Api.DocumentAttribute], stickers: [Api.InputDocument]?, videoCover: Api.InputPhoto?, videoTimestamp: Int32?, ttlSeconds: Int32?) {
                self.flags = flags
                self.file = file
                self.thumb = thumb
                self.mimeType = mimeType
                self.attributes = attributes
                self.stickers = stickers
                self.videoCover = videoCover
                self.videoTimestamp = videoTimestamp
                self.ttlSeconds = ttlSeconds
            }
        }
        class Cons_inputMediaUploadedPhoto: TypeConstructorDescription {
            var flags: Int32
            var file: Api.InputFile
            var stickers: [Api.InputDocument]?
            var ttlSeconds: Int32?
            var video: Api.InputDocument?
            init(flags: Int32, file: Api.InputFile, stickers: [Api.InputDocument]?, ttlSeconds: Int32?, video: Api.InputDocument?) {
                self.flags = flags
                self.file = file
                self.stickers = stickers
                self.ttlSeconds = ttlSeconds
                self.video = video
            }
        }
        class Cons_inputMediaVenue: TypeConstructorDescription {
            var geoPoint: Api.InputGeoPoint
            var title: String
            var address: String
            var provider: String
            var venueId: String
            var venueType: String
            init(geoPoint: Api.InputGeoPoint, title: String, address: String, provider: String, venueId: String, venueType: String) {
                self.geoPoint = geoPoint
                self.title = title
                self.address = address
                self.provider = provider
                self.venueId = venueId
                self.venueType = venueType
            }
        }
        class Cons_inputMediaWebPage: TypeConstructorDescription {
            var flags: Int32
            var url: String
            init(flags: Int32, url: String) {
                self.flags = flags
                self.url = url
            }
        }
        class Cons_inputMediaWidget: TypeConstructorDescription {
            var flags: Int32
            var width: Int32
            var height: Int32
            var html: String
            var publicData: String?
            var chatData: String?
            init(flags: Int32, width: Int32, height: Int32, html: String, publicData: String?, chatData: String?) {
                self.flags = flags
                self.width = width
                self.height = height
                self.html = html
                self.publicData = publicData
                self.chatData = chatData
            }
        }
        class Cons_inputMediaWidgetId: TypeConstructorDescription {
            var flags: Int32
            var widgetId: Int64
            var chatData: String?
            init(flags: Int32, widgetId: Int64, chatData: String?) {
                self.flags = flags
                self.widgetId = widgetId
                self.chatData = chatData
            }
        }
        case inputMediaContact(Cons_inputMediaContact)
        case inputMediaDice(Cons_inputMediaDice)
        case inputMediaDocument(Cons_inputMediaDocument)
        case inputMediaDocumentExternal(Cons_inputMediaDocumentExternal)
        case inputMediaEmpty
        case inputMediaGame(Cons_inputMediaGame)
        case inputMediaGeoLive(Cons_inputMediaGeoLive)
        case inputMediaGeoPoint(Cons_inputMediaGeoPoint)
        case inputMediaInvoice(Cons_inputMediaInvoice)
        case inputMediaPaidMedia(Cons_inputMediaPaidMedia)
        case inputMediaPhoto(Cons_inputMediaPhoto)
        case inputMediaPhotoExternal(Cons_inputMediaPhotoExternal)
        case inputMediaPoll(Cons_inputMediaPoll)
        case inputMediaStakeDice(Cons_inputMediaStakeDice)
        case inputMediaStory(Cons_inputMediaStory)
        case inputMediaTodo(Cons_inputMediaTodo)
        case inputMediaUploadedDocument(Cons_inputMediaUploadedDocument)
        case inputMediaUploadedPhoto(Cons_inputMediaUploadedPhoto)
        case inputMediaVenue(Cons_inputMediaVenue)
        case inputMediaWebPage(Cons_inputMediaWebPage)
        case inputMediaWidget(Cons_inputMediaWidget)
        case inputMediaWidgetId(Cons_inputMediaWidgetId)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputMediaContact(let _data):
                if boxed {
                    buffer.appendInt32(-122978821)
                }
                serializeString(_data.phoneNumber, buffer: buffer, boxed: false)
                serializeString(_data.firstName, buffer: buffer, boxed: false)
                serializeString(_data.lastName, buffer: buffer, boxed: false)
                serializeString(_data.vcard, buffer: buffer, boxed: false)
                break
            case .inputMediaDice(let _data):
                if boxed {
                    buffer.appendInt32(-428884101)
                }
                serializeString(_data.emoticon, buffer: buffer, boxed: false)
                break
            case .inputMediaDocument(let _data):
                if boxed {
                    buffer.appendInt32(-1468646731)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.id.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.videoCover!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.videoTimestamp!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.ttlSeconds!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.query!, buffer: buffer, boxed: false)
                }
                break
            case .inputMediaDocumentExternal(let _data):
                if boxed {
                    buffer.appendInt32(2006319353)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.url, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.ttlSeconds!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.videoCover!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.videoTimestamp!, buffer: buffer, boxed: false)
                }
                break
            case .inputMediaEmpty:
                if boxed {
                    buffer.appendInt32(-1771768449)
                }
                break
            case .inputMediaGame(let _data):
                if boxed {
                    buffer.appendInt32(-750828557)
                }
                _data.id.serialize(buffer, true)
                break
            case .inputMediaGeoLive(let _data):
                if boxed {
                    buffer.appendInt32(-1759532989)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.geoPoint.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.heading!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.period!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.proximityNotificationRadius!, buffer: buffer, boxed: false)
                }
                break
            case .inputMediaGeoPoint(let _data):
                if boxed {
                    buffer.appendInt32(-104578748)
                }
                _data.geoPoint.serialize(buffer, true)
                break
            case .inputMediaInvoice(let _data):
                if boxed {
                    buffer.appendInt32(1080028941)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeString(_data.description, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.photo!.serialize(buffer, true)
                }
                _data.invoice.serialize(buffer, true)
                serializeBytes(_data.payload, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.provider!, buffer: buffer, boxed: false)
                }
                _data.providerData.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.startParam!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.extendedMedia!.serialize(buffer, true)
                }
                break
            case .inputMediaPaidMedia(let _data):
                if boxed {
                    buffer.appendInt32(-1005571194)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.starsAmount, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.extendedMedia.count))
                for item in _data.extendedMedia {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.payload!, buffer: buffer, boxed: false)
                }
                break
            case .inputMediaPhoto(let _data):
                if boxed {
                    buffer.appendInt32(-475053004)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.id.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.ttlSeconds!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.video!.serialize(buffer, true)
                }
                break
            case .inputMediaPhotoExternal(let _data):
                if boxed {
                    buffer.appendInt32(-440664550)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.url, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.ttlSeconds!, buffer: buffer, boxed: false)
                }
                break
            case .inputMediaPoll(let _data):
                if boxed {
                    buffer.appendInt32(-2009448184)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.poll.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.correctAnswers!.count))
                    for item in _data.correctAnswers! {
                        serializeInt32(item, buffer: buffer, boxed: false)
                    }
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.attachedMedia!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.solution!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.solutionEntities!.count))
                    for item in _data.solutionEntities! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.solutionMedia!.serialize(buffer, true)
                }
                break
            case .inputMediaStakeDice(let _data):
                if boxed {
                    buffer.appendInt32(-207018934)
                }
                serializeString(_data.gameHash, buffer: buffer, boxed: false)
                serializeInt64(_data.tonAmount, buffer: buffer, boxed: false)
                serializeBytes(_data.clientSeed, buffer: buffer, boxed: false)
                break
            case .inputMediaStory(let _data):
                if boxed {
                    buffer.appendInt32(-1979852936)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                break
            case .inputMediaTodo(let _data):
                if boxed {
                    buffer.appendInt32(-1614454818)
                }
                _data.todo.serialize(buffer, true)
                break
            case .inputMediaUploadedDocument(let _data):
                if boxed {
                    buffer.appendInt32(58495792)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.file.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.thumb!.serialize(buffer, true)
                }
                serializeString(_data.mimeType, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.attributes.count))
                for item in _data.attributes {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.stickers!.count))
                    for item in _data.stickers! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    _data.videoCover!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    serializeInt32(_data.videoTimestamp!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.ttlSeconds!, buffer: buffer, boxed: false)
                }
                break
            case .inputMediaUploadedPhoto(let _data):
                if boxed {
                    buffer.appendInt32(2105767386)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.file.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.stickers!.count))
                    for item in _data.stickers! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.ttlSeconds!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.video!.serialize(buffer, true)
                }
                break
            case .inputMediaVenue(let _data):
                if boxed {
                    buffer.appendInt32(-1052959727)
                }
                _data.geoPoint.serialize(buffer, true)
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeString(_data.address, buffer: buffer, boxed: false)
                serializeString(_data.provider, buffer: buffer, boxed: false)
                serializeString(_data.venueId, buffer: buffer, boxed: false)
                serializeString(_data.venueType, buffer: buffer, boxed: false)
                break
            case .inputMediaWebPage(let _data):
                if boxed {
                    buffer.appendInt32(-1038383031)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.url, buffer: buffer, boxed: false)
                break
            case .inputMediaWidget(let _data):
                if boxed {
                    buffer.appendInt32(1157021774)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.width, buffer: buffer, boxed: false)
                serializeInt32(_data.height, buffer: buffer, boxed: false)
                serializeString(_data.html, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.publicData!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.chatData!, buffer: buffer, boxed: false)
                }
                break
            case .inputMediaWidgetId(let _data):
                if boxed {
                    buffer.appendInt32(2089114805)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.widgetId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.chatData!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_inputMediaContact(_ reader: BufferReader) -> InputMedia? {
            var _1: String?
            _1 = parseString(reader)
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            _3 = parseString(reader)
            var _4: String?
            _4 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.InputMedia.inputMediaContact(Cons_inputMediaContact(phoneNumber: _1!, firstName: _2!, lastName: _3!, vcard: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaDice(_ reader: BufferReader) -> InputMedia? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputMedia.inputMediaDice(Cons_inputMediaDice(emoticon: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaDocument(_ reader: BufferReader) -> InputMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.InputDocument?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.InputDocument
            }
            var _3: Api.InputPhoto?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.InputPhoto
                }
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = reader.readInt32()
            }
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _6 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.InputMedia.inputMediaDocument(Cons_inputMediaDocument(flags: _1!, id: _2!, videoCover: _3, videoTimestamp: _4, ttlSeconds: _5, query: _6))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaDocumentExternal(_ reader: BufferReader) -> InputMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Api.InputPhoto?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.InputPhoto
                }
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _5 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.InputMedia.inputMediaDocumentExternal(Cons_inputMediaDocumentExternal(flags: _1!, url: _2!, ttlSeconds: _3, videoCover: _4, videoTimestamp: _5))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaEmpty(_ reader: BufferReader) -> InputMedia? {
            return Api.InputMedia.inputMediaEmpty
        }
        static func parse_inputMediaGame(_ reader: BufferReader) -> InputMedia? {
            var _1: Api.InputGame?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputGame
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputMedia.inputMediaGame(Cons_inputMediaGame(id: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaGeoLive(_ reader: BufferReader) -> InputMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.InputGeoPoint?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.InputGeoPoint
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _5 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.InputMedia.inputMediaGeoLive(Cons_inputMediaGeoLive(flags: _1!, geoPoint: _2!, heading: _3, period: _4, proximityNotificationRadius: _5))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaGeoPoint(_ reader: BufferReader) -> InputMedia? {
            var _1: Api.InputGeoPoint?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputGeoPoint
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputMedia.inputMediaGeoPoint(Cons_inputMediaGeoPoint(geoPoint: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaInvoice(_ reader: BufferReader) -> InputMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            _3 = parseString(reader)
            var _4: Api.InputWebDocument?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.InputWebDocument
                }
            }
            var _5: Api.Invoice?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.Invoice
            }
            var _6: Buffer?
            _6 = parseBytes(reader)
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _7 = parseString(reader)
            }
            var _8: Api.DataJSON?
            if let signature = reader.readInt32() {
                _8 = Api.parse(reader, signature: signature) as? Api.DataJSON
            }
            var _9: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _9 = parseString(reader)
            }
            var _10: Api.InputMedia?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _10 = Api.parse(reader, signature: signature) as? Api.InputMedia
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _7 != nil
            let _c8 = _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _10 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 {
                return Api.InputMedia.inputMediaInvoice(Cons_inputMediaInvoice(flags: _1!, title: _2!, description: _3!, photo: _4, invoice: _5!, payload: _6!, provider: _7, providerData: _8!, startParam: _9, extendedMedia: _10))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaPaidMedia(_ reader: BufferReader) -> InputMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: [Api.InputMedia]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.InputMedia.self)
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.InputMedia.inputMediaPaidMedia(Cons_inputMediaPaidMedia(flags: _1!, starsAmount: _2!, extendedMedia: _3!, payload: _4))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaPhoto(_ reader: BufferReader) -> InputMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.InputPhoto?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.InputPhoto
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Api.InputDocument?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.InputDocument
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.InputMedia.inputMediaPhoto(Cons_inputMediaPhoto(flags: _1!, id: _2!, ttlSeconds: _3, video: _4))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaPhotoExternal(_ reader: BufferReader) -> InputMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.InputMedia.inputMediaPhotoExternal(Cons_inputMediaPhotoExternal(flags: _1!, url: _2!, ttlSeconds: _3))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaPoll(_ reader: BufferReader) -> InputMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Poll?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Poll
            }
            var _3: [Int32]?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _3 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
                }
            }
            var _4: Api.InputMedia?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.InputMedia
                }
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _5 = parseString(reader)
            }
            var _6: [Api.MessageEntity]?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let _ = reader.readInt32() {
                    _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self)
                }
            }
            var _7: Api.InputMedia?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.InputMedia
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.InputMedia.inputMediaPoll(Cons_inputMediaPoll(flags: _1!, poll: _2!, correctAnswers: _3, attachedMedia: _4, solution: _5, solutionEntities: _6, solutionMedia: _7))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaStakeDice(_ reader: BufferReader) -> InputMedia? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Buffer?
            _3 = parseBytes(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.InputMedia.inputMediaStakeDice(Cons_inputMediaStakeDice(gameHash: _1!, tonAmount: _2!, clientSeed: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaStory(_ reader: BufferReader) -> InputMedia? {
            var _1: Api.InputPeer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputPeer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.InputMedia.inputMediaStory(Cons_inputMediaStory(peer: _1!, id: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaTodo(_ reader: BufferReader) -> InputMedia? {
            var _1: Api.TodoList?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.TodoList
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputMedia.inputMediaTodo(Cons_inputMediaTodo(todo: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaUploadedDocument(_ reader: BufferReader) -> InputMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.InputFile?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.InputFile
            }
            var _3: Api.InputFile?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.InputFile
                }
            }
            var _4: String?
            _4 = parseString(reader)
            var _5: [Api.DocumentAttribute]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.DocumentAttribute.self)
            }
            var _6: [Api.InputDocument]?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.InputDocument.self)
                }
            }
            var _7: Api.InputPhoto?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.InputPhoto
                }
            }
            var _8: Int32?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                _8 = reader.readInt32()
            }
            var _9: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _9 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _9 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 {
                return Api.InputMedia.inputMediaUploadedDocument(Cons_inputMediaUploadedDocument(flags: _1!, file: _2!, thumb: _3, mimeType: _4!, attributes: _5!, stickers: _6, videoCover: _7, videoTimestamp: _8, ttlSeconds: _9))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaUploadedPhoto(_ reader: BufferReader) -> InputMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.InputFile?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.InputFile
            }
            var _3: [Api.InputDocument]?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let _ = reader.readInt32() {
                    _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.InputDocument.self)
                }
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Api.InputDocument?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.InputDocument
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.InputMedia.inputMediaUploadedPhoto(Cons_inputMediaUploadedPhoto(flags: _1!, file: _2!, stickers: _3, ttlSeconds: _4, video: _5))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaVenue(_ reader: BufferReader) -> InputMedia? {
            var _1: Api.InputGeoPoint?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputGeoPoint
            }
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
                return Api.InputMedia.inputMediaVenue(Cons_inputMediaVenue(geoPoint: _1!, title: _2!, address: _3!, provider: _4!, venueId: _5!, venueType: _6!))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaWebPage(_ reader: BufferReader) -> InputMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.InputMedia.inputMediaWebPage(Cons_inputMediaWebPage(flags: _1!, url: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaWidget(_ reader: BufferReader) -> InputMedia? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: String?
            _4 = parseString(reader)
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _5 = parseString(reader)
            }
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _6 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.InputMedia.inputMediaWidget(Cons_inputMediaWidget(flags: _1!, width: _2!, height: _3!, html: _4!, publicData: _5, chatData: _6))
            }
            else {
                return nil
            }
        }
        static func parse_inputMediaWidgetId(_ reader: BufferReader) -> InputMedia? {
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
                return Api.InputMedia.inputMediaWidgetId(Cons_inputMediaWidgetId(flags: _1!, widgetId: _2!, chatData: _3))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum InputPeer: TypeConstructorDescription {
        class Cons_inputPeerChannel: TypeConstructorDescription {
            var channelId: Int64
            var accessHash: Int64
            init(channelId: Int64, accessHash: Int64) {
                self.channelId = channelId
                self.accessHash = accessHash
            }
        }
        class Cons_inputPeerChannelFromMessage: TypeConstructorDescription {
            var peer: Api.InputPeer
            var msgId: Int32
            var channelId: Int64
            init(peer: Api.InputPeer, msgId: Int32, channelId: Int64) {
                self.peer = peer
                self.msgId = msgId
                self.channelId = channelId
            }
        }
        class Cons_inputPeerChat: TypeConstructorDescription {
            var chatId: Int64
            init(chatId: Int64) {
                self.chatId = chatId
            }
        }
        class Cons_inputPeerUser: TypeConstructorDescription {
            var userId: Int64
            var accessHash: Int64
            init(userId: Int64, accessHash: Int64) {
                self.userId = userId
                self.accessHash = accessHash
            }
        }
        class Cons_inputPeerUserFromMessage: TypeConstructorDescription {
            var peer: Api.InputPeer
            var msgId: Int32
            var userId: Int64
            init(peer: Api.InputPeer, msgId: Int32, userId: Int64) {
                self.peer = peer
                self.msgId = msgId
                self.userId = userId
            }
        }
        case inputPeerChannel(Cons_inputPeerChannel)
        case inputPeerChannelFromMessage(Cons_inputPeerChannelFromMessage)
        case inputPeerChat(Cons_inputPeerChat)
        case inputPeerEmpty
        case inputPeerSelf
        case inputPeerUser(Cons_inputPeerUser)
        case inputPeerUserFromMessage(Cons_inputPeerUserFromMessage)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputPeerChannel(let _data):
                if boxed {
                    buffer.appendInt32(666680316)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                break
            case .inputPeerChannelFromMessage(let _data):
                if boxed {
                    buffer.appendInt32(-1121318848)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                break
            case .inputPeerChat(let _data):
                if boxed {
                    buffer.appendInt32(900291769)
                }
                serializeInt64(_data.chatId, buffer: buffer, boxed: false)
                break
            case .inputPeerEmpty:
                if boxed {
                    buffer.appendInt32(2134579434)
                }
                break
            case .inputPeerSelf:
                if boxed {
                    buffer.appendInt32(2107670217)
                }
                break
            case .inputPeerUser(let _data):
                if boxed {
                    buffer.appendInt32(-571955892)
                }
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                break
            case .inputPeerUserFromMessage(let _data):
                if boxed {
                    buffer.appendInt32(-1468331492)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_inputPeerChannel(_ reader: BufferReader) -> InputPeer? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.InputPeer.inputPeerChannel(Cons_inputPeerChannel(channelId: _1!, accessHash: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_inputPeerChannelFromMessage(_ reader: BufferReader) -> InputPeer? {
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
                return Api.InputPeer.inputPeerChannelFromMessage(Cons_inputPeerChannelFromMessage(peer: _1!, msgId: _2!, channelId: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_inputPeerChat(_ reader: BufferReader) -> InputPeer? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputPeer.inputPeerChat(Cons_inputPeerChat(chatId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inputPeerEmpty(_ reader: BufferReader) -> InputPeer? {
            return Api.InputPeer.inputPeerEmpty
        }
        static func parse_inputPeerSelf(_ reader: BufferReader) -> InputPeer? {
            return Api.InputPeer.inputPeerSelf
        }
        static func parse_inputPeerUser(_ reader: BufferReader) -> InputPeer? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.InputPeer.inputPeerUser(Cons_inputPeerUser(userId: _1!, accessHash: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_inputPeerUserFromMessage(_ reader: BufferReader) -> InputPeer? {
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
                return Api.InputPeer.inputPeerUserFromMessage(Cons_inputPeerUserFromMessage(peer: _1!, msgId: _2!, userId: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum InputPhoto: TypeConstructorDescription {
        class Cons_inputPhoto: TypeConstructorDescription {
            var id: Int64
            var accessHash: Int64
            var fileReference: Buffer
            init(id: Int64, accessHash: Int64, fileReference: Buffer) {
                self.id = id
                self.accessHash = accessHash
                self.fileReference = fileReference
            }
        }
        case inputPhoto(Cons_inputPhoto)
        case inputPhotoEmpty

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputPhoto(let _data):
                if boxed {
                    buffer.appendInt32(1001634122)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeBytes(_data.fileReference, buffer: buffer, boxed: false)
                break
            case .inputPhotoEmpty:
                if boxed {
                    buffer.appendInt32(483901197)
                }
                break
            }
        }

        static func parse_inputPhoto(_ reader: BufferReader) -> InputPhoto? {
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
                return Api.InputPhoto.inputPhoto(Cons_inputPhoto(id: _1!, accessHash: _2!, fileReference: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_inputPhotoEmpty(_ reader: BufferReader) -> InputPhoto? {
            return Api.InputPhoto.inputPhotoEmpty
        }
    }
}
extension Api {
    enum InputQuickReplyShortcut: TypeConstructorDescription {
        class Cons_inputQuickReplyShortcut: TypeConstructorDescription {
            var shortcut: String
            init(shortcut: String) {
                self.shortcut = shortcut
            }
        }
        class Cons_inputQuickReplyShortcutId: TypeConstructorDescription {
            var shortcutId: Int32
            init(shortcutId: Int32) {
                self.shortcutId = shortcutId
            }
        }
        case inputQuickReplyShortcut(Cons_inputQuickReplyShortcut)
        case inputQuickReplyShortcutId(Cons_inputQuickReplyShortcutId)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputQuickReplyShortcut(let _data):
                if boxed {
                    buffer.appendInt32(609840449)
                }
                serializeString(_data.shortcut, buffer: buffer, boxed: false)
                break
            case .inputQuickReplyShortcutId(let _data):
                if boxed {
                    buffer.appendInt32(18418929)
                }
                serializeInt32(_data.shortcutId, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_inputQuickReplyShortcut(_ reader: BufferReader) -> InputQuickReplyShortcut? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputQuickReplyShortcut.inputQuickReplyShortcut(Cons_inputQuickReplyShortcut(shortcut: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inputQuickReplyShortcutId(_ reader: BufferReader) -> InputQuickReplyShortcut? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputQuickReplyShortcut.inputQuickReplyShortcutId(Cons_inputQuickReplyShortcutId(shortcutId: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum InputReplyTo: TypeConstructorDescription {
        class Cons_inputReplyToEphemeralMessage: TypeConstructorDescription {
            var id: Int32
            init(id: Int32) {
                self.id = id
            }
        }
        class Cons_inputReplyToMessage: TypeConstructorDescription {
            var flags: Int32
            var replyToMsgId: Int32
            var topMsgId: Int32?
            var replyToPeerId: Api.InputPeer?
            var quoteText: String?
            var quoteEntities: [Api.MessageEntity]?
            var quoteOffset: Int32?
            var monoforumPeerId: Api.InputPeer?
            var todoItemId: Int32?
            var pollOption: Buffer?
            var quoteRich: [Api.RichText]?
            init(flags: Int32, replyToMsgId: Int32, topMsgId: Int32?, replyToPeerId: Api.InputPeer?, quoteText: String?, quoteEntities: [Api.MessageEntity]?, quoteOffset: Int32?, monoforumPeerId: Api.InputPeer?, todoItemId: Int32?, pollOption: Buffer?, quoteRich: [Api.RichText]?) {
                self.flags = flags
                self.replyToMsgId = replyToMsgId
                self.topMsgId = topMsgId
                self.replyToPeerId = replyToPeerId
                self.quoteText = quoteText
                self.quoteEntities = quoteEntities
                self.quoteOffset = quoteOffset
                self.monoforumPeerId = monoforumPeerId
                self.todoItemId = todoItemId
                self.pollOption = pollOption
                self.quoteRich = quoteRich
            }
        }
        class Cons_inputReplyToMonoForum: TypeConstructorDescription {
            var monoforumPeerId: Api.InputPeer
            init(monoforumPeerId: Api.InputPeer) {
                self.monoforumPeerId = monoforumPeerId
            }
        }
        class Cons_inputReplyToStory: TypeConstructorDescription {
            var peer: Api.InputPeer
            var storyId: Int32
            init(peer: Api.InputPeer, storyId: Int32) {
                self.peer = peer
                self.storyId = storyId
            }
        }
        case inputReplyToEphemeralMessage(Cons_inputReplyToEphemeralMessage)
        case inputReplyToMessage(Cons_inputReplyToMessage)
        case inputReplyToMonoForum(Cons_inputReplyToMonoForum)
        case inputReplyToStory(Cons_inputReplyToStory)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputReplyToEphemeralMessage(let _data):
                if boxed {
                    buffer.appendInt32(1092204894)
                }
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                break
            case .inputReplyToMessage(let _data):
                if boxed {
                    buffer.appendInt32(1975627120)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.replyToMsgId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.topMsgId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.replyToPeerId!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.quoteText!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.quoteEntities!.count))
                    for item in _data.quoteEntities! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.quoteOffset!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    _data.monoforumPeerId!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    serializeInt32(_data.todoItemId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    serializeBytes(_data.pollOption!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.quoteRich!.count))
                    for item in _data.quoteRich! {
                        item.serialize(buffer, true)
                    }
                }
                break
            case .inputReplyToMonoForum(let _data):
                if boxed {
                    buffer.appendInt32(1775660101)
                }
                _data.monoforumPeerId.serialize(buffer, true)
                break
            case .inputReplyToStory(let _data):
                if boxed {
                    buffer.appendInt32(1484862010)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.storyId, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_inputReplyToEphemeralMessage(_ reader: BufferReader) -> InputReplyTo? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputReplyTo.inputReplyToEphemeralMessage(Cons_inputReplyToEphemeralMessage(id: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inputReplyToMessage(_ reader: BufferReader) -> InputReplyTo? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Api.InputPeer?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.InputPeer
                }
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _5 = parseString(reader)
            }
            var _6: [Api.MessageEntity]?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let _ = reader.readInt32() {
                    _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self)
                }
            }
            var _7: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _7 = reader.readInt32()
            }
            var _8: Api.InputPeer?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.InputPeer
                }
            }
            var _9: Int32?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                _9 = reader.readInt32()
            }
            var _10: Buffer?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                _10 = parseBytes(reader)
            }
            var _11: [Api.RichText]?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                if let _ = reader.readInt32() {
                    _11 = Api.parseVector(reader, elementSignature: 0, elementType: Api.RichText.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _11 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 {
                return Api.InputReplyTo.inputReplyToMessage(Cons_inputReplyToMessage(flags: _1!, replyToMsgId: _2!, topMsgId: _3, replyToPeerId: _4, quoteText: _5, quoteEntities: _6, quoteOffset: _7, monoforumPeerId: _8, todoItemId: _9, pollOption: _10, quoteRich: _11))
            }
            else {
                return nil
            }
        }
        static func parse_inputReplyToMonoForum(_ reader: BufferReader) -> InputReplyTo? {
            var _1: Api.InputPeer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputPeer
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.InputReplyTo.inputReplyToMonoForum(Cons_inputReplyToMonoForum(monoforumPeerId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_inputReplyToStory(_ reader: BufferReader) -> InputReplyTo? {
            var _1: Api.InputPeer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputPeer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.InputReplyTo.inputReplyToStory(Cons_inputReplyToStory(peer: _1!, storyId: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum InputRichFile: TypeConstructorDescription {
        class Cons_inputRichFileDocument: TypeConstructorDescription {
            var id: String
            var document: Api.InputDocument
            init(id: String, document: Api.InputDocument) {
                self.id = id
                self.document = document
            }
        }
        class Cons_inputRichFilePhoto: TypeConstructorDescription {
            var id: String
            var photo: Api.InputPhoto
            init(id: String, photo: Api.InputPhoto) {
                self.id = id
                self.photo = photo
            }
        }
        case inputRichFileDocument(Cons_inputRichFileDocument)
        case inputRichFilePhoto(Cons_inputRichFilePhoto)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputRichFileDocument(let _data):
                if boxed {
                    buffer.appendInt32(-2094522947)
                }
                serializeString(_data.id, buffer: buffer, boxed: false)
                _data.document.serialize(buffer, true)
                break
            case .inputRichFilePhoto(let _data):
                if boxed {
                    buffer.appendInt32(-1694473685)
                }
                serializeString(_data.id, buffer: buffer, boxed: false)
                _data.photo.serialize(buffer, true)
                break
            }
        }

        static func parse_inputRichFileDocument(_ reader: BufferReader) -> InputRichFile? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Api.InputDocument?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.InputDocument
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.InputRichFile.inputRichFileDocument(Cons_inputRichFileDocument(id: _1!, document: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_inputRichFilePhoto(_ reader: BufferReader) -> InputRichFile? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Api.InputPhoto?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.InputPhoto
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.InputRichFile.inputRichFilePhoto(Cons_inputRichFilePhoto(id: _1!, photo: _2!))
            }
            else {
                return nil
            }
        }
    }
}
