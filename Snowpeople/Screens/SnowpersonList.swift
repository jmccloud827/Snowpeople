import SwiftData
import SwiftUI

struct SnowpersonList: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \SnowpersonModel.createdDate, order: .reverse) private var snowpeople: [SnowpersonModel]
    
    @State private var isShowingInfoSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(snowpeople, id: \.id) { snowperson in
                    NavigationLink(snowperson.name) {
                        Snowperson(snowperson: snowperson)
                    }
                    .swipeActions {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            modelContext.delete(snowperson)
                        }
                    }
                }
            }
            .navigationTitle("Snowpeople")
            .toolbar {
                ToolbarItem {
                    Button("Add", systemImage: "plus") {
                        modelContext.insert(SnowpersonModel())
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Info", systemImage: "info.circle") {
                        isShowingInfoSheet = true
                    }
                }
            }
            .fullScreenCover(isPresented: $isShowingInfoSheet) {
                infoSheet
            }
        }
    }
    
    private var infoSheet: some View {
        NavigationStack {
            List {
                Section("My friend's and family's snowpeople") {
                    ForEach(SnowpersonModel.samples, id: \.id) { snowperson in
                        NavigationLink(snowperson.name) {
                            Snowperson(snowperson: snowperson, canEdit: false)
                        }
                    }
                }
            }
            .navigationTitle("Info")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .close) {
                        isShowingInfoSheet = false
                    }
                }
            }
        }
    }
}

#Preview {
    SnowpersonList()
        .modelContainer(App.previewContainer)
}
