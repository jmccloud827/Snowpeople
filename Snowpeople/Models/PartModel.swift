import SwiftUI
import SwiftData

@Model final class PartModel {
    var image: ImageModel?
    var shape: ShapeModel?
    private var width: Double = 100
    private var height: Double = 100
    private var xOffset: Double = 0
    private var yOffset: Double = 0
    var rotation = Angle.degrees(0)
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
}
