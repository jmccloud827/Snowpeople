import SwiftUI
import SwiftData

@Model final class ImageModel {
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
}
