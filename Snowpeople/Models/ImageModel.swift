import SwiftUI
import SwiftData

@Model final class ImageModel: Codable {
    var resourceName: String
    private var persistedColor: PersistableColor
    private var originalPersistedColor: PersistableColor
    var layers: [ImageLayerModel]
    @Transient var topLayer: String {
        resourceName + "-0"
    }
    
    @Transient var color: Color {
        get {
            persistedColor.toColor()
        }
        set {
            persistedColor = .init(color: newValue)
        }
    }
    
    @Transient var originalColor: Color {
        get {
            originalPersistedColor.toColor()
        }
        set {
            originalPersistedColor = .init(color: newValue)
        }
    }
    
    @Transient var aspectRatio: Double {
        guard let uiImage = UIImage(named: topLayer) else {
            return 1
        }
        
        return uiImage.size.width / uiImage.size.height
    }
    
    init(_ resourceName: String, color: Color, layers: [ImageLayerData]) {
        self.resourceName = resourceName
        self.persistedColor = .init(color: color)
        self.originalPersistedColor = .init(color: color)
        self.layers = layers.enumerated().map { index, layer in
                .init(number: index + 1, data: layer)
        }
    }
    
    init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: Self.CodingKeys.self)
        self.resourceName = try container.decode(String.self, forKey: .resourceName)
        self.persistedColor = try container.decode(PersistableColor.self, forKey: .persistedColor)
        self.originalPersistedColor = try container.decode(PersistableColor.self, forKey: .originalPersistedColor)
        self.layers = try container.decode([ImageLayerModel].self, forKey: .layers)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(resourceName, forKey: .resourceName)
        try container.encode(persistedColor, forKey: .persistedColor)
        try container.encode(originalPersistedColor, forKey: .originalPersistedColor)
        try container.encode(layers, forKey: .layers)
    }
    
    enum CodingKeys: CodingKey {
        case resourceName
        case persistedColor
        case originalPersistedColor
        case layers
    }
}
