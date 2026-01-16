import SwiftUI

struct PartList: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let parts: [PartModel]
    let onDoneEditing: (PartModel) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [.init(), .init()]) {
                ForEach(parts, id: \.id) { part in
                    NavigationLink {
                        let part = PartModel(partToCopy: part)
                        PartLayerEditor(part: part)
                            .toolbar {
                                ToolbarItem(placement: .confirmationAction) {
                                    Button(role: .confirm) {
                                        onDoneEditing(part)
                                    }
                                }
                            }
                    } label: {
                        Part(part: part)
                            .frame(width: 75, height: 75)
                            .padding(part.shape == nil ? 10 : 20)
                            .background {
                                if colorScheme == .dark {
                                    Color(.systemGray5)
                                }
                                
                                Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    .foregroundStyle(.foreground)
                            }
                        .glassEffect(.clear.interactive(), in: Rectangle())
                    }
                }
            }
            .scrollTargetLayout()
            .padding()
            .background {
                WavySquareBorder()
                    .stroke(.foreground, lineWidth: 2)
                    .padding(5)
            }
        }
        .scrollTargetBehavior(.paging)
        .safeAreaPadding(.horizontal, 20)
    }
}

#Preview {
    NavigationStack {
        ScrollView {
            PartList(parts: .arms) { _ in }
        }
    }
}
