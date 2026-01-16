import SwiftUI

nonisolated struct PersistableColor: Codable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
    
    init(color: Color) {
        let uiColor = UIColor(color)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
    
    init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer = try decoder.container(keyedBy: Self.CodingKeys.self)
        self.red = try container.decode(Double.self, forKey: .red)
        self.green = try container.decode(Double.self, forKey: .green)
        self.blue = try container.decode(Double.self, forKey: .blue)
        self.alpha = try container.decode(Double.self, forKey: .alpha)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(red, forKey: .red)
        try container.encode(green, forKey: .green)
        try container.encode(blue, forKey: .blue)
        try container.encode(alpha, forKey: .alpha)
    }
    
    func toColor() -> Color {
        .init(red: red, green: green, blue: blue, opacity: alpha)
    }
    
    enum CodingKeys: CodingKey {
        case red
        case green
        case blue
        case alpha
    }
}
