import SwiftUI

@MainActor extension [PartModel] {
    static let mouths: [PartModel] = [.mouth1, .mouth2, .mouth3, .mouth4, .mouth5, .mouth6, .mouth7, .mouth8, .mouth9]
}

@MainActor extension PartModel {
    static let mouth1: PartModel = .init(image: .init("mouth1", color: .black, layers: []))
    static let mouth2: PartModel = .init(image: .init("mouth2", color: .black, layers: []))
    static let mouth3: PartModel = .init(image: .init("mouth3", color: .black, layers: []))
    static let mouth4: PartModel = .init(image: .init("mouth4", color: .black, layers: []))
    static let mouth5: PartModel = .init(image: .init("mouth5", color: .black, layers: []))
    static let mouth6: PartModel = .init(image: .init("mouth6", color: .black, layers: []))
    static let mouth7: PartModel = .init(image: .init("mouth7", color: .black, layers: []))
    static let mouth8: PartModel = .init(image: .init("mouth8", color: .black, layers: []))
    static let mouth9: PartModel = .init(image: .init("mouth9", color: .black, layers: []))
}

#Preview {
    PartList(parts: .mouths) { _ in }
}
