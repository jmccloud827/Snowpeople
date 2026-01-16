import SwiftUI

@MainActor extension [PartModel] {
    static let shapes: [PartModel] = [.circle, .rectangle]
}

@MainActor extension PartModel {
    static let circle: PartModel = .init(shape: .init(type: .circle, color: .snow))
    static let rectangle: PartModel = .init(shape: .init(type: .rectangle, color: .snow))
}
