extension Api {
    enum SecureValueType: TypeConstructorDescription {
        case secureValueTypeAddress
        case secureValueTypeBankStatement
        case secureValueTypeDriverLicense
        case secureValueTypeEmail
        case secureValueTypeIdentityCard
        case secureValueTypeInternalPassport
        case secureValueTypePassport
        case secureValueTypePassportRegistration
        case secureValueTypePersonalDetails
        case secureValueTypePhone
        case secureValueTypeRentalAgreement
        case secureValueTypeTemporaryRegistration
        case secureValueTypeUtilityBill

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .secureValueTypeAddress:
                if boxed {
                    buffer.appendInt32(-874308058)
                }
                break
            case .secureValueTypeBankStatement:
                if boxed {
                    buffer.appendInt32(-1995211763)
                }
                break
            case .secureValueTypeDriverLicense:
                if boxed {
                    buffer.appendInt32(115615172)
                }
                break
            case .secureValueTypeEmail:
                if boxed {
                    buffer.appendInt32(-1908627474)
                }
                break
            case .secureValueTypeIdentityCard:
                if boxed {
                    buffer.appendInt32(-1596951477)
                }
                break
            case .secureValueTypeInternalPassport:
                if boxed {
                    buffer.appendInt32(-1717268701)
                }
                break
            case .secureValueTypePassport:
                if boxed {
                    buffer.appendInt32(1034709504)
                }
                break
            case .secureValueTypePassportRegistration:
                if boxed {
                    buffer.appendInt32(-1713143702)
                }
                break
            case .secureValueTypePersonalDetails:
                if boxed {
                    buffer.appendInt32(-1658158621)
                }
                break
            case .secureValueTypePhone:
                if boxed {
                    buffer.appendInt32(-1289704741)
                }
                break
            case .secureValueTypeRentalAgreement:
                if boxed {
                    buffer.appendInt32(-1954007928)
                }
                break
            case .secureValueTypeTemporaryRegistration:
                if boxed {
                    buffer.appendInt32(-368907213)
                }
                break
            case .secureValueTypeUtilityBill:
                if boxed {
                    buffer.appendInt32(-63531698)
                }
                break
            }
        }

        static func parse_secureValueTypeAddress(_ reader: BufferReader) -> SecureValueType? {
            return Api.SecureValueType.secureValueTypeAddress
        }
        static func parse_secureValueTypeBankStatement(_ reader: BufferReader) -> SecureValueType? {
            return Api.SecureValueType.secureValueTypeBankStatement
        }
        static func parse_secureValueTypeDriverLicense(_ reader: BufferReader) -> SecureValueType? {
            return Api.SecureValueType.secureValueTypeDriverLicense
        }
        static func parse_secureValueTypeEmail(_ reader: BufferReader) -> SecureValueType? {
            return Api.SecureValueType.secureValueTypeEmail
        }
        static func parse_secureValueTypeIdentityCard(_ reader: BufferReader) -> SecureValueType? {
            return Api.SecureValueType.secureValueTypeIdentityCard
        }
        static func parse_secureValueTypeInternalPassport(_ reader: BufferReader) -> SecureValueType? {
            return Api.SecureValueType.secureValueTypeInternalPassport
        }
        static func parse_secureValueTypePassport(_ reader: BufferReader) -> SecureValueType? {
            return Api.SecureValueType.secureValueTypePassport
        }
        static func parse_secureValueTypePassportRegistration(_ reader: BufferReader) -> SecureValueType? {
            return Api.SecureValueType.secureValueTypePassportRegistration
        }
        static func parse_secureValueTypePersonalDetails(_ reader: BufferReader) -> SecureValueType? {
            return Api.SecureValueType.secureValueTypePersonalDetails
        }
        static func parse_secureValueTypePhone(_ reader: BufferReader) -> SecureValueType? {
            return Api.SecureValueType.secureValueTypePhone
        }
        static func parse_secureValueTypeRentalAgreement(_ reader: BufferReader) -> SecureValueType? {
            return Api.SecureValueType.secureValueTypeRentalAgreement
        }
        static func parse_secureValueTypeTemporaryRegistration(_ reader: BufferReader) -> SecureValueType? {
            return Api.SecureValueType.secureValueTypeTemporaryRegistration
        }
        static func parse_secureValueTypeUtilityBill(_ reader: BufferReader) -> SecureValueType? {
            return Api.SecureValueType.secureValueTypeUtilityBill
        }
    }
}
extension Api {
    enum SendAsPeer: TypeConstructorDescription {
        class Cons_sendAsPeer: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            init(flags: Int32, peer: Api.Peer) {
                self.flags = flags
                self.peer = peer
            }
        }
        case sendAsPeer(Cons_sendAsPeer)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .sendAsPeer(let _data):
                if boxed {
                    buffer.appendInt32(-1206095820)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                break
            }
        }

        static func parse_sendAsPeer(_ reader: BufferReader) -> SendAsPeer? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.SendAsPeer.sendAsPeer(Cons_sendAsPeer(flags: _1!, peer: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum SendMessageAction: TypeConstructorDescription {
        class Cons_inputSendMessageRichMessageDraftAction: TypeConstructorDescription {
            var flags: Int32
            var randomId: Int64
            var richMessage: Api.InputRichMessage
            init(flags: Int32, randomId: Int64, richMessage: Api.InputRichMessage) {
                self.flags = flags
                self.randomId = randomId
                self.richMessage = richMessage
            }
        }
        class Cons_sendMessageEmojiInteraction: TypeConstructorDescription {
            var emoticon: String
            var msgId: Int32
            var interaction: Api.DataJSON
            init(emoticon: String, msgId: Int32, interaction: Api.DataJSON) {
                self.emoticon = emoticon
                self.msgId = msgId
                self.interaction = interaction
            }
        }
        class Cons_sendMessageEmojiInteractionSeen: TypeConstructorDescription {
            var emoticon: String
            init(emoticon: String) {
                self.emoticon = emoticon
            }
        }
        class Cons_sendMessageHistoryImportAction: TypeConstructorDescription {
            var progress: Int32
            init(progress: Int32) {
                self.progress = progress
            }
        }
        class Cons_sendMessageRichMessageDraftAction: TypeConstructorDescription {
            var flags: Int32
            var randomId: Int64
            var richMessage: Api.RichMessage
            init(flags: Int32, randomId: Int64, richMessage: Api.RichMessage) {
                self.flags = flags
                self.randomId = randomId
                self.richMessage = richMessage
            }
        }
        class Cons_sendMessageStopDraftAction: TypeConstructorDescription {
            var randomId: Int64
            init(randomId: Int64) {
                self.randomId = randomId
            }
        }
        class Cons_sendMessageTextDraftAction: TypeConstructorDescription {
            var flags: Int32
            var randomId: Int64
            var text: Api.TextWithEntities
            init(flags: Int32, randomId: Int64, text: Api.TextWithEntities) {
                self.flags = flags
                self.randomId = randomId
                self.text = text
            }
        }
        class Cons_sendMessageUploadAudioAction: TypeConstructorDescription {
            var progress: Int32
            init(progress: Int32) {
                self.progress = progress
            }
        }
        class Cons_sendMessageUploadDocumentAction: TypeConstructorDescription {
            var progress: Int32
            init(progress: Int32) {
                self.progress = progress
            }
        }
        class Cons_sendMessageUploadPhotoAction: TypeConstructorDescription {
            var progress: Int32
            init(progress: Int32) {
                self.progress = progress
            }
        }
        class Cons_sendMessageUploadRoundAction: TypeConstructorDescription {
            var progress: Int32
            init(progress: Int32) {
                self.progress = progress
            }
        }
        class Cons_sendMessageUploadVideoAction: TypeConstructorDescription {
            var progress: Int32
            init(progress: Int32) {
                self.progress = progress
            }
        }
        case inputSendMessageRichMessageDraftAction(Cons_inputSendMessageRichMessageDraftAction)
        case sendMessageCancelAction
        case sendMessageChooseContactAction
        case sendMessageChooseStickerAction
        case sendMessageEmojiInteraction(Cons_sendMessageEmojiInteraction)
        case sendMessageEmojiInteractionSeen(Cons_sendMessageEmojiInteractionSeen)
        case sendMessageGamePlayAction
        case sendMessageGeoLocationAction
        case sendMessageHistoryImportAction(Cons_sendMessageHistoryImportAction)
        case sendMessageRecordAudioAction
        case sendMessageRecordRoundAction
        case sendMessageRecordVideoAction
        case sendMessageRichMessageDraftAction(Cons_sendMessageRichMessageDraftAction)
        case sendMessageStopDraftAction(Cons_sendMessageStopDraftAction)
        case sendMessageTextDraftAction(Cons_sendMessageTextDraftAction)
        case sendMessageTypingAction
        case sendMessageUploadAudioAction(Cons_sendMessageUploadAudioAction)
        case sendMessageUploadDocumentAction(Cons_sendMessageUploadDocumentAction)
        case sendMessageUploadPhotoAction(Cons_sendMessageUploadPhotoAction)
        case sendMessageUploadRoundAction(Cons_sendMessageUploadRoundAction)
        case sendMessageUploadVideoAction(Cons_sendMessageUploadVideoAction)
        case speakingInGroupCallAction

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputSendMessageRichMessageDraftAction(let _data):
                if boxed {
                    buffer.appendInt32(-1455962178)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.randomId, buffer: buffer, boxed: false)
                _data.richMessage.serialize(buffer, true)
                break
            case .sendMessageCancelAction:
                if boxed {
                    buffer.appendInt32(-44119819)
                }
                break
            case .sendMessageChooseContactAction:
                if boxed {
                    buffer.appendInt32(1653390447)
                }
                break
            case .sendMessageChooseStickerAction:
                if boxed {
                    buffer.appendInt32(-1336228175)
                }
                break
            case .sendMessageEmojiInteraction(let _data):
                if boxed {
                    buffer.appendInt32(630664139)
                }
                serializeString(_data.emoticon, buffer: buffer, boxed: false)
                serializeInt32(_data.msgId, buffer: buffer, boxed: false)
                _data.interaction.serialize(buffer, true)
                break
            case .sendMessageEmojiInteractionSeen(let _data):
                if boxed {
                    buffer.appendInt32(-1234857938)
                }
                serializeString(_data.emoticon, buffer: buffer, boxed: false)
                break
            case .sendMessageGamePlayAction:
                if boxed {
                    buffer.appendInt32(-580219064)
                }
                break
            case .sendMessageGeoLocationAction:
                if boxed {
                    buffer.appendInt32(393186209)
                }
                break
            case .sendMessageHistoryImportAction(let _data):
                if boxed {
                    buffer.appendInt32(-606432698)
                }
                serializeInt32(_data.progress, buffer: buffer, boxed: false)
                break
            case .sendMessageRecordAudioAction:
                if boxed {
                    buffer.appendInt32(-718310409)
                }
                break
            case .sendMessageRecordRoundAction:
                if boxed {
                    buffer.appendInt32(-1997373508)
                }
                break
            case .sendMessageRecordVideoAction:
                if boxed {
                    buffer.appendInt32(-1584933265)
                }
                break
            case .sendMessageRichMessageDraftAction(let _data):
                if boxed {
                    buffer.appendInt32(1381386387)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.randomId, buffer: buffer, boxed: false)
                _data.richMessage.serialize(buffer, true)
                break
            case .sendMessageStopDraftAction(let _data):
                if boxed {
                    buffer.appendInt32(-67566928)
                }
                serializeInt64(_data.randomId, buffer: buffer, boxed: false)
                break
            case .sendMessageTextDraftAction(let _data):
                if boxed {
                    buffer.appendInt32(909162586)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.randomId, buffer: buffer, boxed: false)
                _data.text.serialize(buffer, true)
                break
            case .sendMessageTypingAction:
                if boxed {
                    buffer.appendInt32(381645902)
                }
                break
            case .sendMessageUploadAudioAction(let _data):
                if boxed {
                    buffer.appendInt32(-212740181)
                }
                serializeInt32(_data.progress, buffer: buffer, boxed: false)
                break
            case .sendMessageUploadDocumentAction(let _data):
                if boxed {
                    buffer.appendInt32(-1441998364)
                }
                serializeInt32(_data.progress, buffer: buffer, boxed: false)
                break
            case .sendMessageUploadPhotoAction(let _data):
                if boxed {
                    buffer.appendInt32(-774682074)
                }
                serializeInt32(_data.progress, buffer: buffer, boxed: false)
                break
            case .sendMessageUploadRoundAction(let _data):
                if boxed {
                    buffer.appendInt32(608050278)
                }
                serializeInt32(_data.progress, buffer: buffer, boxed: false)
                break
            case .sendMessageUploadVideoAction(let _data):
                if boxed {
                    buffer.appendInt32(-378127636)
                }
                serializeInt32(_data.progress, buffer: buffer, boxed: false)
                break
            case .speakingInGroupCallAction:
                if boxed {
                    buffer.appendInt32(-651419003)
                }
                break
            }
        }

        static func parse_inputSendMessageRichMessageDraftAction(_ reader: BufferReader) -> SendMessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.InputRichMessage?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.InputRichMessage
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.SendMessageAction.inputSendMessageRichMessageDraftAction(Cons_inputSendMessageRichMessageDraftAction(flags: _1!, randomId: _2!, richMessage: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_sendMessageCancelAction(_ reader: BufferReader) -> SendMessageAction? {
            return Api.SendMessageAction.sendMessageCancelAction
        }
        static func parse_sendMessageChooseContactAction(_ reader: BufferReader) -> SendMessageAction? {
            return Api.SendMessageAction.sendMessageChooseContactAction
        }
        static func parse_sendMessageChooseStickerAction(_ reader: BufferReader) -> SendMessageAction? {
            return Api.SendMessageAction.sendMessageChooseStickerAction
        }
        static func parse_sendMessageEmojiInteraction(_ reader: BufferReader) -> SendMessageAction? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Api.DataJSON?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.DataJSON
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.SendMessageAction.sendMessageEmojiInteraction(Cons_sendMessageEmojiInteraction(emoticon: _1!, msgId: _2!, interaction: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_sendMessageEmojiInteractionSeen(_ reader: BufferReader) -> SendMessageAction? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.SendMessageAction.sendMessageEmojiInteractionSeen(Cons_sendMessageEmojiInteractionSeen(emoticon: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_sendMessageGamePlayAction(_ reader: BufferReader) -> SendMessageAction? {
            return Api.SendMessageAction.sendMessageGamePlayAction
        }
        static func parse_sendMessageGeoLocationAction(_ reader: BufferReader) -> SendMessageAction? {
            return Api.SendMessageAction.sendMessageGeoLocationAction
        }
        static func parse_sendMessageHistoryImportAction(_ reader: BufferReader) -> SendMessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.SendMessageAction.sendMessageHistoryImportAction(Cons_sendMessageHistoryImportAction(progress: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_sendMessageRecordAudioAction(_ reader: BufferReader) -> SendMessageAction? {
            return Api.SendMessageAction.sendMessageRecordAudioAction
        }
        static func parse_sendMessageRecordRoundAction(_ reader: BufferReader) -> SendMessageAction? {
            return Api.SendMessageAction.sendMessageRecordRoundAction
        }
        static func parse_sendMessageRecordVideoAction(_ reader: BufferReader) -> SendMessageAction? {
            return Api.SendMessageAction.sendMessageRecordVideoAction
        }
        static func parse_sendMessageRichMessageDraftAction(_ reader: BufferReader) -> SendMessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.RichMessage?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.RichMessage
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.SendMessageAction.sendMessageRichMessageDraftAction(Cons_sendMessageRichMessageDraftAction(flags: _1!, randomId: _2!, richMessage: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_sendMessageStopDraftAction(_ reader: BufferReader) -> SendMessageAction? {
            var _1: Int64?
            _1 = reader.readInt64()
            let _c1 = _1 != nil
            if _c1 {
                return Api.SendMessageAction.sendMessageStopDraftAction(Cons_sendMessageStopDraftAction(randomId: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_sendMessageTextDraftAction(_ reader: BufferReader) -> SendMessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
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
                return Api.SendMessageAction.sendMessageTextDraftAction(Cons_sendMessageTextDraftAction(flags: _1!, randomId: _2!, text: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_sendMessageTypingAction(_ reader: BufferReader) -> SendMessageAction? {
            return Api.SendMessageAction.sendMessageTypingAction
        }
        static func parse_sendMessageUploadAudioAction(_ reader: BufferReader) -> SendMessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.SendMessageAction.sendMessageUploadAudioAction(Cons_sendMessageUploadAudioAction(progress: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_sendMessageUploadDocumentAction(_ reader: BufferReader) -> SendMessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.SendMessageAction.sendMessageUploadDocumentAction(Cons_sendMessageUploadDocumentAction(progress: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_sendMessageUploadPhotoAction(_ reader: BufferReader) -> SendMessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.SendMessageAction.sendMessageUploadPhotoAction(Cons_sendMessageUploadPhotoAction(progress: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_sendMessageUploadRoundAction(_ reader: BufferReader) -> SendMessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.SendMessageAction.sendMessageUploadRoundAction(Cons_sendMessageUploadRoundAction(progress: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_sendMessageUploadVideoAction(_ reader: BufferReader) -> SendMessageAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.SendMessageAction.sendMessageUploadVideoAction(Cons_sendMessageUploadVideoAction(progress: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_speakingInGroupCallAction(_ reader: BufferReader) -> SendMessageAction? {
            return Api.SendMessageAction.speakingInGroupCallAction
        }
    }
}
extension Api {
    enum ShareTheme: TypeConstructorDescription {
        class Cons_inputShareThemeGift: TypeConstructorDescription {
            var stargift: Api.InputSavedStarGift
            init(stargift: Api.InputSavedStarGift) {
                self.stargift = stargift
            }
        }
        class Cons_shareThemeEmojiBackdrop: TypeConstructorDescription {
            var flags: Int32
            var backdropId: Int32?
            var emojis: [Api.Reaction]?
            init(flags: Int32, backdropId: Int32?, emojis: [Api.Reaction]?) {
                self.flags = flags
                self.backdropId = backdropId
                self.emojis = emojis
            }
        }
        class Cons_shareThemeGift: TypeConstructorDescription {
            var stargift: Api.StarGift
            init(stargift: Api.StarGift) {
                self.stargift = stargift
            }
        }
        case inputShareThemeGift(Cons_inputShareThemeGift)
        case shareThemeDefault
        case shareThemeEmojiBackdrop(Cons_shareThemeEmojiBackdrop)
        case shareThemeGift(Cons_shareThemeGift)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .inputShareThemeGift(let _data):
                if boxed {
                    buffer.appendInt32(1069099867)
                }
                _data.stargift.serialize(buffer, true)
                break
            case .shareThemeDefault:
                if boxed {
                    buffer.appendInt32(-1783830449)
                }
                break
            case .shareThemeEmojiBackdrop(let _data):
                if boxed {
                    buffer.appendInt32(1689466081)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.backdropId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.emojis!.count))
                    for item in _data.emojis! {
                        item.serialize(buffer, true)
                    }
                }
                break
            case .shareThemeGift(let _data):
                if boxed {
                    buffer.appendInt32(-336796051)
                }
                _data.stargift.serialize(buffer, true)
                break
            }
        }

        static func parse_inputShareThemeGift(_ reader: BufferReader) -> ShareTheme? {
            var _1: Api.InputSavedStarGift?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputSavedStarGift
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ShareTheme.inputShareThemeGift(Cons_inputShareThemeGift(stargift: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_shareThemeDefault(_ reader: BufferReader) -> ShareTheme? {
            return Api.ShareTheme.shareThemeDefault
        }
        static func parse_shareThemeEmojiBackdrop(_ reader: BufferReader) -> ShareTheme? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _2 = reader.readInt32()
            }
            var _3: [Api.Reaction]?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let _ = reader.readInt32() {
                    _3 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Reaction.self)
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.ShareTheme.shareThemeEmojiBackdrop(Cons_shareThemeEmojiBackdrop(flags: _1!, backdropId: _2, emojis: _3))
            }
            else {
                return nil
            }
        }
        static func parse_shareThemeGift(_ reader: BufferReader) -> ShareTheme? {
            var _1: Api.StarGift?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.StarGift
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ShareTheme.shareThemeGift(Cons_shareThemeGift(stargift: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum SponsoredMessage: TypeConstructorDescription {
        class Cons_sponsoredMessage: TypeConstructorDescription {
            var flags: Int32
            var randomId: Buffer
            var url: String
            var title: String
            var message: String
            var entities: [Api.MessageEntity]?
            var photo: Api.Photo?
            var media: Api.MessageMedia?
            var color: Api.PeerColor?
            var buttonText: String
            var sponsorInfo: String?
            var additionalInfo: String?
            var minDisplayDuration: Int32?
            var maxDisplayDuration: Int32?
            init(flags: Int32, randomId: Buffer, url: String, title: String, message: String, entities: [Api.MessageEntity]?, photo: Api.Photo?, media: Api.MessageMedia?, color: Api.PeerColor?, buttonText: String, sponsorInfo: String?, additionalInfo: String?, minDisplayDuration: Int32?, maxDisplayDuration: Int32?) {
                self.flags = flags
                self.randomId = randomId
                self.url = url
                self.title = title
                self.message = message
                self.entities = entities
                self.photo = photo
                self.media = media
                self.color = color
                self.buttonText = buttonText
                self.sponsorInfo = sponsorInfo
                self.additionalInfo = additionalInfo
                self.minDisplayDuration = minDisplayDuration
                self.maxDisplayDuration = maxDisplayDuration
            }
        }
        case sponsoredMessage(Cons_sponsoredMessage)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .sponsoredMessage(let _data):
                if boxed {
                    buffer.appendInt32(2109703795)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeBytes(_data.randomId, buffer: buffer, boxed: false)
                serializeString(_data.url, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeString(_data.message, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.entities!.count))
                    for item in _data.entities! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    _data.photo!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 14) != 0 {
                    _data.media!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 13) != 0 {
                    _data.color!.serialize(buffer, true)
                }
                serializeString(_data.buttonText, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 7) != 0 {
                    serializeString(_data.sponsorInfo!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    serializeString(_data.additionalInfo!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 15) != 0 {
                    serializeInt32(_data.minDisplayDuration!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 15) != 0 {
                    serializeInt32(_data.maxDisplayDuration!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_sponsoredMessage(_ reader: BufferReader) -> SponsoredMessage? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Buffer?
            _2 = parseBytes(reader)
            var _3: String?
            _3 = parseString(reader)
            var _4: String?
            _4 = parseString(reader)
            var _5: String?
            _5 = parseString(reader)
            var _6: [Api.MessageEntity]?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let _ = reader.readInt32() {
                    _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self)
                }
            }
            var _7: Api.Photo?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.Photo
                }
            }
            var _8: Api.MessageMedia?
            if Int(_1 ?? 0) & Int(1 << 14) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.MessageMedia
                }
            }
            var _9: Api.PeerColor?
            if Int(_1 ?? 0) & Int(1 << 13) != 0 {
                if let signature = reader.readInt32() {
                    _9 = Api.parse(reader, signature: signature) as? Api.PeerColor
                }
            }
            var _10: String?
            _10 = parseString(reader)
            var _11: String?
            if Int(_1 ?? 0) & Int(1 << 7) != 0 {
                _11 = parseString(reader)
            }
            var _12: String?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                _12 = parseString(reader)
            }
            var _13: Int32?
            if Int(_1 ?? 0) & Int(1 << 15) != 0 {
                _13 = reader.readInt32()
            }
            var _14: Int32?
            if Int(_1 ?? 0) & Int(1 << 15) != 0 {
                _14 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 14) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 13) == 0) || _9 != nil
            let _c10 = _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 7) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 15) == 0) || _13 != nil
            let _c14 = (Int(_1 ?? 0) & Int(1 << 15) == 0) || _14 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 {
                return Api.SponsoredMessage.sponsoredMessage(Cons_sponsoredMessage(flags: _1!, randomId: _2!, url: _3!, title: _4!, message: _5!, entities: _6, photo: _7, media: _8, color: _9, buttonText: _10!, sponsorInfo: _11, additionalInfo: _12, minDisplayDuration: _13, maxDisplayDuration: _14))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum SponsoredPeer: TypeConstructorDescription {
        class Cons_sponsoredPeer: TypeConstructorDescription {
            var flags: Int32
            var randomId: Buffer
            var peer: Api.Peer
            var sponsorInfo: String?
            var additionalInfo: String?
            init(flags: Int32, randomId: Buffer, peer: Api.Peer, sponsorInfo: String?, additionalInfo: String?) {
                self.flags = flags
                self.randomId = randomId
                self.peer = peer
                self.sponsorInfo = sponsorInfo
                self.additionalInfo = additionalInfo
            }
        }
        case sponsoredPeer(Cons_sponsoredPeer)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .sponsoredPeer(let _data):
                if boxed {
                    buffer.appendInt32(-963180333)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeBytes(_data.randomId, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.sponsorInfo!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.additionalInfo!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_sponsoredPeer(_ reader: BufferReader) -> SponsoredPeer? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Buffer?
            _2 = parseBytes(reader)
            var _3: Api.Peer?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _4: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _4 = parseString(reader)
            }
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _5 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.SponsoredPeer.sponsoredPeer(Cons_sponsoredPeer(flags: _1!, randomId: _2!, peer: _3!, sponsorInfo: _4, additionalInfo: _5))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarGift: TypeConstructorDescription {
        class Cons_starGift: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var sticker: Api.Document
            var stars: Int64
            var availabilityRemains: Int32?
            var availabilityTotal: Int32?
            var availabilityResale: Int64?
            var convertStars: Int64
            var firstSaleDate: Int32?
            var lastSaleDate: Int32?
            var upgradeStars: Int64?
            var resellMinStars: Int64?
            var title: String?
            var releasedBy: Api.Peer?
            var perUserTotal: Int32?
            var perUserRemains: Int32?
            var lockedUntilDate: Int32?
            var auctionSlug: String?
            var giftsPerRound: Int32?
            var auctionStartDate: Int32?
            var upgradeVariants: Int32?
            var background: Api.StarGiftBackground?
            init(flags: Int32, id: Int64, sticker: Api.Document, stars: Int64, availabilityRemains: Int32?, availabilityTotal: Int32?, availabilityResale: Int64?, convertStars: Int64, firstSaleDate: Int32?, lastSaleDate: Int32?, upgradeStars: Int64?, resellMinStars: Int64?, title: String?, releasedBy: Api.Peer?, perUserTotal: Int32?, perUserRemains: Int32?, lockedUntilDate: Int32?, auctionSlug: String?, giftsPerRound: Int32?, auctionStartDate: Int32?, upgradeVariants: Int32?, background: Api.StarGiftBackground?) {
                self.flags = flags
                self.id = id
                self.sticker = sticker
                self.stars = stars
                self.availabilityRemains = availabilityRemains
                self.availabilityTotal = availabilityTotal
                self.availabilityResale = availabilityResale
                self.convertStars = convertStars
                self.firstSaleDate = firstSaleDate
                self.lastSaleDate = lastSaleDate
                self.upgradeStars = upgradeStars
                self.resellMinStars = resellMinStars
                self.title = title
                self.releasedBy = releasedBy
                self.perUserTotal = perUserTotal
                self.perUserRemains = perUserRemains
                self.lockedUntilDate = lockedUntilDate
                self.auctionSlug = auctionSlug
                self.giftsPerRound = giftsPerRound
                self.auctionStartDate = auctionStartDate
                self.upgradeVariants = upgradeVariants
                self.background = background
            }
        }
        class Cons_starGiftUnique: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var giftId: Int64
            var title: String
            var slug: String
            var num: Int32
            var ownerId: Api.Peer?
            var ownerName: String?
            var ownerAddress: String?
            var attributes: [Api.StarGiftAttribute]
            var availabilityIssued: Int32
            var availabilityTotal: Int32
            var giftAddress: String?
            var resellAmount: [Api.StarsAmount]?
            var releasedBy: Api.Peer?
            var valueAmount: Int64?
            var valueCurrency: String?
            var valueUsdAmount: Int64?
            var themePeer: Api.Peer?
            var peerColor: Api.PeerColor?
            var hostId: Api.Peer?
            var offerMinStars: Int32?
            var craftChancePermille: Int32?
            init(flags: Int32, id: Int64, giftId: Int64, title: String, slug: String, num: Int32, ownerId: Api.Peer?, ownerName: String?, ownerAddress: String?, attributes: [Api.StarGiftAttribute], availabilityIssued: Int32, availabilityTotal: Int32, giftAddress: String?, resellAmount: [Api.StarsAmount]?, releasedBy: Api.Peer?, valueAmount: Int64?, valueCurrency: String?, valueUsdAmount: Int64?, themePeer: Api.Peer?, peerColor: Api.PeerColor?, hostId: Api.Peer?, offerMinStars: Int32?, craftChancePermille: Int32?) {
                self.flags = flags
                self.id = id
                self.giftId = giftId
                self.title = title
                self.slug = slug
                self.num = num
                self.ownerId = ownerId
                self.ownerName = ownerName
                self.ownerAddress = ownerAddress
                self.attributes = attributes
                self.availabilityIssued = availabilityIssued
                self.availabilityTotal = availabilityTotal
                self.giftAddress = giftAddress
                self.resellAmount = resellAmount
                self.releasedBy = releasedBy
                self.valueAmount = valueAmount
                self.valueCurrency = valueCurrency
                self.valueUsdAmount = valueUsdAmount
                self.themePeer = themePeer
                self.peerColor = peerColor
                self.hostId = hostId
                self.offerMinStars = offerMinStars
                self.craftChancePermille = craftChancePermille
            }
        }
        case starGift(Cons_starGift)
        case starGiftUnique(Cons_starGiftUnique)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starGift(let _data):
                if boxed {
                    buffer.appendInt32(825922887)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                _data.sticker.serialize(buffer, true)
                serializeInt64(_data.stars, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.availabilityRemains!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.availabilityTotal!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt64(_data.availabilityResale!, buffer: buffer, boxed: false)
                }
                serializeInt64(_data.convertStars, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.firstSaleDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.lastSaleDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeInt64(_data.upgradeStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt64(_data.resellMinStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeString(_data.title!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    _data.releasedBy!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    serializeInt32(_data.perUserTotal!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    serializeInt32(_data.perUserRemains!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    serializeInt32(_data.lockedUntilDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    serializeString(_data.auctionSlug!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    serializeInt32(_data.giftsPerRound!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    serializeInt32(_data.auctionStartDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 12) != 0 {
                    serializeInt32(_data.upgradeVariants!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 13) != 0 {
                    _data.background!.serialize(buffer, true)
                }
                break
            case .starGiftUnique(let _data):
                if boxed {
                    buffer.appendInt32(-2047825459)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeInt64(_data.giftId, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                serializeString(_data.slug, buffer: buffer, boxed: false)
                serializeInt32(_data.num, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.ownerId!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeString(_data.ownerName!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeString(_data.ownerAddress!, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.attributes.count))
                for item in _data.attributes {
                    item.serialize(buffer, true)
                }
                serializeInt32(_data.availabilityIssued, buffer: buffer, boxed: false)
                serializeInt32(_data.availabilityTotal, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    serializeString(_data.giftAddress!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.resellAmount!.count))
                    for item in _data.resellAmount! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    _data.releasedBy!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    serializeInt64(_data.valueAmount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    serializeString(_data.valueCurrency!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    serializeInt64(_data.valueUsdAmount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    _data.themePeer!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    _data.peerColor!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 12) != 0 {
                    _data.hostId!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 13) != 0 {
                    serializeInt32(_data.offerMinStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 16) != 0 {
                    serializeInt32(_data.craftChancePermille!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_starGift(_ reader: BufferReader) -> StarGift? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.Document?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Document
            }
            var _4: Int64?
            _4 = reader.readInt64()
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = reader.readInt32()
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _6 = reader.readInt32()
            }
            var _7: Int64?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _7 = reader.readInt64()
            }
            var _8: Int64?
            _8 = reader.readInt64()
            var _9: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _9 = reader.readInt32()
            }
            var _10: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _10 = reader.readInt32()
            }
            var _11: Int64?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _11 = reader.readInt64()
            }
            var _12: Int64?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _12 = reader.readInt64()
            }
            var _13: String?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _13 = parseString(reader)
            }
            var _14: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                if let signature = reader.readInt32() {
                    _14 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _15: Int32?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                _15 = reader.readInt32()
            }
            var _16: Int32?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                _16 = reader.readInt32()
            }
            var _17: Int32?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                _17 = reader.readInt32()
            }
            var _18: String?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                _18 = parseString(reader)
            }
            var _19: Int32?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                _19 = reader.readInt32()
            }
            var _20: Int32?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                _20 = reader.readInt32()
            }
            var _21: Int32?
            if Int(_1 ?? 0) & Int(1 << 12) != 0 {
                _21 = reader.readInt32()
            }
            var _22: Api.StarGiftBackground?
            if Int(_1 ?? 0) & Int(1 << 13) != 0 {
                if let signature = reader.readInt32() {
                    _22 = Api.parse(reader, signature: signature) as? Api.StarGiftBackground
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _7 != nil
            let _c8 = _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _13 != nil
            let _c14 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _14 != nil
            let _c15 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _15 != nil
            let _c16 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _16 != nil
            let _c17 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _17 != nil
            let _c18 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _18 != nil
            let _c19 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _19 != nil
            let _c20 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _20 != nil
            let _c21 = (Int(_1 ?? 0) & Int(1 << 12) == 0) || _21 != nil
            let _c22 = (Int(_1 ?? 0) & Int(1 << 13) == 0) || _22 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 && _c15 && _c16 && _c17 && _c18 && _c19 && _c20 && _c21 && _c22 {
                return Api.StarGift.starGift(Cons_starGift(flags: _1!, id: _2!, sticker: _3!, stars: _4!, availabilityRemains: _5, availabilityTotal: _6, availabilityResale: _7, convertStars: _8!, firstSaleDate: _9, lastSaleDate: _10, upgradeStars: _11, resellMinStars: _12, title: _13, releasedBy: _14, perUserTotal: _15, perUserRemains: _16, lockedUntilDate: _17, auctionSlug: _18, giftsPerRound: _19, auctionStartDate: _20, upgradeVariants: _21, background: _22))
            }
            else {
                return nil
            }
        }
        static func parse_starGiftUnique(_ reader: BufferReader) -> StarGift? {
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
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _8: String?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _8 = parseString(reader)
            }
            var _9: String?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _9 = parseString(reader)
            }
            var _10: [Api.StarGiftAttribute]?
            if let _ = reader.readInt32() {
                _10 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StarGiftAttribute.self)
            }
            var _11: Int32?
            _11 = reader.readInt32()
            var _12: Int32?
            _12 = reader.readInt32()
            var _13: String?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                _13 = parseString(reader)
            }
            var _14: [Api.StarsAmount]?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let _ = reader.readInt32() {
                    _14 = Api.parseVector(reader, elementSignature: 0, elementType: Api.StarsAmount.self)
                }
            }
            var _15: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                if let signature = reader.readInt32() {
                    _15 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _16: Int64?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                _16 = reader.readInt64()
            }
            var _17: String?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                _17 = parseString(reader)
            }
            var _18: Int64?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                _18 = reader.readInt64()
            }
            var _19: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                if let signature = reader.readInt32() {
                    _19 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _20: Api.PeerColor?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                if let signature = reader.readInt32() {
                    _20 = Api.parse(reader, signature: signature) as? Api.PeerColor
                }
            }
            var _21: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 12) != 0 {
                if let signature = reader.readInt32() {
                    _21 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _22: Int32?
            if Int(_1 ?? 0) & Int(1 << 13) != 0 {
                _22 = reader.readInt32()
            }
            var _23: Int32?
            if Int(_1 ?? 0) & Int(1 << 16) != 0 {
                _23 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _9 != nil
            let _c10 = _10 != nil
            let _c11 = _11 != nil
            let _c12 = _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _13 != nil
            let _c14 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _14 != nil
            let _c15 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _15 != nil
            let _c16 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _16 != nil
            let _c17 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _17 != nil
            let _c18 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _18 != nil
            let _c19 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _19 != nil
            let _c20 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _20 != nil
            let _c21 = (Int(_1 ?? 0) & Int(1 << 12) == 0) || _21 != nil
            let _c22 = (Int(_1 ?? 0) & Int(1 << 13) == 0) || _22 != nil
            let _c23 = (Int(_1 ?? 0) & Int(1 << 16) == 0) || _23 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 && _c15 && _c16 && _c17 && _c18 && _c19 && _c20 && _c21 && _c22 && _c23 {
                return Api.StarGift.starGiftUnique(Cons_starGiftUnique(flags: _1!, id: _2!, giftId: _3!, title: _4!, slug: _5!, num: _6!, ownerId: _7, ownerName: _8, ownerAddress: _9, attributes: _10!, availabilityIssued: _11!, availabilityTotal: _12!, giftAddress: _13, resellAmount: _14, releasedBy: _15, valueAmount: _16, valueCurrency: _17, valueUsdAmount: _18, themePeer: _19, peerColor: _20, hostId: _21, offerMinStars: _22, craftChancePermille: _23))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarGiftActiveAuctionState: TypeConstructorDescription {
        class Cons_starGiftActiveAuctionState: TypeConstructorDescription {
            var gift: Api.StarGift
            var state: Api.StarGiftAuctionState
            var userState: Api.StarGiftAuctionUserState
            init(gift: Api.StarGift, state: Api.StarGiftAuctionState, userState: Api.StarGiftAuctionUserState) {
                self.gift = gift
                self.state = state
                self.userState = userState
            }
        }
        case starGiftActiveAuctionState(Cons_starGiftActiveAuctionState)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starGiftActiveAuctionState(let _data):
                if boxed {
                    buffer.appendInt32(-753154979)
                }
                _data.gift.serialize(buffer, true)
                _data.state.serialize(buffer, true)
                _data.userState.serialize(buffer, true)
                break
            }
        }

        static func parse_starGiftActiveAuctionState(_ reader: BufferReader) -> StarGiftActiveAuctionState? {
            var _1: Api.StarGift?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.StarGift
            }
            var _2: Api.StarGiftAuctionState?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.StarGiftAuctionState
            }
            var _3: Api.StarGiftAuctionUserState?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.StarGiftAuctionUserState
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.StarGiftActiveAuctionState.starGiftActiveAuctionState(Cons_starGiftActiveAuctionState(gift: _1!, state: _2!, userState: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarGiftAttribute: TypeConstructorDescription {
        class Cons_starGiftAttributeBackdrop: TypeConstructorDescription {
            var name: String
            var backdropId: Int32
            var centerColor: Int32
            var edgeColor: Int32
            var patternColor: Int32
            var textColor: Int32
            var rarity: Api.StarGiftAttributeRarity
            init(name: String, backdropId: Int32, centerColor: Int32, edgeColor: Int32, patternColor: Int32, textColor: Int32, rarity: Api.StarGiftAttributeRarity) {
                self.name = name
                self.backdropId = backdropId
                self.centerColor = centerColor
                self.edgeColor = edgeColor
                self.patternColor = patternColor
                self.textColor = textColor
                self.rarity = rarity
            }
        }
        class Cons_starGiftAttributeModel: TypeConstructorDescription {
            var flags: Int32
            var name: String
            var document: Api.Document
            var rarity: Api.StarGiftAttributeRarity
            init(flags: Int32, name: String, document: Api.Document, rarity: Api.StarGiftAttributeRarity) {
                self.flags = flags
                self.name = name
                self.document = document
                self.rarity = rarity
            }
        }
        class Cons_starGiftAttributeOriginalDetails: TypeConstructorDescription {
            var flags: Int32
            var senderId: Api.Peer?
            var recipientId: Api.Peer
            var date: Int32
            var message: Api.TextWithEntities?
            init(flags: Int32, senderId: Api.Peer?, recipientId: Api.Peer, date: Int32, message: Api.TextWithEntities?) {
                self.flags = flags
                self.senderId = senderId
                self.recipientId = recipientId
                self.date = date
                self.message = message
            }
        }
        class Cons_starGiftAttributePattern: TypeConstructorDescription {
            var name: String
            var document: Api.Document
            var rarity: Api.StarGiftAttributeRarity
            init(name: String, document: Api.Document, rarity: Api.StarGiftAttributeRarity) {
                self.name = name
                self.document = document
                self.rarity = rarity
            }
        }
        case starGiftAttributeBackdrop(Cons_starGiftAttributeBackdrop)
        case starGiftAttributeModel(Cons_starGiftAttributeModel)
        case starGiftAttributeOriginalDetails(Cons_starGiftAttributeOriginalDetails)
        case starGiftAttributePattern(Cons_starGiftAttributePattern)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starGiftAttributeBackdrop(let _data):
                if boxed {
                    buffer.appendInt32(-1624963868)
                }
                serializeString(_data.name, buffer: buffer, boxed: false)
                serializeInt32(_data.backdropId, buffer: buffer, boxed: false)
                serializeInt32(_data.centerColor, buffer: buffer, boxed: false)
                serializeInt32(_data.edgeColor, buffer: buffer, boxed: false)
                serializeInt32(_data.patternColor, buffer: buffer, boxed: false)
                serializeInt32(_data.textColor, buffer: buffer, boxed: false)
                _data.rarity.serialize(buffer, true)
                break
            case .starGiftAttributeModel(let _data):
                if boxed {
                    buffer.appendInt32(1448235490)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.name, buffer: buffer, boxed: false)
                _data.document.serialize(buffer, true)
                _data.rarity.serialize(buffer, true)
                break
            case .starGiftAttributeOriginalDetails(let _data):
                if boxed {
                    buffer.appendInt32(-524291476)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.senderId!.serialize(buffer, true)
                }
                _data.recipientId.serialize(buffer, true)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.message!.serialize(buffer, true)
                }
                break
            case .starGiftAttributePattern(let _data):
                if boxed {
                    buffer.appendInt32(1315997162)
                }
                serializeString(_data.name, buffer: buffer, boxed: false)
                _data.document.serialize(buffer, true)
                _data.rarity.serialize(buffer, true)
                break
            }
        }

        static func parse_starGiftAttributeBackdrop(_ reader: BufferReader) -> StarGiftAttribute? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int32?
            _3 = reader.readInt32()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: Int32?
            _6 = reader.readInt32()
            var _7: Api.StarGiftAttributeRarity?
            if let signature = reader.readInt32() {
                _7 = Api.parse(reader, signature: signature) as? Api.StarGiftAttributeRarity
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = _6 != nil
            let _c7 = _7 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 {
                return Api.StarGiftAttribute.starGiftAttributeBackdrop(Cons_starGiftAttributeBackdrop(name: _1!, backdropId: _2!, centerColor: _3!, edgeColor: _4!, patternColor: _5!, textColor: _6!, rarity: _7!))
            }
            else {
                return nil
            }
        }
        static func parse_starGiftAttributeModel(_ reader: BufferReader) -> StarGiftAttribute? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: Api.Document?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Document
            }
            var _4: Api.StarGiftAttributeRarity?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.StarGiftAttributeRarity
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.StarGiftAttribute.starGiftAttributeModel(Cons_starGiftAttributeModel(flags: _1!, name: _2!, document: _3!, rarity: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_starGiftAttributeOriginalDetails(_ reader: BufferReader) -> StarGiftAttribute? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _3: Api.Peer?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Api.TextWithEntities?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.TextWithEntities
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.StarGiftAttribute.starGiftAttributeOriginalDetails(Cons_starGiftAttributeOriginalDetails(flags: _1!, senderId: _2, recipientId: _3!, date: _4!, message: _5))
            }
            else {
                return nil
            }
        }
        static func parse_starGiftAttributePattern(_ reader: BufferReader) -> StarGiftAttribute? {
            var _1: String?
            _1 = parseString(reader)
            var _2: Api.Document?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Document
            }
            var _3: Api.StarGiftAttributeRarity?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.StarGiftAttributeRarity
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.StarGiftAttribute.starGiftAttributePattern(Cons_starGiftAttributePattern(name: _1!, document: _2!, rarity: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum StarGiftAttributeCounter: TypeConstructorDescription {
        class Cons_starGiftAttributeCounter: TypeConstructorDescription {
            var attribute: Api.StarGiftAttributeId
            var count: Int32
            init(attribute: Api.StarGiftAttributeId, count: Int32) {
                self.attribute = attribute
                self.count = count
            }
        }
        case starGiftAttributeCounter(Cons_starGiftAttributeCounter)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .starGiftAttributeCounter(let _data):
                if boxed {
                    buffer.appendInt32(783398488)
                }
                _data.attribute.serialize(buffer, true)
                serializeInt32(_data.count, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_starGiftAttributeCounter(_ reader: BufferReader) -> StarGiftAttributeCounter? {
            var _1: Api.StarGiftAttributeId?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.StarGiftAttributeId
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.StarGiftAttributeCounter.starGiftAttributeCounter(Cons_starGiftAttributeCounter(attribute: _1!, count: _2!))
            }
            else {
                return nil
            }
        }
    }
}
