import SwiftData
import SwiftUI

@Model final class SnowpersonModel: Codable {
    var name = "Snowperson"
    var createdDate = Date.now
    var background = Background.originalDay
    private var persistedParts: [PartModel] = []
    
    @Transient var parts: [PartModel] {
        get {
            persistedParts
        }
        set {
            for (index, part) in newValue.enumerated() {
                part.zIndex = index
            }
            persistedParts = newValue
        }
    }
    
    init() {}
    
    init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: Self.CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.createdDate = try container.decode(Date.self, forKey: .createdDate)
        self.background = try container.decode(Background.self, forKey: .background)
        self.persistedParts = try container.decode([PartModel].self, forKey: .persistedParts)
    }
    
    func duplicatePart(_ part: PartModel) -> PartModel {
        let copy = PartModel(partToCopy: part)
        copy.offset = .zero
        parts.append(copy)
        
        return copy
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(createdDate, forKey: .createdDate)
        try container.encode(background, forKey: .background)
        try container.encode(persistedParts, forKey: .persistedParts)
    }
    
    enum Background: String, Codable, CaseIterable {
        case originalDay = "Original (Day)"
        case originalNight = "Original (Night)"
    }
    
    enum CodingKeys: CodingKey {
        case name
        case createdDate
        case background
        case persistedParts
    }
}
