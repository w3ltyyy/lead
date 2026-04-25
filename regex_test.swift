import Foundation

let str = "ChatMessageItemImpl(message: Message(id: MessageId(peerId: PeerId(123), namespace: 0, id: 456789)))"
if let range = str.range(of: "MessageId\\(peerId: [^,]+, namespace: [^,]+, id: (\\d+)\\)", options: .regularExpression) {
    let match = String(str[range])
    print("Match: \(match)")
}
