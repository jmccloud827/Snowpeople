import SwiftUI

@MainActor extension [PartModel] {
    static let mittens: [PartModel] = [.mitten1, .mitten2, .mitten3, .mitten4, .mitten5]
}

@MainActor extension PartModel {
    static let mitten1: PartModel = .init(image: .init("mitten1", color: .blue, layers: [.init(color: .white)]))
    static let mitten2: PartModel = .init(image: .init("mitten2", color: .black, layers: [.init(color: .green)]))
    static let mitten3: PartModel = .init(image: .init("mitten3", color: .black, layers: [.init(color: .white), .init(color: .red)]))
    static let mitten4: PartModel = .init(image: .init("mitten4", color: .black, layers: [.init(color: .green), .init(color: .red)]))
    static let mitten5: PartModel = .init(image: .init("mitten5", color: .black, layers: [.init(color: .gray), .init(color: .cyan)]))
}

#Preview {
    PartList(parts: .mittens) { _ in }
}
