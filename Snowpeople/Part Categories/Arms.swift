import SwiftUI

@MainActor extension [PartModel] {
    static let arms: [PartModel] = [.arm1, .arm2, .arm3, .arm4, .arm5, .arm6, .arm7, .arm8, .arm9]
}

@MainActor extension PartModel {
    static let arm1: PartModel = .init(image: .init("arm1", color: .black, layers: [.init(color: .brown)]))
    static let arm2: PartModel = .init(image: .init("arm2", color: .brown, layers: []))
    static let arm3: PartModel = .init(image: .init("arm3", color: .brown, layers: []))
    static let arm4: PartModel = .init(image: .init("arm4", color: .brown, layers: []))
    static let arm5: PartModel = .init(image: .init("arm5", color: .brown, layers: []))
    static let arm6: PartModel = .init(image: .init("arm6", color: .brown, layers: []))
    static let arm7: PartModel = .init(image: .init("arm7", color: .brown, layers: []))
    static let arm8: PartModel = .init(image: .init("arm8", color: .brown, layers: []))
    static let arm9: PartModel = .init(image: .init("arm9", color: .brown, layers: []))
}

#Preview {
    PartList(parts: .arms) { _ in }
}
