import SwiftUI

@MainActor extension [PartModel] {
    static let buttons: [PartModel] = [.button1, .button2, .button3, .button4, .button5, .button6]
}

@MainActor extension PartModel {
    static let button1: PartModel = .init(image: .init("button1", color: .green, layers: []))
    static let button2: PartModel = .init(image: .init("button2", color: .blue, layers: []))
    static let button3: PartModel = .init(image: .init("button3", color: .orange, layers: []))
    static let button4: PartModel = .init(image: .init("button4", color: .cyan, layers: []))
    static let button5: PartModel = .init(image: .init("button5", color: .black, layers: []))
    static let button6: PartModel = .init(image: .init("button6", color: .black, layers: []))
}

#Preview {
    PartList(parts: .buttons) { _ in }
}
