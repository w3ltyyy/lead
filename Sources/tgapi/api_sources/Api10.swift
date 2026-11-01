extension Api {
    indirect enum Message: TypeConstructorDescription {
        class Cons_message: TypeConstructorDescription {
            var flags: Int32
            var flags2: Int32
            var id: Int32
            var fromId: Api.Peer?
            var fromBoostsApplied: Int32?
            var fromRank: String?
            var peerId: Api.Peer
            var savedPeerId: Api.Peer?
            var fwdFrom: Api.MessageFwdHeader?
            var viaBotId: Int64?
            var viaBusinessBotId: Int64?
            var guestchatViaFrom: Api.Peer?
            var replyTo: Api.MessageReplyHeader?
            var date: Int32
            var message: String
            var media: Api.MessageMedia?
            var replyMarkup: Api.ReplyMarkup?
            var entities: [Api.MessageEntity]?
            var views: Int32?
            var forwards: Int32?
            var replies: Api.MessageReplies?
            var editDate: Int32?
            var postAuthor: String?
            var groupedId: Int64?
            var reactions: Api.MessageReactions?
            var restrictionReason: [Api.RestrictionReason]?
            var ttlPeriod: Int32?
            var quickReplyShortcutId: Int32?
            var effect: Int64?
            var factcheck: Api.FactCheck?
            var reportDeliveryUntilDate: Int32?
            var paidMessageStars: Int64?
            var suggestedPost: Api.SuggestedPost?
            var scheduleRepeatPeriod: Int32?
            var summaryFromLanguage: String?
            var richMessage: Api.RichMessage?
            init(flags: Int32, flags2: Int32, id: Int32, fromId: Api.Peer?, fromBoostsApplied: Int32?, fromRank: String?, peerId: Api.Peer, savedPeerId: Api.Peer?, fwdFrom: Api.MessageFwdHeader?, viaBotId: Int64?, viaBusinessBotId: Int64?, guestchatViaFrom: Api.Peer?, replyTo: Api.MessageReplyHeader?, date: Int32, message: String, media: Api.MessageMedia?, replyMarkup: Api.ReplyMarkup?, entities: [Api.MessageEntity]?, views: Int32?, forwards: Int32?, replies: Api.MessageReplies?, editDate: Int32?, postAuthor: String?, groupedId: Int64?, reactions: Api.MessageReactions?, restrictionReason: [Api.RestrictionReason]?, ttlPeriod: Int32?, quickReplyShortcutId: Int32?, effect: Int64?, factcheck: Api.FactCheck?, reportDeliveryUntilDate: Int32?, paidMessageStars: Int64?, suggestedPost: Api.SuggestedPost?, scheduleRepeatPeriod: Int32?, summaryFromLanguage: String?, richMessage: Api.RichMessage?) {
                self.flags = flags
                self.flags2 = flags2
                self.id = id
                self.fromId = fromId
                self.fromBoostsApplied = fromBoostsApplied
                self.fromRank = fromRank
                self.peerId = peerId
                self.savedPeerId = savedPeerId
                self.fwdFrom = fwdFrom
                self.viaBotId = viaBotId
                self.viaBusinessBotId = viaBusinessBotId
                self.guestchatViaFrom = guestchatViaFrom
                self.replyTo = replyTo
                self.date = date
                self.message = message
                self.media = media
                self.replyMarkup = replyMarkup
                self.entities = entities
                self.views = views
                self.forwards = forwards
                self.replies = replies
                self.editDate = editDate
                self.postAuthor = postAuthor
                self.groupedId = groupedId
                self.reactions = reactions
                self.restrictionReason = restrictionReason
                self.ttlPeriod = ttlPeriod
                self.quickReplyShortcutId = quickReplyShortcutId
                self.effect = effect
                self.factcheck = factcheck
                self.reportDeliveryUntilDate = reportDeliveryUntilDate
                self.paidMessageStars = paidMessageStars
                self.suggestedPost = suggestedPost
                self.scheduleRepeatPeriod = scheduleRepeatPeriod
                self.summaryFromLanguage = summaryFromLanguage
                self.richMessage = richMessage
            }
        }
        class Cons_messageEmpty: TypeConstructorDescription {
            var flags: Int32
            var id: Int32
            var peerId: Api.Peer?
            init(flags: Int32, id: Int32, peerId: Api.Peer?) {
                self.flags = flags
                self.id = id
                self.peerId = peerId
            }
        }
        class Cons_messageService: TypeConstructorDescription {
            var flags: Int32
            var id: Int32
            var fromId: Api.Peer?
            var peerId: Api.Peer
            var savedPeerId: Api.Peer?
            var replyTo: Api.MessageReplyHeader?
            var date: Int32
            var action: Api.MessageAction
            var reactions: Api.MessageReactions?
            var ttlPeriod: Int32?
            init(flags: Int32, id: Int32, fromId: Api.Peer?, peerId: Api.Peer, savedPeerId: Api.Peer?, replyTo: Api.MessageReplyHeader?, date: Int32, action: Api.MessageAction, reactions: Api.MessageReactions?, ttlPeriod: Int32?) {
                self.flags = flags
                self.id = id
                self.fromId = fromId
                self.peerId = peerId
                self.savedPeerId = savedPeerId
                self.replyTo = replyTo
                self.date = date
                self.action = action
                self.reactions = reactions
                self.ttlPeriod = ttlPeriod
            }
        }
        case message(Cons_message)
        case messageEmpty(Cons_messageEmpty)
        case messageService(Cons_messageService)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .message(let _data):
                if boxed {
                    buffer.appendInt32(1979759059)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.flags2, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    _data.fromId!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 29) != 0 {
                    serializeInt32(_data.fromBoostsApplied!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 12) != 0 {
                    serializeString(_data.fromRank!, buffer: buffer, boxed: false)
                }
                _data.peerId.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 28) != 0 {
                    _data.savedPeerId!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.fwdFrom!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    serializeInt64(_data.viaBotId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 0) != 0 {
                    serializeInt64(_data.viaBusinessBotId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 19) != 0 {
                    _data.guestchatViaFrom!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.replyTo!.serialize(buffer, true)
                }
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                serializeString(_data.message, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    _data.media!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    _data.replyMarkup!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.entities!.count))
                    for item in _data.entities! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    serializeInt32(_data.views!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    serializeInt32(_data.forwards!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 23) != 0 {
                    _data.replies!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 15) != 0 {
                    serializeInt32(_data.editDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 16) != 0 {
                    serializeString(_data.postAuthor!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 17) != 0 {
                    serializeInt64(_data.groupedId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 20) != 0 {
                    _data.reactions!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 22) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.restrictionReason!.count))
                    for item in _data.restrictionReason! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 25) != 0 {
                    serializeInt32(_data.ttlPeriod!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 30) != 0 {
                    serializeInt32(_data.quickReplyShortcutId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 2) != 0 {
                    serializeInt64(_data.effect!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 3) != 0 {
                    _data.factcheck!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 5) != 0 {
                    serializeInt32(_data.reportDeliveryUntilDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 6) != 0 {
                    serializeInt64(_data.paidMessageStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 7) != 0 {
                    _data.suggestedPost!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 10) != 0 {
                    serializeInt32(_data.scheduleRepeatPeriod!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 11) != 0 {
                    serializeString(_data.summaryFromLanguage!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 13) != 0 {
                    _data.richMessage!.serialize(buffer, true)
                }
                break
            case .messageEmpty(let _data):
                if boxed {
                    buffer.appendInt32(-1868117372)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.peerId!.serialize(buffer, true)
                }
                break
            case .messageService(let _data):
                if boxed {
                    buffer.appendInt32(2055212554)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    _data.fromId!.serialize(buffer, true)
                }
                _data.peerId.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 28) != 0 {
                    _data.savedPeerId!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    _data.replyTo!.serialize(buffer, true)
                }
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                _data.action.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 20) != 0 {
                    _data.reactions!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 25) != 0 {
                    serializeInt32(_data.ttlPeriod!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_message(_ reader: BufferReader) -> Message? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                if let signature = reader.readInt32() {
                    _4 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 29) != 0 {
                _5 = reader.readInt32()
            }
            var _6: String?
            if Int(_2 ?? 0) & Int(1 << 12) != 0 {
                _6 = parseString(reader)
            }
            var _7: Api.Peer?
            if let signature = reader.readInt32() {
                _7 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _8: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 28) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _9: Api.MessageFwdHeader?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.MessageFwdHeader
                }
            }
            var _10: Int64?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                _10 = reader.readInt64()
            }
            var _11: Int64?
            if Int(_2 ?? 0) & Int(1 << 0) != 0 {
                _11 = reader.readInt64()
            }
            var _12: Api.Peer?
            if Int(_2 ?? 0) & Int(1 << 19) != 0 {
                if let signature = reader.readInt32() {
                    _12 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _13: Api.MessageReplyHeader?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _13 = Api.parse(reader, signature: signature) as? Api.MessageReplyHeader
                }
            }
            var _14: Int32?
            _14 = reader.readInt32()
            var _15: String?
            _15 = parseString(reader)
            var _16: Api.MessageMedia?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                if let signature = reader.readInt32() {
                    _16 = Api.parse(reader, signature: signature) as? Api.MessageMedia
                }
            }
            var _17: Api.ReplyMarkup?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                if let signature = reader.readInt32() {
                    _17 = Api.parse(reader, signature: signature) as? Api.ReplyMarkup
                }
            }
            var _18: [Api.MessageEntity]?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                if let _ = reader.readInt32() {
                    _18 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self)
                }
            }
            var _19: Int32?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                _19 = reader.readInt32()
            }
            var _20: Int32?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                _20 = reader.readInt32()
            }
            var _21: Api.MessageReplies?
            if Int(_1 ?? 0) & Int(1 << 23) != 0 {
                if let signature = reader.readInt32() {
                    _21 = Api.parse(reader, signature: signature) as? Api.MessageReplies
                }
            }
            var _22: Int32?
            if Int(_1 ?? 0) & Int(1 << 15) != 0 {
                _22 = reader.readInt32()
            }
            var _23: String?
            if Int(_1 ?? 0) & Int(1 << 16) != 0 {
                _23 = parseString(reader)
            }
            var _24: Int64?
            if Int(_1 ?? 0) & Int(1 << 17) != 0 {
                _24 = reader.readInt64()
            }
            var _25: Api.MessageReactions?
            if Int(_1 ?? 0) & Int(1 << 20) != 0 {
                if let signature = reader.readInt32() {
                    _25 = Api.parse(reader, signature: signature) as? Api.MessageReactions
                }
            }
            var _26: [Api.RestrictionReason]?
            if Int(_1 ?? 0) & Int(1 << 22) != 0 {
                if let _ = reader.readInt32() {
                    _26 = Api.parseVector(reader, elementSignature: 0, elementType: Api.RestrictionReason.self)
                }
            }
            var _27: Int32?
            if Int(_1 ?? 0) & Int(1 << 25) != 0 {
                _27 = reader.readInt32()
            }
            var _28: Int32?
            if Int(_1 ?? 0) & Int(1 << 30) != 0 {
                _28 = reader.readInt32()
            }
            var _29: Int64?
            if Int(_2 ?? 0) & Int(1 << 2) != 0 {
                _29 = reader.readInt64()
            }
            var _30: Api.FactCheck?
            if Int(_2 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _30 = Api.parse(reader, signature: signature) as? Api.FactCheck
                }
            }
            var _31: Int32?
            if Int(_2 ?? 0) & Int(1 << 5) != 0 {
                _31 = reader.readInt32()
            }
            var _32: Int64?
            if Int(_2 ?? 0) & Int(1 << 6) != 0 {
                _32 = reader.readInt64()
            }
            var _33: Api.SuggestedPost?
            if Int(_2 ?? 0) & Int(1 << 7) != 0 {
                if let signature = reader.readInt32() {
                    _33 = Api.parse(reader, signature: signature) as? Api.SuggestedPost
                }
            }
            var _34: Int32?
            if Int(_2 ?? 0) & Int(1 << 10) != 0 {
                _34 = reader.readInt32()
            }
            var _35: String?
            if Int(_2 ?? 0) & Int(1 << 11) != 0 {
                _35 = parseString(reader)
            }
            var _36: Api.RichMessage?
            if Int(_2 ?? 0) & Int(1 << 13) != 0 {
                if let signature = reader.readInt32() {
                    _36 = Api.parse(reader, signature: signature) as? Api.RichMessage
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 29) == 0) || _5 != nil
            let _c6 = (Int(_2 ?? 0) & Int(1 << 12) == 0) || _6 != nil
            let _c7 = _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 28) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _10 != nil
            let _c11 = (Int(_2 ?? 0) & Int(1 << 0) == 0) || _11 != nil
            let _c12 = (Int(_2 ?? 0) & Int(1 << 19) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _13 != nil
            let _c14 = _14 != nil
            let _c15 = _15 != nil
            let _c16 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _16 != nil
            let _c17 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _17 != nil
            let _c18 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _18 != nil
            let _c19 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _19 != nil
            let _c20 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _20 != nil
            let _c21 = (Int(_1 ?? 0) & Int(1 << 23) == 0) || _21 != nil
            let _c22 = (Int(_1 ?? 0) & Int(1 << 15) == 0) || _22 != nil
            let _c23 = (Int(_1 ?? 0) & Int(1 << 16) == 0) || _23 != nil
            let _c24 = (Int(_1 ?? 0) & Int(1 << 17) == 0) || _24 != nil
            let _c25 = (Int(_1 ?? 0) & Int(1 << 20) == 0) || _25 != nil
            let _c26 = (Int(_1 ?? 0) & Int(1 << 22) == 0) || _26 != nil
            let _c27 = (Int(_1 ?? 0) & Int(1 << 25) == 0) || _27 != nil
            let _c28 = (Int(_1 ?? 0) & Int(1 << 30) == 0) || _28 != nil
            let _c29 = (Int(_2 ?? 0) & Int(1 << 2) == 0) || _29 != nil
            let _c30 = (Int(_2 ?? 0) & Int(1 << 3) == 0) || _30 != nil
            let _c31 = (Int(_2 ?? 0) & Int(1 << 5) == 0) || _31 != nil
            let _c32 = (Int(_2 ?? 0) & Int(1 << 6) == 0) || _32 != nil
            let _c33 = (Int(_2 ?? 0) & Int(1 << 7) == 0) || _33 != nil
            let _c34 = (Int(_2 ?? 0) & Int(1 << 10) == 0) || _34 != nil
            let _c35 = (Int(_2 ?? 0) & Int(1 << 11) == 0) || _35 != nil
            let _c36 = (Int(_2 ?? 0) & Int(1 << 13) == 0) || _36 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 && _c15 && _c16 && _c17 && _c18 && _c19 && _c20 && _c21 && _c22 && _c23 && _c24 && _c25 && _c26 && _c27 && _c28 && _c29 && _c30 && _c31 && _c32 && _c33 && _c34 && _c35 && _c36 {
                return Api.Message.message(Cons_message(flags: _1!, flags2: _2!, id: _3!, fromId: _4, fromBoostsApplied: _5, fromRank: _6, peerId: _7!, savedPeerId: _8, fwdFrom: _9, viaBotId: _10, viaBusinessBotId: _11, guestchatViaFrom: _12, replyTo: _13, date: _14!, message: _15!, media: _16, replyMarkup: _17, entities: _18, views: _19, forwards: _20, replies: _21, editDate: _22, postAuthor: _23, groupedId: _24, reactions: _25, restrictionReason: _26, ttlPeriod: _27, quickReplyShortcutId: _28, effect: _29, factcheck: _30, reportDeliveryUntilDate: _31, paidMessageStars: _32, suggestedPost: _33, scheduleRepeatPeriod: _34, summaryFromLanguage: _35, richMessage: _36))
            }
            else {
                return nil
            }
        }
        static func parse_messageEmpty(_ reader: BufferReader) -> Message? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.Message.messageEmpty(Cons_messageEmpty(flags: _1!, id: _2!, peerId: _3))
            }
            else {
                return nil
            }
        }
        static func parse_messageService(_ reader: BufferReader) -> Message? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _4: Api.Peer?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _5: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 28) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _6: Api.MessageReplyHeader?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let signature = reader.readInt32() {
                    _6 = Api.parse(reader, signature: signature) as? Api.MessageReplyHeader
                }
            }
            var _7: Int32?
            _7 = reader.readInt32()
            var _8: Api.MessageAction?
            if let signature = reader.readInt32() {
                _8 = Api.parse(reader, signature: signature) as? Api.MessageAction
            }
            var _9: Api.MessageReactions?
            if Int(_1 ?? 0) & Int(1 << 20) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.MessageReactions
                }
            }
            var _10: Int32?
            if Int(_1 ?? 0) & Int(1 << 25) != 0 {
                _10 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 28) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _6 != nil
            let _c7 = _7 != nil
            let _c8 = _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 20) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 25) == 0) || _10 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 {
                return Api.Message.messageService(Cons_messageService(flags: _1!, id: _2!, fromId: _3, peerId: _4!, savedPeerId: _5, replyTo: _6, date: _7!, action: _8!, reactions: _9, ttlPeriod: _10))
            }
            else {
                return nil
            }
        }
    }
}
