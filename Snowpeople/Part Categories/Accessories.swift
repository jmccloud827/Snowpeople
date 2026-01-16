import SwiftUI

@MainActor extension [PartModel] {
    static let accessories: [PartModel] = [.accessory1, .accessory2, .accessory3, .accessory4, .accessory5, .accessory6, .accessory7]
}

@MainActor extension PartModel {
    static let accessory1: PartModel = .init(image: .init("accessory1", color: .black, layers: [.init(color: .white)]))
    static let accessory2: PartModel = .init(image: .init("accessory2", color: .black, layers: [.init(color: .clear)]))
    static let accessory3: PartModel = .init(image: .init("accessory3", color: .black, layers: []))
    static let accessory4: PartModel = .init(image: .init("accessory4", color: .black, layers: []))
    static let accessory5: PartModel = .init(image: .init("accessory5", color: .black, layers: [.init(color: .orange)]))
    static let accessory6: PartModel = .init(image: .init("accessory6", color: .black, layers: [.init(color: .blue)]))
    static let accessory7: PartModel = .init(image: .init("accessory7", color: .black, layers: [.init(color: .green)]))
}

#Preview {
    PartList(parts: .accessories) { _ in }
}
