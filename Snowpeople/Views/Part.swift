import SwiftUI

struct Part: View {
    let part: PartModel
    
    var body: some View {
        if let image = part.image {
            SwiftUI.Image(image.topLayer)
                .resizable()
                .renderingMode(.template)
                .interpolation(.none)
                .foregroundStyle(image.color)
                .background {
                    ZStack {
                        ForEach(image.layers, id: \.number) { layer in
                            SwiftUI.Image(image.resourceName + "-\(layer.number)")
                                .resizable()
                                .renderingMode(layer.color == nil ? .original : .template)
                                .interpolation(.none)
                                .foregroundStyle(layer.color ?? .black)
                                .zIndex(-Double(layer.number))
                        }
                    }
                }
        } else if let shape = part.shape {
            Group {
                switch shape.type {
                case .circle:
                    Snowball()
                    
                case .rectangle:
                    SnowRectangle()
                }
            }
            .foregroundStyle(shape.color)
        }
    }
}

#Preview {
    let hat2 = PartModel.hat2
    let hat4 = PartModel.hat4
    
    let snowball = PartModel.circle
    snowball.size.width = 200
    snowball.size.height = 200
    
    return ZStack {
        Part(part: hat4)
        
        Part(part: hat2)
        
        Part(part: snowball)
    }
}
