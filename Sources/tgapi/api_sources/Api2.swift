extension Api {
    enum ChannelAdminLogEventAction: TypeConstructorDescription {
        class Cons_channelAdminLogEventActionChangeAbout: TypeConstructorDescription {
            var prevValue: String
            var newValue: String
            init(prevValue: String, newValue: String) {
                self.prevValue = prevValue
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionChangeAvailableReactions: TypeConstructorDescription {
            var prevValue: Api.ChatReactions
            var newValue: Api.ChatReactions
            init(prevValue: Api.ChatReactions, newValue: Api.ChatReactions) {
                self.prevValue = prevValue
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionChangeEmojiStatus: TypeConstructorDescription {
            var prevValue: Api.EmojiStatus
            var newValue: Api.EmojiStatus
            init(prevValue: Api.EmojiStatus, newValue: Api.EmojiStatus) {
                self.prevValue = prevValue
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionChangeEmojiStickerSet: TypeConstructorDescription {
            var prevStickerset: Api.InputStickerSet
            var newStickerset: Api.InputStickerSet
            init(prevStickerset: Api.InputStickerSet, newStickerset: Api.InputStickerSet) {
                self.prevStickerset = prevStickerset
                self.newStickerset = newStickerset
            }
        }
        class Cons_channelAdminLogEventActionChangeHistoryTTL: TypeConstructorDescription {
            var prevValue: Int32
            var newValue: Int32
            init(prevValue: Int32, newValue: Int32) {
                self.prevValue = prevValue
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionChangeLinkedChat: TypeConstructorDescription {
            var prevValue: Int64
            var newValue: Int64
            init(prevValue: Int64, newValue: Int64) {
                self.prevValue = prevValue
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionChangeLocation: TypeConstructorDescription {
            var prevValue: Api.ChannelLocation
            var newValue: Api.ChannelLocation
            init(prevValue: Api.ChannelLocation, newValue: Api.ChannelLocation) {
                self.prevValue = prevValue
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionChangePeerColor: TypeConstructorDescription {
            var prevValue: Api.PeerColor
            var newValue: Api.PeerColor
            init(prevValue: Api.PeerColor, newValue: Api.PeerColor) {
                self.prevValue = prevValue
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionChangePhoto: TypeConstructorDescription {
            var prevPhoto: Api.Photo
            var newPhoto: Api.Photo
            init(prevPhoto: Api.Photo, newPhoto: Api.Photo) {
                self.prevPhoto = prevPhoto
                self.newPhoto = newPhoto
            }
        }
        class Cons_channelAdminLogEventActionChangeProfilePeerColor: TypeConstructorDescription {
            var prevValue: Api.PeerColor
            var newValue: Api.PeerColor
            init(prevValue: Api.PeerColor, newValue: Api.PeerColor) {
                self.prevValue = prevValue
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionChangeStickerSet: TypeConstructorDescription {
            var prevStickerset: Api.InputStickerSet
            var newStickerset: Api.InputStickerSet
            init(prevStickerset: Api.InputStickerSet, newStickerset: Api.InputStickerSet) {
                self.prevStickerset = prevStickerset
                self.newStickerset = newStickerset
            }
        }
        class Cons_channelAdminLogEventActionChangeTitle: TypeConstructorDescription {
            var prevValue: String
            var newValue: String
            init(prevValue: String, newValue: String) {
                self.prevValue = prevValue
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionChangeUsername: TypeConstructorDescription {
            var prevValue: String
            var newValue: String
            init(prevValue: String, newValue: String) {
                self.prevValue = prevValue
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionChangeUsernames: TypeConstructorDescription {
            var prevValue: [String]
            var newValue: [String]
            init(prevValue: [String], newValue: [String]) {
                self.prevValue = prevValue
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionChangeWallpaper: TypeConstructorDescription {
            var prevValue: Api.WallPaper
            var newValue: Api.WallPaper
            init(prevValue: Api.WallPaper, newValue: Api.WallPaper) {
                self.prevValue = prevValue
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionCreateTopic: TypeConstructorDescription {
            var topic: Api.ForumTopic
            init(topic: Api.ForumTopic) {
                self.topic = topic
            }
        }
        class Cons_channelAdminLogEventActionDefaultBannedRights: TypeConstructorDescription {
            var prevBannedRights: Api.ChatBannedRights
            var newBannedRights: Api.ChatBannedRights
            init(prevBannedRights: Api.ChatBannedRights, newBannedRights: Api.ChatBannedRights) {
                self.prevBannedRights = prevBannedRights
                self.newBannedRights = newBannedRights
            }
        }
        class Cons_channelAdminLogEventActionDeleteMessage: TypeConstructorDescription {
            var message: Api.Message
            init(message: Api.Message) {
                self.message = message
            }
        }
        class Cons_channelAdminLogEventActionDeleteTopic: TypeConstructorDescription {
            var topic: Api.ForumTopic
            init(topic: Api.ForumTopic) {
                self.topic = topic
            }
        }
        class Cons_channelAdminLogEventActionDiscardGroupCall: TypeConstructorDescription {
            var call: Api.InputGroupCall
            init(call: Api.InputGroupCall) {
                self.call = call
            }
        }
        class Cons_channelAdminLogEventActionEditMessage: TypeConstructorDescription {
            var prevMessage: Api.Message
            var newMessage: Api.Message
            init(prevMessage: Api.Message, newMessage: Api.Message) {
                self.prevMessage = prevMessage
                self.newMessage = newMessage
            }
        }
        class Cons_channelAdminLogEventActionEditTopic: TypeConstructorDescription {
            var prevTopic: Api.ForumTopic
            var newTopic: Api.ForumTopic
            init(prevTopic: Api.ForumTopic, newTopic: Api.ForumTopic) {
                self.prevTopic = prevTopic
                self.newTopic = newTopic
            }
        }
        class Cons_channelAdminLogEventActionExportedInviteDelete: TypeConstructorDescription {
            var invite: Api.ExportedChatInvite
            init(invite: Api.ExportedChatInvite) {
                self.invite = invite
            }
        }
        class Cons_channelAdminLogEventActionExportedInviteEdit: TypeConstructorDescription {
            var prevInvite: Api.ExportedChatInvite
            var newInvite: Api.ExportedChatInvite
            init(prevInvite: Api.ExportedChatInvite, newInvite: Api.ExportedChatInvite) {
                self.prevInvite = prevInvite
                self.newInvite = newInvite
            }
        }
        class Cons_channelAdminLogEventActionExportedInviteRevoke: TypeConstructorDescription {
            var invite: Api.ExportedChatInvite
            init(invite: Api.ExportedChatInvite) {
                self.invite = invite
            }
        }
        class Cons_channelAdminLogEventActionParticipantEditRank: TypeConstructorDescription {
            var userId: Int64
            var prevRank: String
            var newRank: String
            init(userId: Int64, prevRank: String, newRank: String) {
                self.userId = userId
                self.prevRank = prevRank
                self.newRank = newRank
            }
        }
        class Cons_channelAdminLogEventActionParticipantInvite: TypeConstructorDescription {
            var participant: Api.ChannelParticipant
            init(participant: Api.ChannelParticipant) {
                self.participant = participant
            }
        }
        class Cons_channelAdminLogEventActionParticipantJoinByInvite: TypeConstructorDescription {
            var flags: Int32
            var invite: Api.ExportedChatInvite
            init(flags: Int32, invite: Api.ExportedChatInvite) {
                self.flags = flags
                self.invite = invite
            }
        }
        class Cons_channelAdminLogEventActionParticipantJoinByRequest: TypeConstructorDescription {
            var invite: Api.ExportedChatInvite
            var approvedBy: Int64
            init(invite: Api.ExportedChatInvite, approvedBy: Int64) {
                self.invite = invite
                self.approvedBy = approvedBy
            }
        }
        class Cons_channelAdminLogEventActionParticipantMute: TypeConstructorDescription {
            var participant: Api.GroupCallParticipant
            init(participant: Api.GroupCallParticipant) {
                self.participant = participant
            }
        }
        class Cons_channelAdminLogEventActionParticipantSubExtend: TypeConstructorDescription {
            var prevParticipant: Api.ChannelParticipant
            var newParticipant: Api.ChannelParticipant
            init(prevParticipant: Api.ChannelParticipant, newParticipant: Api.ChannelParticipant) {
                self.prevParticipant = prevParticipant
                self.newParticipant = newParticipant
            }
        }
        class Cons_channelAdminLogEventActionParticipantToggleAdmin: TypeConstructorDescription {
            var prevParticipant: Api.ChannelParticipant
            var newParticipant: Api.ChannelParticipant
            init(prevParticipant: Api.ChannelParticipant, newParticipant: Api.ChannelParticipant) {
                self.prevParticipant = prevParticipant
                self.newParticipant = newParticipant
            }
        }
        class Cons_channelAdminLogEventActionParticipantToggleBan: TypeConstructorDescription {
            var prevParticipant: Api.ChannelParticipant
            var newParticipant: Api.ChannelParticipant
            init(prevParticipant: Api.ChannelParticipant, newParticipant: Api.ChannelParticipant) {
                self.prevParticipant = prevParticipant
                self.newParticipant = newParticipant
            }
        }
        class Cons_channelAdminLogEventActionParticipantUnmute: TypeConstructorDescription {
            var participant: Api.GroupCallParticipant
            init(participant: Api.GroupCallParticipant) {
                self.participant = participant
            }
        }
        class Cons_channelAdminLogEventActionParticipantVolume: TypeConstructorDescription {
            var participant: Api.GroupCallParticipant
            init(participant: Api.GroupCallParticipant) {
                self.participant = participant
            }
        }
        class Cons_channelAdminLogEventActionPinTopic: TypeConstructorDescription {
            var flags: Int32
            var prevTopic: Api.ForumTopic?
            var newTopic: Api.ForumTopic?
            init(flags: Int32, prevTopic: Api.ForumTopic?, newTopic: Api.ForumTopic?) {
                self.flags = flags
                self.prevTopic = prevTopic
                self.newTopic = newTopic
            }
        }
        class Cons_channelAdminLogEventActionSendMessage: TypeConstructorDescription {
            var message: Api.Message
            init(message: Api.Message) {
                self.message = message
            }
        }
        class Cons_channelAdminLogEventActionStartGroupCall: TypeConstructorDescription {
            var call: Api.InputGroupCall
            init(call: Api.InputGroupCall) {
                self.call = call
            }
        }
        class Cons_channelAdminLogEventActionStopPoll: TypeConstructorDescription {
            var message: Api.Message
            init(message: Api.Message) {
                self.message = message
            }
        }
        class Cons_channelAdminLogEventActionToggleAntiSpam: TypeConstructorDescription {
            var newValue: Api.Bool
            init(newValue: Api.Bool) {
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionToggleAutotranslation: TypeConstructorDescription {
            var newValue: Api.Bool
            init(newValue: Api.Bool) {
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionToggleForum: TypeConstructorDescription {
            var newValue: Api.Bool
            init(newValue: Api.Bool) {
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionToggleGroupCallSetting: TypeConstructorDescription {
            var joinMuted: Api.Bool
            init(joinMuted: Api.Bool) {
                self.joinMuted = joinMuted
            }
        }
        class Cons_channelAdminLogEventActionToggleInvites: TypeConstructorDescription {
            var newValue: Api.Bool
            init(newValue: Api.Bool) {
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionToggleNoForwards: TypeConstructorDescription {
            var newValue: Api.Bool
            init(newValue: Api.Bool) {
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionTogglePreHistoryHidden: TypeConstructorDescription {
            var newValue: Api.Bool
            init(newValue: Api.Bool) {
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionToggleSignatureProfiles: TypeConstructorDescription {
            var newValue: Api.Bool
            init(newValue: Api.Bool) {
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionToggleSignatures: TypeConstructorDescription {
            var newValue: Api.Bool
            init(newValue: Api.Bool) {
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionToggleSlowMode: TypeConstructorDescription {
            var prevValue: Int32
            var newValue: Int32
            init(prevValue: Int32, newValue: Int32) {
                self.prevValue = prevValue
                self.newValue = newValue
            }
        }
        class Cons_channelAdminLogEventActionUpdatePinned: TypeConstructorDescription {
            var message: Api.Message
            init(message: Api.Message) {
                self.message = message
            }
        }
        case channelAdminLogEventActionChangeAbout(Cons_channelAdminLogEventActionChangeAbout)
        case channelAdminLogEventActionChangeAvailableReactions(Cons_channelAdminLogEventActionChangeAvailableReactions)
        case channelAdminLogEventActionChangeEmojiStatus(Cons_channelAdminLogEventActionChangeEmojiStatus)
        case channelAdminLogEventActionChangeEmojiStickerSet(Cons_channelAdminLogEventActionChangeEmojiStickerSet)
        case channelAdminLogEventActionChangeHistoryTTL(Cons_channelAdminLogEventActionChangeHistoryTTL)
        case channelAdminLogEventActionChangeLinkedChat(Cons_channelAdminLogEventActionChangeLinkedChat)
        case channelAdminLogEventActionChangeLocation(Cons_channelAdminLogEventActionChangeLocation)
        case channelAdminLogEventActionChangePeerColor(Cons_channelAdminLogEventActionChangePeerColor)
        case channelAdminLogEventActionChangePhoto(Cons_channelAdminLogEventActionChangePhoto)
        case channelAdminLogEventActionChangeProfilePeerColor(Cons_channelAdminLogEventActionChangeProfilePeerColor)
        case channelAdminLogEventActionChangeStickerSet(Cons_channelAdminLogEventActionChangeStickerSet)
        case channelAdminLogEventActionChangeTitle(Cons_channelAdminLogEventActionChangeTitle)
        case channelAdminLogEventActionChangeUsername(Cons_channelAdminLogEventActionChangeUsername)
        case channelAdminLogEventActionChangeUsernames(Cons_channelAdminLogEventActionChangeUsernames)
        case channelAdminLogEventActionChangeWallpaper(Cons_channelAdminLogEventActionChangeWallpaper)
        case channelAdminLogEventActionCreateTopic(Cons_channelAdminLogEventActionCreateTopic)
        case channelAdminLogEventActionDefaultBannedRights(Cons_channelAdminLogEventActionDefaultBannedRights)
        case channelAdminLogEventActionDeleteMessage(Cons_channelAdminLogEventActionDeleteMessage)
        case channelAdminLogEventActionDeleteTopic(Cons_channelAdminLogEventActionDeleteTopic)
        case channelAdminLogEventActionDiscardGroupCall(Cons_channelAdminLogEventActionDiscardGroupCall)
        case channelAdminLogEventActionEditMessage(Cons_channelAdminLogEventActionEditMessage)
        case channelAdminLogEventActionEditTopic(Cons_channelAdminLogEventActionEditTopic)
        case channelAdminLogEventActionExportedInviteDelete(Cons_channelAdminLogEventActionExportedInviteDelete)
        case channelAdminLogEventActionExportedInviteEdit(Cons_channelAdminLogEventActionExportedInviteEdit)
        case channelAdminLogEventActionExportedInviteRevoke(Cons_channelAdminLogEventActionExportedInviteRevoke)
        case channelAdminLogEventActionParticipantEditRank(Cons_channelAdminLogEventActionParticipantEditRank)
        case channelAdminLogEventActionParticipantInvite(Cons_channelAdminLogEventActionParticipantInvite)
        case channelAdminLogEventActionParticipantJoin
        case channelAdminLogEventActionParticipantJoinByInvite(Cons_channelAdminLogEventActionParticipantJoinByInvite)
        case channelAdminLogEventActionParticipantJoinByRequest(Cons_channelAdminLogEventActionParticipantJoinByRequest)
        case channelAdminLogEventActionParticipantLeave
        case channelAdminLogEventActionParticipantMute(Cons_channelAdminLogEventActionParticipantMute)
        case channelAdminLogEventActionParticipantSubExtend(Cons_channelAdminLogEventActionParticipantSubExtend)
        case channelAdminLogEventActionParticipantToggleAdmin(Cons_channelAdminLogEventActionParticipantToggleAdmin)
        case channelAdminLogEventActionParticipantToggleBan(Cons_channelAdminLogEventActionParticipantToggleBan)
        case channelAdminLogEventActionParticipantUnmute(Cons_channelAdminLogEventActionParticipantUnmute)
        case channelAdminLogEventActionParticipantVolume(Cons_channelAdminLogEventActionParticipantVolume)
        case channelAdminLogEventActionPinTopic(Cons_channelAdminLogEventActionPinTopic)
        case channelAdminLogEventActionSendMessage(Cons_channelAdminLogEventActionSendMessage)
        case channelAdminLogEventActionStartGroupCall(Cons_channelAdminLogEventActionStartGroupCall)
        case channelAdminLogEventActionStopPoll(Cons_channelAdminLogEventActionStopPoll)
        case channelAdminLogEventActionToggleAntiSpam(Cons_channelAdminLogEventActionToggleAntiSpam)
        case channelAdminLogEventActionToggleAutotranslation(Cons_channelAdminLogEventActionToggleAutotranslation)
        case channelAdminLogEventActionToggleForum(Cons_channelAdminLogEventActionToggleForum)
        case channelAdminLogEventActionToggleGroupCallSetting(Cons_channelAdminLogEventActionToggleGroupCallSetting)
        case channelAdminLogEventActionToggleInvites(Cons_channelAdminLogEventActionToggleInvites)
        case channelAdminLogEventActionToggleNoForwards(Cons_channelAdminLogEventActionToggleNoForwards)
        case channelAdminLogEventActionTogglePreHistoryHidden(Cons_channelAdminLogEventActionTogglePreHistoryHidden)
        case channelAdminLogEventActionToggleSignatureProfiles(Cons_channelAdminLogEventActionToggleSignatureProfiles)
        case channelAdminLogEventActionToggleSignatures(Cons_channelAdminLogEventActionToggleSignatures)
        case channelAdminLogEventActionToggleSlowMode(Cons_channelAdminLogEventActionToggleSlowMode)
        case channelAdminLogEventActionUpdatePinned(Cons_channelAdminLogEventActionUpdatePinned)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .channelAdminLogEventActionChangeAbout(let _data):
                if boxed {
                    buffer.appendInt32(1427671598)
                }
                serializeString(_data.prevValue, buffer: buffer, boxed: false)
                serializeString(_data.newValue, buffer: buffer, boxed: false)
                break
            case .channelAdminLogEventActionChangeAvailableReactions(let _data):
                if boxed {
                    buffer.appendInt32(-1102180616)
                }
                _data.prevValue.serialize(buffer, true)
                _data.newValue.serialize(buffer, true)
                break
            case .channelAdminLogEventActionChangeEmojiStatus(let _data):
                if boxed {
                    buffer.appendInt32(1051328177)
                }
                _data.prevValue.serialize(buffer, true)
                _data.newValue.serialize(buffer, true)
                break
            case .channelAdminLogEventActionChangeEmojiStickerSet(let _data):
                if boxed {
                    buffer.appendInt32(1188577451)
                }
                _data.prevStickerset.serialize(buffer, true)
                _data.newStickerset.serialize(buffer, true)
                break
            case .channelAdminLogEventActionChangeHistoryTTL(let _data):
                if boxed {
                    buffer.appendInt32(1855199800)
                }
                serializeInt32(_data.prevValue, buffer: buffer, boxed: false)
                serializeInt32(_data.newValue, buffer: buffer, boxed: false)
                break
            case .channelAdminLogEventActionChangeLinkedChat(let _data):
                if boxed {
                    buffer.appendInt32(84703944)
                }
                serializeInt64(_data.prevValue, buffer: buffer, boxed: false)
                serializeInt64(_data.newValue, buffer: buffer, boxed: false)
                break
            case .channelAdminLogEventActionChangeLocation(let _data):
                if boxed {
                    buffer.appendInt32(241923758)
                }
                _data.prevValue.serialize(buffer, true)
                _data.newValue.serialize(buffer, true)
                break
            case .channelAdminLogEventActionChangePeerColor(let _data):
                if boxed {
                    buffer.appendInt32(1469507456)
                }
                _data.prevValue.serialize(buffer, true)
                _data.newValue.serialize(buffer, true)
                break
            case .channelAdminLogEventActionChangePhoto(let _data):
                if boxed {
                    buffer.appendInt32(1129042607)
                }
                _data.prevPhoto.serialize(buffer, true)
                _data.newPhoto.serialize(buffer, true)
                break
            case .channelAdminLogEventActionChangeProfilePeerColor(let _data):
                if boxed {
                    buffer.appendInt32(1581742885)
                }
                _data.prevValue.serialize(buffer, true)
                _data.newValue.serialize(buffer, true)
                break
            case .channelAdminLogEventActionChangeStickerSet(let _data):
                if boxed {
                    buffer.appendInt32(-1312568665)
                }
                _data.prevStickerset.serialize(buffer, true)
                _data.newStickerset.serialize(buffer, true)
                break
            case .channelAdminLogEventActionChangeTitle(let _data):
                if boxed {
                    buffer.appendInt32(-421545947)
                }
                serializeString(_data.prevValue, buffer: buffer, boxed: false)
                serializeString(_data.newValue, buffer: buffer, boxed: false)
                break
            case .channelAdminLogEventActionChangeUsername(let _data):
                if boxed {
                    buffer.appendInt32(1783299128)
                }
                serializeString(_data.prevValue, buffer: buffer, boxed: false)
                serializeString(_data.newValue, buffer: buffer, boxed: false)
                break
            case .channelAdminLogEventActionChangeUsernames(let _data):
                if boxed {
                    buffer.appendInt32(-263212119)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.prevValue.count))
                for item in _data.prevValue {
                    serializeString(item, buffer: buffer, boxed: false)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.newValue.count))
                for item in _data.newValue {
                    serializeString(item, buffer: buffer, boxed: false)
                }
                break
            case .channelAdminLogEventActionChangeWallpaper(let _data):
                if boxed {
                    buffer.appendInt32(834362706)
                }
                _data.prevValue.serialize(buffer, true)
                _data.newValue.serialize(buffer, true)
                break
            case .channelAdminLogEventActionCreateTopic(let _data):
                if boxed {
                    buffer.appendInt32(1483767080)
                }
                _data.topic.serialize(buffer, true)
                break
            case .channelAdminLogEventActionDefaultBannedRights(let _data):
                if boxed {
                    buffer.appendInt32(771095562)
                }
                _data.prevBannedRights.serialize(buffer, true)
                _data.newBannedRights.serialize(buffer, true)
                break
            case .channelAdminLogEventActionDeleteMessage(let _data):
                if boxed {
                    buffer.appendInt32(1121994683)
                }
                _data.message.serialize(buffer, true)
                break
            case .channelAdminLogEventActionDeleteTopic(let _data):
                if boxed {
                    buffer.appendInt32(-1374254839)
                }
                _data.topic.serialize(buffer, true)
                break
            case .channelAdminLogEventActionDiscardGroupCall(let _data):
                if boxed {
                    buffer.appendInt32(-610299584)
                }
                _data.call.serialize(buffer, true)
                break
            case .channelAdminLogEventActionEditMessage(let _data):
                if boxed {
                    buffer.appendInt32(1889215493)
                }
                _data.prevMessage.serialize(buffer, true)
                _data.newMessage.serialize(buffer, true)
                break
            case .channelAdminLogEventActionEditTopic(let _data):
                if boxed {
                    buffer.appendInt32(-261103096)
                }
                _data.prevTopic.serialize(buffer, true)
                _data.newTopic.serialize(buffer, true)
                break
            case .channelAdminLogEventActionExportedInviteDelete(let _data):
                if boxed {
                    buffer.appendInt32(1515256996)
                }
                _data.invite.serialize(buffer, true)
                break
            case .channelAdminLogEventActionExportedInviteEdit(let _data):
                if boxed {
                    buffer.appendInt32(-384910503)
                }
                _data.prevInvite.serialize(buffer, true)
                _data.newInvite.serialize(buffer, true)
                break
            case .channelAdminLogEventActionExportedInviteRevoke(let _data):
                if boxed {
                    buffer.appendInt32(1091179342)
                }
                _data.invite.serialize(buffer, true)
                break
            case .channelAdminLogEventActionParticipantEditRank(let _data):
                if boxed {
                    buffer.appendInt32(1476834540)
                }
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeString(_data.prevRank, buffer: buffer, boxed: false)
                serializeString(_data.newRank, buffer: buffer, boxed: false)
                break
            case .channelAdminLogEventActionParticipantInvite(let _data):
                if boxed {
                    buffer.appendInt32(-484690728)
                }
                _data.participant.serialize(buffer, true)
                break
            case .channelAdminLogEventActionParticipantJoin:
                if boxed {
                    buffer.appendInt32(405815507)
                }
                break
            case .channelAdminLogEventActionParticipantJoinByInvite(let _data):
                if boxed {
                    buffer.appendInt32(-23084712)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.invite.serialize(buffer, true)
                break
            case .channelAdminLogEventActionParticipantJoinByRequest(let _data):
                if boxed {
                    buffer.appendInt32(-1347021750)
                }
                _data.invite.serialize(buffer, true)
                serializeInt64(_data.approvedBy, buffer: buffer, boxed: false)
                break
            case .channelAdminLogEventActionParticipantLeave:
                if boxed {
                    buffer.appendInt32(-124291086)
                }
                break
            case .channelAdminLogEventActionParticipantMute(let _data):
                if boxed {
                    buffer.appendInt32(-115071790)
                }
                _data.participant.serialize(buffer, true)
                break
            case .channelAdminLogEventActionParticipantSubExtend(let _data):
                if boxed {
                    buffer.appendInt32(1684286899)
                }
                _data.prevParticipant.serialize(buffer, true)
                _data.newParticipant.serialize(buffer, true)
                break
            case .channelAdminLogEventActionParticipantToggleAdmin(let _data):
                if boxed {
                    buffer.appendInt32(-714643696)
                }
                _data.prevParticipant.serialize(buffer, true)
                _data.newParticipant.serialize(buffer, true)
                break
            case .channelAdminLogEventActionParticipantToggleBan(let _data):
                if boxed {
                    buffer.appendInt32(-422036098)
                }
                _data.prevParticipant.serialize(buffer, true)
                _data.newParticipant.serialize(buffer, true)
                break
            case .channelAdminLogEventActionParticipantUnmute(let _data):
                if boxed {
                    buffer.appendInt32(-431740480)
                }
                _data.participant.serialize(buffer, true)
                break
            case .channelAdminLogEventActionParticipantVolume(let _data):
                if boxed {
                    buffer.appendInt32(1048537159)
                }
                _data.participant.serialize(buffer, true)
                break
            case .channelAdminLogEventActionPinTopic(let _data):
                if boxed {
                    buffer.appendInt32(1569535291)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.prevTopic!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    _data.newTopic!.serialize(buffer, true)
                }
                break
            case .channelAdminLogEventActionSendMessage(let _data):
                if boxed {
                    buffer.appendInt32(663693416)
                }
                _data.message.serialize(buffer, true)
                break
            case .channelAdminLogEventActionStartGroupCall(let _data):
                if boxed {
                    buffer.appendInt32(589338437)
                }
                _data.call.serialize(buffer, true)
                break
            case .channelAdminLogEventActionStopPoll(let _data):
                if boxed {
                    buffer.appendInt32(-1895328189)
                }
                _data.message.serialize(buffer, true)
                break
            case .channelAdminLogEventActionToggleAntiSpam(let _data):
                if boxed {
                    buffer.appendInt32(1693675004)
                }
                _data.newValue.serialize(buffer, true)
                break
            case .channelAdminLogEventActionToggleAutotranslation(let _data):
                if boxed {
                    buffer.appendInt32(-988285058)
                }
                _data.newValue.serialize(buffer, true)
                break
            case .channelAdminLogEventActionToggleForum(let _data):
                if boxed {
                    buffer.appendInt32(46949251)
                }
                _data.newValue.serialize(buffer, true)
                break
            case .channelAdminLogEventActionToggleGroupCallSetting(let _data):
                if boxed {
                    buffer.appendInt32(1456906823)
                }
                _data.joinMuted.serialize(buffer, true)
                break
            case .channelAdminLogEventActionToggleInvites(let _data):
                if boxed {
                    buffer.appendInt32(460916654)
                }
                _data.newValue.serialize(buffer, true)
                break
            case .channelAdminLogEventActionToggleNoForwards(let _data):
                if boxed {
                    buffer.appendInt32(-886388890)
                }
                _data.newValue.serialize(buffer, true)
                break
            case .channelAdminLogEventActionTogglePreHistoryHidden(let _data):
                if boxed {
                    buffer.appendInt32(1599903217)
                }
                _data.newValue.serialize(buffer, true)
                break
            case .channelAdminLogEventActionToggleSignatureProfiles(let _data):
                if boxed {
                    buffer.appendInt32(1621597305)
                }
                _data.newValue.serialize(buffer, true)
                break
            case .channelAdminLogEventActionToggleSignatures(let _data):
                if boxed {
                    buffer.appendInt32(648939889)
                }
                _data.newValue.serialize(buffer, true)
                break
            case .channelAdminLogEventActionToggleSlowMode(let _data):
                if boxed {
                    buffer.appendInt32(1401984889)
                }
                serializeInt32(_data.prevValue, buffer: buffer, boxed: false)
                serializeInt32(_data.newValue, buffer: buffer, boxed: false)
                break
            case .channelAdminLogEventActionUpdatePinned(let _data):
                if boxed {
                    buffer.appendInt32(-370660328)
                }
                _data.message.serialize(buffer, true)
                break
            }
        }

        static func parse_channelAdminLogEventActionChangeAbout(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: String?
            _1 = parseString(reader)
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionChangeAbout(Cons_channelAdminLogEventActionChangeAbout(prevValue: _1!, newValue: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionChangeAvailableReactions(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.ChatReactions?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ChatReactions
            }
            var _2: Api.ChatReactions?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.ChatReactions
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionChangeAvailableReactions(Cons_channelAdminLogEventActionChangeAvailableReactions(prevValue: _1!, newValue: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionChangeEmojiStatus(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.EmojiStatus?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.EmojiStatus
            }
            var _2: Api.EmojiStatus?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.EmojiStatus
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionChangeEmojiStatus(Cons_channelAdminLogEventActionChangeEmojiStatus(prevValue: _1!, newValue: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionChangeEmojiStickerSet(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.InputStickerSet?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputStickerSet
            }
            var _2: Api.InputStickerSet?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.InputStickerSet
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionChangeEmojiStickerSet(Cons_channelAdminLogEventActionChangeEmojiStickerSet(prevStickerset: _1!, newStickerset: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionChangeHistoryTTL(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionChangeHistoryTTL(Cons_channelAdminLogEventActionChangeHistoryTTL(prevValue: _1!, newValue: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionChangeLinkedChat(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionChangeLinkedChat(Cons_channelAdminLogEventActionChangeLinkedChat(prevValue: _1!, newValue: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionChangeLocation(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.ChannelLocation?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ChannelLocation
            }
            var _2: Api.ChannelLocation?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.ChannelLocation
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionChangeLocation(Cons_channelAdminLogEventActionChangeLocation(prevValue: _1!, newValue: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionChangePeerColor(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.PeerColor?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.PeerColor
            }
            var _2: Api.PeerColor?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.PeerColor
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionChangePeerColor(Cons_channelAdminLogEventActionChangePeerColor(prevValue: _1!, newValue: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionChangePhoto(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.Photo?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Photo
            }
            var _2: Api.Photo?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Photo
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionChangePhoto(Cons_channelAdminLogEventActionChangePhoto(prevPhoto: _1!, newPhoto: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionChangeProfilePeerColor(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.PeerColor?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.PeerColor
            }
            var _2: Api.PeerColor?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.PeerColor
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionChangeProfilePeerColor(Cons_channelAdminLogEventActionChangeProfilePeerColor(prevValue: _1!, newValue: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionChangeStickerSet(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.InputStickerSet?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputStickerSet
            }
            var _2: Api.InputStickerSet?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.InputStickerSet
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionChangeStickerSet(Cons_channelAdminLogEventActionChangeStickerSet(prevStickerset: _1!, newStickerset: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionChangeTitle(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: String?
            _1 = parseString(reader)
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionChangeTitle(Cons_channelAdminLogEventActionChangeTitle(prevValue: _1!, newValue: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionChangeUsername(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: String?
            _1 = parseString(reader)
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionChangeUsername(Cons_channelAdminLogEventActionChangeUsername(prevValue: _1!, newValue: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionChangeUsernames(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: [String]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: -1255641564, elementType: String.self)
            }
            var _2: [String]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: -1255641564, elementType: String.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionChangeUsernames(Cons_channelAdminLogEventActionChangeUsernames(prevValue: _1!, newValue: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionChangeWallpaper(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.WallPaper?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.WallPaper
            }
            var _2: Api.WallPaper?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.WallPaper
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionChangeWallpaper(Cons_channelAdminLogEventActionChangeWallpaper(prevValue: _1!, newValue: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionCreateTopic(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.ForumTopic?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ForumTopic
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionCreateTopic(Cons_channelAdminLogEventActionCreateTopic(topic: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionDefaultBannedRights(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.ChatBannedRights?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ChatBannedRights
            }
            var _2: Api.ChatBannedRights?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.ChatBannedRights
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionDefaultBannedRights(Cons_channelAdminLogEventActionDefaultBannedRights(prevBannedRights: _1!, newBannedRights: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionDeleteMessage(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.Message?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Message
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionDeleteMessage(Cons_channelAdminLogEventActionDeleteMessage(message: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionDeleteTopic(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.ForumTopic?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ForumTopic
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionDeleteTopic(Cons_channelAdminLogEventActionDeleteTopic(topic: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionDiscardGroupCall(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.InputGroupCall?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputGroupCall
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionDiscardGroupCall(Cons_channelAdminLogEventActionDiscardGroupCall(call: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionEditMessage(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.Message?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Message
            }
            var _2: Api.Message?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Message
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionEditMessage(Cons_channelAdminLogEventActionEditMessage(prevMessage: _1!, newMessage: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionEditTopic(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.ForumTopic?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ForumTopic
            }
            var _2: Api.ForumTopic?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.ForumTopic
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionEditTopic(Cons_channelAdminLogEventActionEditTopic(prevTopic: _1!, newTopic: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionExportedInviteDelete(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.ExportedChatInvite?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ExportedChatInvite
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionExportedInviteDelete(Cons_channelAdminLogEventActionExportedInviteDelete(invite: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionExportedInviteEdit(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.ExportedChatInvite?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ExportedChatInvite
            }
            var _2: Api.ExportedChatInvite?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.ExportedChatInvite
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionExportedInviteEdit(Cons_channelAdminLogEventActionExportedInviteEdit(prevInvite: _1!, newInvite: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionExportedInviteRevoke(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.ExportedChatInvite?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ExportedChatInvite
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionExportedInviteRevoke(Cons_channelAdminLogEventActionExportedInviteRevoke(invite: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionParticipantEditRank(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            _3 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionParticipantEditRank(Cons_channelAdminLogEventActionParticipantEditRank(userId: _1!, prevRank: _2!, newRank: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionParticipantInvite(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.ChannelParticipant?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ChannelParticipant
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionParticipantInvite(Cons_channelAdminLogEventActionParticipantInvite(participant: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionParticipantJoin(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            return Api.ChannelAdminLogEventAction.channelAdminLogEventActionParticipantJoin
        }
        static func parse_channelAdminLogEventActionParticipantJoinByInvite(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.ExportedChatInvite?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.ExportedChatInvite
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionParticipantJoinByInvite(Cons_channelAdminLogEventActionParticipantJoinByInvite(flags: _1!, invite: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionParticipantJoinByRequest(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.ExportedChatInvite?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ExportedChatInvite
            }
            var _2: Int64?
            _2 = reader.readInt64()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionParticipantJoinByRequest(Cons_channelAdminLogEventActionParticipantJoinByRequest(invite: _1!, approvedBy: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionParticipantLeave(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            return Api.ChannelAdminLogEventAction.channelAdminLogEventActionParticipantLeave
        }
        static func parse_channelAdminLogEventActionParticipantMute(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.GroupCallParticipant?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.GroupCallParticipant
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionParticipantMute(Cons_channelAdminLogEventActionParticipantMute(participant: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionParticipantSubExtend(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.ChannelParticipant?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ChannelParticipant
            }
            var _2: Api.ChannelParticipant?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.ChannelParticipant
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionParticipantSubExtend(Cons_channelAdminLogEventActionParticipantSubExtend(prevParticipant: _1!, newParticipant: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionParticipantToggleAdmin(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.ChannelParticipant?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ChannelParticipant
            }
            var _2: Api.ChannelParticipant?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.ChannelParticipant
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionParticipantToggleAdmin(Cons_channelAdminLogEventActionParticipantToggleAdmin(prevParticipant: _1!, newParticipant: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionParticipantToggleBan(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.ChannelParticipant?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.ChannelParticipant
            }
            var _2: Api.ChannelParticipant?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.ChannelParticipant
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionParticipantToggleBan(Cons_channelAdminLogEventActionParticipantToggleBan(prevParticipant: _1!, newParticipant: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionParticipantUnmute(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.GroupCallParticipant?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.GroupCallParticipant
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionParticipantUnmute(Cons_channelAdminLogEventActionParticipantUnmute(participant: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionParticipantVolume(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.GroupCallParticipant?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.GroupCallParticipant
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionParticipantVolume(Cons_channelAdminLogEventActionParticipantVolume(participant: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionPinTopic(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.ForumTopic?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.ForumTopic
                }
            }
            var _3: Api.ForumTopic?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.ForumTopic
                }
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionPinTopic(Cons_channelAdminLogEventActionPinTopic(flags: _1!, prevTopic: _2, newTopic: _3))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionSendMessage(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.Message?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Message
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionSendMessage(Cons_channelAdminLogEventActionSendMessage(message: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionStartGroupCall(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.InputGroupCall?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.InputGroupCall
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionStartGroupCall(Cons_channelAdminLogEventActionStartGroupCall(call: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionStopPoll(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.Message?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Message
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionStopPoll(Cons_channelAdminLogEventActionStopPoll(message: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionToggleAntiSpam(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.Bool?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionToggleAntiSpam(Cons_channelAdminLogEventActionToggleAntiSpam(newValue: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionToggleAutotranslation(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.Bool?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionToggleAutotranslation(Cons_channelAdminLogEventActionToggleAutotranslation(newValue: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionToggleForum(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.Bool?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionToggleForum(Cons_channelAdminLogEventActionToggleForum(newValue: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionToggleGroupCallSetting(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.Bool?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionToggleGroupCallSetting(Cons_channelAdminLogEventActionToggleGroupCallSetting(joinMuted: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionToggleInvites(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.Bool?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionToggleInvites(Cons_channelAdminLogEventActionToggleInvites(newValue: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionToggleNoForwards(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.Bool?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionToggleNoForwards(Cons_channelAdminLogEventActionToggleNoForwards(newValue: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionTogglePreHistoryHidden(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.Bool?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionTogglePreHistoryHidden(Cons_channelAdminLogEventActionTogglePreHistoryHidden(newValue: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionToggleSignatureProfiles(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.Bool?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionToggleSignatureProfiles(Cons_channelAdminLogEventActionToggleSignatureProfiles(newValue: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionToggleSignatures(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.Bool?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Bool
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionToggleSignatures(Cons_channelAdminLogEventActionToggleSignatures(newValue: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionToggleSlowMode(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionToggleSlowMode(Cons_channelAdminLogEventActionToggleSlowMode(prevValue: _1!, newValue: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelAdminLogEventActionUpdatePinned(_ reader: BufferReader) -> ChannelAdminLogEventAction? {
            var _1: Api.Message?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Message
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChannelAdminLogEventAction.channelAdminLogEventActionUpdatePinned(Cons_channelAdminLogEventActionUpdatePinned(message: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum ChannelLocation: TypeConstructorDescription {
        class Cons_channelLocation: TypeConstructorDescription {
            var geoPoint: Api.GeoPoint
            var address: String
            init(geoPoint: Api.GeoPoint, address: String) {
                self.geoPoint = geoPoint
                self.address = address
            }
        }
        case channelLocation(Cons_channelLocation)
        case channelLocationEmpty

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .channelLocation(let _data):
                if boxed {
                    buffer.appendInt32(547062491)
                }
                _data.geoPoint.serialize(buffer, true)
                serializeString(_data.address, buffer: buffer, boxed: false)
                break
            case .channelLocationEmpty:
                if boxed {
                    buffer.appendInt32(-1078612597)
                }
                break
            }
        }

        static func parse_channelLocation(_ reader: BufferReader) -> ChannelLocation? {
            var _1: Api.GeoPoint?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.GeoPoint
            }
            var _2: String?
            _2 = parseString(reader)
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChannelLocation.channelLocation(Cons_channelLocation(geoPoint: _1!, address: _2!))
            }
            else {
                return nil
            }
        }
        static func parse_channelLocationEmpty(_ reader: BufferReader) -> ChannelLocation? {
            return Api.ChannelLocation.channelLocationEmpty
        }
    }
}
