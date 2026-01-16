import SwiftUI

@MainActor extension [PartModel] {
    static let noses: [PartModel] = [.nose1, .nose2, .nose3, .nose4, .nose5, .nose6, .nose7, .nose8, .nose9]
}

@MainActor extension PartModel {
    static let nose1: PartModel = .init(image: .init("nose1", color: .orange, layers: []))
    static let nose2: PartModel = .init(image: .init("nose2", color: .orange, layers: []))
    static let nose3: PartModel = .init(image: .init("nose3", color: .orange, layers: []))
    static let nose4: PartModel = .init(image: .init("nose4", color: .orange, layers: []))
    static let nose5: PartModel = .init(image: .init("nose5", color: .orange, layers: []))
    static let nose6: PartModel = .init(image: .init("nose6", color: .black, layers: [.init(color: .orange)]))
    static let nose7: PartModel = .init(image: .init("nose7", color: .orange, layers: []))
    static let nose8: PartModel = .init(image: .init("nose8", color: .black, layers: [.init(color: .orange)]))
    static let nose9: PartModel = .init(image: .init("nose9", color: .orange, layers: []))
}

#Preview {
    PartList(parts: .noses) { _ in }
}
