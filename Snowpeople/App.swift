import SwiftData
import SwiftUI

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            SnowpersonList()
        }
        .modelContainer(for: [
            SnowpersonModel.self,
            PartModel.self,
            ImageModel.self,
            ImageLayerModel.self,
            ShapeModel.self
        ])
    }
    
    static var previewContainer: ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: SnowpersonModel.self,
                                            PartModel.self,
                                            ImageModel.self,
                                            ImageLayerModel.self,
                                            ShapeModel.self,
                                            configurations: config)
        
        SnowpersonModel.samples.forEach { container.mainContext.insert($0) }
        
        return container
    }
}

// TODO
// Snow Triangle
// Snow Rounded Rectangle
// Snow Ellipse
// Creator information
// More backgrounds
// Refactor background to work for any size
// Make Snowperson list look better
// Haptic feedback
// Clean up part editor buttons

/// App Icon
#Preview {
    Image(systemName: "snow")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundStyle(.white)
            .frame(width: 250, height: 250)
        .padding()
        .padding()
        .padding(44)
        .background(.accent.gradient)
}
