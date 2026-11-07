extension Api {
    indirect enum PageListItem: TypeConstructorDescription {
        class Cons_pageListItemBlocks: TypeConstructorDescription {
            var flags: Int32
            var blocks: [Api.PageBlock]
            init(flags: Int32, blocks: [Api.PageBlock]) {
                self.flags = flags
                self.blocks = blocks
            }
        }
        class Cons_pageListItemText: TypeConstructorDescription {
            var flags: Int32
            var text: Api.RichText
            init(flags: Int32, text: Api.RichText) {
                self.flags = flags
                self.text = text
            }
        }
        case pageListItemBlocks(Cons_pageListItemBlocks)
        case pageListItemText(Cons_pageListItemText)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .pageListItemBlocks(let _data):
                if boxed {
                    buffer.appendInt32(1674209194)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.blocks.count))
                for item in _data.blocks {
                    item.serialize(buffer, true)
                }
                break
            case .pageListItemText(let _data):
                if boxed {
                    buffer.appendInt32(794323004)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.text.serialize(buffer, true)
                break
            }
        }

        static func parse_pageListItemBlocks(_ reader: BufferReader) -> PageListItem? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: [Api.PageBlock]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageBlock.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PageListItem.pageListItemBlocks(Cons_pageListItemBlocks(flags: _1!, blocks: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_pageListItemText(_ reader: BufferReader) -> PageListItem? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.RichText?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PageListItem.pageListItemText(Cons_pageListItemText(flags: _1!, text: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum PageListOrderedItem: TypeConstructorDescription {
        class Cons_pageListOrderedItemBlocks: TypeConstructorDescription {
            var flags: Int32
            var num: String?
            var blocks: [Api.PageBlock]
            var value: Int32?
            var type: String?
            init(flags: Int32, num: String?, blocks: [Api.PageBlock], value: Int32?, type: String?) {
                self.flags = flags
                self.num = num
                self.blocks = blocks
                self.value = value
                self.type = type
            }
        }
        class Cons_pageListOrderedItemText: TypeConstructorDescription {
            var flags: Int32
            var num: String?
            var text: Api.RichText
            var value: Int32?
            var type: String?
            init(flags: Int32, num: String?, text: Api.RichText, value: Int32?, type: String?) {
                self.flags = flags
                self.num = num
                self.text = text
                self.value = value
                self.type = type
            }
        }
        case pageListOrderedItemBlocks(Cons_pageListOrderedItemBlocks)
        case pageListOrderedItemText(Cons_pageListOrderedItemText)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .pageListOrderedItemBlocks(let _data):
                if boxed {
                    buffer.appendInt32(-1879910928)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.num!, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.blocks.count))
                for item in _data.blocks {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.value!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeString(_data.type!, buffer: buffer, boxed: false)
                }
                break
            case .pageListOrderedItemText(let _data):
                if boxed {
                    buffer.appendInt32(352522633)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.num!, buffer: buffer, boxed: false)
                }
                _data.text.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt32(_data.value!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeString(_data.type!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_pageListOrderedItemBlocks(_ reader: BufferReader) -> PageListOrderedItem? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _2 = parseString(reader)
            }
            var _3: [Api.PageBlock]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageBlock.self)
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _4 = reader.readInt32()
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _5 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.PageListOrderedItem.pageListOrderedItemBlocks(Cons_pageListOrderedItemBlocks(flags: _1!, num: _2, blocks: _3!, value: _4, type: _5))
            }
            else {
                return nil
            }
        }
        static func parse_pageListOrderedItemText(_ reader: BufferReader) -> PageListOrderedItem? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _2 = parseString(reader)
            }
            var _3: Api.RichText?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.RichText
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _4 = reader.readInt32()
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _5 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.PageListOrderedItem.pageListOrderedItemText(Cons_pageListOrderedItemText(flags: _1!, num: _2, text: _3!, value: _4, type: _5))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PageRelatedArticle: TypeConstructorDescription {
        class Cons_pageRelatedArticle: TypeConstructorDescription {
            var flags: Int32
            var url: String
            var webpageId: Int64
            var title: String?
            var description: String?
            var photoId: Int64?
            var author: String?
            var publishedDate: Int32?
            init(flags: Int32, url: String, webpageId: Int64, title: String?, description: String?, photoId: Int64?, author: String?, publishedDate: Int32?) {
                self.flags = flags
                self.url = url
                self.webpageId = webpageId
                self.title = title
                self.description = description
                self.photoId = photoId
                self.author = author
                self.publishedDate = publishedDate
            }
        }
        case pageRelatedArticle(Cons_pageRelatedArticle)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .pageRelatedArticle(let _data):
                if boxed {
                    buffer.appendInt32(-1282352120)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.url, buffer: buffer, boxed: false)
                serializeInt64(_data.webpageId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.title!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.description!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt64(_data.photoId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.author!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.publishedDate!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_pageRelatedArticle(_ reader: BufferReader) -> PageRelatedArticle? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _5 = parseString(reader)
            }
            var _6: Int64?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _6 = reader.readInt64()
            }
            var _7: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _7 = parseString(reader)
            }
            var _8: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _8 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.PageRelatedArticle.pageRelatedArticle(Cons_pageRelatedArticle(flags: _1!, url: _2!, webpageId: _3!, title: _4, description: _5, photoId: _6, author: _7, publishedDate: _8))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum PageTableCell: TypeConstructorDescription {
        class Cons_pageTableCell: TypeConstructorDescription {
            var flags: Int32
            var text: Api.RichText?
            var colspan: Int32?
            var rowspan: Int32?
            init(flags: Int32, text: Api.RichText?, colspan: Int32?, rowspan: Int32?) {
                self.flags = flags
                self.text = text
                self.colspan = colspan
                self.rowspan = rowspan
            }
        }
        case pageTableCell(Cons_pageTableCell)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .pageTableCell(let _data):
                if boxed {
                    buffer.appendInt32(878078826)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    _data.text!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.colspan!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.rowspan!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_pageTableCell(_ reader: BufferReader) -> PageTableCell? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.RichText?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.RichText
                }
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _3 = reader.readInt32()
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _4 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.PageTableCell.pageTableCell(Cons_pageTableCell(flags: _1!, text: _2, colspan: _3, rowspan: _4))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PageTableRow: TypeConstructorDescription {
        class Cons_pageTableRow: TypeConstructorDescription {
            var cells: [Api.PageTableCell]
            init(cells: [Api.PageTableCell]) {
                self.cells = cells
            }
        }
        case pageTableRow(Cons_pageTableRow)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .pageTableRow(let _data):
                if boxed {
                    buffer.appendInt32(-524237339)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.cells.count))
                for item in _data.cells {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_pageTableRow(_ reader: BufferReader) -> PageTableRow? {
            var _1: [Api.PageTableCell]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PageTableCell.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PageTableRow.pageTableRow(Cons_pageTableRow(cells: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    indirect enum PaidReactionPrivacy: TypeConstructorDescription {
        class Cons_paidReactionPrivacyPeer: TypeConstructorDescription {
            var peer: Api.InputPeer
            init(peer: Api.InputPeer) {
                self.peer = peer
            }
        }
        case paidReactionPrivacyAnonymous
        case paidReactionPrivacyDefault
        case paidReactionPrivacyPeer(Cons_paidReactionPrivacyPeer)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .paidReactionPrivacyAnonymous:
                if boxed {
                    buffer.appendInt32(520887001)
                }
                break
            case .paidReactionPrivacyDefault:
                if boxed {
                    buffer.appendInt32(543872158)
                }
                break
            case .paidReactionPrivacyPeer(let _data):
                if boxed {
                    buffer.appendInt32(-596837136)
                }
                _data.peer.serialize(buffer, true)
                break
            }
        }

        static func parse_paidReactionPrivacyAnonymous(_ reader: BufferReader) -> PaidReactionPrivacy? {
            return Api.PaidReactionPrivacy.paidReactionPrivacyAnonymous
        }
        static func parse_paidReactionPrivacyDefault(_ reader: BufferReader) -> PaidReactionPrivacy? {
            return Api.PaidReactionPrivacy.paidReactionPrivacyDefault
        }
        static func parse_paidReactionPrivacyPeer(_ reader: BufferReader) -> PaidReactionPrivacy? {
            var _1: Api.InputPeer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputPeer
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.PaidReactionPrivacy.paidReactionPrivacyPeer(Cons_paidReactionPrivacyPeer(peer: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PaymentCharge: TypeConstructorDescription {
        class Cons_paymentCharge: TypeConstructorDescription {
            var id: String
            var providerChargeId: String
            init(id: String, providerChargeId: String) {
                self.id = id
                self.providerChargeId = providerChargeId
            }
        }
        case paymentCharge(Cons_paymentCharge)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .paymentCharge(let _data):
                if boxed {
                    buffer.appendInt32(-368917890)
                }
                serializeString(_data.id, buffer: buffer, boxed: false)
                serializeString(_data.providerChargeId, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_paymentCharge(_ reader: BufferReader) -> PaymentCharge? {
            var _1: String?
            _1 = parseString(reader)
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PaymentCharge.paymentCharge(Cons_paymentCharge(id: _1!, providerChargeId: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PaymentRequestedInfo: TypeConstructorDescription {
        class Cons_paymentRequestedInfo: TypeConstructorDescription {
            var flags: Int32
            var name: String?
            var phone: String?
            var email: String?
            var shippingAddress: Api.PostAddress?
            init(flags: Int32, name: String?, phone: String?, email: String?, shippingAddress: Api.PostAddress?) {
                self.flags = flags
                self.name = name
                self.phone = phone
                self.email = email
                self.shippingAddress = shippingAddress
            }
        }
        case paymentRequestedInfo(Cons_paymentRequestedInfo)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .paymentRequestedInfo(let _data):
                if boxed {
                    buffer.appendInt32(-1868808300)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.name!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.phone!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.email!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.shippingAddress!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_paymentRequestedInfo(_ reader: BufferReader) -> PaymentRequestedInfo? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = parseString(reader)
            }
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _3 = parseString(reader)
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _4 = parseString(reader)
            }
            var _5: Api.PostAddress?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.PostAddress
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.PaymentRequestedInfo.paymentRequestedInfo(Cons_paymentRequestedInfo(flags: _1!, name: _2, phone: _3, email: _4, shippingAddress: _5))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum Peer: TypeConstructorDescription {
        class Cons_peerChannel: TypeConstructorDescription {
            var channelId: Int64
            init(channelId: Int64) {
                self.channelId = channelId
            }
        }
        class Cons_peerChat: TypeConstructorDescription {
            var chatId: Int64
            init(chatId: Int64) {
                self.chatId = chatId
            }
        }
        class Cons_peerUser: TypeConstructorDescription {
            var userId: Int64
            init(userId: Int64) {
                self.userId = userId
            }
        }
        case peerChannel(Cons_peerChannel)
        case peerChat(Cons_peerChat)
        case peerUser(Cons_peerUser)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .peerChannel(let _data):
                if boxed {
                    buffer.appendInt32(-1566230754)
                }
                serializeInt64(_data.channelId, buffer: buffer, boxed: false)
                break
            case .peerChat(let _data):
                if boxed {
                    buffer.appendInt32(918946202)
                }
                serializeInt64(_data.chatId, buffer: buffer, boxed: false)
                break
            case .peerUser(let _data):
                if boxed {
                    buffer.appendInt32(1498486562)
                }
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_peerChannel(_ reader: BufferReader) -> Peer? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.Peer.peerChannel(Cons_peerChannel(channelId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_peerChat(_ reader: BufferReader) -> Peer? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.Peer.peerChat(Cons_peerChat(chatId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_peerUser(_ reader: BufferReader) -> Peer? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.Peer.peerUser(Cons_peerUser(userId: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PeerBlocked: TypeConstructorDescription {
        class Cons_peerBlocked: TypeConstructorDescription {
            var peerId: Api.Peer
            var date: Int32
            init(peerId: Api.Peer, date: Int32) {
                self.peerId = peerId
                self.date = date
            }
        }
        case peerBlocked(Cons_peerBlocked)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .peerBlocked(let _data):
                if boxed {
                    buffer.appendInt32(-386039788)
                }
                _data.peerId.serialize(buffer, true)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_peerBlocked(_ reader: BufferReader) -> PeerBlocked? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.PeerBlocked.peerBlocked(Cons_peerBlocked(peerId: _1!, date: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PeerColor: TypeConstructorDescription {
        class Cons_inputPeerColorCollectible: TypeConstructorDescription {
            var collectibleId: Int64
            init(collectibleId: Int64) {
                self.collectibleId = collectibleId
            }
        }
        class Cons_peerColor: TypeConstructorDescription {
            var flags: Int32
            var color: Int32?
            var backgroundEmojiId: Int64?
            init(flags: Int32, color: Int32?, backgroundEmojiId: Int64?) {
                self.flags = flags
                self.color = color
                self.backgroundEmojiId = backgroundEmojiId
            }
        }
        class Cons_peerColorCollectible: TypeConstructorDescription {
            var flags: Int32
            var collectibleId: Int64
            var giftEmojiId: Int64
            var backgroundEmojiId: Int64
            var accentColor: Int32
            var colors: [Int32]
            var darkAccentColor: Int32?
            var darkColors: [Int32]?
            init(flags: Int32, collectibleId: Int64, giftEmojiId: Int64, backgroundEmojiId: Int64, accentColor: Int32, colors: [Int32], darkAccentColor: Int32?, darkColors: [Int32]?) {
                self.flags = flags
                self.collectibleId = collectibleId
                self.giftEmojiId = giftEmojiId
                self.backgroundEmojiId = backgroundEmojiId
                self.accentColor = accentColor
                self.colors = colors
                self.darkAccentColor = darkAccentColor
                self.darkColors = darkColors
            }
        }
        case inputPeerColorCollectible(Cons_inputPeerColorCollectible)
        case peerColor(Cons_peerColor)
        case peerColorCollectible(Cons_peerColorCollectible)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputPeerColorCollectible(let _data):
                if boxed {
                    buffer.appendInt32(-1192589655)
                }
                serializeInt64(_data.collectibleId, buffer: buffer, boxed: false)
                break
            case .peerColor(let _data):
                if boxed {
                    buffer.appendInt32(-1253352753)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.color!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt64(_data.backgroundEmojiId!, buffer: buffer, boxed: false)
                }
                break
            case .peerColorCollectible(let _data):
                if boxed {
                    buffer.appendInt32(-1178573926)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.collectibleId, buffer: buffer, boxed: false)
                serializeInt64(_data.giftEmojiId, buffer: buffer, boxed: false)
                serializeInt64(_data.backgroundEmojiId, buffer: buffer, boxed: false)
                serializeInt32(_data.accentColor, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.colors.count))
                for item in _data.colors {
                    serializeInt32(item, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.darkAccentColor!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.darkColors!.count))
                    for item in _data.darkColors! {
                        serializeInt32(item, buffer: buffer, boxed: false)
                    }
                }
                break
            }
        }

        static func parse_inputPeerColorCollectible(_ reader: BufferReader) -> PeerColor? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.PeerColor.inputPeerColorCollectible(Cons_inputPeerColorCollectible(collectibleId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_peerColor(_ reader: BufferReader) -> PeerColor? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt32()
            }
            var _3: Int64?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _3 = reader.readInt64()
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.PeerColor.peerColor(Cons_peerColor(flags: _1!, color: _2, backgroundEmojiId: _3))
            }
            else {
                return nil
            }
        }
        static func parse_peerColorCollectible(_ reader: BufferReader) -> PeerColor? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: [Int32]?
            if let _ = reader.readInt32() {
                _6 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
            }
            var _7: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _7 = reader.readInt32()
            }
            var _8: [Int32]?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let _ = reader.readInt32() {
                    _8 = Api.parseVector(reader, elementSignature: -1471112230, elementType: Int32.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.PeerColor.peerColorCollectible(Cons_peerColorCollectible(flags: _1!, collectibleId: _2!, giftEmojiId: _3!, backgroundEmojiId: _4!, accentColor: _5!, colors: _6!, darkAccentColor: _7, darkColors: _8))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PeerLocated: TypeConstructorDescription {
        class Cons_peerLocated: TypeConstructorDescription {
            var peer: Api.Peer
            var expires: Int32
            var distance: Int32
            init(peer: Api.Peer, expires: Int32, distance: Int32) {
                self.peer = peer
                self.expires = expires
                self.distance = distance
            }
        }
        class Cons_peerSelfLocated: TypeConstructorDescription {
            var expires: Int32
            init(expires: Int32) {
                self.expires = expires
            }
        }
        case peerLocated(Cons_peerLocated)
        case peerSelfLocated(Cons_peerSelfLocated)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .peerLocated(let _data):
                if boxed {
                    buffer.appendInt32(-901375139)
                }
                _data.peer.serialize(buffer, true)
                serializeInt32(_data.expires, buffer: buffer, boxed: false)
                serializeInt32(_data.distance, buffer: buffer, boxed: false)
                break
            case .peerSelfLocated(let _data):
                if boxed {
                    buffer.appendInt32(-118740917)
                }
                serializeInt32(_data.expires, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_peerLocated(_ reader: BufferReader) -> PeerLocated? {
            var _1: Api.Peer?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.PeerLocated.peerLocated(Cons_peerLocated(peer: _1!, expires: _2!, distance: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_peerSelfLocated(_ reader: BufferReader) -> PeerLocated? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.PeerLocated.peerSelfLocated(Cons_peerSelfLocated(expires: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PeerNotifySettings: TypeConstructorDescription {
        class Cons_peerNotifySettings: TypeConstructorDescription {
            var flags: Int32
            var showPreviews: Api.Bool?
            var silent: Api.Bool?
            var muteUntil: Int32?
            var iosSound: Api.NotificationSound?
            var androidSound: Api.NotificationSound?
            var otherSound: Api.NotificationSound?
            var storiesMuted: Api.Bool?
            var storiesHideSender: Api.Bool?
            var storiesIosSound: Api.NotificationSound?
            var storiesAndroidSound: Api.NotificationSound?
            var storiesOtherSound: Api.NotificationSound?
            init(flags: Int32, showPreviews: Api.Bool?, silent: Api.Bool?, muteUntil: Int32?, iosSound: Api.NotificationSound?, androidSound: Api.NotificationSound?, otherSound: Api.NotificationSound?, storiesMuted: Api.Bool?, storiesHideSender: Api.Bool?, storiesIosSound: Api.NotificationSound?, storiesAndroidSound: Api.NotificationSound?, storiesOtherSound: Api.NotificationSound?) {
                self.flags = flags
                self.showPreviews = showPreviews
                self.silent = silent
                self.muteUntil = muteUntil
                self.iosSound = iosSound
                self.androidSound = androidSound
                self.otherSound = otherSound
                self.storiesMuted = storiesMuted
                self.storiesHideSender = storiesHideSender
                self.storiesIosSound = storiesIosSound
                self.storiesAndroidSound = storiesAndroidSound
                self.storiesOtherSound = storiesOtherSound
            }
        }
        case peerNotifySettings(Cons_peerNotifySettings)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .peerNotifySettings(let _data):
                if boxed {
                    buffer.appendInt32(-1721619444)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.showPreviews!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.silent!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.muteUntil!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.iosSound!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    _data.androidSound!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    _data.otherSound!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    _data.storiesMuted!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    _data.storiesHideSender!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    _data.storiesIosSound!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    _data.storiesAndroidSound!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    _data.storiesOtherSound!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_peerNotifySettings(_ reader: BufferReader) -> PeerNotifySettings? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            var _3: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Api.NotificationSound?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.NotificationSound
                }
            }
            var _6: Api.NotificationSound?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.NotificationSound
                }
            }
            var _7: Api.NotificationSound?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.NotificationSound
                }
            }
            var _8: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            var _9: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            var _10: Api.NotificationSound?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                if let signature = reader.readInt32() {
                    _10 = Api.parse(reader, signature: signature) as? Api.NotificationSound
                }
            }
            var _11: Api.NotificationSound?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                if let signature = reader.readInt32() {
                    _11 = Api.parse(reader, signature: signature) as? Api.NotificationSound
                }
            }
            var _12: Api.NotificationSound?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                if let signature = reader.readInt32() {
                    _12 = Api.parse(reader, signature: signature) as? Api.NotificationSound
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _12 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 {
                return Api.PeerNotifySettings.peerNotifySettings(Cons_peerNotifySettings(flags: _1!, showPreviews: _2, silent: _3, muteUntil: _4, iosSound: _5, androidSound: _6, otherSound: _7, storiesMuted: _8, storiesHideSender: _9, storiesIosSound: _10, storiesAndroidSound: _11, storiesOtherSound: _12))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PeerSettings: TypeConstructorDescription {
        class Cons_peerSettings: TypeConstructorDescription {
            var flags: Int32
            var geoDistance: Int32?
            var requestChatTitle: String?
            var requestChatDate: Int32?
            var businessBotId: Int64?
            var businessBotManageUrl: String?
            var chargePaidMessageStars: Int64?
            var registrationMonth: String?
            var phoneCountry: String?
            var nameChangeDate: Int32?
            var photoChangeDate: Int32?
            init(flags: Int32, geoDistance: Int32?, requestChatTitle: String?, requestChatDate: Int32?, businessBotId: Int64?, businessBotManageUrl: String?, chargePaidMessageStars: Int64?, registrationMonth: String?, phoneCountry: String?, nameChangeDate: Int32?, photoChangeDate: Int32?) {
                self.flags = flags
                self.geoDistance = geoDistance
                self.requestChatTitle = requestChatTitle
                self.requestChatDate = requestChatDate
                self.businessBotId = businessBotId
                self.businessBotManageUrl = businessBotManageUrl
                self.chargePaidMessageStars = chargePaidMessageStars
                self.registrationMonth = registrationMonth
                self.phoneCountry = phoneCountry
                self.nameChangeDate = nameChangeDate
                self.photoChangeDate = photoChangeDate
            }
        }
        case peerSettings(Cons_peerSettings)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .peerSettings(let _data):
                if boxed {
                    buffer.appendInt32(-193510921)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    serializeInt32(_data.geoDistance!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    serializeString(_data.requestChatTitle!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    serializeInt32(_data.requestChatDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 13) != 0 {
                    serializeInt64(_data.businessBotId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 13) != 0 {
                    serializeString(_data.businessBotManageUrl!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 14) != 0 {
                    serializeInt64(_data.chargePaidMessageStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 15) != 0 {
                    serializeString(_data.registrationMonth!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 16) != 0 {
                    serializeString(_data.phoneCountry!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 17) != 0 {
                    serializeInt32(_data.nameChangeDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 18) != 0 {
                    serializeInt32(_data.photoChangeDate!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_peerSettings(_ reader: BufferReader) -> PeerSettings? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                _2 = reader.readInt32()
            }
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                _3 = parseString(reader)
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                _4 = reader.readInt32()
            }
            var _5: Int64?
            if Int(_1 ?? 0) & Int(1 << 13) != 0 {
                _5 = reader.readInt64()
            }
            var _6: String?
            if Int(_1 ?? 0) & Int(1 << 13) != 0 {
                _6 = parseString(reader)
            }
            var _7: Int64?
            if Int(_1 ?? 0) & Int(1 << 14) != 0 {
                _7 = reader.readInt64()
            }
            var _8: String?
            if Int(_1 ?? 0) & Int(1 << 15) != 0 {
                _8 = parseString(reader)
            }
            var _9: String?
            if Int(_1 ?? 0) & Int(1 << 16) != 0 {
                _9 = parseString(reader)
            }
            var _10: Int32?
            if Int(_1 ?? 0) & Int(1 << 17) != 0 {
                _10 = reader.readInt32()
            }
            var _11: Int32?
            if Int(_1 ?? 0) & Int(1 << 18) != 0 {
                _11 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 13) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 13) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 14) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 15) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 16) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 17) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 18) == 0) || _11 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 {
                return Api.PeerSettings.peerSettings(Cons_peerSettings(flags: _1!, geoDistance: _2, requestChatTitle: _3, requestChatDate: _4, businessBotId: _5, businessBotManageUrl: _6, chargePaidMessageStars: _7, registrationMonth: _8, phoneCountry: _9, nameChangeDate: _10, photoChangeDate: _11))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PeerStories: TypeConstructorDescription {
        class Cons_peerStories: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var maxReadId: Int32?
            var stories: [Api.StoryItem]
            init(flags: Int32, peer: Api.Peer, maxReadId: Int32?, stories: [Api.StoryItem]) {
                self.flags = flags
                self.peer = peer
                self.maxReadId = maxReadId
                self.stories = stories
            }
        }
        case peerStories(Cons_peerStories)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .peerStories(let _data):
                if boxed {
                    buffer.appendInt32(-1707742823)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.maxReadId!, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.stories.count))
                for item in _data.stories {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_peerStories(_ reader: BufferReader) -> PeerStories? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _3 = reader.readInt32()
            }
            var _4: [Api.StoryItem]?
            if let _ = reader.readInt32() {
                _4 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StoryItem.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.PeerStories.peerStories(Cons_peerStories(flags: _1!, peer: _2!, maxReadId: _3, stories: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PendingSuggestion: TypeConstructorDescription {
        class Cons_pendingSuggestion: TypeConstructorDescription {
            var suggestion: String
            var title: Api.TextWithEntities
            var description: Api.TextWithEntities
            var url: String
            init(suggestion: String, title: Api.TextWithEntities, description: Api.TextWithEntities, url: String) {
                self.suggestion = suggestion
                self.title = title
                self.description = description
                self.url = url
            }
        }
        case pendingSuggestion(Cons_pendingSuggestion)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .pendingSuggestion(let _data):
                if boxed {
                    buffer.appendInt32(-404214254)
                }
                serializeString(_data.suggestion, buffer: buffer, boxed: false)
                _data.title.serialize(buffer, true)
                _data.description.serialize(buffer, true)
                serializeString(_data.url, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_pendingSuggestion(_ reader: BufferReader) -> PendingSuggestion? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Api.TextWithEntities?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
            }
            var _3: Api.TextWithEntities?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
            }
            var _4: String?
            _4 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.PendingSuggestion.pendingSuggestion(Cons_pendingSuggestion(suggestion: _1!, title: _2!, description: _3!, url: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum PhoneCall: TypeConstructorDescription {
        class Cons_phoneCall: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var accessHash: Int64
            var date: Int32
            var adminId: Int64
            var participantId: Int64
            var gAOrB: Buffer
            var keyFingerprint: Int64
            var `protocol`: Api.PhoneCallProtocol
            var connections: [Api.PhoneConnection]
            var startDate: Int32
            var customParameters: Api.DataJSON?
            init(flags: Int32, id: Int64, accessHash: Int64, date: Int32, adminId: Int64, participantId: Int64, gAOrB: Buffer, keyFingerprint: Int64, `protocol`: Api.PhoneCallProtocol, connections: [Api.PhoneConnection], startDate: Int32, customParameters: Api.DataJSON?) {
                self.flags = flags
                self.id = id
                self.accessHash = accessHash
                self.date = date
                self.adminId = adminId
                self.participantId = participantId
                self.gAOrB = gAOrB
                self.keyFingerprint = keyFingerprint
                self.`protocol` = `protocol`
                self.connections = connections
                self.startDate = startDate
                self.customParameters = customParameters
            }
        }
        class Cons_phoneCallAccepted: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var accessHash: Int64
            var date: Int32
            var adminId: Int64
            var participantId: Int64
            var gB: Buffer
            var `protocol`: Api.PhoneCallProtocol
            init(flags: Int32, id: Int64, accessHash: Int64, date: Int32, adminId: Int64, participantId: Int64, gB: Buffer, `protocol`: Api.PhoneCallProtocol) {
                self.flags = flags
                self.id = id
                self.accessHash = accessHash
                self.date = date
                self.adminId = adminId
                self.participantId = participantId
                self.gB = gB
                self.`protocol` = `protocol`
            }
        }
        class Cons_phoneCallDiscarded: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var reason: Api.PhoneCallDiscardReason?
            var duration: Int32?
            init(flags: Int32, id: Int64, reason: Api.PhoneCallDiscardReason?, duration: Int32?) {
                self.flags = flags
                self.id = id
                self.reason = reason
                self.duration = duration
            }
        }
        class Cons_phoneCallEmpty: TypeConstructorDescription {
            var id: Int64
            init(id: Int64) {
                self.id = id
            }
        }
        class Cons_phoneCallRequested: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var accessHash: Int64
            var date: Int32
            var adminId: Int64
            var participantId: Int64
            var gAHash: Buffer
            var `protocol`: Api.PhoneCallProtocol
            init(flags: Int32, id: Int64, accessHash: Int64, date: Int32, adminId: Int64, participantId: Int64, gAHash: Buffer, `protocol`: Api.PhoneCallProtocol) {
                self.flags = flags
                self.id = id
                self.accessHash = accessHash
                self.date = date
                self.adminId = adminId
                self.participantId = participantId
                self.gAHash = gAHash
                self.`protocol` = `protocol`
            }
        }
        class Cons_phoneCallWaiting: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var accessHash: Int64
            var date: Int32
            var adminId: Int64
            var participantId: Int64
            var `protocol`: Api.PhoneCallProtocol
            var receiveDate: Int32?
            init(flags: Int32, id: Int64, accessHash: Int64, date: Int32, adminId: Int64, participantId: Int64, `protocol`: Api.PhoneCallProtocol, receiveDate: Int32?) {
                self.flags = flags
                self.id = id
                self.accessHash = accessHash
                self.date = date
                self.adminId = adminId
                self.participantId = participantId
                self.`protocol` = `protocol`
                self.receiveDate = receiveDate
            }
        }
        case phoneCall(Cons_phoneCall)
        case phoneCallAccepted(Cons_phoneCallAccepted)
        case phoneCallDiscarded(Cons_phoneCallDiscarded)
        case phoneCallEmpty(Cons_phoneCallEmpty)
        case phoneCallRequested(Cons_phoneCallRequested)
        case phoneCallWaiting(Cons_phoneCallWaiting)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .phoneCall(let _data):
                if boxed {
                    buffer.appendInt32(810769141)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt64(_data.adminId, buffer: buffer, boxed: false)
                serializeInt64(_data.participantId, buffer: buffer, boxed: false)
                serializeBytes(_data.gAOrB, buffer: buffer, boxed: false)
                serializeInt64(_data.keyFingerprint, buffer: buffer, boxed: false)
                _data.`protocol`.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.connections.count))
                for item in _data.connections {
                    item.serialize(buffer, true)
                }
                serializeInt32(_data.startDate, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    _data.customParameters!.serialize(buffer, true)
                }
                break
            case .phoneCallAccepted(let _data):
                if boxed {
                    buffer.appendInt32(912311057)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt64(_data.adminId, buffer: buffer, boxed: false)
                serializeInt64(_data.participantId, buffer: buffer, boxed: false)
                serializeBytes(_data.gB, buffer: buffer, boxed: false)
                _data.`protocol`.serialize(buffer, true)
                break
            case .phoneCallDiscarded(let _data):
                if boxed {
                    buffer.appendInt32(1355435489)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.reason!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.duration!, buffer: buffer, boxed: false)
                }
                break
            case .phoneCallEmpty(let _data):
                if boxed {
                    buffer.appendInt32(1399245077)
                }
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                break
            case .phoneCallRequested(let _data):
                if boxed {
                    buffer.appendInt32(347139340)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt64(_data.adminId, buffer: buffer, boxed: false)
                serializeInt64(_data.participantId, buffer: buffer, boxed: false)
                serializeBytes(_data.gAHash, buffer: buffer, boxed: false)
                _data.`protocol`.serialize(buffer, true)
                break
            case .phoneCallWaiting(let _data):
                if boxed {
                    buffer.appendInt32(-987599081)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.accessHash, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeInt64(_data.adminId, buffer: buffer, boxed: false)
                serializeInt64(_data.participantId, buffer: buffer, boxed: false)
                _data.`protocol`.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.receiveDate!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_phoneCall(_ reader: BufferReader) -> PhoneCall? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int64?
            _5 = reader.readInt64()
            var _6: Int64?
            _6 = reader.readInt64()
            var _7: Buffer?
            _7 = parseBytes(reader)
            var _8: Int64?
            _8 = reader.readInt64()
            var _9: Api.PhoneCallProtocol?
            if let signature = reader.readInt32() {
                _9 = Api.parse(reader, signature: signature) as? Api.PhoneCallProtocol
            }
            var _10: [Api.PhoneConnection]?
            if let _ = reader.readInt32() {
                _10 = Api.parseVector(reader, elementSignature: 0, elementType: Api.PhoneConnection.self)
            }
            var _11: Int32?
            _11 = reader.readInt32()
            var _12: Api.DataJSON?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                if let signature = reader.readInt32() {
                    _12 = Api.parse(reader, signature: signature) as? Api.DataJSON
                }
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
            let _c12 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _12 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 {
                return Api.PhoneCall.phoneCall(Cons_phoneCall(flags: _1!, id: _2!, accessHash: _3!, date: _4!, adminId: _5!, participantId: _6!, gAOrB: _7!, keyFingerprint: _8!, protocol: _9!, connections: _10!, startDate: _11!, customParameters: _12))
            }
            else {
                return nil
            }
        }
        static func parse_phoneCallAccepted(_ reader: BufferReader) -> PhoneCall? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int64?
            _5 = reader.readInt64()
            var _6: Int64?
            _6 = reader.readInt64()
            var _7: Buffer?
            _7 = parseBytes(reader)
            var _8: Api.PhoneCallProtocol?
            if let signature = reader.readInt32() {
                _8 = Api.parse(reader, signature: signature) as? Api.PhoneCallProtocol
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.PhoneCall.phoneCallAccepted(Cons_phoneCallAccepted(flags: _1!, id: _2!, accessHash: _3!, date: _4!, adminId: _5!, participantId: _6!, gB: _7!, protocol: _8!))
            }
            else {
                return nil
            }
        }
        static func parse_phoneCallDiscarded(_ reader: BufferReader) -> PhoneCall? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.PhoneCallDiscardReason?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.PhoneCallDiscardReason
                }
            }
            var _4: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _4 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.PhoneCall.phoneCallDiscarded(Cons_phoneCallDiscarded(flags: _1!, id: _2!, reason: _3, duration: _4))
            }
            else {
                return nil
            }
        }
        static func parse_phoneCallEmpty(_ reader: BufferReader) -> PhoneCall? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.PhoneCall.phoneCallEmpty(Cons_phoneCallEmpty(id: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_phoneCallRequested(_ reader: BufferReader) -> PhoneCall? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int64?
            _5 = reader.readInt64()
            var _6: Int64?
            _6 = reader.readInt64()
            var _7: Buffer?
            _7 = parseBytes(reader)
            var _8: Api.PhoneCallProtocol?
            if let signature = reader.readInt32() {
                _8 = Api.parse(reader, signature: signature) as? Api.PhoneCallProtocol
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.PhoneCall.phoneCallRequested(Cons_phoneCallRequested(flags: _1!, id: _2!, accessHash: _3!, date: _4!, adminId: _5!, participantId: _6!, gAHash: _7!, protocol: _8!))
            }
            else {
                return nil
            }
        }
        static func parse_phoneCallWaiting(_ reader: BufferReader) -> PhoneCall? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int64?
            _5 = reader.readInt64()
            var _6: Int64?
            _6 = reader.readInt64()
            var _7: Api.PhoneCallProtocol?
            if let signature = reader.readInt32() {
                _7 = Api.parse(reader, signature: signature) as? Api.PhoneCallProtocol
            }
            var _8: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _8 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.PhoneCall.phoneCallWaiting(Cons_phoneCallWaiting(flags: _1!, id: _2!, accessHash: _3!, date: _4!, adminId: _5!, participantId: _6!, protocol: _7!, receiveDate: _8))
            }
            else {
                return nil
            }
        }
    }
}
