import SwiftUI
import SwiftData

@Model final class ShapeModel {
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
    
    enum Kind: Codable {
        case circle
        case rectangle
    }
}
