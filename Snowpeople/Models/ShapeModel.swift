import SwiftUI
import SwiftData

@Model final class ShapeModel: Codable {
    var type: Kind
    private var persistedColor: PersistableColor
    private var originalPersistedColor: PersistableColor
    
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
    
    init(type: Kind, color: Color) {
        self.type = type
        self.persistedColor = .init(color: color)
        self.originalPersistedColor = .init(color: color)
    }
    
    init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: Self.CodingKeys.self)
        self.type = try container.decode(Kind.self, forKey: .type)
        self.persistedColor = try container.decode(PersistableColor.self, forKey: .persistedColor)
        self.originalPersistedColor = try container.decode(PersistableColor.self, forKey: .originalPersistedColor)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(persistedColor, forKey: .persistedColor)
        try container.encode(originalPersistedColor, forKey: .originalPersistedColor)
    }
    
    enum Kind: Codable {
        case circle
        case rectangle
    }
    
    enum CodingKeys: CodingKey {
        case type
        case persistedColor
        case originalPersistedColor
    }
}
