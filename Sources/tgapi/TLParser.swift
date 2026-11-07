import Foundation
import tgapiC

@objc(TLParser)
class TLParser: NSObject {
    @objc static var sharedContext: Any?

    // Thread-safe set of message IDs saved from deletion.
    private static let deletedQueue = DispatchQueue(label: "com.lead.deletedIds",
                                                    attributes: .concurrent)
    private static var _deletedIds = Set<Int32>()
    private static let udKey = "LeadDeletedMsgIds"
    private static var _loaded = false
    private static let editedQueue = DispatchQueue(label: "com.lead.editedIds",
                                                   attributes: .concurrent)
    private static var _editedIds = Set<Int32>()
    private static let editedUdKey = "LeadEditedMsgIds"
    private static let editedMediaUdKey = "LeadEditedMediaMsgIds"
    private static var _editedLoaded = false
    // Scoped keys (see editScope) of messages whose media was replaced.
    private static var _editedMediaKeys = Set<String>()
    private static let editHistoryQueue = DispatchQueue(label: "com.lead.editHistory")
    private static let editHistoryUdKey = "LeadEditHistory"
    private static let textSnapshotsUdKey = "LeadMessageTextSnapshots"
    private static var protectedChannelIds = Set<Int64>()

    // Message ids are only unique per channel, so channel deletions are keyed by
    // "channelId:messageId". Private chats and basic groups share one id space per
    // account and stay in _deletedIds. Ids saved before this split (one mixed set)
    // live in _legacyDeletedIds and keep matching everywhere, as they always did.
    private static var _deletedChannelKeys = Set<String>()
    private static var _legacyDeletedIds = Set<Int32>()
    // Insertion order of the two sets above, oldest first; these are what gets saved.
    private static var _deletedOrder: [Int32] = []
    private static var _deletedChannelOrder: [String] = []
    // id -> "u…"/"g…" when the message was seen before it was deleted. Ids repeat
    // between the accounts of one app, so a known chat has to match as well.
    private static var _deletedPeers: [String: String] = [:]
    private static var deletedPersistScheduled = false
    private static let deletedPeersUdKey = "LeadDeletedMsgPeers"
    private static let channelUdKey = "LeadDeletedChannelMsgKeys"
    private static let legacyUdKey = "LeadDeletedMsgIdsLegacy"
    private static let deletedSchemeUdKey = "LeadDeletedMsgScheme"

    private static func channelKey(_ channelId: Int64, _ id: Int32) -> String {
        return "\(channelId):\(id)"
    }

    /// Private chats / basic groups (updateDeleteMessages). Called from Hooks.xm.
    @objc static func addDeletedId(_ id: Int32) {
        guard id != 0 else { return }
        if isExtension { bridgeHandoff("d \(id)"); return }
        deletedQueue.async(flags: .barrier) {
            guard _deletedIds.insert(id).inserted else { return }
            _deletedOrder.append(id)
            if _deletedOrder.count > 1000 {
                for old in _deletedOrder.prefix(_deletedOrder.count - 1000) {
                    _deletedIds.remove(old)
                    _deletedPeers.removeValue(forKey: "\(old)")
                }
                _deletedOrder.removeFirst(_deletedOrder.count - 1000)
            }
            logDeleted(id: id, channelId: nil)
            scheduleDeletedPersist()
        }
    }

    /// Channels / supergroups (updateDeleteChannelMessages). Called from Hooks.xm.
    @objc(addDeletedId:channelId:)
    static func addDeletedId(_ id: Int32, channelId: Int64) {
        guard id != 0, channelId != 0 else { return }
        if isExtension { bridgeHandoff("d \(id) \(channelId)"); return }
        deletedQueue.async(flags: .barrier) {
            let key = channelKey(channelId, id)
            guard _deletedChannelKeys.insert(key).inserted else { return }
            _deletedChannelOrder.append(key)
            if _deletedChannelOrder.count > 2000 {
                for old in _deletedChannelOrder.prefix(_deletedChannelOrder.count - 2000) {
                    _deletedChannelKeys.remove(old)
                }
                _deletedChannelOrder.removeFirst(_deletedChannelOrder.count - 2000)
            }
            logDeleted(id: id, channelId: channelId)
            scheduleDeletedPersist()
        }
    }

    // Called from logDeleted once the chat of a private / basic group id is known.
    fileprivate static func noteDeletedPeer(id: Int32, tag: String) {
        deletedQueue.async(flags: .barrier) {
            guard _deletedIds.contains(id) else { return }
            _deletedPeers["\(id)"] = tag
            scheduleDeletedPersist()
        }
    }

    // Called on deletedQueue, inside a barrier. A purge in a big group deletes hundreds
    // of ids at once; rewriting the list for each of them held up every isDeleted read
    // made from layout, so the disk write is batched.
    private static func scheduleDeletedPersist() {
        _ = flushOnBackground
        guard !deletedPersistScheduled else { return }
        deletedPersistScheduled = true
        deletedQueue.asyncAfter(deadline: .now() + 2, flags: .barrier) {
            guard deletedPersistScheduled else { return }
            deletedPersistScheduled = false
            let ids = _deletedOrder, channelKeys = _deletedChannelOrder, peers = _deletedPeers
            DispatchQueue.global(qos: .utility).async {
                writeDeleted(ids: ids, channelKeys: channelKeys, peers: peers)
            }
        }
    }

    private static func writeDeleted(ids: [Int32], channelKeys: [String], peers: [String: String]) {
        let defaults = UserDefaults.standard
        defaults.set(ids, forKey: udKey)
        defaults.set(channelKeys, forKey: channelUdKey)
        defaults.set(peers, forKey: deletedPeersUdKey)
    }

    private static func isDeleted(id: Int32, channelId: Int64?, peerTag: String? = nil) -> Bool {
        return deletedQueue.sync {
            if let channelId = channelId {
                return _deletedChannelKeys.contains(channelKey(channelId, id))
            }
            // Ids saved before 2.0 have no chat; they can only be trusted outside
            // channels, where ids are unique per account.
            if _legacyDeletedIds.contains(id) { return true }
            guard _deletedIds.contains(id) else { return false }
            if let peerTag = peerTag, let known = _deletedPeers["\(id)"], known != peerTag { return false }
            return true
        }
    }

    /// Load persisted deleted IDs from UserDefaults into memory (call once at startup).
    @objc static func loadPersistedIds() {
        deletedQueue.async(flags: .barrier) {
            // In the extension deletions only pass through to the app (see the bridge).
            guard !_loaded, !isExtension else { return }
            _loaded = true
            let defaults = UserDefaults.standard
            if defaults.integer(forKey: deletedSchemeUdKey) < 2 {
                // One-time move of the old mixed id list into the legacy set.
                let old = (defaults.array(forKey: udKey) as? [Int32]) ?? []
                defaults.set(old, forKey: legacyUdKey)
                defaults.set([Int32](), forKey: udKey)
                defaults.set(2, forKey: deletedSchemeUdKey)
            }
            _legacyDeletedIds.formUnion((defaults.array(forKey: legacyUdKey) as? [Int32]) ?? [])
            _deletedOrder = (defaults.array(forKey: udKey) as? [Int32]) ?? []
            _deletedIds.formUnion(_deletedOrder)
            _deletedChannelOrder = (defaults.array(forKey: channelUdKey) as? [String]) ?? []
            _deletedChannelKeys.formUnion(_deletedChannelOrder)
            _deletedPeers = (defaults.dictionary(forKey: deletedPeersUdKey) as? [String: String]) ?? [:]
        }
        editedQueue.async(flags: .barrier) {
            guard !_editedLoaded, !isExtension else { return }
            _editedLoaded = true
            let saved = (UserDefaults.standard.array(forKey: editedUdKey) as? [Int32]) ?? []
            _editedIds.formUnion(saved)
            // Entries from before 2.0 were bare ids.
            let savedMedia = UserDefaults.standard.array(forKey: editedMediaUdKey) ?? []
            for value in savedMedia {
                if let key = value as? String { _editedMediaKeys.insert(key) }
                else if let id = (value as? NSNumber)?.int32Value { _editedMediaKeys.insert("\(id)") }
            }
        }
        selfDestructQueue.async(flags: .barrier) {
            guard !_selfDestructLoaded else { return }
            _selfDestructLoaded = true
            let saved = (UserDefaults.standard.array(forKey: selfDestructUdKey) as? [Int32]) ?? []
            _selfDestructingMessageIds.formUnion(saved)
            _selfDestructChannelKeys.formUnion((UserDefaults.standard.array(forKey: selfDestructChannelUdKey) as? [String]) ?? [])
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

    final class MessageRef: NSObject {
        let id: Int32
        // PeerId namespace: 0 user, 1 basic group, 2 channel; -1 when unknown.
        let peerNamespace: Int32
        let peerId: Int64
        // MessageId namespace: 0 is a server message. Messages being sent, local and
        // scheduled ones have their own small ids that collide with real ones.
        let messageNamespace: Int32
        init(id: Int32, peerNamespace: Int32, peerId: Int64, messageNamespace: Int32 = 0) {
            self.id = id
            self.peerNamespace = peerNamespace
            self.peerId = peerId
            self.messageNamespace = messageNamespace
        }

        // Known chat and a server message: only then can ids be compared at all.
        var isComparable: Bool {
            return peerNamespace >= 0 && messageNamespace == 0
        }
    }

    // ChatMessageItem instance -> message ref. Items are immutable (Telegram builds a
    // new one on every update) and the layout hook asks on every pass, so parsing the
    // item each time is pure waste.
    private static let messageRefCache = NSMapTable<AnyObject, MessageRef>(keyOptions: .weakMemory, valueOptions: .strongMemory)
    private static let messageRefCacheLock = NSLock()
    // Items that turned out to have no message id (in-app notification items…): the
    // fallbacks for those are slow, and layout would run them on every pass.
    private static let itemsWithoutRef = NSHashTable<AnyObject>.weakObjects()
    // Node class -> how many superclass hops down its `item` field lives (-1: none).
    // Chat bubble nodes keep ~100 stored properties; listing them all on every
    // layout pass just to reach ChatMessageItemView.item was most of the cost.
    private static var itemDepthByClass: [ObjectIdentifier: Int] = [:]
    private static let itemDepthLock = NSLock()

    static func itemFromNode(_ node: Any) -> Any? {
        let cls = ObjectIdentifier(type(of: node as AnyObject))
        itemDepthLock.lock()
        let known = itemDepthByClass[cls]
        itemDepthLock.unlock()
        if let depth = known {
            guard depth >= 0 else { return nil }
            var mirror: Mirror? = Mirror(reflecting: node)
            for _ in 0..<depth { mirror = mirror?.superclassMirror }
            guard let child = mirror?.children.first(where: { $0.label == "item" }) else { return nil }
            let value = unwrapOptional(child.value)
            return Mirror(reflecting: value).displayStyle == .optional ? nil : value
        }
        var depth = 0
        var found: Any?
        var currentMirror: Mirror? = Mirror(reflecting: node)
        while let mirror = currentMirror {
            if let child = mirror.children.first(where: { $0.label == "item" }) {
                found = unwrapOptional(child.value)
                break
            }
            depth += 1
            currentMirror = mirror.superclassMirror
        }
        itemDepthLock.lock()
        itemDepthByClass[cls] = found == nil ? -1 : depth
        itemDepthLock.unlock()
        if let value = found, Mirror(reflecting: value).displayStyle == .optional { return nil }
        return found
    }
    // ChatMessageItemImpl.description: "(ChatMessageItem id: <ns>:<peer>:<msgNs>_<id>, text: …)".
    // On device PeerId.Id prints as "id(rawValue: 123)" instead of "123"; accept both.
    private static let itemIdRegex = try? NSRegularExpression(pattern: "ChatMessageItem id: (?:\\w+\\(rawValue: )?(\\d+)\\)?:(?:\\w+\\(rawValue: )?(-?\\d+)\\)?:(-?\\d+)_(-?\\d+)", options: [])

    private static func messageRef(fromItem item: Any) -> MessageRef? {
        let description = String(describing: item)
        if let regex = itemIdRegex,
           let match = regex.firstMatch(in: description, options: [], range: NSRange(description.startIndex..<description.endIndex, in: description)),
           let nsRange = Range(match.range(at: 1), in: description),
           let peerRange = Range(match.range(at: 2), in: description),
           let msgNsRange = Range(match.range(at: 3), in: description),
           let idRange = Range(match.range(at: 4), in: description),
           let namespace = Int32(description[nsRange]),
           let peerId = Int64(description[peerRange]),
           let messageNamespace = Int32(description[msgNsRange]),
           let id = Int32(description[idRange]) {
            return MessageRef(id: id, peerNamespace: namespace, peerId: peerId, messageNamespace: messageNamespace)
        }
        // On device the description doesn't always parse; read Message.id directly.
        if let ref = messageRefFromMirror(item) {
            return ref
        }
        if let id = getMessageId(from: item) {
            return MessageRef(id: id.int32Value, peerNamespace: -1, peerId: 0, messageNamespace: -1)
        }
        return nil
    }

    // ChatMessageItemImpl.content: .message(message: Message, …) or
    // .group(messages: [(Message, …)]). Straight down that path only: the item also
    // holds the theme, every localized string and the account context, and walking
    // those for each laid-out message stalled opening a chat for seconds.
    static func messageFromItem(_ item: Any) -> Any? {
        guard let content = diagChild(item, "content"),
              let payload = Mirror(reflecting: content).children.first?.value else { return nil }
        func isMessage(_ value: Any) -> Bool {
            return String(describing: type(of: value)) == "Message"
        }
        if let message = diagChild(payload, "message"), isMessage(message) { return message }
        let messages = diagChild(payload, "messages") ?? payload
        if let first = Mirror(reflecting: messages).children.first?.value {
            if isMessage(first) { return first }
            if let inTuple = Mirror(reflecting: first).children.first?.value, isMessage(inTuple) { return inTuple }
        }
        return nil
    }

    // Postbox.Message.id: MessageId { peerId: PeerId { namespace.rawValue, id.rawValue }, namespace, id }
    private static func messageRefFromMirror(_ item: Any) -> MessageRef? {
        guard let message = messageFromItem(item), let messageId = diagChild(message, "id"),
              let peerId = diagChild(messageId, "peerId"),
              let peerNamespaceValue = diagChild(peerId, "namespace").flatMap({ diagChild($0, "rawValue") }),
              let peerIdValue = diagChild(peerId, "id").flatMap({ diagChild($0, "rawValue") }),
              let messageNamespace = diagChild(messageId, "namespace") as? Int32,
              let id = diagChild(messageId, "id") as? Int32 else {
            return nil
        }
        let peerNamespace: Int32
        switch peerNamespaceValue {
        case let value as UInt32: peerNamespace = Int32(bitPattern: value)
        case let value as Int32: peerNamespace = value
        default: return nil
        }
        guard let peerIdRaw = peerIdValue as? Int64 else { return nil }
        return MessageRef(id: id, peerNamespace: peerNamespace, peerId: peerIdRaw, messageNamespace: messageNamespace)
    }

    static func getMessageRefFromNode(_ node: Any) -> MessageRef? {
        guard let item = itemFromNode(node) else { return nil }
        let isObject = Mirror(reflecting: item).displayStyle == .class
        if isObject {
            messageRefCacheLock.lock()
            let cached = messageRefCache.object(forKey: item as AnyObject)
            let hasNoRef = itemsWithoutRef.contains(item as AnyObject)
            messageRefCacheLock.unlock()
            if let cached = cached { return cached }
            if hasNoRef { return nil }
        }
        guard let ref = messageRef(fromItem: item) else {
            compatCount("refMissing")
            if isObject {
                messageRefCacheLock.lock()
                itemsWithoutRef.add(item as AnyObject)
                messageRefCacheLock.unlock()
            }
            return nil
        }
        compatCount(ref.peerNamespace >= 0 ? "refOk" : "refNoChat")
        if isObject {
            messageRefCacheLock.lock()
            messageRefCache.setObject(ref, forKey: item as AnyObject)
            messageRefCacheLock.unlock()
        }
        return ref
    }

    /// Dynamically extracts message ID from a ChatMessageBubbleItemNode
    @objc static func getMessageIdFromNode(_ node: Any) -> NSNumber? {
        return getMessageRefFromNode(node).map { NSNumber(value: $0.id) }
    }

    @objc static func getMessageTextFromNode(_ node: Any) -> NSString? {
        guard let item = itemFromNode(node), let text = extractMessageText(fromObject: item, depth: 0) else { return nil }
        return NSString(string: text)
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

    @objc static func getPeerIdFromNode(_ node: Any) -> NSNumber? {
        // Try to sniff sharedContext from any node that might have it
        if sharedContext == nil, let obj = node as? NSObject {
            if obj.responds(to: NSSelectorFromString("context")), let ctx = obj.value(forKey: "context") {
                sharedContext = ctx
            }
        }

        // Try KVC first
        if let obj = node as? NSObject {
            for key in ["peer", "peerId", "_peer", "_peerId", "id"] {
                if obj.responds(to: NSSelectorFromString(key)), let val = obj.value(forKey: key) {
                    if let pid = extractId(fromPeer: val) { return pid }
                    if let pid = extractId(fromPeerId: val) { return pid }
                }
            }
        }

        // Try Mirror
        var currentMirror: Mirror? = Mirror(reflecting: node)
        while let mirror = currentMirror {
            for child in mirror.children {
                let label = child.label ?? ""
                if ["peer", "_peer", "peerId", "_peerId", "id"].contains(label) {
                    if let pid = extractId(fromPeer: child.value) { return pid }
                    if let pid = extractId(fromPeerId: child.value) { return pid }
                } else if label == "state" {
                    let stateMirror = Mirror(reflecting: child.value)
                    for stateChild in stateMirror.children {
                        if stateChild.label == "peer" || stateChild.label == "peerId" {
                            if let pid = extractId(fromPeer: stateChild.value) { return pid }
                        }
                    }
                }
            }
            currentMirror = mirror.superclassMirror
        }
        
        // NUCLEAR FALLBACK: Regex on full object description
        let fullDesc = String(describing: node)
        if let pid = extractId(fromPeer: fullDesc) { return pid }
        
        return nil
    }

    @objc static func getPeerNamespaceFromNode(_ node: Any) -> NSNumber? {
        if let obj = node as? NSObject {
            for key in ["peer", "peerId", "_peer", "_peerId", "id"] {
                if obj.responds(to: NSSelectorFromString(key)), let val = obj.value(forKey: key) {
                    if let namespace = extractNamespace(fromPeer: val) { return namespace }
                    if let namespace = extractNamespace(fromPeerId: val) { return namespace }
                }
            }
        }

        var currentMirror: Mirror? = Mirror(reflecting: node)
        while let mirror = currentMirror {
            for child in mirror.children {
                let label = child.label ?? ""
                if ["peer", "_peer", "peerId", "_peerId", "id"].contains(label) {
                    if let namespace = extractNamespace(fromPeer: child.value) { return namespace }
                    if let namespace = extractNamespace(fromPeerId: child.value) { return namespace }
                } else if label == "state" {
                    let stateMirror = Mirror(reflecting: child.value)
                    for stateChild in stateMirror.children {
                        if stateChild.label == "peer" || stateChild.label == "peerId" {
                            if let namespace = extractNamespace(fromPeer: stateChild.value) { return namespace }
                            if let namespace = extractNamespace(fromPeerId: stateChild.value) { return namespace }
                        }
                    }
                }
            }
            currentMirror = mirror.superclassMirror
        }
        return nil
    }

    @objc static func getPeerDisplayTitleFromNode(_ node: Any) -> NSString? {
        if let title = extractDisplayTitle(fromObject: node, depth: 0) {
            return NSString(string: title)
        }
        // Nuclear fallback: same strategy as getPeerIdFromNode.
        // String(describing:) serialises the entire controller including nested peer fields.
        let fullDesc = String(describing: node)
        let first = cleanTitle(regexStringValue(fullDesc, keys: ["firstName"]))
        let last  = cleanTitle(regexStringValue(fullDesc, keys: ["lastName"]))
        let full  = [first, last].compactMap { $0 }.joined(separator: " ")
        if !full.isEmpty { return full as NSString }
        if let username = cleanTitle(regexStringValue(fullDesc, keys: ["username", "addressName"])) {
            let result = username.hasPrefix("@") ? username : "@\(username)"
            return result as NSString
        }
        if let t = cleanTitle(regexStringValue(fullDesc, keys: ["title"])) {
            return t as NSString
        }
        return nil
    }

    @objc static func isSettingsOrMyProfileNode(_ node: Any) -> NSNumber {
        var currentMirror: Mirror? = Mirror(reflecting: node)
        while let mirror = currentMirror {
            for child in mirror.children {
                if (child.label == "isSettings" || child.label == "isMyProfile"),
                   let value = child.value as? Bool,
                   value {
                    return NSNumber(value: true)
                }
            }
            currentMirror = mirror.superclassMirror
        }
        return NSNumber(value: false)
    }

    private static func extractId(fromPeer peer: Any) -> NSNumber? {
        let desc = String(describing: peer)
        if let range = desc.range(of: "(id|userId|channelId):\\s*(-?\\d+)", options: .regularExpression) {
            let match = desc[range]
            if let idRange = match.range(of: "-?\\d+", options: .regularExpression) {
                if let idVal = Int64(match[idRange]) { return NSNumber(value: idVal) }
            }
        }

        // Try direct access if it's an AnyObject
        if let obj = peer as? NSObject {
            if obj.responds(to: NSSelectorFromString("id")), let pid = obj.value(forKey: "id") {
                return extractId(fromPeerId: pid)
            }
        }

        let peerMirror = Mirror(reflecting: peer)
        for peerChild in peerMirror.children {
            if peerChild.label == "id" {
                return extractId(fromPeerId: peerChild.value)
            }
        }
        return nil
    }

    private static func extractNamespace(fromPeer peer: Any) -> NSNumber? {
        if let obj = peer as? NSObject {
            if obj.responds(to: NSSelectorFromString("id")), let pid = obj.value(forKey: "id") {
                return extractNamespace(fromPeerId: pid)
            }
        }

        let peerMirror = Mirror(reflecting: peer)
        for peerChild in peerMirror.children {
            if peerChild.label == "id" {
                return extractNamespace(fromPeerId: peerChild.value)
            }
        }
        return extractNamespace(fromPeerId: peer)
    }

    private static func extractNamespace(fromPeerId pid: Any) -> NSNumber? {
        let desc = String(describing: pid)
        if let colon = desc.firstIndex(of: ":") {
            let namespacePart = desc[..<colon].trimmingCharacters(in: .whitespacesAndNewlines)
            if let namespace = Int32(namespacePart) {
                return NSNumber(value: namespace)
            }
        }

        let pidMirror = Mirror(reflecting: pid)
        for child in pidMirror.children {
            if child.label == "namespace" {
                let namespaceDesc = String(describing: child.value)
                if let namespace = Int32(namespaceDesc) {
                    return NSNumber(value: namespace)
                }
                let namespaceMirror = Mirror(reflecting: child.value)
                for rawChild in namespaceMirror.children where rawChild.label == "rawValue" {
                    if let raw = rawChild.value as? UInt32 { return NSNumber(value: raw) }
                    if let raw = rawChild.value as? Int32 { return NSNumber(value: raw) }
                }
            }
        }
        return nil
    }

    private static func extractDisplayTitle(fromPeer peer: Any) -> String? {
        let unwrapped = unwrapOptional(peer)
        let values = mirrorStringValues(unwrapped)

        if let title = cleanTitle(values["title"]) {
            return title
        }

        let firstName = cleanTitle(values["firstName"])
        let lastName = cleanTitle(values["lastName"])
        let fullName = [firstName, lastName].compactMap { $0 }.joined(separator: " ")
        if !fullName.isEmpty {
            return fullName
        }

        if let username = cleanTitle(values["username"] ?? values["addressName"]) {
            return username.hasPrefix("@") ? username : "@\(username)"
        }

        let desc = String(describing: unwrapped)
        if let title = cleanTitle(regexStringValue(desc, keys: ["title"])) {
            return title
        }
        let descFirstName = cleanTitle(regexStringValue(desc, keys: ["firstName"]))
        let descLastName = cleanTitle(regexStringValue(desc, keys: ["lastName"]))
        let descFullName = [descFirstName, descLastName].compactMap { $0 }.joined(separator: " ")
        if !descFullName.isEmpty {
            return descFullName
        }
        if let username = cleanTitle(regexStringValue(desc, keys: ["username", "addressName"])) {
            return username.hasPrefix("@") ? username : "@\(username)"
        }
        return nil
    }

    private static func extractDisplayTitle(fromObject object: Any, depth: Int) -> String? {
        if depth > 4 { return nil }
        let object = unwrapOptional(object)

        // Direct ivar access: bypasses the responds(to:) guard that blocks Swift-only properties.
        // Chain for PeerInfoScreenImpl: _displayNode → PeerInfoScreenNode.data → peer → name
        if let obj = object as AnyObject? {
            for ivarName in ["peer", "_peer"] {
                if let val = ivarValue(from: obj, named: ivarName), !(val is NSNull) {
                    if let title = extractDisplayTitle(fromPeer: val) { return title }
                }
            }
            for ivarName in ["data", "_data"] {
                if let val = ivarValue(from: obj, named: ivarName), !(val is NSNull) {
                    if let title = extractDisplayTitle(fromScreenData: val) { return title }
                }
            }
            for ivarName in ["_displayNode", "displayNode", "_node", "controllerNode"] {
                if let val = ivarValue(from: obj, named: ivarName), !(val is NSNull) {
                    if let title = extractDisplayTitle(fromObject: val, depth: depth + 1) { return title }
                }
            }
        }

        if let obj = object as? NSObject {
            for key in ["peer", "_peer", "data", "_data", "displayNode", "_displayNode", "controllerNode", "_controllerNode"] {
                if obj.responds(to: NSSelectorFromString(key)), let val = obj.value(forKey: key) {
                    if key == "peer" || key == "_peer" {
                        if let title = extractDisplayTitle(fromPeer: val) { return title }
                    } else if key == "data" || key == "_data" {
                        if let title = extractDisplayTitle(fromScreenData: val) { return title }
                    } else if let title = extractDisplayTitle(fromObject: val, depth: depth + 1) {
                        return title
                    }
                }
            }
        }

        var currentMirror: Mirror? = Mirror(reflecting: object)
        while let mirror = currentMirror {
            for child in mirror.children {
                let label = child.label ?? ""
                if label == "peer" || label == "_peer" {
                    if let title = extractDisplayTitle(fromPeer: child.value) { return title }
                } else if label == "data" || label == "_data" {
                    if let title = extractDisplayTitle(fromScreenData: child.value) { return title }
                } else if label == "displayNode" || label == "_displayNode" || label == "controllerNode" || label == "_controllerNode" || label == "node" {
                    if let title = extractDisplayTitle(fromObject: child.value, depth: depth + 1) { return title }
                } else if label == "state" {
                    let stateMirror = Mirror(reflecting: child.value)
                    for stateChild in stateMirror.children where stateChild.label == "peer" {
                        if let title = extractDisplayTitle(fromPeer: stateChild.value) { return title }
                    }
                }
            }
            currentMirror = mirror.superclassMirror
        }
        return nil
    }

    private static func extractDisplayTitle(fromScreenData data: Any) -> String? {
        let unwrapped = unwrapOptional(data)
        // Direct ivar access first (more reliable than Mirror for ObjC-backed classes)
        if let obj = unwrapped as AnyObject? {
            for ivarName in ["peer", "chatPeer", "savedMessagesPeer"] {
                if let val = ivarValue(from: obj, named: ivarName), !(val is NSNull) {
                    if let title = extractDisplayTitle(fromPeer: val) { return title }
                }
            }
        }
        let mirror = Mirror(reflecting: unwrapped)
        for child in mirror.children {
            if child.label == "peer" || child.label == "savedMessagesPeer" || child.label == "chatPeer" {
                if let title = extractDisplayTitle(fromPeer: child.value) {
                    return title
                }
            }
        }
        return nil
    }

    // Walks a parsed TL object (enums wrapping Cons_* classes, arrays, optionals) and
    // collects the users, chats and messages inside it. The Cons_* payloads are
    // classes, so patching what this returns patches `object` itself.
    private static func collectNested(_ object: Any, depth: Int, users: inout [Api.User], chats: inout [Api.Chat], messages: inout [Api.Message]) {
        if depth > 10 { return }
        if let chat = object as? Api.Chat { chats.append(chat); return }
        if let user = object as? Api.User { users.append(user); return }
        if let message = object as? Api.Message { messages.append(message); return }
        if object is String || object is Buffer || object is Int32 || object is Int64 || object is Double || object is Bool {
            return
        }
        for child in Mirror(reflecting: object).children {
            collectNested(child.value, depth: depth + 1, users: &users, chats: &chats, messages: &messages)
        }
    }

    private static func unwrapOptional(_ value: Any) -> Any {
        let mirror = Mirror(reflecting: value)
        if mirror.displayStyle == .optional, let child = mirror.children.first {
            return unwrapOptional(child.value)
        }
        return value
    }

    // Reads a stored ivar by name, traversing the class hierarchy.
    // Works even for Swift properties that don't have @objc exposure (bypasses responds(to:)).
    private static func ivarValue(from obj: AnyObject, named name: String) -> Any? {
        var cls: AnyClass? = type(of: obj)
        while let c = cls {
            if let ivar = class_getInstanceVariable(c, name) {
                return object_getIvar(obj, ivar)
            }
            cls = class_getSuperclass(c)
        }
        return nil
    }

    private static func mirrorStringValues(_ value: Any) -> [String: String] {
        var result: [String: String] = [:]
        let obj = unwrapOptional(value)
        if let nsObject = obj as? NSObject {
            for key in ["title", "firstName", "lastName", "username", "addressName"] {
                if nsObject.responds(to: NSSelectorFromString(key)), let val = nsObject.value(forKey: key) {
                    result[key] = String(describing: unwrapOptional(val))
                }
            }
        }

        let mirror = Mirror(reflecting: obj)
        for child in mirror.children {
            guard let label = child.label else { continue }
            if ["title", "firstName", "lastName", "username", "addressName"].contains(label) {
                result[label] = String(describing: unwrapOptional(child.value))
            }
        }
        return result
    }

    private static func regexStringValue(_ description: String, keys: [String]) -> String? {
        for key in keys {
            let patterns = [
                "\(key):\\s*Optional\\(\"([^\"]+)\"\\)",
                "\(key):\\s*\"([^\"]+)\"",
                "\(key):\\s*Optional\\(([^,\\)]+)\\)",
                "\(key):\\s*([^,\\)]+)"
            ]
            for pattern in patterns {
                guard let range = description.range(of: pattern, options: .regularExpression) else {
                    continue
                }
                let match = String(description[range])
                if let valueRange = match.range(of: "\"([^\"]+)\"", options: .regularExpression) {
                    return String(match[valueRange]).trimmingCharacters(in: CharacterSet(charactersIn: "\""))
                }
                if let colon = match.firstIndex(of: ":") {
                    return String(match[match.index(after: colon)...])
                        .replacingOccurrences(of: "Optional(", with: "")
                        .replacingOccurrences(of: ")", with: "")
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
        }
        return nil
    }

    private static func cleanTitle(_ value: String?) -> String? {
        guard var value = value?.trimmingCharacters(in: .whitespacesAndNewlines), !value.isEmpty else {
            return nil
        }
        if value == "nil" { return nil }
        if value.hasPrefix("Optional("), value.hasSuffix(")") {
            value = String(value.dropFirst("Optional(".count).dropLast())
        }
        if value.hasPrefix("\""), value.hasSuffix("\""), value.count >= 2 {
            value = String(value.dropFirst().dropLast())
        }
        value = value.trimmingCharacters(in: .whitespacesAndNewlines)
        let lowered = value.lowercased()
        let blocked = [
            "nil", "username", "addressname", "firstname", "lastname", "title",
            "peer", "_peer", "share qr code", "qr code", "message", "call",
            "video call", "mute", "notifications", "bio", "about", "info",
            "edit", "done", "settings", "add to contacts", "add contact",
            "contact", "invite", "more", "back"
        ]
        if value.isEmpty || blocked.contains(lowered) || lowered.hasPrefix("optional(nil") {
            return nil
        }
        return value
    }

    private static func extractMessageText(fromObject object: Any, depth: Int) -> String? {
        if depth > 6 { return nil }
        let object = unwrapOptional(object)

        if let obj = object as? NSObject {
            for key in ["text", "message", "caption"] {
                if obj.responds(to: NSSelectorFromString(key)), let val = obj.value(forKey: key) {
                    if let text = cleanMessageText(unwrapOptional(val)) {
                        return text
                    }
                    if key == "message", let text = extractMessageText(fromObject: val, depth: depth + 1) {
                        return text
                    }
                }
            }
        }

        let mirror = Mirror(reflecting: object)
        for child in mirror.children {
            guard let label = child.label else { continue }
            if label == "text" || label == "message" || label == "caption" {
                if let text = cleanMessageText(unwrapOptional(child.value)) {
                    return text
                }
                if label == "message", let text = extractMessageText(fromObject: child.value, depth: depth + 1) {
                    return text
                }
            } else if label == "content" || label == "firstMessage" || label == "item" || label == "media" {
                if let text = extractMessageText(fromObject: child.value, depth: depth + 1) {
                    return text
                }
            }
        }

        return nil
    }

    private static func cleanMessageText(_ value: Any) -> String? {
        let unwrapped = unwrapOptional(value)
        guard let text = unwrapped as? String else { return nil }
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty { return nil }
        if trimmed == "nil" || trimmed == "Optional(nil)" { return nil }
        return trimmed
    }

    private static func extractId(fromPeerId pid: Any) -> NSNumber? {
        if let idVal = pid as? Int64 { return NSNumber(value: idVal) }
        if let idVal = pid as? Int32 { return NSNumber(value: Int64(idVal)) }
        
        let desc = String(describing: pid)
        if let colon = desc.lastIndex(of: ":") {
            let idPart = desc[desc.index(after: colon)...]
                .trimmingCharacters(in: .whitespacesAndNewlines)
            if let idVal = Int64(idPart) {
                return NSNumber(value: idVal)
            }
        }
        if let range = desc.range(of: "-?\\d+", options: .regularExpression) {
            if let idVal = Int64(desc[range]) {
                return NSNumber(value: idVal)
            }
        }

        let pidMirror = Mirror(reflecting: pid)
        for pidChild in pidMirror.children {
             if pidChild.label == "id" || pidChild.label == "_value" || pidChild.label == "value" {
                 if let idVal = pidChild.value as? Int64 { return NSNumber(value: idVal) }
                 if let idVal = pidChild.value as? Int32 { return NSNumber(value: Int64(idVal)) }
             }
        }
        return nil
    }

    @objc static func getCurrentUserId() -> NSNumber? {
        if let context = sharedContext {
            let mirror = Mirror(reflecting: context)
            for child in mirror.children {
                if child.label == "account" {
                    let accMirror = Mirror(reflecting: child.value)
                    for accChild in accMirror.children {
                        if accChild.label == "peerId" {
                            return extractId(fromPeerId: accChild.value)
                        }
                    }
                }
            }
        }
        let savedId = UserDefaults.standard.integer(forKey: "LeadLastKnownUserId")
        if savedId != 0 { return NSNumber(value: Int64(savedId)) }
        return nil
    }

    /// Peer-aware check for a chat message node. No guessing: a message whose chat
    /// can't be read, or that isn't a server message yet (being sent, scheduled), is
    /// never shown as deleted — ids alone repeat across chats and namespaces.
    @objc static func isDeletedMessageNode(_ node: Any) -> Bool {
        guard let ref = getMessageRefFromNode(node), ref.isComparable else { return false }
        if ref.peerNamespace == 2 { return isDeleted(id: ref.id, channelId: ref.peerId) }
        return isDeleted(id: ref.id, channelId: nil, peerTag: (ref.peerNamespace == 0 ? "u" : "g") + "\(ref.peerId)")
    }

    // Self-destruct / auto-delete ids are stored without their chat; only trust them
    // for server messages outside channels.
    @objc static func isSelfDestructingMessageNode(_ node: Any) -> Bool {
        guard let ref = getMessageRefFromNode(node), ref.isComparable, ref.peerNamespace != 2 else { return false }
        return selfDestructingMessageIds.contains(ref.id)
    }

    // Message ids repeat from channel to channel, and between the accounts of one app;
    // keying edits by id alone put one chat's edit history (and pencil) on another
    // chat's message. Private and basic group entries from before this have no chat
    // (legacyEditKey) and still count for those chats.
    private static func editScope(namespace: Int32, peerId: Int64) -> String {
        switch namespace {
        case 0: return "u\(peerId):"
        case 1: return "g\(peerId):"
        case 2: return "c\(peerId):"
        default: return ""
        }
    }

    private static func editScope(for message: Api.Message) -> String {
        let peer: Api.Peer?
        switch message {
        case let .message(data): peer = data.peerId
        case let .messageService(data): peer = data.peerId
        case .messageEmpty: peer = nil
        }
        guard let tag = peer.flatMap(peerTag) else { return "" }
        return tag + ":"
    }

    private static func editScope(forNode node: Any) -> String {
        guard let ref = getMessageRefFromNode(node) else { return "" }
        return editScope(namespace: ref.peerNamespace, peerId: ref.peerId)
    }

    private static func legacyEditKey(_ id: Int32, scope: String) -> String? {
        return scope.isEmpty || scope.hasPrefix("c") ? nil : "msg:\(id)"
    }

    @objc static func isEdited(_ msgId: NSNumber) -> Bool {
        return isEdited(id: msgId.int32Value, scope: "")
    }

    private static func isEdited(id: Int32, scope: String) -> Bool {
        if hasEditHistory(id, scope: scope) { return true }
        let media = editedMediaKeys
        return media.contains(scope + "\(id)") || (legacyEditKey(id, scope: scope) != nil && media.contains("\(id)"))
    }

    // Identifies a message for the edit-history UI: pass it back to editHistoryForKey:.
    @objc static func editKeyForNode(_ node: Any) -> NSString? {
        guard let ref = getMessageRefFromNode(node), ref.id != 0, ref.isComparable else { return nil }
        return (editScope(namespace: ref.peerNamespace, peerId: ref.peerId) + "\(ref.id)") as NSString
    }

    // "u…" / "g…" / "c…" like the message log's peer field.
    @objc static func peerTagForNode(_ node: Any) -> NSString? {
        guard let ref = getMessageRefFromNode(node) else { return nil }
        switch ref.peerNamespace {
        case 0: return "u\(ref.peerId)" as NSString
        case 1: return "g\(ref.peerId)" as NSString
        case 2: return "c\(ref.peerId)" as NSString
        default: return nil
        }
    }

    @objc static func isEditedMessageNode(_ node: Any) -> Bool {
        guard let ref = getMessageRefFromNode(node), ref.id != 0, ref.isComparable else { return false }
        return isEdited(id: ref.id, scope: editScope(namespace: ref.peerNamespace, peerId: ref.peerId))
    }

    @objc static func editHistoryForKey(_ key: NSString) -> NSArray {
        let historyKey = "msg:\(key)"
        // "u12:34" → the pre-scope entry "34".
        let legacy = (key as String).hasPrefix("c") ? nil : (key as String).split(separator: ":").last.map { "msg:\($0)" }
        return editHistoryQueue.sync {
            let history = cachedEditHistory()
            return (history[historyKey] ?? legacy.flatMap { history[$0] } ?? []) as NSArray
        }
    }

    // ChatMessageItem instances already looked at by observeMessageTextFromNode.
    // Telegram builds a new item when a message changes, so once per item is enough.
    private static let observedItems = NSHashTable<AnyObject>.weakObjects()
    private static let observedItemsLock = NSLock()

    @objc static func observeMessageTextFromNode(_ node: Any) {
        guard UserDefaults.standard.bool(forKey: "LeadAntiEdit") else { return }
        var item: AnyObject?
        if let value = itemFromNode(node), Mirror(reflecting: value).displayStyle == .class { item = value as AnyObject }
        if let item = item {
            observedItemsLock.lock()
            let seen = observedItems.contains(item)
            if !seen { observedItems.add(item) }
            observedItemsLock.unlock()
            if seen { return }
        }
        guard getMessageRefFromNode(node)?.isComparable == true,
              let msgId = getMessageIdFromNode(node),
              let text = getMessageTextFromNode(node) as String?,
              !text.isEmpty else {
            return
        }
        let scope = editScope(forNode: node)
        // Telegram bumps a message's EditedMessageAttribute (and re-lays out the
        // node) for things that aren't real edits — adding a reaction, a view-count
        // bump, link-preview attachment finishing after send, etc. The stock client
        // hides the "edited" label in those cases via isHidden on that attribute.
        // If we can find the attribute, trust it instead of raw text diffing —
        // otherwise a reaction or a normal send can falsely mark a message edited.
        if let attributes = getMessageAttributesFromNode(node), !isVisibleEdit(attributes: attributes) {
            updateSnapshotOnly(id: msgId.int32Value, scope: scope, text: text)
            return
        }
        recordObservedText(id: msgId.int32Value, scope: scope, text: text)
    }

    private static func getMessageAttributesFromNode(_ node: Any) -> [Any]? {
        guard let item = itemFromNode(node) else { return nil }
        return extractMessageAttributes(fromObject: item, depth: 0)
    }

    private static func extractMessageAttributes(fromObject object: Any, depth: Int) -> [Any]? {
        if depth > 6 { return nil }
        let object = unwrapOptional(object)

        if let obj = object as? NSObject,
           obj.responds(to: NSSelectorFromString("attributes")),
           let val = obj.value(forKey: "attributes") as? [Any] {
            return val
        }

        let mirror = Mirror(reflecting: object)
        for child in mirror.children {
            guard let label = child.label else { continue }
            if label == "attributes", let arr = child.value as? [Any] {
                return arr
            } else if label == "message" || label == "content" || label == "firstMessage" || label == "item" || label == "media" {
                if let found = extractMessageAttributes(fromObject: child.value, depth: depth + 1) {
                    return found
                }
            }
        }
        return nil
    }

    // EditedMessageAttribute.isHidden mirrors Telegram's edit_hide TL flag —
    // server-side bumps for reactions/view counts that shouldn't show "edited".
    private static func isVisibleEdit(attributes: [Any]) -> Bool {
        for attr in attributes {
            let typeName = String(describing: type(of: attr))
            guard typeName.contains("EditedMessageAttribute") else { continue }
            let mirror = Mirror(reflecting: attr)
            for child in mirror.children where child.label == "isHidden" {
                if let hidden = child.value as? Bool {
                    return !hidden
                }
            }
            return true
        }
        return false
    }

    // In-memory mirrors of the edit-history UserDefaults entries, only touched on
    // editHistoryQueue. The message layout hook asks about every node on every
    // layout pass; re-reading and bridging these dictionaries there stalled scrolling.
    private static var _editHistoryCache: [String: [[String: Any]]]?
    private static var _textSnapshotsCache: [String: String]?

    private static func cachedEditHistory() -> [String: [[String: Any]]] {
        if let cached = _editHistoryCache { return cached }
        let loaded = UserDefaults.standard.dictionary(forKey: editHistoryUdKey) as? [String: [[String: Any]]] ?? [:]
        _editHistoryCache = loaded
        return loaded
    }

    private static func cachedTextSnapshots() -> [String: String] {
        if let cached = _textSnapshotsCache { return cached }
        let loaded = UserDefaults.standard.dictionary(forKey: textSnapshotsUdKey) as? [String: String] ?? [:]
        _textSnapshotsCache = loaded
        return loaded
    }

    // Called on editHistoryQueue. Only the in-memory cache changes here; the disk
    // write is batched (scheduleEditPersist). Writing the whole dictionary for every
    // message laid out kept editHistoryQueue busy, and the layout-time reads
    // (editHistoryQueue.sync) waited behind those writes when a chat opened.
    private static func storeTextSnapshots(_ snapshots: inout [String: String]) {
        trimStringDictionary(&snapshots, limit: 1200)
        _textSnapshotsCache = snapshots
        scheduleEditPersist()
    }

    private static var editPersistScheduled = false

    // Called on editHistoryQueue.
    private static func scheduleEditPersist() {
        _ = flushOnBackground
        guard !editPersistScheduled else { return }
        editPersistScheduled = true
        editHistoryQueue.asyncAfter(deadline: .now() + 2) {
            guard editPersistScheduled else { return }
            editPersistScheduled = false
            let snapshots = _textSnapshotsCache
            let history = _editHistoryCache
            DispatchQueue.global(qos: .utility).async {
                if let snapshots = snapshots { UserDefaults.standard.set(snapshots, forKey: textSnapshotsUdKey) }
                if let history = history { UserDefaults.standard.set(history, forKey: editHistoryUdKey) }
            }
        }
    }

    // Writes a pending batch right away when the app goes to the background, so an
    // edit seen just before the app is killed isn't lost.
    private static let flushOnBackground: NSObjectProtocol = NotificationCenter.default.addObserver(
        forName: NSNotification.Name("UIApplicationDidEnterBackgroundNotification"), object: nil, queue: nil) { _ in
        editHistoryQueue.sync {
            guard editPersistScheduled else { return }
            editPersistScheduled = false
            if let snapshots = _textSnapshotsCache { UserDefaults.standard.set(snapshots, forKey: textSnapshotsUdKey) }
            if let history = _editHistoryCache { UserDefaults.standard.set(history, forKey: editHistoryUdKey) }
        }
        deletedQueue.sync(flags: .barrier) {
            guard deletedPersistScheduled else { return }
            deletedPersistScheduled = false
            writeDeleted(ids: _deletedOrder, channelKeys: _deletedChannelOrder, peers: _deletedPeers)
        }
    }

    private static let disappearingMarker = "disappearing message "

    // The text without what Lead itself put in front of it. Telegram's copy of a message
    // has the marker while the raw edit update doesn't, which looked like a real edit.
    private static func textWithoutMarkers(_ text: String) -> String {
        var result = text
        if result.hasPrefix("🗑️ ") { result.removeFirst("🗑️ ".count) }
        if result.hasPrefix(disappearingMarker) { result.removeFirst(disappearingMarker.count) }
        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private static func updateSnapshotOnly(id: Int32, scope: String, text: String) {
        let trimmed = textWithoutMarkers(text)
        guard id != 0, !trimmed.isEmpty else { return }
        editHistoryQueue.async {
            let key = editHistoryKey(id, scope: scope)
            var snapshots = cachedTextSnapshots()
            guard snapshots[key] != trimmed else { return }
            snapshots[key] = trimmed
            storeTextSnapshots(&snapshots)
        }
    }

    @objc static func editHistoryForMessageId(_ msgId: NSNumber) -> NSArray {
        let key = editHistoryKey(msgId.int32Value, scope: "")
        return editHistoryQueue.sync {
            return (cachedEditHistory()[key] ?? []) as NSArray
        }
    }

    private static func hasEditHistory(_ id: Int32, scope: String) -> Bool {
        let key = editHistoryKey(id, scope: scope)
        let legacy = legacyEditKey(id, scope: scope)
        return editHistoryQueue.sync {
            let history = cachedEditHistory()
            return !(history[key] ?? legacy.flatMap { history[$0] } ?? []).isEmpty
        }
    }

    private static var editedIds: Set<Int32> {
        editedQueue.sync {
            return _editedIds
        }
    }

    private static var editedMediaKeys: Set<String> {
        editedQueue.sync {
            return _editedMediaKeys
        }
    }

    private static func addEditedId(_ id: Int32) {
        guard id != 0 else { return }
        editedQueue.async(flags: .barrier) {
            _editedIds.insert(id)
            var saved = (UserDefaults.standard.array(forKey: editedUdKey) as? [Int32]) ?? []
            if !saved.contains(id) {
                saved.append(id)
                if saved.count > 1000 { saved.removeFirst(saved.count - 1000) }
                UserDefaults.standard.set(saved, forKey: editedUdKey)
            }
        }
    }

    private static func addEditedMediaId(_ id: Int32, scope: String) {
        guard id != 0 else { return }
        let key = scope + "\(id)"
        editedQueue.async(flags: .barrier) {
            guard !_editedMediaKeys.contains(key) else { return }
            _editedMediaKeys.insert(key)
            var saved = Array(_editedMediaKeys)
            if saved.count > 1000 {
                saved.removeFirst(saved.count - 1000)
                _editedMediaKeys = Set(saved)
            }
            UserDefaults.standard.set(saved, forKey: editedMediaUdKey)
        }
    }

    private static func editHistoryKey(_ id: Int32, scope: String) -> String {
        return "msg:\(scope)\(id)"
    }

    private static func recordObservedText(id: Int32, scope: String, text: String) {
        let trimmed = textWithoutMarkers(text)
        guard id != 0, !trimmed.isEmpty else { return }

        editHistoryQueue.async {
            let key = editHistoryKey(id, scope: scope)
            let legacyKey = legacyEditKey(id, scope: scope)
            var snapshots = cachedTextSnapshots()

            guard let previous = snapshots[key] ?? legacyKey.flatMap({ snapshots[$0] }), !previous.isEmpty else {
                snapshots[key] = trimmed
                storeTextSnapshots(&snapshots)
                return
            }

            guard previous != trimmed else { return }

            var allHistory = cachedEditHistory()
            var versions = allHistory[key] ?? legacyKey.flatMap({ allHistory[$0] }) ?? []
            let now = Int(Date().timeIntervalSince1970)

            if versions.isEmpty {
                versions.append([
                    "label": "Original",
                    "text": previous,
                    "date": now
                ])
            } else if versions.contains(where: { ($0["text"] as? String) == trimmed }) {
                snapshots[key] = trimmed
                storeTextSnapshots(&snapshots)
                return
            }

            if let lastText = versions.last?["text"] as? String, lastText != trimmed {
                versions.append([
                    "label": versions.isEmpty ? "Edited" : "Edit \(versions.count)",
                    "text": trimmed,
                    "date": now
                ])
            }

            if versions.count > 12 {
                versions.removeFirst(versions.count - 12)
            }

            allHistory[key] = versions
            addEditedId(id)
            trimHistoryDictionary(&allHistory, limit: 1000)
            _editHistoryCache = allHistory
            scheduleEditPersist()
            snapshots[key] = trimmed
            storeTextSnapshots(&snapshots)
            DispatchQueue.main.async {
                NotificationCenter.default.post(
                    name: NSNotification.Name("LeadMessageEditedRealtime"),
                    object: nil,
                    userInfo: ["ids": [NSNumber(value: id)]]
                )
            }
        }
    }

    private static func trimStringDictionary(_ dictionary: inout [String: String], limit: Int) {
        guard dictionary.count > limit else { return }
        let overflow = dictionary.count - limit
        for key in dictionary.keys.prefix(overflow) {
            dictionary.removeValue(forKey: key)
        }
    }

    private static func trimHistoryDictionary(_ dictionary: inout [String: [[String: Any]]], limit: Int) {
        guard dictionary.count > limit else { return }
        let overflow = dictionary.count - limit
        for key in dictionary.keys.prefix(overflow) {
            dictionary.removeValue(forKey: key)
        }
    }

    // The Api Cons_* payloads are classes, so everything below patches them in place
    // and only reports whether something changed. Rebuilding a constructor field by
    // field broke the build on every layer bump (and silently dropped new fields).

    // IDs of messages that originally had a self-destruct timer (one-time media ttlSeconds).
    // Must be persisted: the TTL flag is stripped from the wire message before Postbox
    // ever sees it, so if the app process dies and relaunches (common on chat re-entry
    // after backgrounding), an in-memory-only set would lose the marker permanently —
    // the message would render exactly like a normal video forever after.
    private static let selfDestructQueue = DispatchQueue(label: "com.lead.selfDestructIds",
                                                          attributes: .concurrent)
    private static var _selfDestructingMessageIds = Set<Int32>()
    private static let selfDestructUdKey = "LeadSelfDestructMsgIds"
    private static var _selfDestructLoaded = false

    // Channel ids repeat from channel to channel and overlap private ones, so they're
    // kept per channel: one bare set labeled ordinary messages "disappearing".
    private static var _selfDestructChannelKeys = Set<String>()
    private static let selfDestructChannelUdKey = "LeadSelfDestructChannelKeys"

    private static var selfDestructingMessageIds: Set<Int32> {
        selfDestructQueue.sync { _selfDestructingMessageIds }
    }

    private static func isSelfDestructing(id: Int32, channelId: Int64?) -> Bool {
        return selfDestructQueue.sync {
            if let channelId = channelId { return _selfDestructChannelKeys.contains(channelKey(channelId, id)) }
            return _selfDestructingMessageIds.contains(id)
        }
    }

    private static func channelId(of peer: Api.Peer) -> Int64? {
        if case let .peerChannel(data) = peer { return data.channelId }
        return nil
    }

    private static func addSelfDestructId(_ id: Int32, channelId: Int64? = nil) {
        guard id != 0 else { return }
        if isExtension {
            bridgeHandoff(channelId.map { "t \(id) \($0)" } ?? "t \(id)")
            selfDestructQueue.async(flags: .barrier) {
                if let channelId = channelId {
                    _selfDestructChannelKeys.insert(channelKey(channelId, id))
                } else {
                    _selfDestructingMessageIds.insert(id)
                }
            }
            return
        }
        if let channelId = channelId {
            let key = channelKey(channelId, id)
            selfDestructQueue.async(flags: .barrier) {
                guard _selfDestructChannelKeys.insert(key).inserted else { return }
                var saved = (UserDefaults.standard.array(forKey: selfDestructChannelUdKey) as? [String]) ?? []
                saved.append(key)
                if saved.count > 1000 { saved.removeFirst(saved.count - 1000) }
                UserDefaults.standard.set(saved, forKey: selfDestructChannelUdKey)
            }
            return
        }
        selfDestructQueue.async(flags: .barrier) {
            _selfDestructingMessageIds.insert(id)
            var saved = (UserDefaults.standard.array(forKey: selfDestructUdKey) as? [Int32]) ?? []
            if !saved.contains(id) {
                saved.append(id)
                if saved.count > 1000 { saved.removeFirst(saved.count - 1000) }
                UserDefaults.standard.set(saved, forKey: selfDestructUdKey)
            }
        }
    }

    @objc static func isMessageSelfDestructing(_ msgId: NSNumber) -> Bool {
        return selfDestructingMessageIds.contains(msgId.int32Value)
    }

    @objc(isMessageSelfDestructing:channelId:)
    static func isMessageSelfDestructing(_ msgId: NSNumber, channelId: Int64) -> Bool {
        return isSelfDestructing(id: msgId.int32Value, channelId: channelId)
    }

    // IDs of messages in chats with auto-delete (ttlPeriod)
    private static var autoDeleteMessageIds = Set<Int32>()

    @objc static func isMessageAutoDelete(_ msgId: NSNumber) -> Bool {
        return autoDeleteMessageIds.contains(msgId.int32Value)
    }

    private static func mediaHasTTL(_ media: Api.MessageMedia) -> Bool {
        switch media {
        case let .messageMediaPhoto(data):
            return data.ttlSeconds != nil || (Int(data.flags) & Int(1 << 2)) != 0
        case let .messageMediaDocument(data):
            return data.ttlSeconds != nil || (Int(data.flags) & Int(1 << 2)) != 0
        default:
            return false
        }
    }

    // Strips view-once / timed media in place. Only touches media that actually has a
    // timer — stripping every photo/document used to remove spoilers from all media.
    @discardableResult
    private static func stripTTLMedia(_ media: Api.MessageMedia, messageId: Int32, channelId: Int64? = nil) -> Bool {
        guard UserDefaults.standard.bool(forKey: "LeadAntiSelfDestruct"), mediaHasTTL(media) else { return false }
        addSelfDestructId(messageId, channelId: channelId)
        compatCount("ttl")
        switch media {
        case let .messageMediaPhoto(data):
            // ttl_seconds:flags.2, spoiler:flags.3
            data.ttlSeconds = nil
            data.flags &= ~Int32((1 << 2) | (1 << 3))
        case let .messageMediaDocument(data):
            // ttl_seconds:flags.2, spoiler:flags.4
            data.ttlSeconds = nil
            data.flags &= ~Int32((1 << 2) | (1 << 4))
        default:
            return false
        }
        return true
    }

    private static func stripNoForwards(_ chat: Api.Chat) -> Bool {
        guard UserDefaults.standard.bool(forKey: "disableForwardRestriction") ||
              UserDefaults.standard.bool(forKey: "LeadAntiSelfDestruct") else { return false }

        // Only the noforwards bit itself may be cleared: the neighbouring bits are
        // broadcast/admin_rights/etc., and clearing them turned channels into
        // groups and dropped admin rights.
        switch chat {
        case let .channel(data):
            // noforwards:flags.27
            guard data.flags & Int32(1 << 27) != 0 else { return false }
            data.flags &= ~Int32(1 << 27)
            diagCount("leadDiagChan")
            return true
        case let .chat(data):
            // noforwards:flags.25
            guard data.flags & Int32(1 << 25) != 0 else { return false }
            data.flags &= ~Int32(1 << 25)
            diagCount("leadDiagChat")
            return true
        default:
            return false
        }
    }

    private static func stripNoForwardsFromChats(_ chats: [Api.Chat]) -> Bool {
        var modified = false
        for chat in chats where stripNoForwards(chat) {
            modified = true
        }
        return modified
    }

    private static var isHideStories: Bool {
        return UserDefaults.standard.bool(forKey: "LeadHideStories")
    }

    // stories_max_id draws the story ring around avatars: user flags2.5, channel flags2.4.
    private static func hideStoryRings(users: [Api.User], chats: [Api.Chat]) -> Bool {
        guard isHideStories else { return false }
        var changed = false
        for user in users {
            if case let .user(data) = user, data.storiesMaxId != nil {
                data.storiesMaxId = nil
                data.flags2 &= ~Int32(1 << 5)
                changed = true
            }
        }
        for chat in chats {
            if case let .channel(data) = chat, data.storiesMaxId != nil {
                data.storiesMaxId = nil
                data.flags2 &= ~Int32(1 << 4)
                changed = true
            }
        }
        return changed
    }

    // Everything that rides along with users/chats vectors in a response.
    private static func processPeers(users: [Api.User], chats: [Api.Chat]) -> Bool {
        observePeers(users: users, chats: chats)
        let chatsChanged = stripNoForwardsFromChats(chats)
        let ringsChanged = hideStoryRings(users: users, chats: chats)
        return chatsChanged || ringsChanged
    }

    // storyItem noforwards:flags.10 — with it cleared Telegram offers forwarding and,
    // for Premium accounts, "Save to Gallery" on protected stories.
    private static func unlockStories(_ stories: [Api.StoryItem]) -> Bool {
        guard UserDefaults.standard.bool(forKey: "LeadDownloadStories") else { return false }
        var changed = false
        for story in stories {
            if case let .storyItem(data) = story, data.flags & Int32(1 << 10) != 0 {
                data.flags &= ~Int32(1 << 10)
                changed = true
            }
        }
        return changed
    }

    private static func unlockPeerStories(_ peerStories: Api.PeerStories) -> Bool {
        switch peerStories {
        case let .peerStories(data):
            return unlockStories(data.stories)
        }
    }

    // Drops live story pushes when stories are hidden; they carry no pts, so the
    // update sequence is unaffected.
    private static func filterStoryUpdates(_ updates: inout [Api.Update]) -> Bool {
        guard isHideStories else { return false }
        let count = updates.count
        updates.removeAll { update in
            if case .updateStory = update { return true }
            return false
        }
        return updates.count != count
    }

    // channelFull/chatFull carry no noforwards flag — only the auto-delete timer.
    // The optional field and its flag bit must be cleared together, otherwise the
    // serializer force-unwraps the nil field and crashes.
    private static func stripAutoDeleteFromFullChat(_ chatFull: Api.ChatFull) -> Bool {
        guard UserDefaults.standard.bool(forKey: "LeadAntiAutoDelete") else { return false }
        switch chatFull {
        case let .channelFull(data):
            // ttl_period:flags.24
            guard data.ttlPeriod != nil else { return false }
            data.ttlPeriod = nil
            data.flags &= ~Int32(1 << 24)
            return true
        case let .chatFull(data):
            // ttl_period:flags.14
            guard data.ttlPeriod != nil else { return false }
            data.ttlPeriod = nil
            data.flags &= ~Int32(1 << 14)
            return true
        case .communityFull:
            return false
        }
    }

    // Private chats carry their copy protection on userFull since layer 232.
    private static func stripProtectionFromUserFull(_ userFull: Api.UserFull) -> Bool {
        let defaults = UserDefaults.standard
        let noForwardsBypass = defaults.bool(forKey: "disableForwardRestriction") || defaults.bool(forKey: "LeadAntiSelfDestruct")
        let antiAutoDelete = defaults.bool(forKey: "LeadAntiAutoDelete")
        guard noForwardsBypass || antiAutoDelete else { return false }
        guard case let .userFull(data) = userFull else { return false }
        var changed = false
        // noforwards_my_enabled:flags2.23, noforwards_peer_enabled:flags2.24 — Telegram
        // locks the chat when either side turned protection on.
        let noForwardsMask = Int32((1 << 23) | (1 << 24))
        if noForwardsBypass && data.flags2 & noForwardsMask != 0 {
            data.flags2 &= ~noForwardsMask
            diagCount("leadDiagUserFull")
            changed = true
        }
        // ttl_period:flags.14
        if antiAutoDelete && data.ttlPeriod != nil {
            data.ttlPeriod = nil
            data.flags &= ~Int32(1 << 14)
            changed = true
        }
        return changed
    }

    private static func shiftEntities(_ entities: [Api.MessageEntity], by offset: Int32) {
        for entity in entities {
            switch entity {
            case let .messageEntityUnknown(d): d.offset += offset
            case let .messageEntityMention(d): d.offset += offset
            case let .messageEntityHashtag(d): d.offset += offset
            case let .messageEntityBotCommand(d): d.offset += offset
            case let .messageEntityUrl(d): d.offset += offset
            case let .messageEntityEmail(d): d.offset += offset
            case let .messageEntityBold(d): d.offset += offset
            case let .messageEntityItalic(d): d.offset += offset
            case let .messageEntityCode(d): d.offset += offset
            case let .messageEntityPre(d): d.offset += offset
            case let .messageEntityTextUrl(d): d.offset += offset
            case let .messageEntityMentionName(d): d.offset += offset
            case let .inputMessageEntityMentionName(d): d.offset += offset
            case let .messageEntityPhone(d): d.offset += offset
            case let .messageEntityCashtag(d): d.offset += offset
            case let .messageEntityUnderline(d): d.offset += offset
            case let .messageEntityStrike(d): d.offset += offset
            case let .messageEntityBlockquote(d): d.offset += offset
            case let .messageEntityBankCard(d): d.offset += offset
            case let .messageEntitySpoiler(d): d.offset += offset
            case let .messageEntityCustomEmoji(d): d.offset += offset
            case let .messageEntityFormattedDate(d): d.offset += offset
            case let .messageEntityDiffInsert(d): d.offset += offset
            case let .messageEntityDiffReplace(d): d.offset += offset
            case let .messageEntityDiffDelete(d): d.offset += offset
            case let .messageEntityTonAddress(d): d.offset += offset
            }
        }
    }

    private static func applyTTLIndicator(message: String, entities: [Api.MessageEntity]?, shouldApply: Bool) -> (String, [Api.MessageEntity]?) {
        guard shouldApply, !UserDefaults.standard.bool(forKey: "LeadHideTTLLabel") else {
            return (message, entities)
        }
        var newMessageText = message
        var newEntities = entities ?? []
        let marker = disappearingMarker
        if !newMessageText.contains("disappearing message") && !newMessageText.hasPrefix("🗑️") {
            shiftEntities(newEntities, by: Int32(marker.utf16.count))
            let markerTextLen = Int32(marker.utf16.count - 1)
            newEntities.insert(.messageEntityItalic(Api.MessageEntity.Cons_messageEntityItalic(offset: 0, length: markerTextLen)), at: 0)
            newEntities.insert(.messageEntitySpoiler(Api.MessageEntity.Cons_messageEntitySpoiler(offset: 0, length: markerTextLen)), at: 0)
            newMessageText = marker + newMessageText
        }
        return (newMessageText, newEntities)
    }

    // Shared by message / updateShortMessage / updateShortChatMessage: whether the
    // message's auto-delete timer (ttl_period) should be dropped.
    private static func shouldStripAutoDelete(ttlPeriod: Int32?, flags: Int32) -> Bool {
        let defaults = UserDefaults.standard
        guard defaults.bool(forKey: "LeadAntiAutoDelete") || defaults.bool(forKey: "LeadAntiSelfDestruct") else { return false }
        // ttl_period:flags.25
        return ttlPeriod != nil || flags & Int32(1 << 25) != 0
    }

    private static func stripTTLMessage(_ apiMsg: Api.Message) -> Bool {
        let defaults = UserDefaults.standard
        let antiSelfDestruct = defaults.bool(forKey: "LeadAntiSelfDestruct")
        let noForwardsBypass = defaults.bool(forKey: "disableForwardRestriction") || antiSelfDestruct
        guard case let .message(data) = apiMsg else {
            return false
        }
        var changed = false

        let channelId = channelId(of: data.peerId)
        let stripAutoDelete = shouldStripAutoDelete(ttlPeriod: data.ttlPeriod, flags: data.flags)
        if stripAutoDelete {
            addSelfDestructId(data.id, channelId: channelId)
        }

        // Check media TTL synchronously before stripping — addSelfDestructId is async so
        // selfDestructingMessageIds.contains() would always return false at this point.
        let hasMediaTTL = antiSelfDestruct && data.media.map { mediaHasTTL($0) } == true
        if let media = data.media, stripTTLMedia(media, messageId: data.id, channelId: channelId) {
            changed = true
        }

        let isMediaDestructing = hasMediaTTL || (antiSelfDestruct && isSelfDestructing(id: data.id, channelId: channelId))
        if stripAutoDelete || isMediaDestructing {
            let (newMessageText, newEntities) = applyTTLIndicator(message: data.message, entities: data.entities, shouldApply: true)
            if newMessageText != data.message {
                data.message = newMessageText
                data.entities = newEntities
                changed = true
            }
            // ttl_period:flags.25, media_unread:flags.5
            if data.ttlPeriod != nil || data.flags & Int32((1 << 25) | (1 << 5)) != 0 {
                data.ttlPeriod = nil
                data.flags &= ~Int32((1 << 25) | (1 << 5))
                changed = true
            }
        }

        // noforwards:flags.26
        if noForwardsBypass && data.flags & Int32(1 << 26) != 0 {
            data.flags &= ~Int32(1 << 26)
            diagCount("leadDiagMsg")
            changed = true
        }

        // entities:flags.7
        if let entities = data.entities, !entities.isEmpty {
            data.flags |= Int32(1 << 7)
        }

        return changed
    }

    private static func stripTTLMessages(_ messages: [Api.Message]) -> Bool {
        observeMessages(messages)
        var modified = false
        for message in messages where stripTTLMessage(message) {
            modified = true
        }
        return modified
    }

    private static func stripTTLUpdates(_ updates: [Api.Update]) -> Bool {
        var modified = false
        for update in updates where stripTTLUpdate(update) {
            modified = true
        }
        return modified
    }

    private static func stripTTLUpdate(_ update: Api.Update) -> Bool {
        switch update {
        // Edits carry the full message again, noforwards bit included; without
        // stripping them an edit in a protected chat re-locks that message.
        case let .updateEditMessage(data):
            if UserDefaults.standard.bool(forKey: "LeadAntiEdit") {
                recordEditedMessage(data.message)
            }
            return stripTTLMessage(data.message)
        case let .updateEditChannelMessage(data):
            if UserDefaults.standard.bool(forKey: "LeadAntiEdit") {
                recordEditedMessage(data.message)
            }
            return stripTTLMessage(data.message)
        case let .updateNewMessage(data):
            observeMessages([data.message])
            return stripTTLMessage(data.message)
        case let .updateNewChannelMessage(data):
            observeMessages([data.message])
            return stripTTLMessage(data.message)
        case let .updateStory(data):
            let kept = keepDeletedStory(data)
            let unlocked = unlockStories([data.story])
            return kept || unlocked
        default:
            return false
        }
    }

    private static func recordEditedMessage(_ message: Api.Message) {
        logEdited(message)
        guard let originalId = id(from: message), originalId != 0 else {
            return
        }
        let scope = editScope(for: message)
        if let text = text(from: message), !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            recordObservedText(id: originalId, scope: scope, text: text)
            return
        }
        guard isMediaEdit(message) else {
            return
        }
        addEditedMediaId(originalId, scope: scope)
        DispatchQueue.main.async {
            NotificationCenter.default.post(
                name: NSNotification.Name("LeadMessageEditedRealtime"),
                object: nil,
                userInfo: ["ids": [NSNumber(value: originalId)]]
            )
        }
    }

    private static func id(from message: Api.Message) -> Int32? {
        switch message {
        case let .message(data):
            return data.id
        case let .messageEmpty(data):
            return data.id
        case let .messageService(data):
            return data.id
        }
    }

    private static func text(from message: Api.Message) -> String? {
        switch message {
        case let .message(data):
            return data.message
        default:
            return nil
        }
    }

    private static func isMediaEdit(_ message: Api.Message) -> Bool {
        switch message {
        case let .message(data):
            return data.editDate != nil && data.media != nil
        default:
            return false
        }
    }

    private static func visualStarsAmount() -> Int64? {
        guard UserDefaults.standard.bool(forKey: "LeadVisualStarsEnabled") else {
            return nil
        }
        let amount = UserDefaults.standard.object(forKey: "LeadVisualStarsAmount") as? NSNumber
        let value = amount?.int64Value ?? Int64(UserDefaults.standard.integer(forKey: "LeadVisualStarsAmount"))
        return value > 0 ? value : nil
    }

    private static func patchVisualStarsAmount(_ amount: Api.StarsAmount) -> Bool {
        guard let fakeAmount = visualStarsAmount() else {
            return false
        }
        switch amount {
        case let .starsAmount(data):
            if data.amount == fakeAmount && data.nanos == 0 {
                return false
            }
            data.amount = fakeAmount
            data.nanos = 0
            return true
        case .starsTonAmount:
            return false
        }
    }

    private static func patchVisualStarsStatus(_ status: Api.payments.StarsStatus) -> Bool {
        switch status {
        case let .starsStatus(data):
            return patchVisualStarsAmount(data.balance)
        }
    }

    private static func patchVisualStarsUpdate(_ update: Api.Update) -> Bool {
        switch update {
        case let .updateStarsBalance(data):
            return patchVisualStarsAmount(data.balance)
        default:
            return false
        }
    }

    private static func patchVisualStarsUpdates(_ updates: [Api.Update]) -> Bool {
        var changed = false
        for update in updates where patchVisualStarsUpdate(update) {
            changed = true
        }
        return changed
    }

    // updateShortMessage / updateShortChatMessage share the same flag layout:
    // media_unread:flags.5, entities:flags.7, ttl_period:flags.25 (no noforwards bit).
    private static func stripShortMessage(id: Int32, flags: inout Int32, message: inout String, entities: inout [Api.MessageEntity]?, ttlPeriod: inout Int32?) -> Bool {
        guard shouldStripAutoDelete(ttlPeriod: ttlPeriod, flags: flags) else { return false }
        addSelfDestructId(id)
        let (newMessageText, newEntities) = applyTTLIndicator(message: message, entities: entities, shouldApply: true)
        message = newMessageText
        entities = newEntities
        if let entities = entities, !entities.isEmpty {
            flags |= Int32(1 << 7)
        }
        ttlPeriod = nil
        flags &= ~Int32((1 << 25) | (1 << 5))
        return true
    }

    // Whether any enabled feature needs responses/updates parsed. Hooks.xm asks this
    // before unpacking live updates, so both paths stay in step.
    @objc static var wantsPatching: Bool {
        let defaults = UserDefaults.standard
        let isStories = defaults.bool(forKey: "LeadDownloadStories") || isHideStories
        // Anti-Revoke needs the parse too: it feeds the deleted-messages log.
        return defaults.bool(forKey: "LeadAntiSelfDestruct") ||
            defaults.bool(forKey: "LeadAntiAutoDelete") ||
            defaults.bool(forKey: "disableForwardRestriction") ||
            defaults.bool(forKey: "LeadAntiEdit") ||
            defaults.bool(forKey: "LeadAntiRevoke") ||
            defaults.bool(forKey: "LeadHideProxyPromo") || defaults.bool(forKey: "disableAllAds") ||
            visualStarsAmount() != nil || isStories || isSavingDeletedStories
    }

    @objc static func stripAntiSelfDestruct(_ data: NSData) -> NSData? {
        // The proxy's sponsored channel is an ad too: "Disable all ads" hides it as well.
        let isHidePromo = UserDefaults.standard.bool(forKey: "LeadHideProxyPromo") || UserDefaults.standard.bool(forKey: "disableAllAds")
        guard wantsPatching else { return nil }
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
        guard let result = Api.parse(reader, signature: signature) else {
            diagParseFailed(signature: signature, length: data.length)
            // A type Lead knows that still didn't parse: something inside it is from
            // another layer, and everything that patches it is off for this client.
            if Api.knowsSignature(signature) { compatCount("parseFailed", signature: signature) }
            return nil
        }
        compatCount("parsed")
        
        var modified = false

        if let updates = result as? Api.Updates {
            switch updates {
            case let .updates(data):
                let filtered = filterStoryUpdates(&data.updates)
                let stripped = stripTTLUpdates(data.updates)
                let starsPatched = patchVisualStarsUpdates(data.updates)
                let peersChanged = processPeers(users: data.users, chats: data.chats)
                modified = filtered || stripped || starsPatched || peersChanged
            case let .updateShort(data):
                let stripped = stripTTLUpdate(data.update)
                let starsPatched = patchVisualStarsUpdate(data.update)
                modified = stripped || starsPatched
            case let .updateShortMessage(data):
                observeShortMessage(tag: "u\(data.userId)", id: data.id, text: data.message)
                modified = stripShortMessage(id: data.id, flags: &data.flags, message: &data.message, entities: &data.entities, ttlPeriod: &data.ttlPeriod)
            case let .updateShortChatMessage(data):
                observeShortMessage(tag: "g\(data.chatId)", id: data.id, text: data.message)
                modified = stripShortMessage(id: data.id, flags: &data.flags, message: &data.message, entities: &data.entities, ttlPeriod: &data.ttlPeriod)
            case let .updateShortSentMessage(data):
                // media:flags.9, ttl_period:flags.25, media_unread:flags.5
                if let media = data.media, stripTTLMedia(media, messageId: data.id) {
                    modified = true
                }
                if shouldStripAutoDelete(ttlPeriod: data.ttlPeriod, flags: data.flags) {
                    addSelfDestructId(data.id)
                    data.ttlPeriod = nil
                    data.flags &= ~Int32((1 << 25) | (1 << 5))
                    modified = true
                }
            case let .updatesCombined(data):
                let filtered = filterStoryUpdates(&data.updates)
                let stripped = stripTTLUpdates(data.updates)
                let starsPatched = patchVisualStarsUpdates(data.updates)
                let peersChanged = processPeers(users: data.users, chats: data.chats)
                modified = filtered || stripped || starsPatched || peersChanged
            default:
                break
            }
        } else if let msgs = result as? Api.messages.Messages {
            var messages: [Api.Message] = []
            var chats: [Api.Chat] = []
            var users: [Api.User] = []
            switch msgs {
            case let .messages(data):
                messages = data.messages
                chats = data.chats
                users = data.users
            case let .messagesSlice(data):
                messages = data.messages
                chats = data.chats
                users = data.users
            case let .channelMessages(data):
                messages = data.messages
                chats = data.chats
                users = data.users
            case .messagesNotModified:
                break
            }
            let changedChats = processPeers(users: users, chats: chats)
            let changedMsgs = stripTTLMessages(messages)
            modified = changedChats || changedMsgs
        } else if let chatFull = result as? Api.messages.ChatFull {
            switch chatFull {
            case let .chatFull(data):
                let changedFull = stripAutoDeleteFromFullChat(data.fullChat)
                let changedChats = processPeers(users: data.users, chats: data.chats)
                modified = changedFull || changedChats
            }
        } else if let difference = result as? Api.updates.Difference {
            // updates.getDifference — how most messages arrive after the app was backgrounded.
            switch difference {
            case let .difference(data):
                let filtered = filterStoryUpdates(&data.otherUpdates)
                let changedMsgs = stripTTLMessages(data.newMessages)
                let changedUpdates = stripTTLUpdates(data.otherUpdates)
                let changedChats = processPeers(users: data.users, chats: data.chats)
                modified = filtered || changedMsgs || changedUpdates || changedChats
            case let .differenceSlice(data):
                let filtered = filterStoryUpdates(&data.otherUpdates)
                let changedMsgs = stripTTLMessages(data.newMessages)
                let changedUpdates = stripTTLUpdates(data.otherUpdates)
                let changedChats = processPeers(users: data.users, chats: data.chats)
                modified = filtered || changedMsgs || changedUpdates || changedChats
            default:
                break
            }
        } else if let difference = result as? Api.updates.ChannelDifference {
            switch difference {
            case let .channelDifference(data):
                let changedMsgs = stripTTLMessages(data.newMessages)
                let changedUpdates = stripTTLUpdates(data.otherUpdates)
                let changedChats = processPeers(users: data.users, chats: data.chats)
                modified = changedMsgs || changedUpdates || changedChats
            case let .channelDifferenceTooLong(data):
                let changedMsgs = stripTTLMessages(data.messages)
                let changedChats = processPeers(users: data.users, chats: data.chats)
                modified = changedMsgs || changedChats
            case .channelDifferenceEmpty:
                break
            }
        } else if let dialogs = result as? Api.messages.Dialogs {
            switch dialogs {
            case let .dialogs(data):
                let changedMsgs = stripTTLMessages(data.messages)
                let changedChats = processPeers(users: data.users, chats: data.chats)
                modified = changedMsgs || changedChats
            case let .dialogsSlice(data):
                let changedMsgs = stripTTLMessages(data.messages)
                let changedChats = processPeers(users: data.users, chats: data.chats)
                modified = changedMsgs || changedChats
            case .dialogsNotModified:
                break
            }
        } else if let userFull = result as? Api.users.UserFull {
            switch userFull {
            case let .userFull(data):
                let changedUser = stripProtectionFromUserFull(data.fullUser)
                let changedChats = processPeers(users: data.users, chats: data.chats)
                modified = changedUser || changedChats
            }
        } else if let chats = result as? Api.messages.Chats {
            switch chats {
            case let .chats(data):
                modified = processPeers(users: [], chats: data.chats)
            case let .chatsSlice(data):
                modified = processPeers(users: [], chats: data.chats)
            }
        } else if let update = result as? Api.Update {
            let stripped = stripTTLUpdate(update)
            let starsPatched = patchVisualStarsUpdate(update)
            modified = stripped || starsPatched
        } else if let starsStatus = result as? Api.payments.StarsStatus {
            modified = patchVisualStarsStatus(starsStatus)
        } else if let message = result as? Api.Message {
            modified = stripTTLMessage(message)
        } else if let discussion = result as? Api.messages.DiscussionMessage {
            switch discussion {
            case let .discussionMessage(data):
                let changedChats = processPeers(users: data.users, chats: data.chats)
                let changedMsgs = stripTTLMessages(data.messages)
                modified = changedChats || changedMsgs
            }
        } else if let peerDialogs = result as? Api.messages.PeerDialogs {
            switch peerDialogs {
            case let .peerDialogs(data):
                let changedChats = processPeers(users: data.users, chats: data.chats)
                let changedMsgs = stripTTLMessages(data.messages)
                modified = changedChats || changedMsgs
            }
        } else if let resolved = result as? Api.contacts.ResolvedPeer {
            // Opening a channel by link or @username.
            if case let .resolvedPeer(data) = resolved {
                modified = processPeers(users: data.users, chats: data.chats)
            }
        } else if let found = result as? Api.contacts.Found {
            if case let .found(data) = found {
                modified = processPeers(users: data.users, chats: data.chats)
            }
        } else if let topics = result as? Api.messages.ForumTopics {
            if case let .forumTopics(data) = topics {
                let changedChats = processPeers(users: data.users, chats: data.chats)
                let changedMsgs = stripTTLMessages(data.messages)
                modified = changedChats || changedMsgs
            }
        } else if let promo = result as? Api.help.PromoData {
            // proxy:flags.0, psa_type:flags.1, psa_message:flags.2, peer:flags.3 — the
            // pending suggestions in the same object are Telegram's own hints and stay.
            if isHidePromo, case let .promoData(data) = promo, data.flags & Int32(0b1111) != 0 {
                data.flags &= ~Int32(0b1111)
                data.peer = nil
                data.psaType = nil
                data.psaMessage = nil
                modified = true
            }
        } else if let allStories = result as? Api.stories.AllStories {
            switch allStories {
            case let .allStories(data):
                if isHideStories {
                    // Empty feed; keep `state` so Telegram's incremental sync stays valid.
                    // has_more:flags.0
                    data.peerStories = []
                    data.count = 0
                    data.flags &= ~Int32(1 << 0)
                    modified = true
                } else {
                    var changed = false
                    for peerStories in data.peerStories {
                        let kept = keepDeletedStories(in: peerStories)
                        let unlocked = unlockPeerStories(peerStories)
                        if kept || unlocked { changed = true }
                    }
                    modified = changed
                }
                if processPeers(users: data.users, chats: data.chats) {
                    modified = true
                }
            case .allStoriesNotModified:
                break
            }
        } else if let peerStories = result as? Api.stories.PeerStories {
            switch peerStories {
            case let .peerStories(data):
                let kept = keepDeletedStories(in: data.stories)
                let changedStories = unlockPeerStories(data.stories) || kept
                let changedPeers = processPeers(users: data.users, chats: data.chats)
                modified = changedStories || changedPeers
            }
        } else if let stories = result as? Api.stories.Stories {
            switch stories {
            case let .stories(data):
                var kept = false
                if let restored = keepDeletedStories(in: data.stories) {
                    data.stories = restored
                    kept = true
                }
                let changedStories = unlockStories(data.stories) || kept
                let changedPeers = processPeers(users: data.users, chats: data.chats)
                modified = changedStories || changedPeers
            }
        } else {
            // Any other response that carries chats (view counters, send-as peers,
            // participants, sponsored, saved dialogs…). Telegram stores those channels
            // again, so a protected one would be locked again on the next fetch.
            var users: [Api.User] = []
            var chats: [Api.Chat] = []
            var messages: [Api.Message] = []
            collectNested(result, depth: 0, users: &users, chats: &chats, messages: &messages)
            let changedChats = processPeers(users: users, chats: chats)
            let changedMsgs = stripTTLMessages(messages)
            modified = changedChats || changedMsgs
        }

        if diagEnabled {
            let counts = diagTakeCounts()
            if !counts.isEmpty {
                diagLog("PATCH \(String(describing: type(of: result))) sig=\(hex(signature)) \(counts)")
            }
        }

        if modified {
            let outBuf = Buffer()
            Api.serializeObject(result, buffer: outBuf, boxed: true)
            return outBuf.makeData() as NSData
        }
        return nil
    }

    @objc static func handleResponse(_ data: NSData, functionID: NSNumber) -> NSData? {
        // Returns patched data only if something was actually modified.
        // Returning nil means "no change" — caller uses original data as-is.
        return stripAntiSelfDestruct(data)
    }

    // Encodes a voice-like waveform (100 samples, 5 bits each) using a seeded LCG
    // so the pattern is deterministic but looks natural — varied heights, a few
    // louder peaks, gentle envelope at the edges like real speech.
    // Without a non-nil waveform the server may demote the message to a regular audio file.
    static func makeVoiceWaveform(samples: Int = 100) -> Data {
        var bytes = Data(repeating: 0, count: (samples * 5 + 7) / 8)

        // LCG pseudo-random to avoid importing Foundation/random
        var seed: UInt32 = 0xA3F1B2C4
        func nextRand() -> Double {
            seed = seed &* 1664525 &+ 1013904223
            return Double(seed >> 16) / 65535.0
        }

        // Build amplitude envelope: fade in, sustain, fade out
        for i in 0..<samples {
            let pos = Double(i) / Double(samples - 1)
            let envelope: Double
            if pos < 0.08 {
                envelope = pos / 0.08
            } else if pos > 0.92 {
                envelope = (1.0 - pos) / 0.08
            } else {
                envelope = 1.0
            }
            // Combine slow wave + fast noise to mimic speech rhythm
            let wave = 0.45 + 0.3 * sin(pos * .pi * 7.0) + 0.25 * sin(pos * .pi * 19.0)
            let noise = nextRand() * 0.4
            let raw = min(1.0, max(0.0, (wave + noise) * envelope))
            // Map to 5-bit range; keep minimum bar of 1 so there are no silent gaps
            let v = max(1, Int(raw * 30.0 + 0.5))

            let bitBase = i * 5
            let byteIdx = bitBase >> 3
            let bitOff  = bitBase & 7
            let bitsHere = min(5, 8 - bitOff)
            bytes[byteIdx] |= UInt8((v & ((1 << bitsHere) - 1)) << bitOff)
            if bitsHere < 5 {
                bytes[byteIdx + 1] |= UInt8(v >> bitsHere)
            }
        }
        return bytes
    }

    @objc(transformVideoToVoiceSendMedia:duration:)
    static func transformVideoToVoiceSendMedia(_ data: NSData, duration: NSNumber?) -> NSData? {
        return rewriteSendMedia(data) { media in
            guard case let .inputMediaUploadedDocument(document) = media else {
                return nil
            }

            var sourceDuration: Int32 = duration?.int32Value ?? 0
            var looksLikeVideo = document.mimeType.hasPrefix("video/")
            for attribute in document.attributes {
                if case let .documentAttributeVideo(video) = attribute {
                    looksLikeVideo = true
                    if sourceDuration <= 0 {
                        sourceDuration = max(1, Int32(video.duration.rounded()))
                    }
                }
            }
            guard looksLikeVideo else {
                return nil
            }
            if sourceDuration <= 0 {
                sourceDuration = 1
            }

            let newDocumentFlags = document.flags & ~Int32((1 << 0) | (1 << 2) | (1 << 6) | (1 << 7))
            let audioAttribute = Api.DocumentAttribute.documentAttributeAudio(
                Api.DocumentAttribute.Cons_documentAttributeAudio(
                    flags: Int32(1 << 10) | Int32(1 << 2),
                    duration: sourceDuration,
                    title: nil,
                    performer: nil,
                    waveform: Buffer(data: TLParser.makeVoiceWaveform(samples: 100))
                )
            )
            return Api.InputMedia.inputMediaUploadedDocument(
                Api.InputMedia.Cons_inputMediaUploadedDocument(
                    flags: newDocumentFlags,
                    file: document.file,
                    thumb: nil,
                    mimeType: "audio/mp4",
                    attributes: [audioAttribute],
                    stickers: nil,
                    videoCover: nil,
                    videoTimestamp: nil,
                    ttlSeconds: document.ttlSeconds
                )
            )
        }
    }

    /// "Send audio as voice": an uploaded audio file goes out as a voice message.
    @objc(transformAudioToVoiceSendMedia:)
    static func transformAudioToVoiceSendMedia(_ data: NSData) -> NSData? {
        return rewriteSendMedia(data) { media in
            guard case let .inputMediaUploadedDocument(document) = media,
                  document.mimeType.hasPrefix("audio/") else {
                return nil
            }
            var audio: Api.DocumentAttribute.Cons_documentAttributeAudio?
            for attribute in document.attributes {
                if case let .documentAttributeAudio(value) = attribute {
                    audio = value
                }
            }
            // voice:flags.10 — already a voice message, nothing to do.
            guard let audio = audio, audio.flags & Int32(1 << 10) == 0 else {
                return nil
            }
            // voice:flags.10, waveform:flags.2; title/performer (flags.0/1) belong to music.
            audio.flags = Int32(1 << 10) | Int32(1 << 2)
            audio.title = nil
            audio.performer = nil
            audio.waveform = Buffer(data: TLParser.makeVoiceWaveform(samples: 100))
            document.attributes = document.attributes.filter { attribute in
                if case .documentAttributeFilename = attribute { return false }
                return true
            }
            // force_file:flags.4 would make the server keep it a plain file.
            document.flags &= ~Int32(1 << 4)
            return media
        }
    }

    // Parses a messages.sendMedia payload (layer 232 field order), lets `transform`
    // swap the media, and re-serializes the call. nil = leave the request alone.
    private static func rewriteSendMedia(_ data: NSData, _ transform: (Api.InputMedia) -> Api.InputMedia?) -> NSData? {
        let buffer = Buffer(data: data as Data)
        let reader = BufferReader(buffer)
        guard reader.readInt32() == 53536639 else {
            return nil
        }
        guard let flags = reader.readInt32() else {
            return nil
        }
        guard let peerSignature = reader.readInt32(),
              let peer = Api.parse(reader, signature: peerSignature) as? Api.InputPeer else {
            return nil
        }

        var replyTo: Api.InputReplyTo?
        if Int(flags) & Int(1 << 0) != 0 {
            guard let signature = reader.readInt32(),
                  let value = Api.parse(reader, signature: signature) as? Api.InputReplyTo else {
                return nil
            }
            replyTo = value
        }

        guard let mediaSignature = reader.readInt32(),
              let media = Api.parse(reader, signature: mediaSignature) as? Api.InputMedia else {
            return nil
        }
        guard let message = parseString(reader),
              let randomId = reader.readInt64() else {
            return nil
        }

        var replyMarkup: Api.ReplyMarkup?
        if Int(flags) & Int(1 << 2) != 0 {
            guard let signature = reader.readInt32(),
                  let value = Api.parse(reader, signature: signature) as? Api.ReplyMarkup else {
                return nil
            }
            replyMarkup = value
        }

        var entities: [Api.MessageEntity]?
        if Int(flags) & Int(1 << 3) != 0 {
            guard reader.readInt32() != nil,
                  let value = Api.parseVector(reader, elementSignature: 0, elementType: Api.MessageEntity.self) else {
                return nil
            }
            entities = value
        }

        var scheduleDate: Int32?
        if Int(flags) & Int(1 << 10) != 0 {
            guard let value = reader.readInt32() else { return nil }
            scheduleDate = value
        }

        var scheduleRepeatPeriod: Int32?
        if Int(flags) & Int(1 << 24) != 0 {
            guard let value = reader.readInt32() else { return nil }
            scheduleRepeatPeriod = value
        }

        var sendAs: Api.InputPeer?
        if Int(flags) & Int(1 << 13) != 0 {
            guard let signature = reader.readInt32(),
                  let value = Api.parse(reader, signature: signature) as? Api.InputPeer else {
                return nil
            }
            sendAs = value
        }

        var quickReplyShortcut: Api.InputQuickReplyShortcut?
        if Int(flags) & Int(1 << 17) != 0 {
            guard let signature = reader.readInt32(),
                  let value = Api.parse(reader, signature: signature) as? Api.InputQuickReplyShortcut else {
                return nil
            }
            quickReplyShortcut = value
        }

        var effect: Int64?
        if Int(flags) & Int(1 << 18) != 0 {
            guard let value = reader.readInt64() else { return nil }
            effect = value
        }

        var allowPaidStars: Int64?
        if Int(flags) & Int(1 << 21) != 0 {
            guard let value = reader.readInt64() else { return nil }
            allowPaidStars = value
        }

        var suggestedPost: Api.SuggestedPost?
        if Int(flags) & Int(1 << 22) != 0 {
            guard let signature = reader.readInt32(),
                  let value = Api.parse(reader, signature: signature) as? Api.SuggestedPost else {
                return nil
            }
            suggestedPost = value
        }

        guard let newMedia = transform(media) else {
            return nil
        }

        let request = Api.functions.messages.sendMedia(
            flags: flags,
            peer: peer,
            replyTo: replyTo,
            media: newMedia,
            message: message,
            randomId: randomId,
            replyMarkup: replyMarkup,
            entities: entities,
            scheduleDate: scheduleDate,
            scheduleRepeatPeriod: scheduleRepeatPeriod,
            sendAs: sendAs,
            quickReplyShortcut: quickReplyShortcut,
            effect: effect,
            allowPaidStars: allowPaidStars,
            suggestedPost: suggestedPost
        )
        return request.1.makeData() as NSData
    }
}

// MARK: - Message log (deleted / edited)
//
// Anti-Revoke and Anti-Edit keep messages in the chat; this keeps a readable list
// of them for the Lead menu. Deletions arrive as bare ids, so recent incoming
// texts and chat names are remembered as responses pass through.
extension TLParser {
    private static let logQueue = DispatchQueue(label: "com.lead.messageLog")
    private static var recentTexts: [String: String] = [:]   // "c123:45" -> text
    private static var recentOrder: [String] = []
    private static var globalIdPeers: [Int32: String] = [:]  // private/basic-group id -> "u…"/"g…"
    private static var peerNames: [String: [String: String]] = [:] // "c123" -> name/username
    private static var peerProfiles: [String: [String: String]] = [:] // "u123" -> name/username/photo id
    private static var recentLoaded = false
    private static var recentSaveScheduled = false
    private static let logUdKey = "LeadMessageLog"
    private static let recentLimit = 4000
    private static let logLimit = 500

    private static var recentFilePath: String {
        return (NSHomeDirectory() as NSString).appendingPathComponent("Documents/lead_recent_messages.plist")
    }

    private static var isLogging: Bool {
        // The extension has no use for the log: what it sees comes back through the handoff.
        if isExtension { return false }
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "LeadAntiRevoke") || defaults.bool(forKey: "LeadAntiEdit") || defaults.bool(forKey: "LeadProfileChangesLog")
    }

    private static var ownDeletions: [Int32: TimeInterval] = [:]

    /// Ids this device just asked the server to delete (Hooks.xm), so they don't show up
    /// as someone else's deletion in the log or the banner.
    @objc static func noteOwnDeletion(_ ids: [NSNumber]) {
        let now = Date().timeIntervalSince1970
        logQueue.async {
            ownDeletions = ownDeletions.filter { now - $0.value < 300 }
            for id in ids { ownDeletions[id.int32Value] = now }
        }
    }

    static func peerTag(_ peer: Api.Peer) -> String? {
        switch peer {
        case let .peerUser(data): return "u\(data.userId)"
        case let .peerChat(data): return "g\(data.chatId)"
        case let .peerChannel(data): return "c\(data.channelId)"
        }
    }

    // Called on logQueue.
    private static func loadRecentIfNeeded() {
        guard !recentLoaded else { return }
        recentLoaded = true
        guard let stored = NSDictionary(contentsOfFile: recentFilePath) as? [String: Any] else { return }
        recentTexts = stored["texts"] as? [String: String] ?? [:]
        recentOrder = stored["order"] as? [String] ?? Array(recentTexts.keys)
        peerNames = stored["names"] as? [String: [String: String]] ?? [:]
        peerProfiles = stored["profiles"] as? [String: [String: String]] ?? [:]
        for key in recentOrder {
            let parts = key.split(separator: ":")
            if parts.count == 2, !parts[0].hasPrefix("c"), let id = Int32(parts[1]) {
                globalIdPeers[id] = String(parts[0])
            }
        }
    }

    // Called on logQueue. Batches disk writes: the cache changes with every update.
    private static func scheduleRecentSave() {
        guard !recentSaveScheduled else { return }
        recentSaveScheduled = true
        logQueue.asyncAfter(deadline: .now() + 8) {
            recentSaveScheduled = false
            let payload: NSDictionary = ["texts": recentTexts, "order": recentOrder, "names": peerNames, "profiles": peerProfiles]
            payload.write(toFile: recentFilePath, atomically: true)
        }
    }

    private static func displayText(_ message: String, hasMedia: Bool) -> String {
        var text = message
        if text.hasPrefix("🗑️ ") { text.removeFirst("🗑️ ".count) }
        if text.isEmpty && hasMedia { return "[media]" }
        return text
    }

    // Called on logQueue.
    private static func remember(tag: String, id: Int32, text: String) {
        let key = "\(tag):\(id)"
        if recentTexts[key] == nil {
            recentOrder.append(key)
        }
        recentTexts[key] = text
        if !tag.hasPrefix("c") {
            globalIdPeers[id] = tag
        }
        if recentOrder.count > recentLimit {
            let overflow = recentOrder.prefix(recentOrder.count - recentLimit)
            for old in overflow { recentTexts.removeValue(forKey: old) }
            recentOrder.removeFirst(overflow.count)
        }
        scheduleRecentSave()
    }

    static func observeMessages(_ messages: [Api.Message]) {
        guard isLogging else { return }
        var items: [(String, Int32, String)] = []
        for message in messages {
            guard case let .message(data) = message, let tag = peerTag(data.peerId) else { continue }
            items.append((tag, data.id, displayText(data.message, hasMedia: data.media != nil)))
        }
        guard !items.isEmpty else { return }
        logQueue.async {
            loadRecentIfNeeded()
            for (tag, id, text) in items { remember(tag: tag, id: id, text: text) }
        }
    }

    static func observeShortMessage(tag: String, id: Int32, text: String) {
        guard isLogging else { return }
        logQueue.async {
            loadRecentIfNeeded()
            remember(tag: tag, id: id, text: displayText(text, hasMedia: false))
        }
    }

    static func observePeers(users: [Api.User], chats: [Api.Chat]) {
        guard isLogging, !(users.isEmpty && chats.isEmpty) else { return }
        var found: [String: [String: String]] = [:]
        var profiles: [String: [String: String]] = [:]
        for user in users {
            if case let .user(data) = user {
                let name = [data.firstName, data.lastName].compactMap { $0 }.filter { !$0.isEmpty }.joined(separator: " ")
                var info = ["name": name]
                if let username = data.username { info["username"] = username }
                if !name.isEmpty || info["username"] != nil { found["u\(data.id)"] = info }
                // min:flags.20 objects are partial, self:flags.10 is you, deleted:flags.13 has no profile.
                if data.flags & Int32((1 << 20) | (1 << 10) | (1 << 13)) == 0, !name.isEmpty {
                    var profile = info
                    switch data.photo {
                    case let .userProfilePhoto(photo)?: profile["photo"] = "\(photo.photoId)"
                    default: profile["photo"] = "none"
                    }
                    profiles["u\(data.id)"] = profile
                }
            }
        }
        for chat in chats {
            switch chat {
            case let .chat(data): found["g\(data.id)"] = ["name": data.title]
            case let .chatForbidden(data): found["g\(data.id)"] = ["name": data.title]
            case let .channel(data):
                var info = ["name": data.title]
                if let username = data.username { info["username"] = username }
                found["c\(data.id)"] = info
            case let .channelForbidden(data): found["c\(data.id)"] = ["name": data.title]
            default: break
            }
        }
        guard !found.isEmpty else { return }
        logQueue.async {
            loadRecentIfNeeded()
            var changed = false
            if UserDefaults.standard.bool(forKey: "LeadProfileChangesLog") {
                for (key, profile) in profiles {
                    if let previous = peerProfiles[key] {
                        logProfileChanges(tag: key, old: previous, new: profile)
                    }
                    if peerProfiles[key] != profile {
                        peerProfiles[key] = profile
                        changed = true
                    }
                }
            }
            for (key, info) in found where peerNames[key] != info {
                peerNames[key] = info
                changed = true
            }
            if peerNames.count > 3000 {
                for key in peerNames.keys.prefix(peerNames.count - 3000) { peerNames.removeValue(forKey: key) }
            }
            if changed { scheduleRecentSave() }
        }
    }

    // Called on logQueue.
    private static func appendLogEntry(_ entry: [String: Any]) {
        let defaults = UserDefaults.standard
        var log = defaults.array(forKey: logUdKey) as? [[String: Any]] ?? []
        // The same deletion can arrive twice (live push and getDifference catch-up).
        if entry["kind"] as? String == "deleted",
           log.prefix(50).contains(where: { ($0["kind"] as? String) == "deleted" && ($0["peer"] as? String) == (entry["peer"] as? String) && ($0["id"] as? Int32) == (entry["id"] as? Int32) }) {
            return
        }
        log.insert(entry, at: 0)
        if log.count > logLimit { log.removeLast(log.count - logLimit) }
        defaults.set(log, forKey: logUdKey)
        let showBanner = entry["kind"] as? String == "deleted" && defaults.bool(forKey: "LeadDeletionBanner")
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name("LeadMessageLogChanged"), object: nil)
            if showBanner {
                NotificationCenter.default.post(name: NSNotification.Name("LeadDeletionBanner"), object: nil, userInfo: entry)
            }
        }
    }

    private static func entry(kind: String, tag: String?, id: Int32, text: String?, old: String?) -> [String: Any] {
        var entry: [String: Any] = ["kind": kind, "id": id, "date": Date().timeIntervalSince1970]
        if let tag = tag {
            entry["peer"] = tag
            if let info = peerNames[tag] {
                if let name = info["name"], !name.isEmpty { entry["name"] = name }
                if let username = info["username"] { entry["username"] = username }
            }
        }
        if let text = text { entry["text"] = text }
        if let old = old { entry["old"] = old }
        return entry
    }

    static func logDeleted(id: Int32, channelId: Int64?) {
        guard UserDefaults.standard.bool(forKey: "LeadAntiRevoke"), id != 0 else { return }
        logQueue.async {
            if ownDeletions[id] != nil { return }
            loadRecentIfNeeded()
            let tag = channelId.map { "c\($0)" } ?? globalIdPeers[id]
            if channelId == nil, let tag = tag { noteDeletedPeer(id: id, tag: tag) }
            let text = tag.flatMap { recentTexts["\($0):\(id)"] }
            appendLogEntry(entry(kind: "deleted", tag: tag, id: id, text: text, old: nil))
        }
    }

    static func logEdited(_ message: Api.Message) {
        guard case let .message(data) = message, let tag = peerTag(data.peerId) else { return }
        // out:flags.1 — your own edits aren't news.
        let outgoing = data.flags & Int32(1 << 1) != 0
        // edit_hide:flags.21 or no edit_date: reactions, keyboards and the like resend
        // the message through the edit update without anyone having edited it.
        let hidden = data.flags & Int32(1 << 21) != 0 || data.editDate == nil
        let newText = displayText(data.message, hasMedia: data.media != nil)
        logQueue.async {
            loadRecentIfNeeded()
            let old = recentTexts["\(tag):\(data.id)"]
            if !outgoing && !hidden && old != newText {
                appendLogEntry(entry(kind: "edited", tag: tag, id: data.id, text: newText, old: old))
            }
            remember(tag: tag, id: data.id, text: newText)
        }
    }

    // Called on logQueue.
    private static func logProfileChanges(tag: String, old: [String: String], new: [String: String]) {
        let now = Date().timeIntervalSince1970
        func add(_ field: String, _ before: String?, _ after: String?) {
            var entry: [String: Any] = ["kind": "profile", "peer": tag, "field": field, "id": 0, "date": now]
            if let name = new["name"], !name.isEmpty { entry["name"] = name }
            if let username = new["username"] { entry["username"] = username }
            if let before = before { entry["old"] = before }
            if let after = after { entry["text"] = after }
            appendLogEntry(entry)
        }
        if let before = old["name"], let after = new["name"], before != after, !before.isEmpty {
            add("name", before, after)
        }
        if old["username"] != new["username"], old["username"] != nil || new["username"] != nil {
            add("username", old["username"], new["username"])
        }
        if let before = old["photo"], let after = new["photo"], before != after {
            add(after == "none" ? "photo_removed" : "photo", nil, nil)
        }
    }

    @objc static func messageLogEntries() -> NSArray {
        return (UserDefaults.standard.array(forKey: logUdKey) ?? []) as NSArray
    }

    @objc static func clearMessageLog() {
        logQueue.async {
            UserDefaults.standard.removeObject(forKey: logUdKey)
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name("LeadMessageLogChanged"), object: nil)
            }
        }
    }
}

// MARK: - Deleted stories (anti-revoke for stories)
//
// Every story that passes through is cached. When its author deletes it, Telegram
// learns that either from updateStory(storyItemDeleted) or because the story is
// missing from a fresh list; both are answered with the cached copy, marked 🗑️,
// until it would have expired anyway.
extension TLParser {
    private static let storyQueue = DispatchQueue(label: "com.lead.storyCache")
    private static var storyCache: [String: Data] = [:]      // "u12:5" -> boxed StoryItem
    private static var storyExpiry: [String: Int32] = [:]
    private static var storyCacheLoaded = false
    private static var storySaveScheduled = false
    private static let storyCacheLimit = 600

    private static var storyCachePath: String {
        return (NSHomeDirectory() as NSString).appendingPathComponent("Documents/lead_story_cache.plist")
    }

    static var isSavingDeletedStories: Bool {
        return UserDefaults.standard.bool(forKey: "LeadSaveDeletedStories")
    }

    private static func storyId(_ story: Api.StoryItem) -> Int32 {
        switch story {
        case let .storyItem(data): return data.id
        case let .storyItemSkipped(data): return data.id
        case let .storyItemDeleted(data): return data.id
        }
    }

    // Called on storyQueue.
    private static func loadStoryCacheIfNeeded() {
        guard !storyCacheLoaded else { return }
        storyCacheLoaded = true
        guard let stored = NSDictionary(contentsOfFile: storyCachePath) as? [String: Any] else { return }
        storyCache = stored["items"] as? [String: Data] ?? [:]
        storyExpiry = stored["expiry"] as? [String: Int32] ?? [:]
    }

    // Called on storyQueue.
    private static func scheduleStorySave() {
        guard !storySaveScheduled else { return }
        storySaveScheduled = true
        storyQueue.asyncAfter(deadline: .now() + 5) {
            storySaveScheduled = false
            let payload: NSDictionary = ["items": storyCache, "expiry": storyExpiry]
            payload.write(toFile: storyCachePath, atomically: true)
        }
    }

    private static func cacheStories(_ stories: [Api.StoryItem], tag: String) {
        var items: [(String, Data, Int32)] = []
        for story in stories {
            // Our own restored copies (🗑️ caption) never go back into the cache.
            guard case let .storyItem(data) = story, !(data.caption ?? "").hasPrefix("🗑️") else { continue }
            let buffer = Buffer()
            story.serialize(buffer, true)
            items.append(("\(tag):\(data.id)", buffer.makeData(), data.expireDate))
        }
        guard !items.isEmpty else { return }
        let now = Int32(Date().timeIntervalSince1970)
        storyQueue.sync {
            loadStoryCacheIfNeeded()
            for (key, data, expiry) in items {
                storyCache[key] = data
                storyExpiry[key] = expiry
            }
            for (key, expiry) in storyExpiry where expiry < now {
                storyCache.removeValue(forKey: key)
                storyExpiry.removeValue(forKey: key)
            }
            if storyCache.count > storyCacheLimit {
                let oldest = storyExpiry.sorted { $0.value < $1.value }.prefix(storyCache.count - storyCacheLimit)
                for (key, _) in oldest {
                    storyCache.removeValue(forKey: key)
                    storyExpiry.removeValue(forKey: key)
                }
            }
            scheduleStorySave()
        }
    }

    // A fresh copy of a cached story with 🗑️ in front of its caption.
    private static func restoredStory(key: String) -> Api.StoryItem? {
        let data: Data? = storyQueue.sync {
            loadStoryCacheIfNeeded()
            return storyCache[key]
        }
        guard let data = data,
              let story = Api.parse(Buffer(data: data)) as? Api.StoryItem,
              case let .storyItem(item) = story,
              // out:flags.16 — your own story: you deleted it, and it stays deleted.
              item.flags & Int32(1 << 16) == 0 else { return nil }
        let prefix = "🗑️ "
        let caption = item.caption ?? ""
        if !caption.hasPrefix("🗑️") {
            item.caption = prefix + caption
            item.flags |= Int32(1 << 0) // caption:flags.0
            if let entities = item.entities {
                shiftEntities(entities, by: Int32(prefix.utf16.count))
            }
        }
        return story
    }

    // updateStory: cache live stories, swap a deletion for the cached copy.
    static func keepDeletedStory(_ update: Api.Update.Cons_updateStory) -> Bool {
        guard isSavingDeletedStories, let tag = peerTag(update.peer) else { return false }
        guard case let .storyItemDeleted(deleted) = update.story else {
            cacheStories([update.story], tag: tag)
            return false
        }
        guard let restored = restoredStory(key: "\(tag):\(deleted.id)") else { return false }
        update.story = restored
        return true
    }

    // A full list of a peer's active stories: anything cached, unexpired and missing was deleted.
    static func keepDeletedStories(in peerStories: Api.PeerStories) -> Bool {
        guard isSavingDeletedStories, case let .peerStories(data) = peerStories, let tag = peerTag(data.peer) else { return false }
        cacheStories(data.stories, tag: tag)
        let present = Set(data.stories.map(storyId))
        let now = Int32(Date().timeIntervalSince1970)
        let missing: [String] = storyQueue.sync {
            loadStoryCacheIfNeeded()
            return storyExpiry.compactMap { key, expiry in
                guard expiry > now, key.hasPrefix("\(tag):"),
                      let id = key.split(separator: ":").last.flatMap({ Int32($0) }),
                      !present.contains(id) else { return nil }
                return key
            }
        }
        let restored = missing.compactMap(restoredStory)
        guard !restored.isEmpty else { return false }
        data.stories = (data.stories + restored).sorted { storyId($0) < storyId($1) }
        return true
    }

    // stories.getStoriesByID has no peer in its answer; restore only when the id is unambiguous.
    static func keepDeletedStories(in stories: [Api.StoryItem]) -> [Api.StoryItem]? {
        guard isSavingDeletedStories else { return nil }
        var changed = false
        let result = stories.map { story -> Api.StoryItem in
            guard case let .storyItemDeleted(deleted) = story else { return story }
            let suffix = ":\(deleted.id)"
            let keys: [String] = storyQueue.sync {
                loadStoryCacheIfNeeded()
                return storyCache.keys.filter { $0.hasSuffix(suffix) }
            }
            guard keys.count == 1, let restored = restoredStory(key: keys[0]) else { return story }
            changed = true
            return restored
        }
        return changed ? result : nil
    }
}


// MARK: - Diagnostics (test mode)
//
// "Diagnostics" in the Content page writes what the network hooks and the chat
// UI see to Documents/lead_diag.log, so a broken feature can be traced on a
// real device: which responses reach Lead, what gets patched, and with which
// flags Telegram finally shows a message.
extension TLParser {
    private static let diagQueue = DispatchQueue(label: "com.lead.diag")
    private static let diagLimit = 1_500_000
    private static var diagSeenNodes = Set<String>()
    private static var diagParseFailures: [Int32: Int] = [:]
    private static let diagLock = NSLock()

    // Recording turns itself off after half an hour: it's for one bug report, and
    // left on it slows every chat down.
    private static let diagMaxDuration: TimeInterval = 30 * 60

    @objc static var diagEnabled: Bool {
        let defaults = UserDefaults.standard
        guard defaults.bool(forKey: "LeadDiagnostics") else { return false }
        let now = Date().timeIntervalSince1970
        let since = defaults.double(forKey: "LeadDiagnosticsSince")
        if since == 0 {
            defaults.set(now, forKey: "LeadDiagnosticsSince")
        } else if now - since > diagMaxDuration {
            defaults.set(false, forKey: "LeadDiagnostics")
            defaults.removeObject(forKey: "LeadDiagnosticsSince")
            return false
        }
        return true
    }

    @objc static func diagLogPath() -> String {
        let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? NSTemporaryDirectory()
        return (docs as NSString).appendingPathComponent("lead_diag.log")
    }

    @objc static func diagLog(_ line: String) {
        guard diagEnabled else { return }
        let stamp = Date().timeIntervalSince1970
        let text = String(format: "%.3f ", stamp) + line + "\n"
        diagQueue.async {
            let path = diagLogPath()
            let fm = FileManager.default
            if !fm.fileExists(atPath: path) { fm.createFile(atPath: path, contents: nil) }
            // Keep the newest half once the file grows past the limit.
            if let size = (try? fm.attributesOfItem(atPath: path))?[.size] as? Int, size > diagLimit,
               let data = fm.contents(atPath: path) {
                fm.createFile(atPath: path, contents: data.suffix(diagLimit / 2))
            }
            guard let handle = FileHandle(forWritingAtPath: path) else { return }
            handle.seekToEndOfFile()
            handle.write(text.data(using: .utf8) ?? Data())
            handle.closeFile()
        }
    }

    @objc static func diagClear() {
        diagQueue.async {
            try? FileManager.default.removeItem(atPath: diagLogPath())
            diagLock.lock(); diagSeenNodes.removeAll(); diagParseFailures.removeAll(); diagLock.unlock()
        }
    }

    @objc static func diagLogSize() -> Int {
        return ((try? FileManager.default.attributesOfItem(atPath: diagLogPath()))?[.size] as? Int) ?? 0
    }

    static func hex(_ value: Int32) -> String {
        return String(format: "%08x", UInt32(bitPattern: value))
    }

    // Counts patched objects per top-level parse; kept per thread since responses
    // and live updates are parsed on different queues.
    static func diagCount(_ key: String) {
        guard diagEnabled else { return }
        let dict = Thread.current.threadDictionary
        dict[key] = ((dict[key] as? Int) ?? 0) + 1
    }

    static func diagTakeCounts() -> String {
        let dict = Thread.current.threadDictionary
        var parts: [String] = []
        for key in ["leadDiagChan", "leadDiagChat", "leadDiagMsg", "leadDiagUserFull"] {
            if let n = dict[key] as? Int, n > 0 {
                parts.append("\(key.replacingOccurrences(of: "leadDiag", with: ""))=\(n)")
            }
            dict.removeObject(forKey: key)
        }
        return parts.joined(separator: " ")
    }

    static func diagParseFailed(signature: Int32, length: Int) {
        guard diagEnabled else { return }
        // MTProto service messages (rpc_result, acks, pongs, salts…) aren't API objects.
        let service: Set<UInt32> = [0xf35c6d01, 0x62d6b459, 0x347773c5, 0x9ec20908, 0xedab447b, 0xa7eff811, 0x276d3ec6,
                                    0x809db6df, 0x04deb57d, 0x8cc0d131, 0x7d861a08, 0x2144ca19, 0xae500895, 0x0949d9dc,
                                    0x3072cfa1, 0x5e2ad36e, 0x5bb8e511]
        if service.contains(UInt32(bitPattern: signature)) { return }
        diagLock.lock()
        let count = (diagParseFailures[signature] ?? 0) + 1
        diagParseFailures[signature] = count
        diagLock.unlock()
        if count <= 3 {
            diagLog("PARSE-FAIL sig=\(hex(signature)) len=\(length)")
        }
    }

    // What Telegram's own parser made of the (patched) response: channel flags as
    // Telegram will store them. noforwards = flags bit 27.
    @objc static func diagResponse(_ functionID: Int32, inLength: Int, patched: Bool, result: Any?) {
        guard diagEnabled else { return }
        // Only what's cheap: walking Telegram's parsed object here cost noticeable
        // time on every response. What got patched is logged by the PATCH lines.
        let typeName = result.map { String(describing: type(of: $0)) } ?? "nil"
        diagLog("RESP fn=\(hex(functionID)) len=\(inLength) patched=\(patched ? 1 : 0) type=\(typeName)")
    }

    // One line per chat message the first time it's laid out: the flags Telegram
    // decides with. Message.flags 512 = CopyProtected; TelegramChannelFlags 256 =
    // copyProtectionEnabled; associatedData.isCopyProtectionEnabled = chat level.
    @objc static func diagNode(_ node: Any) {
        guard diagEnabled, let ref = getMessageRefFromNode(node) else { return }
        let key = "\(ref.peerNamespace):\(ref.peerId):\(ref.id)"
        diagLock.lock()
        let isNew = diagSeenNodes.count < 150 && diagSeenNodes.insert(key).inserted
        diagLock.unlock()
        guard isNew else { return }

        guard let item = itemFromNode(node) else {
            diagLog("UI \(key) no item")
            return
        }
        var chatLevel = "?"
        if let associated = diagChild(item, "associatedData"),
           let value = diagChild(associated, "isCopyProtectionEnabled") as? Bool {
            chatLevel = value ? "1" : "0"
        }
        var messageFlags = "?"
        var channelFlags = "?"
        if let message = messageFromItem(item) {
            if let flags = diagChild(message, "flags"), let raw = diagChild(flags, "rawValue") {
                messageFlags = "\(raw)"
                if let value = raw as? UInt32 { messageFlags += value & 512 != 0 ? "(prot)" : "" }
            }
            if let peers = diagChild(message, "peers"),
               let channel = diagFindObject(peers, depth: 0, where: { name, _ in name == "TelegramChannel" }),
               let flags = diagChild(channel, "flags"), let raw = diagChild(flags, "rawValue") {
                channelFlags = "\(raw)"
                if let value = raw as? Int32 { channelFlags += value & 256 != 0 ? "(prot)" : "" }
            }
        }
        var line = "UI msg=\(key) chatProt=\(chatLevel) msgFlags=\(messageFlags) channelFlags=\(channelFlags)"
        if ref.peerNamespace < 0 {
            // The peer couldn't be read from the item's description: show its shape,
            // cut before the message text.
            var described = String(describing: item)
            if let range = described.range(of: ", text") { described = String(described[..<range.lowerBound]) }
            line += " itemType=\(type(of: item)) desc=\(described.prefix(90))"
        }
        diagLog(line)
    }

    private static func diagChild(_ object: Any, _ label: String) -> Any? {
        var currentMirror: Mirror? = Mirror(reflecting: unwrapOptional(object))
        while let mirror = currentMirror {
            for child in mirror.children where child.label == label {
                return unwrapOptional(child.value)
            }
            currentMirror = mirror.superclassMirror
        }
        return nil
    }

    private static func diagFindObject(_ object: Any, depth: Int, where match: (String, Mirror) -> Bool) -> Any? {
        if depth > 6 { return nil }
        let object = unwrapOptional(object)
        if object is String || object is Data || object is Int32 || object is Int64 || object is Bool { return nil }
        let mirror = Mirror(reflecting: object)
        if match(String(describing: type(of: object)), mirror) { return object }
        for child in mirror.children {
            if let found = diagFindObject(child.value, depth: depth + 1, where: match) { return found }
        }
        return nil
    }
}

// MARK: - Notification extension bridge
//
// While the app is suspended the notification service extension stores new messages,
// so Lead patches its responses too. Extensions have their own UserDefaults: the app
// mirrors the few settings that matter into a shared folder, and the extension leaves
// what it found (deleted ids, timers) there for the app to pick up.
extension TLParser {
    @objc static var sharedNotesPath: String?
    static let isExtension = Bundle.main.bundlePath.hasSuffix(".appex")

    private static let bridgedKeys = ["LeadAntiRevoke", "LeadAntiSelfDestruct", "LeadAntiAutoDelete", "disableForwardRestriction",
                                      "LeadHideTTLLabel", "LeadShowIosRestricted"]
    private static let bridgedLists = ["LeadSelfDestructMsgIds", "LeadSelfDestructChannelKeys"]
    private static let bridgeQueue = DispatchQueue(label: "com.lead.bridge")

    private static func bridgeFile(_ name: String) -> String? {
        return sharedNotesPath.map { ($0 as NSString).appendingPathComponent(name) }
    }

    @objc static func bridgeWriteSettings() {
        guard let path = bridgeFile("settings.plist") else { return }
        let defaults = UserDefaults.standard
        let values = NSMutableDictionary()
        for key in bridgedKeys { values[key] = defaults.bool(forKey: key) }
        for key in bridgedLists { if let list = defaults.array(forKey: key) { values[key] = list } }
        bridgeQueue.async { values.write(toFile: path, atomically: true) }
    }

    /// In the extension: true when there's something to patch. The values go in as
    /// registered defaults, so every check reads them as usual and nothing is stored.
    @objc static func bridgeLoadSettings() -> Bool {
        guard let path = bridgeFile("settings.plist"),
              let values = NSDictionary(contentsOfFile: path) as? [String: Any] else { return false }
        UserDefaults.standard.register(defaults: values)
        return bridgedKeys.contains { $0 != "LeadHideTTLLabel" && (values[$0] as? Bool) == true }
    }

    fileprivate static func bridgeHandoff(_ line: String) {
        guard let path = bridgeFile("handoff.txt") else { return }
        bridgeQueue.async {
            guard let data = (line + "\n").data(using: .utf8) else { return }
            if !FileManager.default.fileExists(atPath: path) { FileManager.default.createFile(atPath: path, contents: nil) }
            guard let handle = FileHandle(forWritingAtPath: path) else { return }
            handle.seekToEndOfFile()
            handle.write(data)
            handle.closeFile()
        }
    }

    /// In the app: takes in what the extension saw since the last time.
    @objc static func bridgeTakeHandoff() {
        guard let path = bridgeFile("handoff.txt") else { return }
        bridgeQueue.async {
            let taken = path + ".taken"
            let fm = FileManager.default
            try? fm.removeItem(atPath: taken)
            guard (try? fm.moveItem(atPath: path, toPath: taken)) != nil,
                  let text = try? String(contentsOfFile: taken, encoding: .utf8) else { return }
            try? fm.removeItem(atPath: taken)
            var deleted: [NSNumber] = []
            for line in text.split(separator: "\n") {
                let parts = line.split(separator: " ")
                guard parts.count >= 2, let id = Int32(parts[1]) else { continue }
                let channelId = parts.count > 2 ? Int64(parts[2]) : nil
                if parts[0] == "d" {
                    if let channelId = channelId { addDeletedId(id, channelId: channelId) } else { addDeletedId(id) }
                    deleted.append(NSNumber(value: id))
                } else if parts[0] == "t" {
                    addSelfDestructId(id, channelId: channelId)
                }
            }
            guard !deleted.isEmpty else { return }
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name("LeadMessageDeletedRealtime"), object: nil, userInfo: ["ids": deleted])
            }
        }
    }

    /// In the extension: for the compatibility page, proof it ran and did something.
    @objc static func bridgeNotePatched() {
        guard let path = bridgeFile("extension-status.plist") else { return }
        bridgeQueue.async {
            let count = ((NSDictionary(contentsOfFile: path)?["patched"] as? NSNumber)?.intValue ?? 0) + 1
            (["patched": count, "date": Date().timeIntervalSince1970] as NSDictionary).write(toFile: path, atomically: true)
        }
    }

    @objc static func bridgeExtensionStatus() -> NSDictionary? {
        return bridgeFile("extension-status.plist").flatMap { NSDictionary(contentsOfFile: $0) }
    }
}

// MARK: - Compatibility page
extension TLParser {
    private static var compatValues: [String: Int] = [:]
    private static var compatLastFailed: Int32 = 0
    private static let compatLock = NSLock()

    fileprivate static func compatCount(_ key: String, signature: Int32? = nil) {
        compatLock.lock()
        compatValues[key, default: 0] += 1
        if let signature = signature { compatLastFailed = signature }
        compatLock.unlock()
    }

    @objc static func compatCounters() -> NSDictionary {
        compatLock.lock()
        defer { compatLock.unlock() }
        let result = NSMutableDictionary(dictionary: compatValues)
        if compatLastFailed != 0 { result["lastFailed"] = hex(compatLastFailed) }
        return result
    }

    /// PeerId can't tell a supergroup from a broadcast channel; the loaded peer can.
    /// 1 group, 2 broadcast, 0 not known yet (profile data still loading).
    @objc static func channelKindFromController(_ controller: Any) -> NSNumber {
        guard let node = ivarValue(from: controller as AnyObject, named: "_displayNode"),
              let data = ivarValue(from: node as AnyObject, named: "data"), !(data is NSNull),
              let peer = diagChild(data, "peer"),
              let info = diagChild(peer, "info"),
              let label = Mirror(reflecting: info).children.first?.label else { return 0 }
        return label == "group" ? 1 : label == "broadcast" ? 2 : 0
    }
}
