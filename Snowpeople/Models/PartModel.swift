import SwiftUI
import SwiftData

@Model final class PartModel: Codable {
    var image: ImageModel?
    var shape: ShapeModel?
    private var width: Double = 100
    private var height: Double = 100
    private var xOffset: Double = 0
    private var yOffset: Double = 0
    var persistedRotation = Angle.degrees(0)
    var isFlippedOnYAxis = false
    var zIndex: Int = 0
    
    @Transient var size: CGSize {
        get {
            .init(width: width, height: height)
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }
    
    @Transient var offset: CGSize {
        get {
            .init(width: xOffset, height: yOffset)
        }
        set {
            xOffset = newValue.width
            yOffset = newValue.height
        }
    }
    
    @Transient var rotation: Angle {
        get {
            persistedRotation
        }
        set {
            if newValue == .degrees(.nan) {
                persistedRotation = .degrees(0)
            } else {
                persistedRotation = newValue
            }
        }
    }
    
    init(image: ImageModel) {
        self.image = image
        self.shape = nil
    }
    
    init(shape: ShapeModel) {
        self.image = nil
        self.shape = shape
    }
    
    init(partToCopy: PartModel) {
        if let image = partToCopy.image {
            self.image = .init(image.resourceName, color: image.color, layers: image.layers.map { .init(color: $0.color) })
        }
        
        if let shape = partToCopy.shape {
            self.shape = .init(type: shape.type, color: shape.color)
        }
        
        self.width = partToCopy.width
        self.height = partToCopy.height
        self.xOffset = partToCopy.xOffset
        self.yOffset = partToCopy.yOffset
        self.rotation = partToCopy.rotation
        self.isFlippedOnYAxis = partToCopy.isFlippedOnYAxis
        self.zIndex = partToCopy.zIndex
    }
    
    init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: Self.CodingKeys.self)
        self.image = try container.decode(ImageModel.self, forKey: .image)
        self.shape = try container.decode(ShapeModel.self, forKey: .shape)
        self.width = try container.decode(Double.self, forKey: .width)
        self.height = try container.decode(Double.self, forKey: .height)
        self.xOffset = try container.decode(Double.self, forKey: .xOffset)
        self.yOffset = try container.decode(Double.self, forKey: .yOffset)
        self.persistedRotation = try container.decode(Angle.self, forKey: .persistedRotation)
        self.isFlippedOnYAxis = try container.decode(Bool.self, forKey: .isFlippedOnYAxis)
        self.zIndex = try container.decode(Int.self, forKey: .zIndex)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(image, forKey: .image)
        try container.encode(shape, forKey: .shape)
        try container.encode(width, forKey: .width)
        try container.encode(height, forKey: .height)
        try container.encode(xOffset, forKey: .xOffset)
        try container.encode(yOffset, forKey: .yOffset)
        try container.encode(persistedRotation, forKey: .persistedRotation)
        try container.encode(isFlippedOnYAxis, forKey: .isFlippedOnYAxis)
        try container.encode(zIndex, forKey: .zIndex)
    }
    
    enum CodingKeys: CodingKey {
        case image
        case shape
        case width
        case height
        case xOffset
        case yOffset
        case persistedRotation
        case isFlippedOnYAxis
        case zIndex
    }
}
