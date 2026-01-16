import SwiftUI

@MainActor extension [PartModel] {
    static let faces: [PartModel] = [.face1, .face2, .face3, .face4, .face5, .face6, .face7, .face8, .face9]
}

@MainActor extension PartModel {
    static let face1: PartModel = .init(image: .init("face1", color: .black, layers: [.init(color: .orange), .init(color: .blue)]))
    static let face2: PartModel = .init(image: .init("face2", color: .black, layers: [.init(color: .orange), .init(color: .green)]))
    static let face3: PartModel = .init(image: .init("face3", color: .black, layers: [.init(color: .orange), .init(color: .brown)]))
    static let face4: PartModel = .init(image: .init("face4", color: .black, layers: [.init(color: .orange), .init(color: .blue)]))
    static let face5: PartModel = .init(image: .init("face5", color: .black, layers: [.init(color: .orange)]))
    static let face6: PartModel = .init(image: .init("face6", color: .black, layers: [.init(color: .orange)]))
    static let face7: PartModel = .init(image: .init("face7", color: .black, layers: [.init(color: .orange)]))
    static let face8: PartModel = .init(image: .init("face8", color: .black, layers: [.init(color: .orange), .init(color: .white)]))
    static let face9: PartModel = .init(image: .init("face9", color: .black, layers: [.init(color: .orange), .init(color: .white)]))
}

#Preview {
    PartList(parts: .faces) { _ in }
}
