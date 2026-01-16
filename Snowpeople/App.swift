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
        
        container.mainContext.insert(SnowpersonModel.dani)
        container.mainContext.insert(SnowpersonModel.brooke)
        container.mainContext.insert(SnowpersonModel.chase)
        
        return container
    }
}

// TODO
// Snow Triangle
// Snow Rounded Rectangle
// Snow Ellipse
// Move forward and back buttons
// Creator information
// More backgrounds
// Refactor background to work for any size
// Make rotation gesture rotate around center
// Make Snowperson list look better
// Scale button is not keeping aspect ratio
