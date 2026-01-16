import SwiftUI

@MainActor extension [PartModel] {
    static let neckwear: [PartModel] = [.neckwear1, .neckwear2, .neckwear3, .neckwear4, .neckwear5, .neckwear6, .neckwear7, .neckwear8, .neckwear9]
}

@MainActor extension PartModel {
    static let neckwear1: PartModel = .init(image: .init("neckwear1", color: .black, layers: [.init(color: .red), .init(color: .blue)]))
    static let neckwear2: PartModel = .init(image: .init("neckwear2", color: .black, layers: [.init(color: .red)]))
    static let neckwear3: PartModel = .init(image: .init("neckwear3", color: .black, layers: []))
    static let neckwear4: PartModel = .init(image: .init("neckwear4", color: .orange, layers: []))
    static let neckwear5: PartModel = .init(image: .init("neckwear5", color: .black, layers: [.init(color: .white), .init(color: .green)]))
    static let neckwear6: PartModel = .init(image: .init("neckwear6", color: .black, layers: [.init(color: .red)]))
    static let neckwear7: PartModel = .init(image: .init("neckwear7", color: .black, layers: []))
    static let neckwear8: PartModel = .init(image: .init("neckwear8", color: .black, layers: [.init(color: .red), .init(color: .gray)]))
    static let neckwear9: PartModel = .init(image: .init("neckwear9", color: .green, layers: []))
}

#Preview {
    PartList(parts: .neckwear) { _ in }
}
