extension Api {
    enum ChatFull: TypeConstructorDescription {
        class Cons_channelFull: TypeConstructorDescription {
            var flags: Int32
            var flags2: Int32
            var id: Int64
            var about: String
            var participantsCount: Int32?
            var adminsCount: Int32?
            var kickedCount: Int32?
            var bannedCount: Int32?
            var onlineCount: Int32?
            var readInboxMaxId: Int32
            var readOutboxMaxId: Int32
            var unreadCount: Int32
            var chatPhoto: Api.Photo
            var notifySettings: Api.PeerNotifySettings
            var exportedInvite: Api.ExportedChatInvite?
            var botInfo: [Api.BotInfo]
            var migratedFromChatId: Int64?
            var migratedFromMaxId: Int32?
            var pinnedMsgId: Int32?
            var stickerset: Api.StickerSet?
            var availableMinId: Int32?
            var folderId: Int32?
            var linkedChatId: Int64?
            var location: Api.ChannelLocation?
            var slowmodeSeconds: Int32?
            var slowmodeNextSendDate: Int32?
            var statsDc: Int32?
            var pts: Int32
            var call: Api.InputGroupCall?
            var ttlPeriod: Int32?
            var pendingSuggestions: [String]?
            var groupcallDefaultJoinAs: Api.Peer?
            var themeEmoticon: String?
            var requestsPending: Int32?
            var recentRequesters: [Int64]?
            var defaultSendAs: Api.Peer?
            var availableReactions: Api.ChatReactions?
            var reactionsLimit: Int32?
            var stories: Api.PeerStories?
            var wallpaper: Api.WallPaper?
            var boostsApplied: Int32?
            var boostsUnrestrict: Int32?
            var emojiset: Api.StickerSet?
            var botVerification: Api.BotVerification?
            var stargiftsCount: Int32?
            var sendPaidMessagesStars: Int64?
            var mainTab: Api.ProfileTab?
            var guardBotId: Int64?
            var shareTheme: Api.ShareTheme?
            init(flags: Int32, flags2: Int32, id: Int64, about: String, participantsCount: Int32?, adminsCount: Int32?, kickedCount: Int32?, bannedCount: Int32?, onlineCount: Int32?, readInboxMaxId: Int32, readOutboxMaxId: Int32, unreadCount: Int32, chatPhoto: Api.Photo, notifySettings: Api.PeerNotifySettings, exportedInvite: Api.ExportedChatInvite?, botInfo: [Api.BotInfo], migratedFromChatId: Int64?, migratedFromMaxId: Int32?, pinnedMsgId: Int32?, stickerset: Api.StickerSet?, availableMinId: Int32?, folderId: Int32?, linkedChatId: Int64?, location: Api.ChannelLocation?, slowmodeSeconds: Int32?, slowmodeNextSendDate: Int32?, statsDc: Int32?, pts: Int32, call: Api.InputGroupCall?, ttlPeriod: Int32?, pendingSuggestions: [String]?, groupcallDefaultJoinAs: Api.Peer?, themeEmoticon: String?, requestsPending: Int32?, recentRequesters: [Int64]?, defaultSendAs: Api.Peer?, availableReactions: Api.ChatReactions?, reactionsLimit: Int32?, stories: Api.PeerStories?, wallpaper: Api.WallPaper?, boostsApplied: Int32?, boostsUnrestrict: Int32?, emojiset: Api.StickerSet?, botVerification: Api.BotVerification?, stargiftsCount: Int32?, sendPaidMessagesStars: Int64?, mainTab: Api.ProfileTab?, guardBotId: Int64?, shareTheme: Api.ShareTheme?) {
                self.flags = flags
                self.flags2 = flags2
                self.id = id
                self.about = about
                self.participantsCount = participantsCount
                self.adminsCount = adminsCount
                self.kickedCount = kickedCount
                self.bannedCount = bannedCount
                self.onlineCount = onlineCount
                self.readInboxMaxId = readInboxMaxId
                self.readOutboxMaxId = readOutboxMaxId
                self.unreadCount = unreadCount
                self.chatPhoto = chatPhoto
                self.notifySettings = notifySettings
                self.exportedInvite = exportedInvite
                self.botInfo = botInfo
                self.migratedFromChatId = migratedFromChatId
                self.migratedFromMaxId = migratedFromMaxId
                self.pinnedMsgId = pinnedMsgId
                self.stickerset = stickerset
                self.availableMinId = availableMinId
                self.folderId = folderId
                self.linkedChatId = linkedChatId
                self.location = location
                self.slowmodeSeconds = slowmodeSeconds
                self.slowmodeNextSendDate = slowmodeNextSendDate
                self.statsDc = statsDc
                self.pts = pts
                self.call = call
                self.ttlPeriod = ttlPeriod
                self.pendingSuggestions = pendingSuggestions
                self.groupcallDefaultJoinAs = groupcallDefaultJoinAs
                self.themeEmoticon = themeEmoticon
                self.requestsPending = requestsPending
                self.recentRequesters = recentRequesters
                self.defaultSendAs = defaultSendAs
                self.availableReactions = availableReactions
                self.reactionsLimit = reactionsLimit
                self.stories = stories
                self.wallpaper = wallpaper
                self.boostsApplied = boostsApplied
                self.boostsUnrestrict = boostsUnrestrict
                self.emojiset = emojiset
                self.botVerification = botVerification
                self.stargiftsCount = stargiftsCount
                self.sendPaidMessagesStars = sendPaidMessagesStars
                self.mainTab = mainTab
                self.guardBotId = guardBotId
                self.shareTheme = shareTheme
            }
        }
        class Cons_chatFull: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var about: String
            var participants: Api.ChatParticipants
            var chatPhoto: Api.Photo?
            var notifySettings: Api.PeerNotifySettings
            var exportedInvite: Api.ExportedChatInvite?
            var botInfo: [Api.BotInfo]?
            var pinnedMsgId: Int32?
            var folderId: Int32?
            var call: Api.InputGroupCall?
            var ttlPeriod: Int32?
            var groupcallDefaultJoinAs: Api.Peer?
            var themeEmoticon: String?
            var requestsPending: Int32?
            var recentRequesters: [Int64]?
            var availableReactions: Api.ChatReactions?
            var reactionsLimit: Int32?
            init(flags: Int32, id: Int64, about: String, participants: Api.ChatParticipants, chatPhoto: Api.Photo?, notifySettings: Api.PeerNotifySettings, exportedInvite: Api.ExportedChatInvite?, botInfo: [Api.BotInfo]?, pinnedMsgId: Int32?, folderId: Int32?, call: Api.InputGroupCall?, ttlPeriod: Int32?, groupcallDefaultJoinAs: Api.Peer?, themeEmoticon: String?, requestsPending: Int32?, recentRequesters: [Int64]?, availableReactions: Api.ChatReactions?, reactionsLimit: Int32?) {
                self.flags = flags
                self.id = id
                self.about = about
                self.participants = participants
                self.chatPhoto = chatPhoto
                self.notifySettings = notifySettings
                self.exportedInvite = exportedInvite
                self.botInfo = botInfo
                self.pinnedMsgId = pinnedMsgId
                self.folderId = folderId
                self.call = call
                self.ttlPeriod = ttlPeriod
                self.groupcallDefaultJoinAs = groupcallDefaultJoinAs
                self.themeEmoticon = themeEmoticon
                self.requestsPending = requestsPending
                self.recentRequesters = recentRequesters
                self.availableReactions = availableReactions
                self.reactionsLimit = reactionsLimit
            }
        }
        class Cons_communityFull: TypeConstructorDescription {
            var flags: Int32
            var id: Int64
            var about: String
            var chatPhoto: Api.Photo
            var linkedPeers: [Api.CommunityPeer]
            var adminsCount: Int32?
            var kickedCount: Int32?
            var peerLinkRequestsPending: Int32?
            init(flags: Int32, id: Int64, about: String, chatPhoto: Api.Photo, linkedPeers: [Api.CommunityPeer], adminsCount: Int32?, kickedCount: Int32?, peerLinkRequestsPending: Int32?) {
                self.flags = flags
                self.id = id
                self.about = about
                self.chatPhoto = chatPhoto
                self.linkedPeers = linkedPeers
                self.adminsCount = adminsCount
                self.kickedCount = kickedCount
                self.peerLinkRequestsPending = peerLinkRequestsPending
            }
        }
        case channelFull(Cons_channelFull)
        case chatFull(Cons_chatFull)
        case communityFull(Cons_communityFull)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .channelFull(let _data):
                if boxed {
                    buffer.appendInt32(-993731264)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.flags2, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeString(_data.about, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.participantsCount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.adminsCount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.kickedCount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.bannedCount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 13) != 0 {
                    serializeInt32(_data.onlineCount!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.readInboxMaxId, buffer: buffer, boxed: false)
                serializeInt32(_data.readOutboxMaxId, buffer: buffer, boxed: false)
                serializeInt32(_data.unreadCount, buffer: buffer, boxed: false)
                _data.chatPhoto.serialize(buffer, true)
                _data.notifySettings.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 23) != 0 {
                    _data.exportedInvite!.serialize(buffer, true)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.botInfo.count))
                for item in _data.botInfo {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt64(_data.migratedFromChatId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    serializeInt32(_data.migratedFromMaxId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeInt32(_data.pinnedMsgId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 8) != 0 {
                    _data.stickerset!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 9) != 0 {
                    serializeInt32(_data.availableMinId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    serializeInt32(_data.folderId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 14) != 0 {
                    serializeInt64(_data.linkedChatId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 15) != 0 {
                    _data.location!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 17) != 0 {
                    serializeInt32(_data.slowmodeSeconds!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 18) != 0 {
                    serializeInt32(_data.slowmodeNextSendDate!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 12) != 0 {
                    serializeInt32(_data.statsDc!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.pts, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 21) != 0 {
                    _data.call!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 24) != 0 {
                    serializeInt32(_data.ttlPeriod!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 25) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.pendingSuggestions!.count))
                    for item in _data.pendingSuggestions! {
                        serializeString(item, buffer: buffer, boxed: false)
                    }
                }
                if Int(_data.flags) & Int(1 << 26) != 0 {
                    _data.groupcallDefaultJoinAs!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 27) != 0 {
                    serializeString(_data.themeEmoticon!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 28) != 0 {
                    serializeInt32(_data.requestsPending!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 28) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.recentRequesters!.count))
                    for item in _data.recentRequesters! {
                        serializeInt64(item, buffer: buffer, boxed: false)
                    }
                }
                if Int(_data.flags) & Int(1 << 29) != 0 {
                    _data.defaultSendAs!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 30) != 0 {
                    _data.availableReactions!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 13) != 0 {
                    serializeInt32(_data.reactionsLimit!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 4) != 0 {
                    _data.stories!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 7) != 0 {
                    _data.wallpaper!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 8) != 0 {
                    serializeInt32(_data.boostsApplied!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 9) != 0 {
                    serializeInt32(_data.boostsUnrestrict!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 10) != 0 {
                    _data.emojiset!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 17) != 0 {
                    _data.botVerification!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 18) != 0 {
                    serializeInt32(_data.stargiftsCount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 21) != 0 {
                    serializeInt64(_data.sendPaidMessagesStars!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 22) != 0 {
                    _data.mainTab!.serialize(buffer, true)
                }
                if Int(_data.flags2) & Int(1 << 23) != 0 {
                    serializeInt64(_data.guardBotId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags2) & Int(1 << 25) != 0 {
                    _data.shareTheme!.serialize(buffer, true)
                }
                break
            case .chatFull(let _data):
                if boxed {
                    buffer.appendInt32(640893467)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeString(_data.about, buffer: buffer, boxed: false)
                _data.participants.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    _data.chatPhoto!.serialize(buffer, true)
                }
                _data.notifySettings.serialize(buffer, true)
                if Int(_data.flags) & Int(1 << 13) != 0 {
                    _data.exportedInvite!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 3) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.botInfo!.count))
                    for item in _data.botInfo! {
                        item.serialize(buffer, true)
                    }
                }
                if Int(_data.flags) & Int(1 << 6) != 0 {
                    serializeInt32(_data.pinnedMsgId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 11) != 0 {
                    serializeInt32(_data.folderId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 12) != 0 {
                    _data.call!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 14) != 0 {
                    serializeInt32(_data.ttlPeriod!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 15) != 0 {
                    _data.groupcallDefaultJoinAs!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 16) != 0 {
                    serializeString(_data.themeEmoticon!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 17) != 0 {
                    serializeInt32(_data.requestsPending!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 17) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.recentRequesters!.count))
                    for item in _data.recentRequesters! {
                        serializeInt64(item, buffer: buffer, boxed: false)
                    }
                }
                if Int(_data.flags) & Int(1 << 18) != 0 {
                    _data.availableReactions!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 20) != 0 {
                    serializeInt32(_data.reactionsLimit!, buffer: buffer, boxed: false)
                }
                break
            case .communityFull(let _data):
                if boxed {
                    buffer.appendInt32(-877157113)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.id, buffer: buffer, boxed: false)
                serializeString(_data.about, buffer: buffer, boxed: false)
                _data.chatPhoto.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.linkedPeers.count))
                for item in _data.linkedPeers {
                    item.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeInt32(_data.adminsCount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 2) != 0 {
                    serializeInt32(_data.kickedCount!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeInt32(_data.peerLinkRequestsPending!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_channelFull(_ reader: BufferReader) -> ChatFull? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: String?
            _4 = parseString(reader)
            var _5: Int32?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = reader.readInt32()
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _6 = reader.readInt32()
            }
            var _7: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _7 = reader.readInt32()
            }
            var _8: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _8 = reader.readInt32()
            }
            var _9: Int32?
            if Int(_1 ?? 0) & Int(1 << 13) != 0 {
                _9 = reader.readInt32()
            }
            var _10: Int32?
            _10 = reader.readInt32()
            var _11: Int32?
            _11 = reader.readInt32()
            var _12: Int32?
            _12 = reader.readInt32()
            var _13: Api.Photo?
            if let signature = reader.readInt32() {
                _13 = Api.parse(reader, signature: signature) as? Api.Photo
            }
            var _14: Api.PeerNotifySettings?
            if let signature = reader.readInt32() {
                _14 = Api.parse(reader, signature: signature) as? Api.PeerNotifySettings
            }
            var _15: Api.ExportedChatInvite?
            if Int(_1 ?? 0) & Int(1 << 23) != 0 {
                if let signature = reader.readInt32() {
                    _15 = Api.parse(reader, signature: signature) as? Api.ExportedChatInvite
                }
            }
            var _16: [Api.BotInfo]?
            if let _ = reader.readInt32() {
                _16 = Api.parseVector(reader, elementSignature: 0, elementType: Api.BotInfo.self)
            }
            var _17: Int64?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _17 = reader.readInt64()
            }
            var _18: Int32?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                _18 = reader.readInt32()
            }
            var _19: Int32?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _19 = reader.readInt32()
            }
            var _20: Api.StickerSet?
            if Int(_1 ?? 0) & Int(1 << 8) != 0 {
                if let signature = reader.readInt32() {
                    _20 = Api.parse(reader, signature: signature) as? Api.StickerSet
                }
            }
            var _21: Int32?
            if Int(_1 ?? 0) & Int(1 << 9) != 0 {
                _21 = reader.readInt32()
            }
            var _22: Int32?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                _22 = reader.readInt32()
            }
            var _23: Int64?
            if Int(_1 ?? 0) & Int(1 << 14) != 0 {
                _23 = reader.readInt64()
            }
            var _24: Api.ChannelLocation?
            if Int(_1 ?? 0) & Int(1 << 15) != 0 {
                if let signature = reader.readInt32() {
                    _24 = Api.parse(reader, signature: signature) as? Api.ChannelLocation
                }
            }
            var _25: Int32?
            if Int(_1 ?? 0) & Int(1 << 17) != 0 {
                _25 = reader.readInt32()
            }
            var _26: Int32?
            if Int(_1 ?? 0) & Int(1 << 18) != 0 {
                _26 = reader.readInt32()
            }
            var _27: Int32?
            if Int(_1 ?? 0) & Int(1 << 12) != 0 {
                _27 = reader.readInt32()
            }
            var _28: Int32?
            _28 = reader.readInt32()
            var _29: Api.InputGroupCall?
            if Int(_1 ?? 0) & Int(1 << 21) != 0 {
                if let signature = reader.readInt32() {
                    _29 = Api.parse(reader, signature: signature) as? Api.InputGroupCall
                }
            }
            var _30: Int32?
            if Int(_1 ?? 0) & Int(1 << 24) != 0 {
                _30 = reader.readInt32()
            }
            var _31: [String]?
            if Int(_1 ?? 0) & Int(1 << 25) != 0 {
                if let _ = reader.readInt32() {
                    _31 = Api.parseVector(reader, elementSignature: -1255641564, elementType: String.self)
                }
            }
            var _32: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 26) != 0 {
                if let signature = reader.readInt32() {
                    _32 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _33: String?
            if Int(_1 ?? 0) & Int(1 << 27) != 0 {
                _33 = parseString(reader)
            }
            var _34: Int32?
            if Int(_1 ?? 0) & Int(1 << 28) != 0 {
                _34 = reader.readInt32()
            }
            var _35: [Int64]?
            if Int(_1 ?? 0) & Int(1 << 28) != 0 {
                if let _ = reader.readInt32() {
                    _35 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
                }
            }
            var _36: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 29) != 0 {
                if let signature = reader.readInt32() {
                    _36 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _37: Api.ChatReactions?
            if Int(_1 ?? 0) & Int(1 << 30) != 0 {
                if let signature = reader.readInt32() {
                    _37 = Api.parse(reader, signature: signature) as? Api.ChatReactions
                }
            }
            var _38: Int32?
            if Int(_2 ?? 0) & Int(1 << 13) != 0 {
                _38 = reader.readInt32()
            }
            var _39: Api.PeerStories?
            if Int(_2 ?? 0) & Int(1 << 4) != 0 {
                if let signature = reader.readInt32() {
                    _39 = Api.parse(reader, signature: signature) as? Api.PeerStories
                }
            }
            var _40: Api.WallPaper?
            if Int(_2 ?? 0) & Int(1 << 7) != 0 {
                if let signature = reader.readInt32() {
                    _40 = Api.parse(reader, signature: signature) as? Api.WallPaper
                }
            }
            var _41: Int32?
            if Int(_2 ?? 0) & Int(1 << 8) != 0 {
                _41 = reader.readInt32()
            }
            var _42: Int32?
            if Int(_2 ?? 0) & Int(1 << 9) != 0 {
                _42 = reader.readInt32()
            }
            var _43: Api.StickerSet?
            if Int(_2 ?? 0) & Int(1 << 10) != 0 {
                if let signature = reader.readInt32() {
                    _43 = Api.parse(reader, signature: signature) as? Api.StickerSet
                }
            }
            var _44: Api.BotVerification?
            if Int(_2 ?? 0) & Int(1 << 17) != 0 {
                if let signature = reader.readInt32() {
                    _44 = Api.parse(reader, signature: signature) as? Api.BotVerification
                }
            }
            var _45: Int32?
            if Int(_2 ?? 0) & Int(1 << 18) != 0 {
                _45 = reader.readInt32()
            }
            var _46: Int64?
            if Int(_2 ?? 0) & Int(1 << 21) != 0 {
                _46 = reader.readInt64()
            }
            var _47: Api.ProfileTab?
            if Int(_2 ?? 0) & Int(1 << 22) != 0 {
                if let signature = reader.readInt32() {
                    _47 = Api.parse(reader, signature: signature) as? Api.ProfileTab
                }
            }
            var _48: Int64?
            if Int(_2 ?? 0) & Int(1 << 23) != 0 {
                _48 = reader.readInt64()
            }
            var _49: Api.ShareTheme?
            if Int(_2 ?? 0) & Int(1 << 25) != 0 {
                if let signature = reader.readInt32() {
                    _49 = Api.parse(reader, signature: signature) as? Api.ShareTheme
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 13) == 0) || _9 != nil
            let _c10 = _10 != nil
            let _c11 = _11 != nil
            let _c12 = _12 != nil
            let _c13 = _13 != nil
            let _c14 = _14 != nil
            let _c15 = (Int(_1 ?? 0) & Int(1 << 23) == 0) || _15 != nil
            let _c16 = _16 != nil
            let _c17 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _17 != nil
            let _c18 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _18 != nil
            let _c19 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _19 != nil
            let _c20 = (Int(_1 ?? 0) & Int(1 << 8) == 0) || _20 != nil
            let _c21 = (Int(_1 ?? 0) & Int(1 << 9) == 0) || _21 != nil
            let _c22 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _22 != nil
            let _c23 = (Int(_1 ?? 0) & Int(1 << 14) == 0) || _23 != nil
            let _c24 = (Int(_1 ?? 0) & Int(1 << 15) == 0) || _24 != nil
            let _c25 = (Int(_1 ?? 0) & Int(1 << 17) == 0) || _25 != nil
            let _c26 = (Int(_1 ?? 0) & Int(1 << 18) == 0) || _26 != nil
            let _c27 = (Int(_1 ?? 0) & Int(1 << 12) == 0) || _27 != nil
            let _c28 = _28 != nil
            let _c29 = (Int(_1 ?? 0) & Int(1 << 21) == 0) || _29 != nil
            let _c30 = (Int(_1 ?? 0) & Int(1 << 24) == 0) || _30 != nil
            let _c31 = (Int(_1 ?? 0) & Int(1 << 25) == 0) || _31 != nil
            let _c32 = (Int(_1 ?? 0) & Int(1 << 26) == 0) || _32 != nil
            let _c33 = (Int(_1 ?? 0) & Int(1 << 27) == 0) || _33 != nil
            let _c34 = (Int(_1 ?? 0) & Int(1 << 28) == 0) || _34 != nil
            let _c35 = (Int(_1 ?? 0) & Int(1 << 28) == 0) || _35 != nil
            let _c36 = (Int(_1 ?? 0) & Int(1 << 29) == 0) || _36 != nil
            let _c37 = (Int(_1 ?? 0) & Int(1 << 30) == 0) || _37 != nil
            let _c38 = (Int(_2 ?? 0) & Int(1 << 13) == 0) || _38 != nil
            let _c39 = (Int(_2 ?? 0) & Int(1 << 4) == 0) || _39 != nil
            let _c40 = (Int(_2 ?? 0) & Int(1 << 7) == 0) || _40 != nil
            let _c41 = (Int(_2 ?? 0) & Int(1 << 8) == 0) || _41 != nil
            let _c42 = (Int(_2 ?? 0) & Int(1 << 9) == 0) || _42 != nil
            let _c43 = (Int(_2 ?? 0) & Int(1 << 10) == 0) || _43 != nil
            let _c44 = (Int(_2 ?? 0) & Int(1 << 17) == 0) || _44 != nil
            let _c45 = (Int(_2 ?? 0) & Int(1 << 18) == 0) || _45 != nil
            let _c46 = (Int(_2 ?? 0) & Int(1 << 21) == 0) || _46 != nil
            let _c47 = (Int(_2 ?? 0) & Int(1 << 22) == 0) || _47 != nil
            let _c48 = (Int(_2 ?? 0) & Int(1 << 23) == 0) || _48 != nil
            let _c49 = (Int(_2 ?? 0) & Int(1 << 25) == 0) || _49 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 && _c15 && _c16 && _c17 && _c18 && _c19 && _c20 && _c21 && _c22 && _c23 && _c24 && _c25 && _c26 && _c27 && _c28 && _c29 && _c30 && _c31 && _c32 && _c33 && _c34 && _c35 && _c36 && _c37 && _c38 && _c39 && _c40 && _c41 && _c42 && _c43 && _c44 && _c45 && _c46 && _c47 && _c48 && _c49 {
                return Api.ChatFull.channelFull(Cons_channelFull(flags: _1!, flags2: _2!, id: _3!, about: _4!, participantsCount: _5, adminsCount: _6, kickedCount: _7, bannedCount: _8, onlineCount: _9, readInboxMaxId: _10!, readOutboxMaxId: _11!, unreadCount: _12!, chatPhoto: _13!, notifySettings: _14!, exportedInvite: _15, botInfo: _16!, migratedFromChatId: _17, migratedFromMaxId: _18, pinnedMsgId: _19, stickerset: _20, availableMinId: _21, folderId: _22, linkedChatId: _23, location: _24, slowmodeSeconds: _25, slowmodeNextSendDate: _26, statsDc: _27, pts: _28!, call: _29, ttlPeriod: _30, pendingSuggestions: _31, groupcallDefaultJoinAs: _32, themeEmoticon: _33, requestsPending: _34, recentRequesters: _35, defaultSendAs: _36, availableReactions: _37, reactionsLimit: _38, stories: _39, wallpaper: _40, boostsApplied: _41, boostsUnrestrict: _42, emojiset: _43, botVerification: _44, stargiftsCount: _45, sendPaidMessagesStars: _46, mainTab: _47, guardBotId: _48, shareTheme: _49))
            }
            else {
                return nil
            }
        }
        static func parse_chatFull(_ reader: BufferReader) -> ChatFull? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            _3 = parseString(reader)
            var _4: Api.ChatParticipants?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.ChatParticipants
            }
            var _5: Api.Photo?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                if let signature = reader.readInt32() {
                    _5 = Api.parse(reader, signature: signature) as? Api.Photo
                }
            }
            var _6: Api.PeerNotifySettings?
            if let signature = reader.readInt32() {
                _6 = Api.parse(reader, signature: signature) as? Api.PeerNotifySettings
            }
            var _7: Api.ExportedChatInvite?
            if Int(_1 ?? 0) & Int(1 << 13) != 0 {
                if let signature = reader.readInt32() {
                    _7 = Api.parse(reader, signature: signature) as? Api.ExportedChatInvite
                }
            }
            var _8: [Api.BotInfo]?
            if Int(_1 ?? 0) & Int(1 << 3) != 0 {
                if let _ = reader.readInt32() {
                    _8 = Api.parseVector(reader, elementSignature: 0, elementType: Api.BotInfo.self)
                }
            }
            var _9: Int32?
            if Int(_1 ?? 0) & Int(1 << 6) != 0 {
                _9 = reader.readInt32()
            }
            var _10: Int32?
            if Int(_1 ?? 0) & Int(1 << 11) != 0 {
                _10 = reader.readInt32()
            }
            var _11: Api.InputGroupCall?
            if Int(_1 ?? 0) & Int(1 << 12) != 0 {
                if let signature = reader.readInt32() {
                    _11 = Api.parse(reader, signature: signature) as? Api.InputGroupCall
                }
            }
            var _12: Int32?
            if Int(_1 ?? 0) & Int(1 << 14) != 0 {
                _12 = reader.readInt32()
            }
            var _13: Api.Peer?
            if Int(_1 ?? 0) & Int(1 << 15) != 0 {
                if let signature = reader.readInt32() {
                    _13 = Api.parse(reader, signature: signature) as? Api.Peer
                }
            }
            var _14: String?
            if Int(_1 ?? 0) & Int(1 << 16) != 0 {
                _14 = parseString(reader)
            }
            var _15: Int32?
            if Int(_1 ?? 0) & Int(1 << 17) != 0 {
                _15 = reader.readInt32()
            }
            var _16: [Int64]?
            if Int(_1 ?? 0) & Int(1 << 17) != 0 {
                if let _ = reader.readInt32() {
                    _16 = Api.parseVector(reader, elementSignature: 570911930, elementType: Int64.self)
                }
            }
            var _17: Api.ChatReactions?
            if Int(_1 ?? 0) & Int(1 << 18) != 0 {
                if let signature = reader.readInt32() {
                    _17 = Api.parse(reader, signature: signature) as? Api.ChatReactions
                }
            }
            var _18: Int32?
            if Int(_1 ?? 0) & Int(1 << 20) != 0 {
                _18 = reader.readInt32()
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _5 != nil
            let _c6 = _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 13) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 3) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 6) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 11) == 0) || _10 != nil
            let _c11 = (Int(_1 ?? 0) & Int(1 << 12) == 0) || _11 != nil
            let _c12 = (Int(_1 ?? 0) & Int(1 << 14) == 0) || _12 != nil
            let _c13 = (Int(_1 ?? 0) & Int(1 << 15) == 0) || _13 != nil
            let _c14 = (Int(_1 ?? 0) & Int(1 << 16) == 0) || _14 != nil
            let _c15 = (Int(_1 ?? 0) & Int(1 << 17) == 0) || _15 != nil
            let _c16 = (Int(_1 ?? 0) & Int(1 << 17) == 0) || _16 != nil
            let _c17 = (Int(_1 ?? 0) & Int(1 << 18) == 0) || _17 != nil
            let _c18 = (Int(_1 ?? 0) & Int(1 << 20) == 0) || _18 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 && _c11 && _c12 && _c13 && _c14 && _c15 && _c16 && _c17 && _c18 {
                return Api.ChatFull.chatFull(Cons_chatFull(flags: _1!, id: _2!, about: _3!, participants: _4!, chatPhoto: _5, notifySettings: _6!, exportedInvite: _7, botInfo: _8, pinnedMsgId: _9, folderId: _10, call: _11, ttlPeriod: _12, groupcallDefaultJoinAs: _13, themeEmoticon: _14, requestsPending: _15, recentRequesters: _16, availableReactions: _17, reactionsLimit: _18))
            }
            else {
                return nil
            }
        }
        static func parse_communityFull(_ reader: BufferReader) -> ChatFull? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: String?
            _3 = parseString(reader)
            var _4: Api.Photo?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.Photo
            }
            var _5: [Api.CommunityPeer]?
            if let _ = reader.readInt32() {
                _5 = Api.parseVector(reader, elementSignature: 0, elementType: Api.CommunityPeer.self)
            }
            var _6: Int32?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _6 = reader.readInt32()
            }
            var _7: Int32?
            if Int(_1 ?? 0) & Int(1 << 2) != 0 {
                _7 = reader.readInt32()
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
            let _c6 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _6 != nil
            let _c7 = (Int(_1 ?? 0) & Int(1 << 2) == 0) || _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _8 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 {
                return Api.ChatFull.communityFull(Cons_communityFull(flags: _1!, id: _2!, about: _3!, chatPhoto: _4!, linkedPeers: _5!, adminsCount: _6, kickedCount: _7, peerLinkRequestsPending: _8))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum ChatInvite: TypeConstructorDescription {
        class Cons_chatInvite: TypeConstructorDescription {
            var flags: Int32
            var title: String
            var about: String?
            var photo: Api.Photo
            var participantsCount: Int32
            var participants: [Api.User]?
            var color: Int32
            var subscriptionPricing: Api.StarsSubscriptionPricing?
            var subscriptionFormId: Int64?
            var botVerification: Api.BotVerification?
            init(flags: Int32, title: String, about: String?, photo: Api.Photo, participantsCount: Int32, participants: [Api.User]?, color: Int32, subscriptionPricing: Api.StarsSubscriptionPricing?, subscriptionFormId: Int64?, botVerification: Api.BotVerification?) {
                self.flags = flags
                self.title = title
                self.about = about
                self.photo = photo
                self.participantsCount = participantsCount
                self.participants = participants
                self.color = color
                self.subscriptionPricing = subscriptionPricing
                self.subscriptionFormId = subscriptionFormId
                self.botVerification = botVerification
            }
        }
        class Cons_chatInviteAlready: TypeConstructorDescription {
            var chat: Api.Chat
            init(chat: Api.Chat) {
                self.chat = chat
            }
        }
        class Cons_chatInvitePeek: TypeConstructorDescription {
            var chat: Api.Chat
            var expires: Int32
            init(chat: Api.Chat, expires: Int32) {
                self.chat = chat
                self.expires = expires
            }
        }
        case chatInvite(Cons_chatInvite)
        case chatInviteAlready(Cons_chatInviteAlready)
        case chatInvitePeek(Cons_chatInvitePeek)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .chatInvite(let _data):
                if boxed {
                    buffer.appendInt32(1553807106)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeString(_data.title, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 5) != 0 {
                    serializeString(_data.about!, buffer: buffer, boxed: false)
                }
                _data.photo.serialize(buffer, true)
                serializeInt32(_data.participantsCount, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 4) != 0 {
                    buffer.appendInt32(481674261)
                    buffer.appendInt32(Int32(_data.participants!.count))
                    for item in _data.participants! {
                        item.serialize(buffer, true)
                    }
                }
                serializeInt32(_data.color, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    _data.subscriptionPricing!.serialize(buffer, true)
                }
                if Int(_data.flags) & Int(1 << 12) != 0 {
                    serializeInt64(_data.subscriptionFormId!, buffer: buffer, boxed: false)
                }
                if Int(_data.flags) & Int(1 << 13) != 0 {
                    _data.botVerification!.serialize(buffer, true)
                }
                break
            case .chatInviteAlready(let _data):
                if boxed {
                    buffer.appendInt32(1516793212)
                }
                _data.chat.serialize(buffer, true)
                break
            case .chatInvitePeek(let _data):
                if boxed {
                    buffer.appendInt32(1634294960)
                }
                _data.chat.serialize(buffer, true)
                serializeInt32(_data.expires, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_chatInvite(_ reader: BufferReader) -> ChatInvite? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: String?
            _2 = parseString(reader)
            var _3: String?
            if Int(_1 ?? 0) & Int(1 << 5) != 0 {
                _3 = parseString(reader)
            }
            var _4: Api.Photo?
            if let signature = reader.readInt32() {
                _4 = Api.parse(reader, signature: signature) as? Api.Photo
            }
            var _5: Int32?
            _5 = reader.readInt32()
            var _6: [Api.User]?
            if Int(_1 ?? 0) & Int(1 << 4) != 0 {
                if let _ = reader.readInt32() {
                    _6 = Api.parseVector(reader, elementSignature: 0, elementType: Api.User.self)
                }
            }
            var _7: Int32?
            _7 = reader.readInt32()
            var _8: Api.StarsSubscriptionPricing?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                if let signature = reader.readInt32() {
                    _8 = Api.parse(reader, signature: signature) as? Api.StarsSubscriptionPricing
                }
            }
            var _9: Int64?
            if Int(_1 ?? 0) & Int(1 << 12) != 0 {
                _9 = reader.readInt64()
            }
            var _10: Api.BotVerification?
            if Int(_1 ?? 0) & Int(1 << 13) != 0 {
                if let signature = reader.readInt32() {
                    _10 = Api.parse(reader, signature: signature) as? Api.BotVerification
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 5) == 0) || _3 != nil
            let _c4 = _4 != nil
            let _c5 = _5 != nil
            let _c6 = (Int(_1 ?? 0) & Int(1 << 4) == 0) || _6 != nil
            let _c7 = _7 != nil
            let _c8 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _8 != nil
            let _c9 = (Int(_1 ?? 0) & Int(1 << 12) == 0) || _9 != nil
            let _c10 = (Int(_1 ?? 0) & Int(1 << 13) == 0) || _10 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 && _c6 && _c7 && _c8 && _c9 && _c10 {
                return Api.ChatInvite.chatInvite(Cons_chatInvite(flags: _1!, title: _2!, about: _3, photo: _4!, participantsCount: _5!, participants: _6, color: _7!, subscriptionPricing: _8, subscriptionFormId: _9, botVerification: _10))
            }
            else {
                return nil
            }
        }
        static func parse_chatInviteAlready(_ reader: BufferReader) -> ChatInvite? {
            var _1: Api.Chat?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Chat
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChatInvite.chatInviteAlready(Cons_chatInviteAlready(chat: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_chatInvitePeek(_ reader: BufferReader) -> ChatInvite? {
            var _1: Api.Chat?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.Chat
            }
            var _2: Int32?
            _2 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChatInvite.chatInvitePeek(Cons_chatInvitePeek(chat: _1!, expires: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum ChatParticipant: TypeConstructorDescription {
        class Cons_chatParticipant: TypeConstructorDescription {
            var flags: Int32
            var userId: Int64
            var inviterId: Int64
            var date: Int32
            var rank: String?
            init(flags: Int32, userId: Int64, inviterId: Int64, date: Int32, rank: String?) {
                self.flags = flags
                self.userId = userId
                self.inviterId = inviterId
                self.date = date
                self.rank = rank
            }
        }
        class Cons_chatParticipantAdmin: TypeConstructorDescription {
            var flags: Int32
            var userId: Int64
            var inviterId: Int64
            var date: Int32
            var rank: String?
            init(flags: Int32, userId: Int64, inviterId: Int64, date: Int32, rank: String?) {
                self.flags = flags
                self.userId = userId
                self.inviterId = inviterId
                self.date = date
                self.rank = rank
            }
        }
        class Cons_chatParticipantCreator: TypeConstructorDescription {
            var flags: Int32
            var userId: Int64
            var rank: String?
            init(flags: Int32, userId: Int64, rank: String?) {
                self.flags = flags
                self.userId = userId
                self.rank = rank
            }
        }
        case chatParticipant(Cons_chatParticipant)
        case chatParticipantAdmin(Cons_chatParticipantAdmin)
        case chatParticipantCreator(Cons_chatParticipantCreator)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .chatParticipant(let _data):
                if boxed {
                    buffer.appendInt32(954703838)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeInt64(_data.inviterId, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.rank!, buffer: buffer, boxed: false)
                }
                break
            case .chatParticipantAdmin(let _data):
                if boxed {
                    buffer.appendInt32(56677842)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                serializeInt64(_data.inviterId, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.rank!, buffer: buffer, boxed: false)
                }
                break
            case .chatParticipantCreator(let _data):
                if boxed {
                    buffer.appendInt32(-503814216)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.userId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    serializeString(_data.rank!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_chatParticipant(_ reader: BufferReader) -> ChatParticipant? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.ChatParticipant.chatParticipant(Cons_chatParticipant(flags: _1!, userId: _2!, inviterId: _3!, date: _4!, rank: _5))
            }
            else {
                return nil
            }
        }
        static func parse_chatParticipantAdmin(_ reader: BufferReader) -> ChatParticipant? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: String?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                _5 = parseString(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.ChatParticipant.chatParticipantAdmin(Cons_chatParticipantAdmin(flags: _1!, userId: _2!, inviterId: _3!, date: _4!, rank: _5))
            }
            else {
                return nil
            }
        }
        static func parse_chatParticipantCreator(_ reader: BufferReader) -> ChatParticipant? {
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
                return Api.ChatParticipant.chatParticipantCreator(Cons_chatParticipantCreator(flags: _1!, userId: _2!, rank: _3))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum ChatParticipants: TypeConstructorDescription {
        class Cons_chatParticipants: TypeConstructorDescription {
            var chatId: Int64
            var participants: [Api.ChatParticipant]
            var version: Int32
            init(chatId: Int64, participants: [Api.ChatParticipant], version: Int32) {
                self.chatId = chatId
                self.participants = participants
                self.version = version
            }
        }
        class Cons_chatParticipantsForbidden: TypeConstructorDescription {
            var flags: Int32
            var chatId: Int64
            var selfParticipant: Api.ChatParticipant?
            init(flags: Int32, chatId: Int64, selfParticipant: Api.ChatParticipant?) {
                self.flags = flags
                self.chatId = chatId
                self.selfParticipant = selfParticipant
            }
        }
        case chatParticipants(Cons_chatParticipants)
        case chatParticipantsForbidden(Cons_chatParticipantsForbidden)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .chatParticipants(let _data):
                if boxed {
                    buffer.appendInt32(1018991608)
                }
                serializeInt64(_data.chatId, buffer: buffer, boxed: false)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.participants.count))
                for item in _data.participants {
                    item.serialize(buffer, true)
                }
                serializeInt32(_data.version, buffer: buffer, boxed: false)
                break
            case .chatParticipantsForbidden(let _data):
                if boxed {
                    buffer.appendInt32(-2023500831)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.chatId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.selfParticipant!.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_chatParticipants(_ reader: BufferReader) -> ChatParticipants? {
            var _1: Int64?
            _1 = reader.readInt64()
            var _2: [Api.ChatParticipant]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.ChatParticipant.self)
            }
            var _3: Int32?
            _3 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.ChatParticipants.chatParticipants(Cons_chatParticipants(chatId: _1!, participants: _2!, version: _3!))
            }
            else {
                return nil
            }
        }
        static func parse_chatParticipantsForbidden(_ reader: BufferReader) -> ChatParticipants? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Api.ChatParticipant?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _3 = Api.parse(reader, signature: signature) as? Api.ChatParticipant
                }
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.ChatParticipants.chatParticipantsForbidden(Cons_chatParticipantsForbidden(flags: _1!, chatId: _2!, selfParticipant: _3))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum ChatPhoto: TypeConstructorDescription {
        class Cons_chatPhoto: TypeConstructorDescription {
            var flags: Int32
            var photoId: Int64
            var strippedThumb: Buffer?
            var dcId: Int32
            init(flags: Int32, photoId: Int64, strippedThumb: Buffer?, dcId: Int32) {
                self.flags = flags
                self.photoId = photoId
                self.strippedThumb = strippedThumb
                self.dcId = dcId
            }
        }
        case chatPhoto(Cons_chatPhoto)
        case chatPhotoEmpty

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .chatPhoto(let _data):
                if boxed {
                    buffer.appendInt32(476978193)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt64(_data.photoId, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 1) != 0 {
                    serializeBytes(_data.strippedThumb!, buffer: buffer, boxed: false)
                }
                serializeInt32(_data.dcId, buffer: buffer, boxed: false)
                break
            case .chatPhotoEmpty:
                if boxed {
                    buffer.appendInt32(935395612)
                }
                break
            }
        }

        static func parse_chatPhoto(_ reader: BufferReader) -> ChatPhoto? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int64?
            _2 = reader.readInt64()
            var _3: Buffer?
            if Int(_1 ?? 0) & Int(1 << 1) != 0 {
                _3 = parseBytes(reader)
            }
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = (Int(_1 ?? 0) & Int(1 << 1) == 0) || _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.ChatPhoto.chatPhoto(Cons_chatPhoto(flags: _1!, photoId: _2!, strippedThumb: _3, dcId: _4!))
            }
            else {
                return nil
            }
        }
        static func parse_chatPhotoEmpty(_ reader: BufferReader) -> ChatPhoto? {
            return Api.ChatPhoto.chatPhotoEmpty
        }
    }
}
extension Api {
    enum ChatReactions: TypeConstructorDescription {
        class Cons_chatReactionsAll: TypeConstructorDescription {
            var flags: Int32
            init(flags: Int32) {
                self.flags = flags
            }
        }
        class Cons_chatReactionsSome: TypeConstructorDescription {
            var reactions: [Api.Reaction]
            init(reactions: [Api.Reaction]) {
                self.reactions = reactions
            }
        }
        case chatReactionsAll(Cons_chatReactionsAll)
        case chatReactionsNone
        case chatReactionsSome(Cons_chatReactionsSome)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .chatReactionsAll(let _data):
                if boxed {
                    buffer.appendInt32(1385335754)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                break
            case .chatReactionsNone:
                if boxed {
                    buffer.appendInt32(-352570692)
                }
                break
            case .chatReactionsSome(let _data):
                if boxed {
                    buffer.appendInt32(1713193015)
                }
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.reactions.count))
                for item in _data.reactions {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_chatReactionsAll(_ reader: BufferReader) -> ChatReactions? {
            var _1: Int32?
            _1 = reader.readInt32()
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChatReactions.chatReactionsAll(Cons_chatReactionsAll(flags: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_chatReactionsNone(_ reader: BufferReader) -> ChatReactions? {
            return Api.ChatReactions.chatReactionsNone
        }
        static func parse_chatReactionsSome(_ reader: BufferReader) -> ChatReactions? {
            var _1: [Api.Reaction]?
            if let _ = reader.readInt32() {
                _1 = Api.parseVector(reader, elementSignature: 0, elementType: Api.Reaction.self)
            }
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChatReactions.chatReactionsSome(Cons_chatReactionsSome(reactions: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum ChatTheme: TypeConstructorDescription {
        class Cons_chatTheme: TypeConstructorDescription {
            var emoticon: String
            init(emoticon: String) {
                self.emoticon = emoticon
            }
        }
        class Cons_chatThemeUniqueGift: TypeConstructorDescription {
            var gift: Api.StarGift
            var themeSettings: [Api.ThemeSettings]
            init(gift: Api.StarGift, themeSettings: [Api.ThemeSettings]) {
                self.gift = gift
                self.themeSettings = themeSettings
            }
        }
        case chatTheme(Cons_chatTheme)
        case chatThemeUniqueGift(Cons_chatThemeUniqueGift)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .chatTheme(let _data):
                if boxed {
                    buffer.appendInt32(-1008731132)
                }
                serializeString(_data.emoticon, buffer: buffer, boxed: false)
                break
            case .chatThemeUniqueGift(let _data):
                if boxed {
                    buffer.appendInt32(878246344)
                }
                _data.gift.serialize(buffer, true)
                buffer.appendInt32(481674261)
                buffer.appendInt32(Int32(_data.themeSettings.count))
                for item in _data.themeSettings {
                    item.serialize(buffer, true)
                }
                break
            }
        }

        static func parse_chatTheme(_ reader: BufferReader) -> ChatTheme? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.ChatTheme.chatTheme(Cons_chatTheme(emoticon: _1!))
            }
            else {
                return nil
            }
        }
        static func parse_chatThemeUniqueGift(_ reader: BufferReader) -> ChatTheme? {
            var _1: Api.StarGift?
            if let signature = reader.readInt32() {
                _1 = Api.parse(reader, signature: signature) as? Api.StarGift
            }
            var _2: [Api.ThemeSettings]?
            if let _ = reader.readInt32() {
                _2 = Api.parseVector(reader, elementSignature: 0, elementType: Api.ThemeSettings.self)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            if _c1 && _c2 {
                return Api.ChatTheme.chatThemeUniqueGift(Cons_chatThemeUniqueGift(gift: _1!, themeSettings: _2!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum CommunityPeer: TypeConstructorDescription {
        class Cons_communityPeer: TypeConstructorDescription {
            var flags: Int32
            var visible: Api.Bool?
            var peer: Api.Peer
            init(flags: Int32, visible: Api.Bool?, peer: Api.Peer) {
                self.flags = flags
                self.visible = visible
                self.peer = peer
            }
        }
        case communityPeer(Cons_communityPeer)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .communityPeer(let _data):
                if boxed {
                    buffer.appendInt32(1981030077)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 0) != 0 {
                    _data.visible!.serialize(buffer, true)
                }
                _data.peer.serialize(buffer, true)
                break
            }
        }

        static func parse_communityPeer(_ reader: BufferReader) -> CommunityPeer? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Bool?
            if Int(_1 ?? 0) & Int(1 << 0) != 0 {
                if let signature = reader.readInt32() {
                    _2 = Api.parse(reader, signature: signature) as? Api.Bool
                }
            }
            var _3: Api.Peer?
            if let signature = reader.readInt32() {
                _3 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            let _c1 = _1 != nil
            let _c2 = (Int(_1 ?? 0) & Int(1 << 0) == 0) || _2 != nil
            let _c3 = _3 != nil
            if _c1 && _c2 && _c3 {
                return Api.CommunityPeer.communityPeer(Cons_communityPeer(flags: _1!, visible: _2, peer: _3!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum CommunityPeerRequest: TypeConstructorDescription {
        class Cons_communityPeerRequest: TypeConstructorDescription {
            var flags: Int32
            var peer: Api.Peer
            var requestedBy: Int64
            var date: Int32
            init(flags: Int32, peer: Api.Peer, requestedBy: Int64, date: Int32) {
                self.flags = flags
                self.peer = peer
                self.requestedBy = requestedBy
                self.date = date
            }
        }
        case communityPeerRequest(Cons_communityPeerRequest)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .communityPeerRequest(let _data):
                if boxed {
                    buffer.appendInt32(2078997125)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                _data.peer.serialize(buffer, true)
                serializeInt64(_data.requestedBy, buffer: buffer, boxed: false)
                serializeInt32(_data.date, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_communityPeerRequest(_ reader: BufferReader) -> CommunityPeerRequest? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Api.Peer?
            if let signature = reader.readInt32() {
                _2 = Api.parse(reader, signature: signature) as? Api.Peer
            }
            var _3: Int64?
            _3 = reader.readInt64()
            var _4: Int32?
            _4 = reader.readInt32()
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            if _c1 && _c2 && _c3 && _c4 {
                return Api.CommunityPeerRequest.communityPeerRequest(Cons_communityPeerRequest(flags: _1!, peer: _2!, requestedBy: _3!, date: _4!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum DataJSON: TypeConstructorDescription {
        class Cons_dataJSON: TypeConstructorDescription {
            var data: String
            init(data: String) {
                self.data = data
            }
        }
        case dataJSON(Cons_dataJSON)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .dataJSON(let _data):
                if boxed {
                    buffer.appendInt32(2104790276)
                }
                serializeString(_data.data, buffer: buffer, boxed: false)
                break
            }
        }

        static func parse_dataJSON(_ reader: BufferReader) -> DataJSON? {
            var _1: String?
            _1 = parseString(reader)
            let _c1 = _1 != nil
            if _c1 {
                return Api.DataJSON.dataJSON(Cons_dataJSON(data: _1!))
            }
            else {
                return nil
            }
        }
    }
}
extension Api {
    enum DcOption: TypeConstructorDescription {
        class Cons_dcOption: TypeConstructorDescription {
            var flags: Int32
            var id: Int32
            var ipAddress: String
            var port: Int32
            var secret: Buffer?
            init(flags: Int32, id: Int32, ipAddress: String, port: Int32, secret: Buffer?) {
                self.flags = flags
                self.id = id
                self.ipAddress = ipAddress
                self.port = port
                self.secret = secret
            }
        }
        case dcOption(Cons_dcOption)

        func serialize(_ buffer: Buffer, _ boxed: Swift.Bool) {
            switch self {
            case .dcOption(let _data):
                if boxed {
                    buffer.appendInt32(414687501)
                }
                serializeInt32(_data.flags, buffer: buffer, boxed: false)
                serializeInt32(_data.id, buffer: buffer, boxed: false)
                serializeString(_data.ipAddress, buffer: buffer, boxed: false)
                serializeInt32(_data.port, buffer: buffer, boxed: false)
                if Int(_data.flags) & Int(1 << 10) != 0 {
                    serializeBytes(_data.secret!, buffer: buffer, boxed: false)
                }
                break
            }
        }

        static func parse_dcOption(_ reader: BufferReader) -> DcOption? {
            var _1: Int32?
            _1 = reader.readInt32()
            var _2: Int32?
            _2 = reader.readInt32()
            var _3: String?
            _3 = parseString(reader)
            var _4: Int32?
            _4 = reader.readInt32()
            var _5: Buffer?
            if Int(_1 ?? 0) & Int(1 << 10) != 0 {
                _5 = parseBytes(reader)
            }
            let _c1 = _1 != nil
            let _c2 = _2 != nil
            let _c3 = _3 != nil
            let _c4 = _4 != nil
            let _c5 = (Int(_1 ?? 0) & Int(1 << 10) == 0) || _5 != nil
            if _c1 && _c2 && _c3 && _c4 && _c5 {
                return Api.DcOption.dcOption(Cons_dcOption(flags: _1!, id: _2!, ipAddress: _3!, port: _4!, secret: _5))
            }
            else {
                return nil
            }
        }
    }
}
