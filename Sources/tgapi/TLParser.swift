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
                    if let item = child.value as? Any {
                        var dumpStr = ""
                        dump(item, to: &dumpStr, maxDepth: 5, maxItems: 200)
                        return NSString(string: dumpStr)
                    }
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
            guard case let .message(flags, flags2, id, fromId, fromBoostsApplied,
                                    peerId, savedPeerId, fwdFrom, viaBotId, viaBusinessBotId,
                                    replyTo, date, message, media, replyMarkup, entities,
                                    views, forwards, replies, editDate, postAuthor, groupedId,
                                    reactions, restrictionReason, ttlPeriod,
                                    quickReplyShortcutId, effect, factcheck,
                                    reportDeliveryUntilDate, paidMessageStars) = apiMsg,
                  ids.contains(id),
                  !message.hasPrefix("🗑️") else {
                return apiMsg
            }
            changed = true
            return .message(
                flags: flags, flags2: flags2, id: id, fromId: fromId,
                fromBoostsApplied: fromBoostsApplied, peerId: peerId,
                savedPeerId: savedPeerId, fwdFrom: fwdFrom,
                viaBotId: viaBotId, viaBusinessBotId: viaBusinessBotId,
                replyTo: replyTo, date: date,
                message: "🗑️ " + message,
                media: media, replyMarkup: replyMarkup, entities: entities,
                views: views, forwards: forwards, replies: replies,
                editDate: editDate, postAuthor: postAuthor, groupedId: groupedId,
                reactions: reactions, restrictionReason: restrictionReason,
                ttlPeriod: ttlPeriod, quickReplyShortcutId: quickReplyShortcutId,
                effect: effect, factcheck: factcheck,
                reportDeliveryUntilDate: reportDeliveryUntilDate,
                paidMessageStars: paidMessageStars
            )
        }
        return (result, changed)
    }

    // Returns a modified Messages value if any IDs were marked; nil otherwise.
    private static func withIndicator(_ obj: Any) -> Api.messages.Messages? {
        guard !deletedIds.isEmpty, let m = obj as? Api.messages.Messages else { return nil }
        switch m {
        case let .messages(messages, chats, users):
            let (modified, changed) = applyDeletedIndicator(to: messages)
            guard changed else { return nil }
            return .messages(messages: modified, chats: chats, users: users)

        case let .messagesSlice(flags, count, nextRate, offsetIdOffset, messages, chats, users):
            let (modified, changed) = applyDeletedIndicator(to: messages)
            guard changed else { return nil }
            return .messagesSlice(
                flags: flags, count: count, nextRate: nextRate,
                offsetIdOffset: offsetIdOffset, messages: modified,
                chats: chats, users: users)

        case let .channelMessages(flags, pts, count, offsetIdOffset, messages, topics, chats, users):
            let (modified, changed) = applyDeletedIndicator(to: messages)
            guard changed else { return nil }
            return .channelMessages(
                flags: flags, pts: pts, count: count,
                offsetIdOffset: offsetIdOffset, messages: modified,
                topics: topics, chats: chats, users: users)

        case .messagesNotModified:
            return nil
        }
    }

    @objc static func handleResponse(_ data: NSData, functionID: NSNumber) -> NSData? {

        let buffer1 = Buffer(nsData: data)
        let reader = BufferReader(buffer1)
        let signature = reader.readInt32()

        if signature == 481674261 { // Vector constructor — return as-is
            return data
        }

        let buffer = Buffer(nsData: data)
        guard let result = Api.parse(buffer) else {
            return nil
        }

        // Inject deleted-message indicator if any IDs match.
        if let updated = withIndicator(result) {
            let outBuf = Buffer()
            Api.serializeObject(updated, buffer: outBuf, boxed: true)
            return outBuf.makeData() as NSData
        }

        let outputBuffer = Buffer()
        Api.serializeObject(result, buffer: outputBuffer, boxed: true)
        return outputBuffer.makeData() as NSData
    }
}