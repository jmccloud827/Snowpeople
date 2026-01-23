import SwiftUI

struct PartEditor: View {
    @Environment(SnowpersonModel.self) private var snowperson
    
    @Bindable var part: PartModel
    @Binding var idOfPartBeingEdited: ObjectIdentifier?
    let onWillUpdate: () -> Void
    
    @State private var currentScale = 1.0
    @State private var currentRotation: Angle
    @State private var currentOffset: CGSize
    @State private var currentSize: CGSize
    @State private var showImageEditor = false
    
    let buttonSize = 20.0
    let minimumSize = 20.0
    
    init(part: PartModel, idOfPartBeingEdited: Binding<ObjectIdentifier?>, onWillUpdate: @escaping () -> Void) {
        self.part = part
        _idOfPartBeingEdited = idOfPartBeingEdited
        self.onWillUpdate = onWillUpdate
        self.currentRotation = part.rotation
        self.currentOffset = part.offset
        self.currentSize = part.size
    }
    
    var body: some View {
        Part(part: part)
            .scaleEffect(x: part.isFlippedOnYAxis ? -1 : 1)
            .rotationEffect(currentRotation)
            .offset(currentOffset)
            .gesture(focusAndMoveGesture)
            .gesture(magnifyAndRotateGesture)
            .frame(width: currentSize.width * currentScale, height: currentSize.height * currentScale)
            .zIndex(Double(part.zIndex))
            .disabled(idOfPartBeingEdited != nil && idOfPartBeingEdited != part.id)
            .sheet(isPresented: $showImageEditor) {
                NavigationStack {
                    PartLayerEditor(part: part)
                }
            }
        
        if idOfPartBeingEdited == part.id {
            Rectangle()
                .foregroundStyle(.white.opacity(0.001))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .gesture(focusAndMoveGesture)
                .gesture(magnifyAndRotateGesture)
                .zIndex(.infinity)
            
            Rectangle()
                .foregroundStyle(.white.opacity(0.001))
                .background {
                    if idOfPartBeingEdited == part.id {
                        ZStack {
                            Rectangle()
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                .foregroundColor(Color.black)
                            
                            deleteButton
                            
                            leftWidthButton
                            
                            rightWidthButton
                            
                            topHeightButton
                            
                            bottomHeightButton
                            
                            scaleButton
                        }
                        .foregroundStyle(.black)
                    }
                }
                .rotationEffect(currentRotation)
                .background {
                    if idOfPartBeingEdited == part.id {
                        rotateButton
                            .foregroundStyle(.black)
                    }
                }
                .offset(currentOffset)
                .gesture(focusAndMoveGesture)
                .gesture(magnifyAndRotateGesture)
                .frame(width: currentSize.width * currentScale, height: currentSize.height * currentScale)
                .zIndex(.infinity)
        }
    }
    
    private var deleteButton: some View {
        makeBorderButton(systemName: "trash",
                         alignment: .topLeading,
                         gesture: TapGesture()
                             .onEnded {
                                 onWillUpdate()
                                 idOfPartBeingEdited = nil
                                 snowperson.parts.removeAll { $0.id == part.id }
                             })
    }
    
    private var leftWidthButton: some View {
        makeCircleButton(alignment: .leading,
                         gesture: DragGesture(minimumDistance: 0)
                             .onChanged { gesture in
                                 currentSize.width = max(minimumSize, currentSize.width - gesture.translation.width)
                             }
                             .onEnded { _ in
                                 onWillUpdate()
                                 part.size.width = currentSize.width
                             })
    }
    
    private var rightWidthButton: some View {
        makeCircleButton(alignment: .trailing,
                         gesture: DragGesture(minimumDistance: 0)
                             .onChanged { gesture in
                                 currentSize.width = max(minimumSize, currentSize.width + gesture.translation.width)
                             }
                             .onEnded { _ in
                                 onWillUpdate()
                                 part.size.width = currentSize.width
                             })
    }
    
    private var topHeightButton: some View {
        makeCircleButton(alignment: .top,
                         gesture: DragGesture(minimumDistance: 0)
                             .onChanged { gesture in
                                 currentSize.height = max(minimumSize, currentSize.height - gesture.translation.height)
                             }
                             .onEnded { _ in
                                 onWillUpdate()
                                 part.size.height = currentSize.height
                             })
    }
    
    private var bottomHeightButton: some View {
        makeCircleButton(alignment: .bottom,
                         gesture: DragGesture(minimumDistance: 0)
                             .onChanged { gesture in
                                 currentSize.height = max(minimumSize, currentSize.height + gesture.translation.height)
                             }
                             .onEnded { _ in
                                 onWillUpdate()
                                 part.size.height = currentSize.height
                             })
    }
    
    private var scaleButton: some View {
        makeBorderButton(systemName: "arrow.up.left.and.arrow.down.right",
                         alignment: .bottomTrailing,
                         gesture: DragGesture(minimumDistance: 0)
                             .onChanged { gesture in
                                 let maxTranslation = max(gesture.translation.width, gesture.translation.height)
                    
                                 let magnification = 1 + maxTranslation / max(part.size.width, part.size.height)
                
                                 if currentSize.width * magnification < minimumSize || currentSize.height * magnification < minimumSize {
                                     return
                                 }
                    
                                 currentScale = magnification
                             }
                             .onEnded { _ in
                                 onWillUpdate()
                
                                 currentSize.width *= currentScale
                                 currentSize.height *= currentScale
                
                                 currentScale = 1
                                 part.size = currentSize
                             })
    }
    
    private var rotateButton: some View {
        let g: DragGesture? = nil
        return makeBorderButton(systemName: "arrow.trianglehead.counterclockwise.rotate.90",
                                alignment: .topTrailing,
                                gesture: g)
            .rotationEffect(currentRotation)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        let currentAngle = atan2(gesture.location.x - part.size.width / 2, gesture.location.y - part.size.height / 2)
                        let startAngle = atan2(gesture.startLocation.x - part.size.width / 2, gesture.startLocation.y - part.size.height / 2)
                        let theta = Angle(radians: startAngle - currentAngle) + part.rotation
                        currentRotation = .degrees(theta.degrees.truncatingRemainder(dividingBy: 360))
                    }
                    .onEnded { _ in
                        onWillUpdate()
                        part.rotation = currentRotation
                    }
            )
    }
    
    private var focusAndMoveGesture: some Gesture {
        TapGesture()
            .onEnded { _ in
                if idOfPartBeingEdited == part.id {
                    idOfPartBeingEdited = nil
                } else {
                    idOfPartBeingEdited = part.id
                }
            }
            .simultaneously(with:
                LongPressGesture()
                    .onEnded { value in
                        onWillUpdate()
                        showImageEditor = value
                    }
            )
            .simultaneously(with:
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        currentOffset.width = part.offset.width + gesture.translation.width
                        currentOffset.height = part.offset.height + gesture.translation.height
                    }
                    .onEnded { _ in
                        if currentOffset != part.offset {
                            onWillUpdate()
                        }
                        part.offset.width = currentOffset.width
                        part.offset.height = currentOffset.height
                    }
            )
    }
    
    private var magnifyAndRotateGesture: some Gesture {
        MagnifyGesture(minimumScaleDelta: 0)
            .onChanged { gesture in
                if currentSize.width * gesture.magnification < minimumSize || currentSize.height * gesture.magnification < minimumSize {
                    return
                }
                
                currentScale = gesture.magnification
            }
            .onEnded { gesture in
                onWillUpdate()
                currentScale = 1
                
                currentSize.width *= gesture.magnification
                currentSize.height *= gesture.magnification
                
                part.size = currentSize
            }
            .simultaneously(with:
                RotateGesture(minimumAngleDelta: .degrees(0))
                    .onChanged { gesture in
                        let newRotation = part.rotation + gesture.rotation
                        if newRotation.radians.isNaN {
                            return
                        }
                        
                        currentRotation = part.rotation + gesture.rotation
                    }
                    .onEnded { _ in
                        onWillUpdate()
                        part.rotation = currentRotation
                    }
            )
    }
    
    private func makeBorderButton(systemName: String, alignment: Alignment, gesture: (some Gesture)?) -> some View {
        Image(systemName: systemName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.vertical, 2)
            .frame(width: buttonSize, height: buttonSize)
            .frame(width: buttonSize * 1.75, height: buttonSize * 1.25)
            .background {
                RoundedRectangle(cornerSize: .init(width: 15, height: 15))
                    .foregroundStyle(Color(.systemGray5))
                    .colorScheme(.light)
            }
            .offset(getButtonOffsets(for: alignment))
            .gesture(gesture)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
    
    private func getButtonOffsets(for alignment: Alignment) -> CGSize {
        let width: Double =
            if [Alignment.topLeading, Alignment.leading, Alignment.bottomLeading].contains(alignment) {
                -buttonSize * 1.75
            } else if [Alignment.topTrailing, Alignment.trailing, Alignment.bottomTrailing].contains(alignment) {
                buttonSize * 1.75
            } else {
                0
            }
        
        let height: Double =
            if [Alignment.topLeading, Alignment.top, Alignment.topTrailing].contains(alignment) {
                -buttonSize
            } else if [Alignment.bottomLeading, Alignment.bottom, Alignment.bottomTrailing].contains(alignment) {
                buttonSize
            } else {
                0
            }
        
        return .init(width: width, height: height)
    }
    
    private func makeCircleButton(alignment: CircleButtonAlignment, gesture: some Gesture) -> some View {
        Image(systemName: "circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .background(.white)
            .clipShape(Circle())
            .frame(width: buttonSize, height: buttonSize)
            .offset(alignment.getOffset(buttonSize: buttonSize))
            .gesture(gesture)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment.asAlignment)
    }
    
    private enum CircleButtonAlignment {
        case top
        case bottom
        case leading
        case trailing
        
        var asAlignment: Alignment {
            switch self {
            case .top: return .top
            case .bottom: return .bottom
            case .leading: return .leading
            case .trailing: return .trailing
            }
        }
        
        func getOffset(buttonSize: Double) -> CGSize {
            switch self {
            case .top: return .init(width: 0, height: -buttonSize / 2)
            case .bottom: return .init(width: 0, height: buttonSize / 2)
            case .leading: return .init(width: -buttonSize / 2, height: 0)
            case .trailing: return .init(width: buttonSize / 2, height: 0)
            }
        }
    }
}

#Preview {
    @Previewable @State var idOfPartBeingEdited: ObjectIdentifier? = nil
    
    ZStack {
        ForEach(SnowpersonModel.dani.parts, id: \.id) { part in
            PartEditor(part: part, idOfPartBeingEdited: $idOfPartBeingEdited) {}
        }
    }
    .environment(SnowpersonModel.dani)
}
