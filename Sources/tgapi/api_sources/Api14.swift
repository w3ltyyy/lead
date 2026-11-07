extension Api {
    enum NotificationSound: TypeConstructorDescription {
        class Cons_notificationSoundLocal: TypeConstructorDescription {
            var title: String
            var data: String
            init(title: String, data: String) {
                self.title = title
                self.data = data
            }
        }
        class Cons_notificationSoundRingtone: TypeConstructorDescription {
            var id: Int64
            init(id: Int64) {
                self.id = id
            }
        }
        case notificationSoundDefault
        case notificationSoundLocal(Cons_notificationSoundLocal)
        case notificationSoundNone
        case notificationSoundRingtone(Cons_notificationSoundRingtone)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .notificationSoundDefault:
                if boxed {
                    buffer.appendInt32(-1746354498)
                }
                break
            case .notificationSoundLocal(let _data):
                if boxed {
                    buffer.appendInt32(-2096391452)
                }
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeString(_data.data, buffer: buffer, boxed: false)
                break
            case .notificationSoundNone:
                if boxed {
                    buffer.appendInt32(1863070943)
                }
                break
            case .notificationSoundRingtone(let _data):
                if boxed {
                    buffer.appendInt32(-9666487)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_notificationSoundDefault(_ reader: BufferReader) -> NotificationSound? {
            return Api.NotificationSound.notificationSoundDefault
        }
        static func parse_notificationSoundLocal(_ reader: BufferReader) -> NotificationSound? {
            var _1: String?
            _1 = parseString(reader)
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.NotificationSound.notificationSoundLocal(Cons_notificationSoundLocal(title: _1!, data: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_notificationSoundNone(_ reader: BufferReader) -> NotificationSound? {
            return Api.NotificationSound.notificationSoundNone
        }
        static func parse_notificationSoundRingtone(_ reader: BufferReader) -> NotificationSound? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.NotificationSound.notificationSoundRingtone(Cons_notificationSoundRingtone(id: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum NotifyPeer: TypeConstructorDescription {
        class Cons_notifyCommunity: TypeConstructorDescription {
            var communityId: Int64
            init(communityId: Int64) {
                self.communityId = communityId
            }
        }
        class Cons_notifyForumTopic: TypeConstructorDescription {
            var peer: Api.Peer
            var topMsgId: Int32
            init(peer: Api.Peer, topMsgId: Int32) {
                self.peer = peer
                self.topMsgId = topMsgId
            }
        }
        class Cons_notifyPeer: TypeConstructorDescription {
            var peer: Api.Peer
            init(peer: Api.Peer) {
                self.peer = peer
            }
        }
        case notifyBroadcasts
        case notifyChats
        case notifyCommunity(Cons_notifyCommunity)
        case notifyForumTopic(Cons_notifyForumTopic)
        case notifyPeer(Cons_notifyPeer)
        case notifyUsers

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .notifyBroadcasts:
                if boxed {
                    buffer.appendInt32(-703403793)
                }
                break
            case .notifyChats:
                if boxed {
                    buffer.appendInt32(-1073230141)
                }
                break
            case .notifyCommunity(let _data):
                if boxed {
                    buffer.appendInt32(-1103664743)
                }
                serializeInt64(_data.communityId, buffer: buffer, boxed: false)
                break
            case .notifyForumTopic(let _data):
                if boxed {
                    buffer.appendInt32(577659656)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.topMsgId, buffer: buffer, boxed: false)
                break
            case .notifyPeer(let _data):
                if boxed {
                    buffer.appendInt32(-1613493288)
                }
                _data.peer.serialize(buffer, true)
                break
            case .notifyUsers:
                if boxed {
                    buffer.appendInt32(-1261946036)
                }
                break
            }
        }

        static func parse_notifyBroadcasts(_ reader: BufferReader) -> NotifyPeer? {
            return Api.NotifyPeer.notifyBroadcasts
        }
        static func parse_notifyChats(_ reader: BufferReader) -> NotifyPeer? {
            return Api.NotifyPeer.notifyChats
        }
        static func parse_notifyCommunity(_ reader: BufferReader) -> NotifyPeer? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.NotifyPeer.notifyCommunity(Cons_notifyCommunity(communityId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_notifyForumTopic(_ reader: BufferReader) -> NotifyPeer? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.NotifyPeer.notifyForumTopic(Cons_notifyForumTopic(peer: _1!, topMsgId: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_notifyPeer(_ reader: BufferReader) -> NotifyPeer? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.NotifyPeer.notifyPeer(Cons_notifyPeer(peer: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_notifyUsers(_ reader: BufferReader) -> NotifyPeer? {
            return Api.NotifyPeer.notifyUsers
        }
    }
}
extension Api {
    enum Page: TypeConstructorDescription {
        class Cons_page: TypeConstructorDescription {
            var flags: Int32
            var url: String
            var blocks: [Api.PageBlock]
            var photos: [Api.Photo]
            var documents: [Api.Document]
            var views: Int32?
            init(flags: Int32, url: String, blocks: [Api.PageBlock], photos: [Api.Photo], documents: [Api.Document], views: Int32?) {
                self.flags = flags
                self.url = url
                self.blocks = blocks
                self.photos = photos
                self.documents = documents
                self.views = views
            }
        }
        case page(Cons_page)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .page(let _data):
                if boxed {
                    buffer.appendInt32(-1738178803)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.url, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.blocks.count))
                for item in _data.blocks {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.photos.count))
                for item in _data.photos {
                    item.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.documents.count))
                for item in _data.documents {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.views!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_page(_ reader: BufferReader) -> Page? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: [Api.PageBlock]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageBlock.self)
            }
            var _4: [Api.Photo]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Photo.self)
            }
            var _5: [Api.Document]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Document.self)
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _6 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _6 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 {
                return Api.Page.page(Cons_page(flags: _1!, url: _2!, blocks: _3!, photos: _4!, documents: _5!, views: _6))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum PageBlock: TypeConstructorDescription {
        class Cons_inputPageBlockMap: TypeConstructorDescription {
            var geo: Api.InputGeoPoint
            var zoom: Int32
            var w: Int32
            var h: Int32
            var caption: Api.PageCaption
            init(geo: Api.InputGeoPoint, zoom: Int32, w: Int32, h: Int32, caption: Api.PageCaption) {
                self.geo = geo
                self.zoom = zoom
                self.w = w
                self.h = h
                self.caption = caption
            }
        }
        class Cons_pageBlockAnchor: TypeConstructorDescription {
            var name: String
            init(name: String) {
                self.name = name
            }
        }
        class Cons_pageBlockAudio: TypeConstructorDescription {
            var audioId: Int64
            var caption: Api.PageCaption
            init(audioId: Int64, caption: Api.PageCaption) {
                self.audioId = audioId
                self.caption = caption
            }
        }
        class Cons_pageBlockAuthorDate: TypeConstructorDescription {
            var author: Api.RichText
            var publishedDate: Int32
            init(author: Api.RichText, publishedDate: Int32) {
                self.author = author
                self.publishedDate = publishedDate
            }
        }
        class Cons_pageBlockBlockquote: TypeConstructorDescription {
            var flags: Int32
            var text: Api.RichText
            var caption: Api.RichText
            init(flags: Int32, text: Api.RichText, caption: Api.RichText) {
                self.flags = flags
                self.text = text
                self.caption = caption
            }
        }
        class Cons_pageBlockBlockquoteBlocks: TypeConstructorDescription {
            var blocks: [Api.PageBlock]
            var caption: Api.RichText
            init(blocks: [Api.PageBlock], caption: Api.RichText) {
                self.blocks = blocks
                self.caption = caption
            }
        }
        class Cons_pageBlockButtonRow: TypeConstructorDescription {
            var flags: Int32
            var buttons: [Api.PageButton]
            init(flags: Int32, buttons: [Api.PageButton]) {
                self.flags = flags
                self.buttons = buttons
            }
        }
        class Cons_pageBlockChannel: TypeConstructorDescription {
            var channel: Api.Chat
            init(channel: Api.Chat) {
                self.channel = channel
            }
        }
        class Cons_pageBlockCollage: TypeConstructorDescription {
            var items: [Api.PageBlock]
            var caption: Api.PageCaption
            init(items: [Api.PageBlock], caption: Api.PageCaption) {
                self.items = items
                self.caption = caption
            }
        }
        class Cons_pageBlockCover: TypeConstructorDescription {
            var cover: Api.PageBlock
            init(cover: Api.PageBlock) {
                self.cover = cover
            }
        }
        class Cons_pageBlockDetails: TypeConstructorDescription {
            var flags: Int32
            var blocks: [Api.PageBlock]
            var title: Api.RichText
            init(flags: Int32, blocks: [Api.PageBlock], title: Api.RichText) {
                self.flags = flags
                self.blocks = blocks
                self.title = title
            }
        }
        class Cons_pageBlockDocument: TypeConstructorDescription {
            var documentId: Int64
            var caption: Api.PageCaption
            init(documentId: Int64, caption: Api.PageCaption) {
                self.documentId = documentId
                self.caption = caption
            }
        }
        class Cons_pageBlockEmbed: TypeConstructorDescription {
            var flags: Int32
            var url: String?
            var html: String?
            var posterPhotoId: Int64?
            var w: Int32?
            var h: Int32?
            var caption: Api.PageCaption
            init(flags: Int32, url: String?, html: String?, posterPhotoId: Int64?, w: Int32?, h: Int32?, caption: Api.PageCaption) {
                self.flags = flags
                self.url = url
                self.html = html
                self.posterPhotoId = posterPhotoId
                self.w = w
                self.h = h
                self.caption = caption
            }
        }
        class Cons_pageBlockEmbedPost: TypeConstructorDescription {
            var url: String
            var webpageId: Int64
            var authorPhotoId: Int64
            var author: String
            var date: Int32
            var blocks: [Api.PageBlock]
            var caption: Api.PageCaption
            init(url: String, webpageId: Int64, authorPhotoId: Int64, author: String, date: Int32, blocks: [Api.PageBlock], caption: Api.PageCaption) {
                self.url = url
                self.webpageId = webpageId
                self.authorPhotoId = authorPhotoId
                self.author = author
                self.date = date
                self.blocks = blocks
                self.caption = caption
            }
        }
        class Cons_pageBlockFooter: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_pageBlockHeader: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_pageBlockHeading1: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_pageBlockHeading2: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_pageBlockHeading3: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_pageBlockHeading4: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_pageBlockHeading5: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_pageBlockHeading6: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_pageBlockKicker: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_pageBlockList: TypeConstructorDescription {
            var items: [Api.PageListItem]
            init(items: [Api.PageListItem]) {
                self.items = items
            }
        }
        class Cons_pageBlockMap: TypeConstructorDescription {
            var geo: Api.GeoPoint
            var zoom: Int32
            var w: Int32
            var h: Int32
            var caption: Api.PageCaption
            init(geo: Api.GeoPoint, zoom: Int32, w: Int32, h: Int32, caption: Api.PageCaption) {
                self.geo = geo
                self.zoom = zoom
                self.w = w
                self.h = h
                self.caption = caption
            }
        }
        class Cons_pageBlockMath: TypeConstructorDescription {
            var source: String
            init(source: String) {
                self.source = source
            }
        }
        class Cons_pageBlockOrderedList: TypeConstructorDescription {
            var flags: Int32
            var items: [Api.PageListOrderedItem]
            var start: Int32?
            var type: String?
            init(flags: Int32, items: [Api.PageListOrderedItem], start: Int32?, type: String?) {
                self.flags = flags
                self.items = items
                self.start = start
                self.type = type
            }
        }
        class Cons_pageBlockParagraph: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_pageBlockPhoto: TypeConstructorDescription {
            var flags: Int32
            var photoId: Int64
            var caption: Api.PageCaption
            var url: String?
            var webpageId: Int64?
            init(flags: Int32, photoId: Int64, caption: Api.PageCaption, url: String?, webpageId: Int64?) {
                self.flags = flags
                self.photoId = photoId
                self.caption = caption
                self.url = url
                self.webpageId = webpageId
            }
        }
        class Cons_pageBlockPreformatted: TypeConstructorDescription {
            var text: Api.RichText
            var language: String
            init(text: Api.RichText, language: String) {
                self.text = text
                self.language = language
            }
        }
        class Cons_pageBlockPullquote: TypeConstructorDescription {
            var text: Api.RichText
            var caption: Api.RichText
            init(text: Api.RichText, caption: Api.RichText) {
                self.text = text
                self.caption = caption
            }
        }
        class Cons_pageBlockRelatedArticles: TypeConstructorDescription {
            var title: Api.RichText
            var articles: [Api.PageRelatedArticle]
            init(title: Api.RichText, articles: [Api.PageRelatedArticle]) {
                self.title = title
                self.articles = articles
            }
        }
        class Cons_pageBlockSlideshow: TypeConstructorDescription {
            var items: [Api.PageBlock]
            var caption: Api.PageCaption
            init(items: [Api.PageBlock], caption: Api.PageCaption) {
                self.items = items
                self.caption = caption
            }
        }
        class Cons_pageBlockSubheader: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_pageBlockSubtitle: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_pageBlockTable: TypeConstructorDescription {
            var flags: Int32
            var title: Api.RichText
            var rows: [Api.PageTableRow]
            init(flags: Int32, title: Api.RichText, rows: [Api.PageTableRow]) {
                self.flags = flags
                self.title = title
                self.rows = rows
            }
        }
        class Cons_pageBlockThinking: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_pageBlockTitle: TypeConstructorDescription {
            var text: Api.RichText
            init(text: Api.RichText) {
                self.text = text
            }
        }
        class Cons_pageBlockVideo: TypeConstructorDescription {
            var flags: Int32
            var videoId: Int64
            var caption: Api.PageCaption
            init(flags: Int32, videoId: Int64, caption: Api.PageCaption) {
                self.flags = flags
                self.videoId = videoId
                self.caption = caption
            }
        }
        case inputPageBlockMap(Cons_inputPageBlockMap)
        case pageBlockAnchor(Cons_pageBlockAnchor)
        case pageBlockAudio(Cons_pageBlockAudio)
        case pageBlockAuthorDate(Cons_pageBlockAuthorDate)
        case pageBlockBlockquote(Cons_pageBlockBlockquote)
        case pageBlockBlockquoteBlocks(Cons_pageBlockBlockquoteBlocks)
        case pageBlockButtonRow(Cons_pageBlockButtonRow)
        case pageBlockChannel(Cons_pageBlockChannel)
        case pageBlockCollage(Cons_pageBlockCollage)
        case pageBlockCover(Cons_pageBlockCover)
        case pageBlockDetails(Cons_pageBlockDetails)
        case pageBlockDivider
        case pageBlockDocument(Cons_pageBlockDocument)
        case pageBlockEmbed(Cons_pageBlockEmbed)
        case pageBlockEmbedPost(Cons_pageBlockEmbedPost)
        case pageBlockFooter(Cons_pageBlockFooter)
        case pageBlockHeader(Cons_pageBlockHeader)
        case pageBlockHeading1(Cons_pageBlockHeading1)
        case pageBlockHeading2(Cons_pageBlockHeading2)
        case pageBlockHeading3(Cons_pageBlockHeading3)
        case pageBlockHeading4(Cons_pageBlockHeading4)
        case pageBlockHeading5(Cons_pageBlockHeading5)
        case pageBlockHeading6(Cons_pageBlockHeading6)
        case pageBlockKicker(Cons_pageBlockKicker)
        case pageBlockList(Cons_pageBlockList)
        case pageBlockMap(Cons_pageBlockMap)
        case pageBlockMath(Cons_pageBlockMath)
        case pageBlockOrderedList(Cons_pageBlockOrderedList)
        case pageBlockParagraph(Cons_pageBlockParagraph)
        case pageBlockPhoto(Cons_pageBlockPhoto)
        case pageBlockPreformatted(Cons_pageBlockPreformatted)
        case pageBlockPullquote(Cons_pageBlockPullquote)
        case pageBlockRelatedArticles(Cons_pageBlockRelatedArticles)
        case pageBlockSlideshow(Cons_pageBlockSlideshow)
        case pageBlockSubheader(Cons_pageBlockSubheader)
        case pageBlockSubtitle(Cons_pageBlockSubtitle)
        case pageBlockTable(Cons_pageBlockTable)
        case pageBlockThinking(Cons_pageBlockThinking)
        case pageBlockTitle(Cons_pageBlockTitle)
        case pageBlockUnsupported
        case pageBlockVideo(Cons_pageBlockVideo)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputPageBlockMap(let _data):
                if boxed {
                    buffer.appendInt32(1464557951)
                }
                _data.geo.serialize(buffer, true)
                serializeInt32(_data.zoom, buffer: buffer, boxed: false)
                serializeInt32(_data.w, buffer: buffer, boxed: false)
                serializeInt32(_data.h, buffer: buffer, boxed: false)
                _data.caption.serialize(buffer, true)
                break
            case .pageBlockAnchor(let _data):
                if boxed {
                    buffer.appendInt32(-837994576)
                }
                serializeString(_data.name, buffer: buffer, boxed: false)
                break
            case .pageBlockAudio(let _data):
                if boxed {
                    buffer.appendInt32(-2143067670)
                }
                serializeInt64(_data.audioId, buffer: buffer, boxed: false)
                _data.caption.serialize(buffer, true)
                break
            case .pageBlockAuthorDate(let _data):
                if boxed {
                    buffer.appendInt32(-1162877472)
                }
                _data.author.serialize(buffer, true)
                serializeInt32(_data.publishedDate, buffer: buffer, boxed: false)
                break
            case .pageBlockBlockquote(let _data):
                if boxed {
                    buffer.appendInt32(1724999435)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.text.serialize(buffer, true)
                _data.caption.serialize(buffer, true)
                break
            case .pageBlockBlockquoteBlocks(let _data):
                if boxed {
                    buffer.appendInt32(242108356)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.blocks.count))
                for item in _data.blocks {
                    item.serialize(buffer, true)
                }
                _data.caption.serialize(buffer, true)
                break
            case .pageBlockButtonRow(let _data):
                if boxed {
                    buffer.appendInt32(1835270936)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.buttons.count))
                for item in _data.buttons {
                    item.serialize(buffer, true)
                }
                break
            case .pageBlockChannel(let _data):
                if boxed {
                    buffer.appendInt32(-283684427)
                }
                _data.channel.serialize(buffer, true)
                break
            case .pageBlockCollage(let _data):
                if boxed {
                    buffer.appendInt32(1705048653)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.items.count))
                for item in _data.items {
                    item.serialize(buffer, true)
                }
                _data.caption.serialize(buffer, true)
                break
            case .pageBlockCover(let _data):
                if boxed {
                    buffer.appendInt32(972174080)
                }
                _data.cover.serialize(buffer, true)
                break
            case .pageBlockDetails(let _data):
                if boxed {
                    buffer.appendInt32(1987480557)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.blocks.count))
                for item in _data.blocks {
                    item.serialize(buffer, true)
                }
                _data.title.serialize(buffer, true)
                break
            case .pageBlockDivider:
                if boxed {
                    buffer.appendInt32(-618614392)
                }
                break
            case .pageBlockDocument(let _data):
                if boxed {
                    buffer.appendInt32(955923363)
                }
                serializeInt64(_data.documentId, buffer: buffer, boxed: false)
                _data.caption.serialize(buffer, true)
                break
            case .pageBlockEmbed(let _data):
                if boxed {
                    buffer.appendInt32(-1468953147)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.url!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.html!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt64(_data.posterPhotoId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeInt32(_data.w!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeInt32(_data.h!, buffer: buffer, boxed: false)
                }
                _data.caption.serialize(buffer, true)
                break
            case .pageBlockEmbedPost(let _data):
                if boxed {
                    buffer.appendInt32(-229005301)
                }
                serializeString(_data.url, buffer: buffer, boxed: false)
                serializeInt64(_data.webpageId, buffer: buffer, boxed: false)
                serializeInt64(_data.authorPhotoId, buffer: buffer, boxed: false)
                serializeString(_data.author, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.blocks.count))
                for item in _data.blocks {
                    item.serialize(buffer, true)
                }
                _data.caption.serialize(buffer, true)
                break
            case .pageBlockFooter(let _data):
                if boxed {
                    buffer.appendInt32(1216809369)
                }
                _data.text.serialize(buffer, true)
                break
            case .pageBlockHeader(let _data):
                if boxed {
                    buffer.appendInt32(-1076861716)
                }
                _data.text.serialize(buffer, true)
                break
            case .pageBlockHeading1(let _data):
                if boxed {
                    buffer.appendInt32(-1157691601)
                }
                _data.text.serialize(buffer, true)
                break
            case .pageBlockHeading2(let _data):
                if boxed {
                    buffer.appendInt32(158018284)
                }
                _data.text.serialize(buffer, true)
                break
            case .pageBlockHeading3(let _data):
                if boxed {
                    buffer.appendInt32(1743204781)
                }
                _data.text.serialize(buffer, true)
                break
            case .pageBlockHeading4(let _data):
                if boxed {
                    buffer.appendInt32(-1254983893)
                }
                _data.text.serialize(buffer, true)
                break
            case .pageBlockHeading5(let _data):
                if boxed {
                    buffer.appendInt32(-608277398)
                }
                _data.text.serialize(buffer, true)
                break
            case .pageBlockHeading6(let _data):
                if boxed {
                    buffer.appendInt32(1747599785)
                }
                _data.text.serialize(buffer, true)
                break
            case .pageBlockKicker(let _data):
                if boxed {
                    buffer.appendInt32(504660880)
                }
                _data.text.serialize(buffer, true)
                break
            case .pageBlockList(let _data):
                if boxed {
                    buffer.appendInt32(-454524911)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.items.count))
                for item in _data.items {
                    item.serialize(buffer, true)
                }
                break
            case .pageBlockMap(let _data):
                if boxed {
                    buffer.appendInt32(-1538310410)
                }
                _data.geo.serialize(buffer, true)
                serializeInt32(_data.zoom, buffer: buffer, boxed: false)
                serializeInt32(_data.w, buffer: buffer, boxed: false)
                serializeInt32(_data.h, buffer: buffer, boxed: false)
                _data.caption.serialize(buffer, true)
                break
            case .pageBlockMath(let _data):
                if boxed {
                    buffer.appendInt32(1493699616)
                }
                serializeString(_data.source, buffer: buffer, boxed: false)
                break
            case .pageBlockOrderedList(let _data):
                if boxed {
                    buffer.appendInt32(534181569)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.items.count))
                for item in _data.items {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.start!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.type!, buffer: buffer, boxed: false)
                }
                break
            case .pageBlockParagraph(let _data):
                if boxed {
                    buffer.appendInt32(1182402406)
                }
                _data.text.serialize(buffer, true)
                break
            case .pageBlockPhoto(let _data):
                if boxed {
                    buffer.appendInt32(391759200)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.photoId, buffer: buffer, boxed: false)
                _data.caption.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.url!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt64(_data.webpageId!, buffer: buffer, boxed: false)
                }
                break
            case .pageBlockPreformatted(let _data):
                if boxed {
                    buffer.appendInt32(-1066346178)
                }
                _data.text.serialize(buffer, true)
                serializeString(_data.language, buffer: buffer, boxed: false)
                break
            case .pageBlockPullquote(let _data):
                if boxed {
                    buffer.appendInt32(1329878739)
                }
                _data.text.serialize(buffer, true)
                _data.caption.serialize(buffer, true)
                break
            case .pageBlockRelatedArticles(let _data):
                if boxed {
                    buffer.appendInt32(370236054)
                }
                _data.title.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.articles.count))
                for item in _data.articles {
                    item.serialize(buffer, true)
                }
                break
            case .pageBlockSlideshow(let _data):
                if boxed {
                    buffer.appendInt32(52401552)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.items.count))
                for item in _data.items {
                    item.serialize(buffer, true)
                }
                _data.caption.serialize(buffer, true)
                break
            case .pageBlockSubheader(let _data):
                if boxed {
                    buffer.appendInt32(-248793375)
                }
                _data.text.serialize(buffer, true)
                break
            case .pageBlockSubtitle(let _data):
                if boxed {
                    buffer.appendInt32(-1879401953)
                }
                _data.text.serialize(buffer, true)
                break
            case .pageBlockTable(let _data):
                if boxed {
                    buffer.appendInt32(-1085412734)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.title.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.rows.count))
                for item in _data.rows {
                    item.serialize(buffer, true)
                }
                break
            case .pageBlockThinking(let _data):
                if boxed {
                    buffer.appendInt32(1009361890)
                }
                _data.text.serialize(buffer, true)
                break
            case .pageBlockTitle(let _data):
                if boxed {
                    buffer.appendInt32(1890305021)
                }
                _data.text.serialize(buffer, true)
                break
            case .pageBlockUnsupported:
                if boxed {
                    buffer.appendInt32(324435594)
                }
                break
            case .pageBlockVideo(let _data):
                if boxed {
                    buffer.appendInt32(2089805750)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.videoId, buffer: buffer, boxed: false)
                _data.caption.serialize(buffer, true)
                break
            }
        }

        static func parse_inputPageBlockMap(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.InputGeoPoint?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputGeoPoint
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Api.PageCaption?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.PageCaption
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.PageBlock.inputPageBlockMap(Cons_inputPageBlockMap(geo: _1!, zoom: _2!, w: _3!, h: _4!, caption: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockAnchor(_ reader: BufferReader) -> PageBlock? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockAnchor(Cons_pageBlockAnchor(name: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockAudio(_ reader: BufferReader) -> PageBlock? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Api.PageCaption?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.PageCaption
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PageBlock.pageBlockAudio(Cons_pageBlockAudio(audioId: _1!, caption: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockAuthorDate(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PageBlock.pageBlockAuthorDate(Cons_pageBlockAuthorDate(author: _1!, publishedDate: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockBlockquote(_ reader: BufferReader) -> PageBlock? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.RichText?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            var _3: Api.RichText?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.PageBlock.pageBlockBlockquote(Cons_pageBlockBlockquote(flags: _1!, text: _2!, caption: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockBlockquoteBlocks(_ reader: BufferReader) -> PageBlock? {
            var _1: [Api.PageBlock]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageBlock.self)
            }
            var _2: Api.RichText?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PageBlock.pageBlockBlockquoteBlocks(Cons_pageBlockBlockquoteBlocks(blocks: _1!, caption: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockButtonRow(_ reader: BufferReader) -> PageBlock? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.PageButton]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageButton.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PageBlock.pageBlockButtonRow(Cons_pageBlockButtonRow(flags: _1!, buttons: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockChannel(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.Chat?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Chat
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockChannel(Cons_pageBlockChannel(channel: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockCollage(_ reader: BufferReader) -> PageBlock? {
            var _1: [Api.PageBlock]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageBlock.self)
            }
            var _2: Api.PageCaption?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.PageCaption
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PageBlock.pageBlockCollage(Cons_pageBlockCollage(items: _1!, caption: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockCover(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.PageBlock?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.PageBlock
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockCover(Cons_pageBlockCover(cover: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockDetails(_ reader: BufferReader) -> PageBlock? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.PageBlock]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageBlock.self)
            }
            var _3: Api.RichText?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.PageBlock.pageBlockDetails(Cons_pageBlockDetails(flags: _1!, blocks: _2!, title: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockDivider(_ reader: BufferReader) -> PageBlock? {
            return Api.PageBlock.pageBlockDivider
        }
        static func parse_pageBlockDocument(_ reader: BufferReader) -> PageBlock? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Api.PageCaption?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.PageCaption
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PageBlock.pageBlockDocument(Cons_pageBlockDocument(documentId: _1!, caption: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockEmbed(_ reader: BufferReader) -> PageBlock? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _2 = parseString(reader)
            }
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _3 = parseString(reader)
            }
            var _4: Int64?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _4 = reader.readInt64()
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _5 = reader.readInt32()
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _6 = reader.readInt32()
            }
            var _7: Api.PageCaption?
            if let signature = reader.readInt32() {
                _7 = Api.parse(reader, signature: signature) as? Api.PageCaption
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _6 != nil
            let _c7 = _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.PageBlock.pageBlockEmbed(Cons_pageBlockEmbed(flags: _1!, url: _2, html: _3, posterPhotoId: _4, w: _5, h: _6, caption: _7!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockEmbedPost(_ reader: BufferReader) -> PageBlock? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: String?
            _4 = parseString(reader)
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: [Api.PageBlock]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageBlock.self)
            }
            var _7: Api.PageCaption?
            if let signature = reader.readInt32() {
                _7 = Api.parse(reader, signature: signature) as? Api.PageCaption
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.PageBlock.pageBlockEmbedPost(Cons_pageBlockEmbedPost(url: _1!, webpageId: _2!, authorPhotoId: _3!, author: _4!, date: _5!, blocks: _6!, caption: _7!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockFooter(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockFooter(Cons_pageBlockFooter(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockHeader(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockHeader(Cons_pageBlockHeader(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockHeading1(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockHeading1(Cons_pageBlockHeading1(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockHeading2(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockHeading2(Cons_pageBlockHeading2(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockHeading3(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockHeading3(Cons_pageBlockHeading3(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockHeading4(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockHeading4(Cons_pageBlockHeading4(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockHeading5(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockHeading5(Cons_pageBlockHeading5(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockHeading6(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockHeading6(Cons_pageBlockHeading6(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockKicker(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockKicker(Cons_pageBlockKicker(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockList(_ reader: BufferReader) -> PageBlock? {
            var _1: [Api.PageListItem]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageListItem.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockList(Cons_pageBlockList(items: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockMap(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.GeoPoint?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.GeoPoint
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Api.PageCaption?
            if let signature = reader.readInt32() {
                _5 = Api.parse(reader, signature: signature) as? Api.PageCaption
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.PageBlock.pageBlockMap(Cons_pageBlockMap(geo: _1!, zoom: _2!, w: _3!, h: _4!, caption: _5!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockMath(_ reader: BufferReader) -> PageBlock? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockMath(Cons_pageBlockMath(source: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockOrderedList(_ reader: BufferReader) -> PageBlock? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.PageListOrderedItem]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageListOrderedItem.self)
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _4 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.PageBlock.pageBlockOrderedList(Cons_pageBlockOrderedList(flags: _1!, items: _2!, start: _3, type: _4))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockParagraph(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockParagraph(Cons_pageBlockParagraph(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockPhoto(_ reader: BufferReader) -> PageBlock? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.PageCaption?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.PageCaption
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            var _5: Int64?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = reader.readInt64()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.PageBlock.pageBlockPhoto(Cons_pageBlockPhoto(flags: _1!, photoId: _2!, caption: _3!, url: _4, webpageId: _5))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockPreformatted(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PageBlock.pageBlockPreformatted(Cons_pageBlockPreformatted(text: _1!, language: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockPullquote(_ reader: BufferReader) -> PageBlock? {
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
                return Api.PageBlock.pageBlockPullquote(Cons_pageBlockPullquote(text: _1!, caption: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockRelatedArticles(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            var _2: [Api.PageRelatedArticle]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageRelatedArticle.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PageBlock.pageBlockRelatedArticles(Cons_pageBlockRelatedArticles(title: _1!, articles: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockSlideshow(_ reader: BufferReader) -> PageBlock? {
            var _1: [Api.PageBlock]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageBlock.self)
            }
            var _2: Api.PageCaption?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.PageCaption
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PageBlock.pageBlockSlideshow(Cons_pageBlockSlideshow(items: _1!, caption: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockSubheader(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockSubheader(Cons_pageBlockSubheader(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockSubtitle(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockSubtitle(Cons_pageBlockSubtitle(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockTable(_ reader: BufferReader) -> PageBlock? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.RichText?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            var _3: [Api.PageTableRow]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageTableRow.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.PageBlock.pageBlockTable(Cons_pageBlockTable(flags: _1!, title: _2!, rows: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockThinking(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockThinking(Cons_pageBlockThinking(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockTitle(_ reader: BufferReader) -> PageBlock? {
            var _1: Api.RichText?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageBlock.pageBlockTitle(Cons_pageBlockTitle(text: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_pageBlockUnsupported(_ reader: BufferReader) -> PageBlock? {
            return Api.PageBlock.pageBlockUnsupported
        }
        static func parse_pageBlockVideo(_ reader: BufferReader) -> PageBlock? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.PageCaption?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.PageCaption
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.PageBlock.pageBlockVideo(Cons_pageBlockVideo(flags: _1!, videoId: _2!, caption: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum PageButton: TypeConstructorDescription {
        class Cons_pageButton: TypeConstructorDescription {
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
        case pageButton(Cons_pageButton)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .pageButton(let _data):
                if boxed {
                    buffer.appendInt32(1764381832)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.text.serialize(buffer, true)
                _data.type.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.style!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_pageButton(_ reader: BufferReader) -> PageButton? {
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
                return Api.PageButton.pageButton(Cons_pageButton(flags: _1!, text: _2!, type: _3!, style: _4))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum PageCaption: TypeConstructorDescription {
        class Cons_pageCaption: TypeConstructorDescription {
            var text: Api.RichText
            var credit: Api.RichText
            init(text: Api.RichText, credit: Api.RichText) {
                self.text = text
                self.credit = credit
            }
        }
        case pageCaption(Cons_pageCaption)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .pageCaption(let _data):
                if boxed {
                    buffer.appendInt32(1869903447)
                }
                _data.text.serialize(buffer, true)
                _data.credit.serialize(buffer, true)
                break
            }
        }

        static func parse_pageCaption(_ reader: BufferReader) -> PageCaption? {
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
                return Api.PageCaption.pageCaption(Cons_pageCaption(text: _1!, credit: _2!))
            }
            else {
                return nil
            }
        }
    }
}
