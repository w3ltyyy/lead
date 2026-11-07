extension Api.wallet {
    enum Transactions: TypeConstructorDescription {
        class Cons_transactions: TypeConstructorDescription {
            var flags: Int32
            var balance: Int64
            var transactions: [Api.WalletTransaction]
            var nextOffset: String?
            var chats: [Api.Chat]
            var users: [Api.User]
            init(flags: Int32, balance: Int64, transactions: [Api.WalletTransaction], nextOffset: String?, chats: [Api.Chat], users: [Api.User]) {
                self.flags = flags
                self.balance = balance
                self.transactions = transactions
                self.nextOffset = nextOffset
                self.chats = chats
                self.users = users
            }
        }
        case transactions(Cons_transactions)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .transactions(let _data):
                if boxed {
                    buffer.appendInt32(1126356389)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.balance, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.transactions.count))
                for item in _data.transactions {
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

        static func parse_transactions(_ reader: BufferReader) -> Transactions? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: [Api.WalletTransaction]?
            if let _ = reader.readInt32() {
                _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.WalletTransaction.self)
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
                return Api.wallet.Transactions.transactions(Cons_transactions(flags: _1!, balance: _2!, transactions: _3!, nextOffset: _4, chats: _5!, users: _6!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api.functions.messages {
    static func sendMedia(flags: Int32, peer: Api.InputPeer, replyTo: Api.InputReplyTo?, media: Api.InputMedia, message: String, randomId: Int64, replyMarkup: Api.ReplyMarkup?, entities: [Api.MessageEntity]?, scheduleDate: Int32?, scheduleRepeatPeriod: Int32?, sendAs: Api.InputPeer?, quickReplyShortcut: Api.InputQuickReplyShortcut?, effect: Int64?, allowPaidStars: Int64?, suggestedPost: Api.SuggestedPost?) -> (FunctionDescription, Buffer, DeserializeFunctionResponse<Api.Updates>) {
        let buffer = Buffer()
        buffer.appendInt32(53536639)
        serializeInt32(flags, buffer: buffer, boxed: false)
        peer.serialize(buffer, true)
        if Int(flags) & Int(1 << 0) != 0 {
            replyTo!.serialize(buffer, true)
        }
        media.serialize(buffer, true)
        serializeString(message, buffer: buffer, boxed: false)
        serializeInt64(randomId, buffer: buffer, boxed: false)
        if Int(flags) & Int(1 << 2) != 0 {
            replyMarkup!.serialize(buffer, true)
        }
        if Int(flags) & Int(1 << 3) != 0 {
            buffer.appendInt32(481674261)
            buffer.appendInt32(Int32(entities!.count))
            for item in entities! {
                item.serialize(buffer, true)
            }
        }
        if Int(flags) & Int(1 << 10) != 0 {
            serializeInt32(scheduleDate!, buffer: buffer, boxed: false)
        }
        if Int(flags) & Int(1 << 24) != 0 {
            serializeInt32(scheduleRepeatPeriod!, buffer: buffer, boxed: false)
        }
        if Int(flags) & Int(1 << 13) != 0 {
            sendAs!.serialize(buffer, true)
        }
        if Int(flags) & Int(1 << 17) != 0 {
            quickReplyShortcut!.serialize(buffer, true)
        }
        if Int(flags) & Int(1 << 18) != 0 {
            serializeInt64(effect!, buffer: buffer, boxed: false)
        }
        if Int(flags) & Int(1 << 21) != 0 {
            serializeInt64(allowPaidStars!, buffer: buffer, boxed: false)
        }
        if Int(flags) & Int(1 << 22) != 0 {
            suggestedPost!.serialize(buffer, true)
        }
        return (FunctionDescription(name: "messages.sendMedia", parameters: []), buffer, DeserializeFunctionResponse { (buffer: Buffer) -> Api.Updates? in
            let reader = BufferReader(buffer)
            var result: Api.Updates?
            if let signature = reader.readInt32() {
                result = Api.parse(reader, signature: signature) as? Api.Updates
            }
            return result
        })
    }
}
