import SwiftUI

struct PartLayerEditor: View {
    @Bindable var part: PartModel
    
    var body: some View {
        List {
            Section {
                Part(part: part)
                    .frame(width: 200, height: 200)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            if let image = part.image {
                @Bindable var image = image
                    
                Section {
                    ColorPicker("Base Color", selection: $image.color)
                }
                    
                ForEach($image.layers.filter { $0.wrappedValue.color != nil }.enumerated(), id: \.element.id) { index, $layer in
                    if let bindedColor = Binding($layer.color) {
                        ColorPicker("Sub-Color \(index + 1)", selection: bindedColor)
                    }
                }
            } else if let shape = part.shape {
                @Bindable var shape = shape
                
                ColorPicker("Color", selection: $shape.color)
            }
        }
        .navigationTitle("Layer Editor")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button("Reset") {
                    if let image = part.image {
                        part.image?.color = image.originalColor
                        part.image?.layers = image.layers.map { .init(number: $0.number, color: $0.originalColor) }
                    } else if let shape = part.shape {
                        part.shape?.color = shape.originalColor
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PartLayerEditor(part: .hat2)
    }
}
