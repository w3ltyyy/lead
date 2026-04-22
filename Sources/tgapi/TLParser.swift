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