import SwiftUI

struct PartSelector: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let onSelection: (PartModel) -> Void
    
    static let partCategories: [(name: String, parts: [PartModel])] = [
        ("Shapes", .shapes),
        ("Arms", .arms),
        ("Faces", .faces),
        ("Hats", .hats),
        ("Mittens", .mittens),
        ("Neckwear", .neckwear),
        ("Buttons", .buttons),
        ("Accessories", .accessories),
        ("Eyes", .eyes),
        ("Noses", .noses),
        ("Mouths", .mouths)
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                ForEach(Self.partCategories, id: \.name) { category in
                    Section {
                        PartList(parts: category.parts) { part in
                            onSelection(part)
                        }
                    } header: {
                        Text(category.name)
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PartSelector { _ in
        }
    }
}
