import SwiftData
import SwiftUI

struct Snowperson: View {
    @Bindable var snowperson: SnowpersonModel
    var canEdit = true
    
    @State private var idOfPartBeingEdited: ObjectIdentifier? = nil
    @State private var showNewLayerSheet = false
    @State private var showSettingsSheet = false
    @State private var undoActions: [[PartModel]] = []
    @State private var redoActions: [[PartModel]] = []
    
    var body: some View {
        ZStack {
            background
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            Circle()
                .foregroundStyle(.clear)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            ForEach(snowperson.parts, id: \.id) { part in
                PartEditor(part: part, idOfPartBeingEdited: $idOfPartBeingEdited) {
                    addUndoAction()
                }
            }
            
            Rectangle()
                .foregroundStyle(.snow)
                .frame(height: 100)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .bottom)
                .zIndex(.infinity)
        }
        .navigationTitle(snowperson.name)
        .navigationBarTitleDisplayMode(.inline)
        .environment(snowperson)
        .toolbar {
            if canEdit {
                ToolbarSpacer(.flexible, placement: .bottomBar)
                
                ToolbarItem(placement: .bottomBar) {
                    Button("Add", systemImage: "plus") {
                        showNewLayerSheet = true
                    }
                }
                
                ToolbarItem {
                    Button("Undo", systemImage: "arrow.uturn.backward") {
                        if let lastActionParts = undoActions.popLast() {
                            redoActions.append(snowperson.parts)
                            snowperson.parts = lastActionParts
                        }
                    }
                    .disabled(undoActions.isEmpty)
                }
                
                ToolbarItem {
                    Button("Redo", systemImage: "arrow.uturn.forward") {
                        if let lastActionParts = redoActions.popLast() {
                            undoActions.append(snowperson.parts)
                            snowperson.parts = lastActionParts
                        }
                    }
                    .disabled(redoActions.isEmpty)
                }
                
                ToolbarSpacer(.fixed)
                
                ToolbarItem {
                    Button("Settings", systemImage: "gearshape") {
                        showSettingsSheet = true
                    }
                }
            }
        }
        .sheet(isPresented: $showSettingsSheet) {
            settingsSheet
        }
        .fullScreenCover(isPresented: $showNewLayerSheet) {
            newLayerSheet
        }
        .disabled(!canEdit)
    }
    
    @ViewBuilder private var background: some View {
        switch snowperson.background {
        case .originalDay:
            OriginalBackground(isNight: false)
            
        case .originalNight:
            OriginalBackground(isNight: true)
        }
    }
    
    private var settingsSheet: some View {
        NavigationStack {
            List {
                Section("Name") {
                    TextField("Name", text: $snowperson.name)
                }
                
                Section {
                    Picker("Background", selection: $snowperson.background) {
                        ForEach(SnowpersonModel.Background.allCases, id: \.self) { background in
                            Text(background.rawValue)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    private var newLayerSheet: some View {
        NavigationStack {
            PartSelector { selectedPart in
                addUndoAction()
                snowperson.parts.append(selectedPart)
                    
                showNewLayerSheet = false
            }
            .navigationTitle("New Layer")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .close) {
                        showNewLayerSheet = false
                    }
                }
            }
        }
    }
    
    private func addUndoAction() {
        redoActions = []
        undoActions.append(snowperson.parts.map { .init(partToCopy: $0) })
    }
}

#Preview {
    NavigationStack {
        Snowperson(snowperson: .dani)
    }
}
