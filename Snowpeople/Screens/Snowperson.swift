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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay {
                    ZStack {
                        ForEach(snowperson.parts, id: \.id) { part in
                            PartEditor(part: part, idOfPartBeingEdited: $idOfPartBeingEdited) {
                                addUndoAction()
                            }
                        }
                    }
                }
            
            Rectangle()
                .foregroundStyle(.snow)
                .frame(height: 100)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .zIndex(.infinity)
        }
        .ignoresSafeArea()
        .navigationTitle(snowperson.name)
        .navigationBarTitleDisplayMode(.inline)
        .environment(snowperson)
        .toolbar {
            if canEdit {
                if let idOfPartBeingEdited {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button("Move Back", systemImage: "arrowshape.turn.up.backward.fill") {
                            snowperson.movePartBackwardByID(idOfPartBeingEdited)
                        }
                        .disabled(!snowperson.getCanMovePartBackwardByID(idOfPartBeingEdited))
                        
                        Button("Move Forward", systemImage: "arrowshape.turn.up.forward.fill") {
                            snowperson.movePartForwardByID(idOfPartBeingEdited)
                        }
                        .disabled(!snowperson.getCanMovePartForwardByID(idOfPartBeingEdited))
                    }
                    
                    ToolbarSpacer(.fixed, placement: .bottomBar)
                    
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button("Duplicate", systemImage: "plus.square.on.square.fill") {
                            addUndoAction()
                            self.idOfPartBeingEdited = nil
                            guard let part = snowperson.getPartById(idOfPartBeingEdited) else {
                                return
                            }
                            
                            let copiedPart = snowperson.duplicatePart(part)
                            self.idOfPartBeingEdited = copiedPart.id
                        }
                        
                        Button("Flip Vertically", systemImage: "arrow.trianglehead.left.and.right.righttriangle.left.righttriangle.right.fill") {
                            addUndoAction()
                            guard let part = snowperson.getPartById(idOfPartBeingEdited) else {
                                return
                            }
                            
                            part.isFlippedOnYAxis.toggle()
                        }
                    }
                }
                
                ToolbarSpacer(.flexible, placement: .bottomBar)
                
                ToolbarItem(placement: .bottomBar) {
                    Button("Add", systemImage: "plus") {
                        showNewLayerSheet = true
                    }
                    .buttonStyle(.glassProminent)
                }
                
                ToolbarItem {
                    Button("Undo", systemImage: "arrow.uturn.backward") {
                        self.idOfPartBeingEdited = nil
                        if let lastActionParts = undoActions.popLast() {
                            redoActions.append(snowperson.parts)
                            snowperson.parts = lastActionParts
                        }
                    }
                    .disabled(undoActions.isEmpty)
                }
                
                ToolbarItem {
                    Button("Redo", systemImage: "arrow.uturn.forward") {
                        self.idOfPartBeingEdited = nil
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
