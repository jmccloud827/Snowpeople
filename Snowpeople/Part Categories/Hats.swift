import SwiftUI

@MainActor extension [PartModel] {
    static let hats: [PartModel] = [.hat1, .hat2, .hat3, .hat4, .hat5, .hat6, .hat7, .hat8, .hat9, .hat10, .hat11]
}

@MainActor extension PartModel {
    static let hat1: PartModel = .init(image: .init("hat1", color: .black, layers: [.init(color: .red)]))
    static let hat2: PartModel = .init(image: .init("hat2", color: .black, layers: [.init(), .init(color: .red)]))
    static let hat3: PartModel = .init(image: .init("hat3", color: .black, layers: []))
    static let hat4: PartModel = .init(image: .init("hat4", color: .black, layers: [.init(color: .white), .init(color: .indigo)]))
    static let hat5: PartModel = .init(image: .init("hat5", color: .black, layers: [.init(color: .blue), .init(color: .red)]))
    static let hat6: PartModel = .init(image: .init("hat6", color: .black, layers: [.init(color: .white), .init(color: .green), .init(color: .red)]))
    static let hat7: PartModel = .init(image: .init("hat7", color: .black, layers: [.init(color: .mint), .init(color: .green)]))
    static let hat8: PartModel = .init(image: .init("hat8", color: .black, layers: [.init(color: .red)]))
    static let hat9: PartModel = .init(image: .init("hat9", color: .black, layers: [.init(color: .gray), .init(color: .red)]))
    static let hat10: PartModel = .init(image: .init("hat10", color: .black, layers: [.init(color: .teal)]))
    static let hat11: PartModel = .init(image: .init("hat11", color: .black, layers: [.init(color: .white), .init(color: .green)]))
}

#Preview {
    PartList(parts: .hats) { _ in }
}
