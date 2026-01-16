import SwiftUI

@MainActor extension [PartModel] {
    static let eyes: [PartModel] = [.eyes1, .eyes2, .eyes3, .eyes4, .eyes5, .eyes6, .eyes7, .eyes8, .eyes9]
}

@MainActor extension PartModel {
    static let eyes1: PartModel = .init(image: .init("eyes1", color: .black, layers: [.init(color: .white)]))
    static let eyes2: PartModel = .init(image: .init("eyes2", color: .black, layers: [.init(color: .white)]))
    static let eyes3: PartModel = .init(image: .init("eyes3", color: .black, layers: [.init(color: .white)]))
    static let eyes4: PartModel = .init(image: .init("eyes4", color: .black, layers: [.init(color: .green)]))
    static let eyes5: PartModel = .init(image: .init("eyes5", color: .black, layers: []))
    static let eyes6: PartModel = .init(image: .init("eyes6", color: .black, layers: []))
    static let eyes7: PartModel = .init(image: .init("eyes7", color: .black, layers: []))
    static let eyes8: PartModel = .init(image: .init("eyes8", color: .black, layers: [.init(color: .brown)]))
    static let eyes9: PartModel = .init(image: .init("eyes9", color: .black, layers: [.init(color: .blue)]))
}

#Preview {
    PartList(parts: .eyes) { _ in }
}
