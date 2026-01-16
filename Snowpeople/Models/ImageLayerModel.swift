import SwiftUI
import SwiftData

@Model final class ImageLayerModel: Codable {
    var number: Int
    private var persistedColor: PersistableColor?
    private var originalPersistedColor: PersistableColor?
    
    @Transient var color: Color? {
        get {
            persistedColor?.toColor()
        }
        set {
            if let newValue {
                persistedColor = .init(color: newValue)
            } else {
                persistedColor = nil
            }
        }
    }
    
    @Transient var originalColor: Color? {
        get {
            originalPersistedColor?.toColor()
        }
        set {
            if let newValue {
                originalPersistedColor = .init(color: newValue)
            } else {
                originalPersistedColor = nil
            }
        }
    }
    
    init(number: Int, color: Color? = nil) {
        self.number = number
        if let color {
            self.persistedColor = .init(color: color)
            self.originalPersistedColor = .init(color: color)
        }
    }
    
    convenience init(number: Int, data: ImageLayerData) {
        self.init(number: number, color: data.color)
    }
    
    init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: Self.CodingKeys.self)
        self.number = try container.decode(Int.self, forKey: .number)
        self.persistedColor = try container.decode(PersistableColor.self, forKey: .persistedColor)
        self.originalPersistedColor = try container.decode(PersistableColor.self, forKey: .originalPersistedColor)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(number, forKey: .number)
        try container.encode(persistedColor, forKey: .persistedColor)
        try container.encode(originalPersistedColor, forKey: .originalPersistedColor)
    }
    
    enum CodingKeys: CodingKey {
        case number
        case persistedColor
        case originalPersistedColor
    }
}

nonisolated struct ImageLayerData {
    let color: Color?
    
    init(color: Color? = nil) {
        self.color = color
    }
}
