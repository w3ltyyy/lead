import Foundation

@objc(TLParser)
class TLParser: NSObject {

    // Thread-safe set of message IDs saved from deletion.
    private static let deletedQueue = DispatchQueue(label: "com.lead.deletedIds",
                                                    attributes: .concurrent)
    private static var _deletedIds = Set<Int32>()
    private static let udKey = "LeadDeletedMsgIds"
    private static var _loaded = false

    /// Called from ObjC (Hooks.xm) before zeroing message IDs in anti-revoke.
    @objc static func addDeletedId(_ id: Int32) {
        guard id != 0 else { return }
        deletedQueue.async(flags: .barrier) {
            _deletedIds.insert(id)
            // Persist to UserDefaults for cross-session indicator support
            var saved = (UserDefaults.standard.array(forKey: udKey) as? [Int32]) ?? []
            if !saved.contains(id) {
                saved.append(id)
                // Keep only last 1000 IDs to avoid unbounded growth
                if saved.count > 1000 { saved.removeFirst(saved.count - 1000) }
                UserDefaults.standard.set(saved, forKey: udKey)
            }
        }
    }

    private static var deletedIds: Set<Int32> {
        deletedQueue.sync {
            if !_loaded {
                // First access: load persisted IDs from UserDefaults
                // (can't call deletedQueue.async inside sync, use flag trick)
            }
            return _deletedIds
        }
    }

    /// Load persisted deleted IDs from UserDefaults into memory (call once at startup).
    @objc static func loadPersistedIds() {
        deletedQueue.async(flags: .barrier) {
            guard !_loaded else { return }
            _loaded = true
            let saved = (UserDefaults.standard.array(forKey: udKey) as? [Int32]) ?? []
            _deletedIds.formUnion(saved)
        }
    }

    /// Dynamically extracts message.id.id from a ChatMessageItem using string description parsing.
    /// This is safer than Mirror because it bypasses computed properties and layout differences.
    @objc static func getMessageId(from item: Any) -> NSNumber? {
        let description = String(describing: item)
        
        let pattern = "MessageId\\(peerId: [^,]+, namespace: [^,]+, id: (\\d+)\\)"
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            let nsRange = NSRange(description.startIndex..<description.endIndex, in: description)
            if let match = regex.firstMatch(in: description, options: [], range: nsRange) {
                if let idRange = Range(match.range(at: 1), in: description), let id = Int32(description[idRange]) {
                    return NSNumber(value: id)
                }
            }
        }
        
        // NEW PATTERN: Matches "id: 0:id(rawValue: 8310923053):0_11639"
        let rawValuePattern = "rawValue: \\d+\\):\\d+_(\\d+)"
        if let regex = try? NSRegularExpression(pattern: rawValuePattern, options: []) {
            let nsRange = NSRange(description.startIndex..<description.endIndex, in: description)
            if let match = regex.firstMatch(in: description, options: [], range: nsRange) {
                if let idRange = Range(match.range(at: 1), in: description), let id = Int32(description[idRange]) {
                    return NSNumber(value: id)
                }
            }
        }
        
        let fallbackPattern = "messageId: (\\d+)"
        if let regex = try? NSRegularExpression(pattern: fallbackPattern, options: []) {
            let nsRange = NSRange(description.startIndex..<description.endIndex, in: description)
            if let match = regex.firstMatch(in: description, options: [], range: nsRange) {
                if let idRange = Range(match.range(at: 1), in: description), let id = Int32(description[idRange]) {
                    return NSNumber(value: id)
                }
            }
        }
        
        // Also try standard mirror reflection
        let mirror = Mirror(reflecting: item)
        for child in mirror.children {
            if child.label == "message" || child.label == "firstMessage" || child.label == "content" {
                if child.label == "content" {
                    let contentMirror = Mirror(reflecting: child.value)
                    for cChild in contentMirror.children {
                        if cChild.label == "firstMessage" || cChild.label == "message" {
                            if let id = extractId(fromMessage: cChild.value) { return id }
                        }
                    }
                }
                if let id = extractId(fromMessage: child.value) { return id }
            }
        }
        
        // Safe shallow dump. Limits depth to 5 to completely avoid the infinite recursion lag,
        // but goes deep enough to print the MessageId which is usually at depth 1 to 4.
        var dumpStr = ""
        dump(item, to: &dumpStr, maxDepth: 5, maxItems: 200)
        
        let dumpPattern = "MessageId.*?id: (\\d+)"
        if let regex = try? NSRegularExpression(pattern: dumpPattern, options: [.dotMatchesLineSeparators]) {
            let nsRange = NSRange(dumpStr.startIndex..<dumpStr.endIndex, in: dumpStr)
            if let match = regex.firstMatch(in: dumpStr, options: [], range: nsRange) {
                if let idRange = Range(match.range(at: 1), in: dumpStr), let id = Int32(dumpStr[idRange]) {
                    return NSNumber(value: id)
                }
            }
        }
        
        let dumpRawValuePattern = "rawValue: \\d+\\):\\d+_(\\d+)"
        if let regex = try? NSRegularExpression(pattern: dumpRawValuePattern, options: []) {
            let nsRange = NSRange(dumpStr.startIndex..<dumpStr.endIndex, in: dumpStr)
            if let match = regex.firstMatch(in: dumpStr, options: [], range: nsRange) {
                if let idRange = Range(match.range(at: 1), in: dumpStr), let id = Int32(dumpStr[idRange]) {
                    return NSNumber(value: id)
                }
            }
        }
        
        return nil
    }

    private static func extractId(fromMessage msg: Any) -> NSNumber? {
        let msgMirror = Mirror(reflecting: msg)
        for msgChild in msgMirror.children {
            if msgChild.label == "id" {
                let idMirror = Mirror(reflecting: msgChild.value)
                for idChild in idMirror.children {
                    if idChild.label == "id", let idVal = idChild.value as? Int32 {
                        return NSNumber(value: idVal)
                    }
                }
            }
        }
        return nil
    }

    /// Dynamically extracts message ID from a ChatMessageBubbleItemNode
    @objc static func getMessageIdFromNode(_ node: Any) -> NSNumber? {
        var currentMirror: Mirror? = Mirror(reflecting: node)
        while let mirror = currentMirror {
            for child in mirror.children {
                if child.label == "item" {
                    if let item = child.value as? Any {
                        if let id = getMessageId(from: item) {
                            return id
                        }
                    }
                }
            }
            currentMirror = mirror.superclassMirror
        }
        
        // If reflection completely fails to find 'item', try parsing the node's string description.
        // This is 100% safe (unlike dump) and might reveal the message ID if the node implements CustomStringConvertible.
        let nodeDesc = String(describing: node)
        let pattern = "MessageId\\(peerId: [^,]+, namespace: [^,]+, id: (\\d+)\\)"
        if let regex = try? NSRegularExpression(pattern: pattern, options: []) {
            let nsRange = NSRange(nodeDesc.startIndex..<nodeDesc.endIndex, in: nodeDesc)
            if let match = regex.firstMatch(in: nodeDesc, options: [], range: nsRange) {
                if let idRange = Range(match.range(at: 1), in: nodeDesc), let id = Int32(nodeDesc[idRange]) {
                    return NSNumber(value: id)
                }
            }
        }
        
        let fallbackPattern = "messageId: (\\d+)"
        if let regex = try? NSRegularExpression(pattern: fallbackPattern, options: []) {
            let nsRange = NSRange(nodeDesc.startIndex..<nodeDesc.endIndex, in: nodeDesc)
            if let match = regex.firstMatch(in: nodeDesc, options: [], range: nsRange) {
                if let idRange = Range(match.range(at: 1), in: nodeDesc), let id = Int32(nodeDesc[idRange]) {
                    return NSNumber(value: id)
                }
            }
        }
        
        return nil
    }

    @objc static func getDebugDumpFromNode(_ node: Any) -> NSString {
        var currentMirror: Mirror? = Mirror(reflecting: node)
        while let mirror = currentMirror {
            for child in mirror.children {
                if child.label == "item" {
                    let item = child.value
                    var dumpStr = ""
                    dump(item, to: &dumpStr, maxDepth: 5, maxItems: 200)
                    return NSString(string: dumpStr)
                }
            }
            currentMirror = mirror.superclassMirror
        }
        return NSString(string: "ITEM NOT FOUND IN MIRROR")
    }

    @objc static func isDeleted(_ msgId: NSNumber) -> Bool {
        return deletedIds.contains(msgId.int32Value)
    }

    // Prepend 🗑️ to each message whose ID is in the deleted set.
    private static func applyDeletedIndicator(to msgs: [Api.Message]) -> (messages: [Api.Message], changed: Bool) {
        let ids = deletedIds
        guard !ids.isEmpty else { return (msgs, false) }
        var changed = false
        let result = msgs.map { apiMsg -> Api.Message in
            guard case let .message(data) = apiMsg,
                  ids.contains(data.id),
                  !data.message.hasPrefix("🗑️") else {
                return apiMsg
            }
            changed = true
            return .message(Api.Message.Cons_message(
                flags: data.flags, flags2: data.flags2, id: data.id, fromId: data.fromId,
                fromBoostsApplied: data.fromBoostsApplied, fromRank: data.fromRank, peerId: data.peerId,
                savedPeerId: data.savedPeerId, fwdFrom: data.fwdFrom,
                viaBotId: data.viaBotId, viaBusinessBotId: data.viaBusinessBotId,
                replyTo: data.replyTo, date: data.date,
                message: "🗑️ " + data.message,
                media: data.media, replyMarkup: data.replyMarkup, entities: data.entities,
                views: data.views, forwards: data.forwards, replies: data.replies,
                editDate: data.editDate, postAuthor: data.postAuthor, groupedId: data.groupedId,
                reactions: data.reactions, restrictionReason: data.restrictionReason,
                ttlPeriod: data.ttlPeriod, quickReplyShortcutId: data.quickReplyShortcutId,
                effect: data.effect, factcheck: data.factcheck,
                reportDeliveryUntilDate: data.reportDeliveryUntilDate,
                paidMessageStars: data.paidMessageStars,
                suggestedPost: data.suggestedPost, scheduleRepeatPeriod: data.scheduleRepeatPeriod,
                summaryFromLanguage: data.summaryFromLanguage
            ))
        }
        return (result, changed)
    }

    // Returns a modified Messages value if any IDs were marked; nil otherwise.
    private static func withIndicator(_ obj: Any) -> Api.messages.Messages? {
        guard !deletedIds.isEmpty, let m = obj as? Api.messages.Messages else { return nil }
        switch m {
        case let .messages(data):
            let (modified, changed) = applyDeletedIndicator(to: data.messages)
            let stripped = modified.map { stripTTLMessage($0) }
            return changed || true ? .messages(Api.messages.Messages.Cons_messages(messages: stripped, topics: data.topics, chats: data.chats, users: data.users)) : nil
        case let .messagesSlice(data):
            let (modified, changed) = applyDeletedIndicator(to: data.messages)
            let stripped = modified.map { stripTTLMessage($0) }
            return changed || true ? .messagesSlice(Api.messages.Messages.Cons_messagesSlice(flags: data.flags, count: data.count, nextRate: data.nextRate, offsetIdOffset: data.offsetIdOffset, searchFlood: data.searchFlood, messages: stripped, topics: data.topics, chats: data.chats, users: data.users)) : nil
        case let .channelMessages(data):
            let (modified, changed) = applyDeletedIndicator(to: data.messages)
            let stripped = modified.map { stripTTLMessage($0) }
            return changed || true ? .channelMessages(Api.messages.Messages.Cons_channelMessages(flags: data.flags, pts: data.pts, count: data.count, offsetIdOffset: data.offsetIdOffset, messages: stripped, topics: data.topics, chats: data.chats, users: data.users)) : nil
        default:
            return nil
        }
    }
    // IDs of messages that originally had a self-destruct timer
    private static var selfDestructingMessageIds = Set<Int32>()

    @objc static func isMessageSelfDestructing(_ msgId: NSNumber) -> Bool {
        return selfDestructingMessageIds.contains(msgId.int32Value)
    }

    private static func stripTTLMedia(_ media: Api.MessageMedia, messageId: Int32) -> Api.MessageMedia {
        guard UserDefaults.standard.bool(forKey: "LeadAntiSelfDestruct") else { return media }
        switch media {
        case let .messageMediaPhoto(data):
            if data.ttlSeconds != nil || (Int(data.flags) & Int(1 << 2)) != 0 {
                selfDestructingMessageIds.insert(messageId)
            }
            // Clear ttlSeconds (bit 2) and spoiler (bit 3) and media_unread (bit 5) just in case
            return .messageMediaPhoto(Api.MessageMedia.Cons_messageMediaPhoto(flags: data.flags & ~(1 << 2) & ~(1 << 3) & ~(1 << 5), photo: data.photo, ttlSeconds: nil, video: data.video))
        case let .messageMediaDocument(data):
            if data.ttlSeconds != nil || (Int(data.flags) & Int(1 << 2)) != 0 {
                selfDestructingMessageIds.insert(messageId)
            }
            // Clear ttlSeconds (bit 2) and spoiler (bit 3) and video stuff
            return .messageMediaDocument(Api.MessageMedia.Cons_messageMediaDocument(flags: data.flags & ~(1 << 2) & ~(1 << 3), document: data.document, altDocuments: data.altDocuments, videoCover: data.videoCover, videoTimestamp: data.videoTimestamp, ttlSeconds: nil))
        default:
            return media
        }
    }

    private static func stripNoForwards(_ chat: Api.Chat) -> Api.Chat {
        guard UserDefaults.standard.bool(forKey: "disableForwardRestriction") || 
              UserDefaults.standard.bool(forKey: "LeadAntiSelfDestruct") else { return chat }
              
        switch chat {
        case let .channel(data):
            // Bit 16 is standard, bit 27 is used in neutralizePayload, bit 5 is restricted
            let mask: Int32 = ~( (1 << 16) | (1 << 27) | (1 << 5) )
            return .channel(Api.Chat.Cons_channel(
                flags: data.flags & mask,
                flags2: data.flags2 & mask,
                id: data.id, accessHash: data.accessHash, title: data.title,
                username: data.username, photo: data.photo, date: data.date,
                restrictionReason: data.restrictionReason, adminRights: data.adminRights,
                bannedRights: data.bannedRights, defaultBannedRights: data.defaultBannedRights,
                participantsCount: data.participantsCount, usernames: data.usernames,
                storiesMaxId: data.storiesMaxId, color: data.color, profileColor: data.profileColor,
                emojiStatus: data.emojiStatus, level: data.level, subscriptionUntilDate: data.subscriptionUntilDate,
                botVerificationIcon: data.botVerificationIcon, sendPaidMessagesStars: data.sendPaidMessagesStars,
                linkedMonoforumId: data.linkedMonoforumId
            ))
        case let .chat(data):
            // Bit 14/16/25 are used for restrictions
            let mask: Int32 = ~( (1 << 14) | (1 << 16) | (1 << 25) )
            return .chat(Api.Chat.Cons_chat(
                flags: data.flags & mask,
                id: data.id, title: data.title, photo: data.photo,
                participantsCount: data.participantsCount, date: data.date, version: data.version,
                migratedTo: data.migratedTo, adminRights: data.adminRights,
                defaultBannedRights: data.defaultBannedRights
            ))
        default:
            return chat
        }
    }

    private static func stripNoForwardsFromChats(_ chats: [Api.Chat]) -> [Api.Chat] {
        return chats.map { stripNoForwards($0) }
    }

    private static func shiftEntities(_ entities: [Api.MessageEntity]?, by offset: Int32) -> [Api.MessageEntity] {
        guard let entities = entities else { return [] }
        return entities.map { entity in
            switch entity {
            case let .messageEntityUnknown(d): return .messageEntityUnknown(Api.MessageEntity.Cons_messageEntityUnknown(offset: d.offset + offset, length: d.length))
            case let .messageEntityMention(d): return .messageEntityMention(Api.MessageEntity.Cons_messageEntityMention(offset: d.offset + offset, length: d.length))
            case let .messageEntityHashtag(d): return .messageEntityHashtag(Api.MessageEntity.Cons_messageEntityHashtag(offset: d.offset + offset, length: d.length))
            case let .messageEntityBotCommand(d): return .messageEntityBotCommand(Api.MessageEntity.Cons_messageEntityBotCommand(offset: d.offset + offset, length: d.length))
            case let .messageEntityUrl(d): return .messageEntityUrl(Api.MessageEntity.Cons_messageEntityUrl(offset: d.offset + offset, length: d.length))
            case let .messageEntityEmail(d): return .messageEntityEmail(Api.MessageEntity.Cons_messageEntityEmail(offset: d.offset + offset, length: d.length))
            case let .messageEntityBold(d): return .messageEntityBold(Api.MessageEntity.Cons_messageEntityBold(offset: d.offset + offset, length: d.length))
            case let .messageEntityItalic(d): return .messageEntityItalic(Api.MessageEntity.Cons_messageEntityItalic(offset: d.offset + offset, length: d.length))
            case let .messageEntityCode(d): return .messageEntityCode(Api.MessageEntity.Cons_messageEntityCode(offset: d.offset + offset, length: d.length))
            case let .messageEntityPre(d): return .messageEntityPre(Api.MessageEntity.Cons_messageEntityPre(offset: d.offset + offset, length: d.length, language: d.language))
            case let .messageEntityTextUrl(d): return .messageEntityTextUrl(Api.MessageEntity.Cons_messageEntityTextUrl(offset: d.offset + offset, length: d.length, url: d.url))
            case let .messageEntityMentionName(d): return .messageEntityMentionName(Api.MessageEntity.Cons_messageEntityMentionName(offset: d.offset + offset, length: d.length, userId: d.userId))
            case let .messageEntityPhone(d): return .messageEntityPhone(Api.MessageEntity.Cons_messageEntityPhone(offset: d.offset + offset, length: d.length))
            case let .messageEntityCashtag(d): return .messageEntityCashtag(Api.MessageEntity.Cons_messageEntityCashtag(offset: d.offset + offset, length: d.length))
            case let .messageEntityUnderline(d): return .messageEntityUnderline(Api.MessageEntity.Cons_messageEntityUnderline(offset: d.offset + offset, length: d.length))
            case let .messageEntityStrike(d): return .messageEntityStrike(Api.MessageEntity.Cons_messageEntityStrike(offset: d.offset + offset, length: d.length))
            case let .messageEntityBlockquote(d): return .messageEntityBlockquote(Api.MessageEntity.Cons_messageEntityBlockquote(flags: d.flags, offset: d.offset + offset, length: d.length))
            case let .messageEntityBankCard(d): return .messageEntityBankCard(Api.MessageEntity.Cons_messageEntityBankCard(offset: d.offset + offset, length: d.length))
            case let .messageEntitySpoiler(d): return .messageEntitySpoiler(Api.MessageEntity.Cons_messageEntitySpoiler(offset: d.offset + offset, length: d.length))
            case let .messageEntityCustomEmoji(d): return .messageEntityCustomEmoji(Api.MessageEntity.Cons_messageEntityCustomEmoji(offset: d.offset + offset, length: d.length, documentId: d.documentId))
            default: return entity
            }
        }
    }

    private static func applyTTLIndicator(message: String, entities: [Api.MessageEntity]?, shouldApply: Bool) -> (String, [Api.MessageEntity]?) {
        var newMessageText = message
        var newEntities = entities ?? []
        
        if shouldApply {
            let marker = "dissapearing message "
            if !newMessageText.contains("dissapearing message") && !newMessageText.hasPrefix("🗑️") {
                 // Remove ⏱️ emoji if it was added in previous turns
                 if newMessageText.hasPrefix("⏱️ ") {
                     newMessageText.removeFirst(3)
                 }
                 
                 let markerLen = Int32(marker.count)
                 newEntities = shiftEntities(newEntities, by: markerLen)
                 
                 // Add italic and spoiler entities for the marker
                 let markerTextLen = Int32(marker.count - 1)
                 newEntities.insert(.messageEntityItalic(Api.MessageEntity.Cons_messageEntityItalic(offset: 0, length: markerTextLen)), at: 0)
                 newEntities.insert(.messageEntitySpoiler(Api.MessageEntity.Cons_messageEntitySpoiler(offset: 0, length: markerTextLen)), at: 0)
                 
                 newMessageText = marker + newMessageText
            }
        }
        return (newMessageText, newEntities)
    }

    private static func stripTTLMessage(_ apiMsg: Api.Message) -> Api.Message {
        guard UserDefaults.standard.bool(forKey: "LeadAntiSelfDestruct") else { return apiMsg }
        guard case let .message(data) = apiMsg else {
            return apiMsg
        }
        
        var isDestructing = false
        if data.ttlPeriod != nil || (Int(data.flags) & Int(1 << 25)) != 0 {
            isDestructing = true
            selfDestructingMessageIds.insert(data.id)
        }

        let newMedia = data.media.map { stripTTLMedia($0, messageId: data.id) }
        
        let isMediaDestructing = selfDestructingMessageIds.contains(data.id)
        let shouldStripFlags = isDestructing || isMediaDestructing
        
        let (newMessageText, newEntities) = applyTTLIndicator(message: data.message, entities: data.entities, shouldApply: shouldStripFlags)
        
        var newFlags = shouldStripFlags ? (data.flags & ~(1 << 25) & ~(1 << 5)) : data.flags
        var newFlags2 = data.flags2
        
        // Strip noforwards if requested
        if UserDefaults.standard.bool(forKey: "disableForwardRestriction") || 
           UserDefaults.standard.bool(forKey: "LeadAntiSelfDestruct") {
            // Bit 14 is standard, bit 26 is used in neutralizePayload
            let mask: Int32 = ~( (1 << 14) | (1 << 26) )
            newFlags &= mask
            newFlags2 &= mask
        }
        
        // Set entities flag (bit 7) if we have entities
        if (newEntities?.count ?? 0) > 0 {
            newFlags |= (1 << 7)
        }
        
        return .message(Api.Message.Cons_message(
            flags: newFlags, flags2: data.flags2, id: data.id, fromId: data.fromId,
            fromBoostsApplied: data.fromBoostsApplied, fromRank: data.fromRank, peerId: data.peerId,
            savedPeerId: data.savedPeerId, fwdFrom: data.fwdFrom,
            viaBotId: data.viaBotId, viaBusinessBotId: data.viaBusinessBotId,
            replyTo: data.replyTo, date: data.date,
            message: newMessageText,
            media: newMedia, replyMarkup: data.replyMarkup, entities: newEntities,
            views: data.views, forwards: data.forwards, replies: data.replies,
            editDate: data.editDate, postAuthor: data.postAuthor, groupedId: data.groupedId,
            reactions: data.reactions, restrictionReason: data.restrictionReason,
            ttlPeriod: shouldStripFlags ? nil : data.ttlPeriod, quickReplyShortcutId: data.quickReplyShortcutId,
            effect: data.effect, factcheck: data.factcheck,
            reportDeliveryUntilDate: data.reportDeliveryUntilDate,
            paidMessageStars: data.paidMessageStars,
            suggestedPost: data.suggestedPost, scheduleRepeatPeriod: data.scheduleRepeatPeriod,
            summaryFromLanguage: data.summaryFromLanguage
        ))
    }

    private static func stripTTLUpdate(_ update: Api.Update) -> Api.Update {
        switch update {
        case let .updateNewMessage(data):
            return .updateNewMessage(Api.Update.Cons_updateNewMessage(message: stripTTLMessage(data.message), pts: data.pts, ptsCount: data.ptsCount))
        case let .updateNewChannelMessage(data):
            return .updateNewChannelMessage(Api.Update.Cons_updateNewChannelMessage(message: stripTTLMessage(data.message), pts: data.pts, ptsCount: data.ptsCount))
        default:
            return update
        }
    }

    @objc static func stripAntiSelfDestruct(_ data: NSData) -> NSData? {
        let isAntiSelfDestruct = UserDefaults.standard.bool(forKey: "LeadAntiSelfDestruct")
        let isNoForwardsBypass = UserDefaults.standard.bool(forKey: "disableForwardRestriction")
        
        guard isAntiSelfDestruct || isNoForwardsBypass else { return nil }
        let buffer = Buffer(data: data as Data)
        let reader = BufferReader(buffer)
        guard let signature = reader.readInt32() else { return nil }
        
        if signature == 0x73f1f8dc { // msg_container
            guard let count = reader.readInt32() else { return nil }
            let outBuf = Buffer()
            outBuf.appendInt32(0x73f1f8dc)
            outBuf.appendInt32(count)
            
            var modifiedContainer = false
            for _ in 0..<count {
                guard let msg_id = reader.readInt64(),
                      let seqno = reader.readInt32(),
                      let bytes = reader.readInt32() else { return nil }
                
                guard let bodyBuffer = reader.readBuffer(Int(bytes)) else { return nil }
                let bodyData = bodyBuffer.makeData() as NSData
                
                var newBodyData = bodyData
                if let stripped = stripAntiSelfDestruct(newBodyData) {
                    newBodyData = stripped
                    modifiedContainer = true
                }
                
                outBuf.appendInt64(msg_id)
                outBuf.appendInt32(seqno)
                outBuf.appendInt32(Int32(newBodyData.length))
                outBuf.appendBytes(newBodyData.bytes, length: UInt(newBodyData.length))
            }
            
            return modifiedContainer ? (outBuf.makeData() as NSData) : nil
        }
        // Do not reset the reader, because Api.parse(reader, signature:) expects the reader to be at offset 4
        guard let result = Api.parse(reader, signature: signature) else { return nil }
        
        var modified = false
        var newResult: Any = result

        if let updates = result as? Api.Updates {
            switch updates {
            case let .updates(data):
                let stripped = data.updates.map { stripTTLUpdate($0) }
                let newChats = stripNoForwardsFromChats(data.chats)
                newResult = Api.Updates.updates(Api.Updates.Cons_updates(updates: stripped, users: data.users, chats: newChats, date: data.date, seq: data.seq))
                modified = true
            case let .updateShort(data):
                newResult = Api.Updates.updateShort(Api.Updates.Cons_updateShort(update: stripTTLUpdate(data.update), date: data.date))
                modified = true
            case let .updateShortMessage(data):
                var isDestructing = false
                if data.ttlPeriod != nil || (Int(data.flags) & Int(1 << 25)) != 0 {
                    isDestructing = true
                    selfDestructingMessageIds.insert(data.id)
                }
                var newFlags = data.flags
                if isDestructing {
                    newFlags &= ~(1 << 25)
                    newFlags &= ~(1 << 5)
                }
                
                if UserDefaults.standard.bool(forKey: "disableForwardRestriction") || 
                   UserDefaults.standard.bool(forKey: "LeadAntiSelfDestruct") {
                    newFlags &= ~(1 << 14)
                    newFlags &= ~(1 << 26)
                }
                
                let (newMessageText, newEntities) = applyTTLIndicator(message: data.message, entities: data.entities, shouldApply: isDestructing)
                if (newEntities?.count ?? 0) > 0 {
                    newFlags |= (1 << 7)
                }
                
                newResult = Api.Updates.updateShortMessage(Api.Updates.Cons_updateShortMessage(flags: newFlags, id: data.id, userId: data.userId, message: newMessageText, pts: data.pts, ptsCount: data.ptsCount, date: data.date, fwdFrom: data.fwdFrom, viaBotId: data.viaBotId, replyTo: data.replyTo, entities: newEntities, ttlPeriod: isDestructing ? nil : data.ttlPeriod))
                modified = true
            case let .updateShortChatMessage(data):
                var isDestructing = false
                if data.ttlPeriod != nil || (Int(data.flags) & Int(1 << 25)) != 0 {
                    isDestructing = true
                    selfDestructingMessageIds.insert(data.id)
                }
                var newFlags = data.flags
                if isDestructing {
                    newFlags &= ~(1 << 25)
                    newFlags &= ~(1 << 5)
                }
                
                if UserDefaults.standard.bool(forKey: "disableForwardRestriction") || 
                   UserDefaults.standard.bool(forKey: "LeadAntiSelfDestruct") {
                    newFlags &= ~(1 << 14)
                    newFlags &= ~(1 << 26)
                }
                
                let (newMessageText, newEntities) = applyTTLIndicator(message: data.message, entities: data.entities, shouldApply: isDestructing)
                if (newEntities?.count ?? 0) > 0 {
                    newFlags |= (1 << 7)
                }
                
                newResult = Api.Updates.updateShortChatMessage(Api.Updates.Cons_updateShortChatMessage(flags: newFlags, id: data.id, fromId: data.fromId, chatId: data.chatId, message: newMessageText, pts: data.pts, ptsCount: data.ptsCount, date: data.date, fwdFrom: data.fwdFrom, viaBotId: data.viaBotId, replyTo: data.replyTo, entities: newEntities, ttlPeriod: isDestructing ? nil : data.ttlPeriod))
                modified = true
            case let .updateShortSentMessage(data):
                let newMedia = data.media.map { stripTTLMedia($0, messageId: data.id) }
                let isMediaDestructing = selfDestructingMessageIds.contains(data.id)
                let newFlags = isMediaDestructing ? (data.flags & ~(1 << 25) & ~(1 << 5)) : data.flags
                newResult = Api.Updates.updateShortSentMessage(Api.Updates.Cons_updateShortSentMessage(flags: newFlags, id: data.id, pts: data.pts, ptsCount: data.ptsCount, date: data.date, media: newMedia, entities: data.entities, ttlPeriod: isMediaDestructing ? nil : data.ttlPeriod))
                modified = true
            case let .updatesCombined(data):
                let stripped = data.updates.map { stripTTLUpdate($0) }
                let newChats = stripNoForwardsFromChats(data.chats)
                newResult = Api.Updates.updatesCombined(Api.Updates.Cons_updatesCombined(updates: stripped, users: data.users, chats: newChats, date: data.date, seqStart: data.seqStart, seq: data.seq))
                modified = true
            default:
                break
            }
        } else if let msgs = result as? Api.messages.Messages {
            switch msgs {
            case let .messages(data):
                let newMessages = data.messages.map { stripTTLMessage($0) }
                let newChats = stripNoForwardsFromChats(data.chats)
                newResult = Api.messages.Messages.messages(Api.messages.Messages.Cons_messages(messages: newMessages, topics: data.topics, chats: newChats, users: data.users))
                modified = true
            case let .messagesSlice(data):
                let newMessages = data.messages.map { stripTTLMessage($0) }
                let newChats = stripNoForwardsFromChats(data.chats)
                newResult = Api.messages.Messages.messagesSlice(Api.messages.Messages.Cons_messagesSlice(flags: data.flags, count: data.count, nextRate: data.nextRate, offsetIdOffset: data.offsetIdOffset, searchFlood: data.searchFlood, messages: newMessages, topics: data.topics, chats: newChats, users: data.users))
                modified = true
            case let .channelMessages(data):
                let newMessages = data.messages.map { stripTTLMessage($0) }
                let newChats = stripNoForwardsFromChats(data.chats)
                newResult = Api.messages.Messages.channelMessages(Api.messages.Messages.Cons_channelMessages(flags: data.flags, pts: data.pts, count: data.count, offsetIdOffset: data.offsetIdOffset, messages: newMessages, topics: data.topics, chats: newChats, users: data.users))
                modified = true
            default:
                break
            }
        } else if let chatFull = result as? Api.messages.ChatFull {
            switch chatFull {
            case let .chatFull(data):
                let newChats = stripNoForwardsFromChats(data.chats)
                newResult = Api.messages.ChatFull.chatFull(Api.messages.ChatFull.Cons_chatFull(fullChat: data.fullChat, chats: newChats, users: data.users))
                modified = true
            }
        } else if let chats = result as? Api.messages.Chats {
            switch chats {
            case let .chats(data):
                let newChats = stripNoForwardsFromChats(data.chats)
                newResult = Api.messages.Chats.chats(Api.messages.Chats.Cons_chats(chats: newChats))
                modified = true
            case let .chatsSlice(data):
                let newChats = stripNoForwardsFromChats(data.chats)
                newResult = Api.messages.Chats.chatsSlice(Api.messages.Chats.Cons_chatsSlice(count: data.count, chats: newChats))
                modified = true
            }
        } else if let update = result as? Api.Update {
            let stripped = stripTTLUpdate(update)
            newResult = stripped
            modified = true
        } else if let message = result as? Api.Message {
            let stripped = stripTTLMessage(message)
            newResult = stripped
            modified = true
        } else if let discussion = result as? Api.messages.DiscussionMessage {
            switch discussion {
            case let .discussionMessage(data):
                let newMessages = data.messages.map { stripTTLMessage($0) }
                let newChats = stripNoForwardsFromChats(data.chats)
                newResult = Api.messages.DiscussionMessage.discussionMessage(Api.messages.DiscussionMessage.Cons_discussionMessage(flags: data.flags, messages: newMessages, maxId: data.maxId, readInboxMaxId: data.readInboxMaxId, readOutboxMaxId: data.readOutboxMaxId, unreadCount: data.unreadCount, chats: newChats, users: data.users))
                modified = true
            }
        } else if let peerDialogs = result as? Api.messages.PeerDialogs {
            switch peerDialogs {
            case let .peerDialogs(data):
                let newMessages = data.messages.map { stripTTLMessage($0) }
                let newChats = stripNoForwardsFromChats(data.chats)
                newResult = Api.messages.PeerDialogs.peerDialogs(Api.messages.PeerDialogs.Cons_peerDialogs(dialogs: data.dialogs, messages: newMessages, chats: newChats, users: data.users, state: data.state))
                modified = true
            }
        }
        
        if modified {
            let outBuf = Buffer()
            Api.serializeObject(newResult, buffer: outBuf, boxed: true)
            return outBuf.makeData() as NSData
        }
        return nil
    }

    @objc static func handleResponse(_ data: NSData, functionID: NSNumber) -> NSData? {

        let buffer1 = Buffer(data: data as Data)
        let reader = BufferReader(buffer1)
        let signature = reader.readInt32()

        if signature == 481674261 { // Vector constructor — return as-is
            return data
        }

        let buffer = Buffer(data: data as Data)
        guard let result = Api.parse(buffer) else {
            return nil
        }

        // Apply deleted indicators AND strip self-destruct from fetched history.
        let withInd = withIndicator(result)
        var shouldSerialize = false
        var objToSerialize: Any = result

        if withInd != nil {
            objToSerialize = withInd!
            shouldSerialize = true
        } else if UserDefaults.standard.bool(forKey: "LeadAntiSelfDestruct") {
            // Even if no deleted indicators were applied, we should strip TTL.
            if let msgs = result as? Api.messages.Messages {
                switch msgs {
                case let .messages(data):
                    objToSerialize = Api.messages.Messages.messages(Api.messages.Messages.Cons_messages(messages: data.messages.map { stripTTLMessage($0) }, topics: data.topics, chats: data.chats, users: data.users))
                    shouldSerialize = true
                case let .messagesSlice(data):
                    objToSerialize = Api.messages.Messages.messagesSlice(Api.messages.Messages.Cons_messagesSlice(flags: data.flags, count: data.count, nextRate: data.nextRate, offsetIdOffset: data.offsetIdOffset, searchFlood: data.searchFlood, messages: data.messages.map { stripTTLMessage($0) }, topics: data.topics, chats: data.chats, users: data.users))
                    shouldSerialize = true
                case let .channelMessages(data):
                    objToSerialize = Api.messages.Messages.channelMessages(Api.messages.Messages.Cons_channelMessages(flags: data.flags, pts: data.pts, count: data.count, offsetIdOffset: data.offsetIdOffset, messages: data.messages.map { stripTTLMessage($0) }, topics: data.topics, chats: data.chats, users: data.users))
                    shouldSerialize = true
                default:
                    break
                }
            }
        }

        if shouldSerialize {
            let outBuf = Buffer()
            Api.serializeObject(objToSerialize, buffer: outBuf, boxed: true)
            return outBuf.makeData() as NSData
        }

        let outputBuffer = Buffer()
        Api.serializeObject(result, buffer: outputBuffer, boxed: true)
        return outputBuffer.makeData() as NSData
    }
}