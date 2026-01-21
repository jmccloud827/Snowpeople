import SwiftUI
import SwiftData

@Model final class ImageLayerModel {
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
}

nonisolated struct ImageLayerData {
    let color: Color?
    
    init(color: Color? = nil) {
        self.color = color
    }
}
