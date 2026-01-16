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
                            
                            flipOnYAxisButton
                            
                            duplicateButton
                            
                            widthButton
                            
                            heightButton
                            
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
        Image(systemName: "trash")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.vertical, 2)
            .frame(width: buttonSize, height: buttonSize)
            .frame(width: buttonSize * 1.75, height: buttonSize * 1.25)
            .onTapGesture {
                onWillUpdate()
                idOfPartBeingEdited = nil
                snowperson.parts.removeAll { $0.id == part.id }
            }
            .background {
                RoundedRectangle(cornerSize: .init(width: 15, height: 15))
                    .foregroundStyle(Color(.systemGray5))
                    .colorScheme(.light)
            }
            .offset(x: -buttonSize * 1.75, y: -buttonSize)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    private var flipOnYAxisButton: some View {
        Image(systemName: "arrow.trianglehead.left.and.right.righttriangle.left.righttriangle.right")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.vertical, 2)
            .frame(width: buttonSize, height: buttonSize)
            .frame(width: buttonSize * 1.75, height: buttonSize * 1.25)
            .onTapGesture {
                onWillUpdate()
                part.isFlippedOnYAxis.toggle()
            }
            .background {
                RoundedRectangle(cornerSize: .init(width: 15, height: 15))
                    .foregroundStyle(Color(.systemGray5))
                    .colorScheme(.light)
            }
            .offset(x: -buttonSize * 1.75, y: buttonSize)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
    }
    
    private var duplicateButton: some View {
        Image(systemName: "plus.square.on.square")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.vertical, 2)
            .frame(width: buttonSize, height: buttonSize)
            .frame(width: buttonSize * 1.75, height: buttonSize * 1.25)
            .onTapGesture {
                idOfPartBeingEdited = nil
                let copiedPart = snowperson.duplicatePart(part)
                idOfPartBeingEdited = copiedPart.id
            }
            .background {
                RoundedRectangle(cornerSize: .init(width: 15, height: 15))
                    .foregroundStyle(Color(.systemGray5))
                    .colorScheme(.light)
            }
            .offset(x: -buttonSize * 1.75)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
    
    private var widthButton: some View {
        Image(systemName: "circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .background(.white)
            .clipShape(Circle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        currentSize.width = max(minimumSize, currentSize.width + gesture.translation.width)
                    }
                    .onEnded { _ in
                        onWillUpdate()
                        part.size.width = currentSize.width
                    }
            )
            .frame(width: buttonSize, height: buttonSize)
            .offset(x: buttonSize / 2)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
    }
    
    private var heightButton: some View {
        Image(systemName: "circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .background(.white)
            .clipShape(Circle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        currentSize.height = max(minimumSize, currentSize.height - gesture.translation.height)
                    }
                    .onEnded { _ in
                        onWillUpdate()
                        part.size.height = currentSize.height
                    }
            )
            .frame(width: buttonSize, height: buttonSize)
            .offset(y: -buttonSize / 2)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    private var scaleButton: some View {
        Image(systemName: "arrow.up.left.and.arrow.down.right")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        let maxTranslation = max(gesture.translation.width, gesture.translation.height)
                        let newWidth = currentSize.width + maxTranslation
                        let newHeight = currentSize.height + maxTranslation
                        guard newWidth > minimumSize && newHeight > minimumSize else {
                            return
                        }
                        
                        currentSize.width = newWidth
                        currentSize.height = newHeight
                    }
                    .onEnded { _ in
                        onWillUpdate()
                        part.size = currentSize
                    }
            )
            .padding(.vertical, 2)
            .frame(width: buttonSize, height: buttonSize)
            .frame(width: buttonSize * 1.75, height: buttonSize * 1.25)
            .background {
                RoundedRectangle(cornerSize: .init(width: 15, height: 15))
                    .foregroundStyle(Color(.systemGray5))
                    .colorScheme(.light)
            }
            .offset(x: buttonSize * 1.75, y: buttonSize)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
    
    private var rotateButton: some View {
        Image(systemName: "arrow.trianglehead.counterclockwise.rotate.90")
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
            .offset(x: buttonSize * 1.75, y: -buttonSize)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .rotationEffect(currentRotation)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        let currentAngle = atan2(gesture.location.x, gesture.location.y)
                        let startAngle = atan2(gesture.startLocation.x, gesture.startLocation.y)
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
                        currentRotation = part.rotation + gesture.rotation
                    }
                    .onEnded { _ in
                        onWillUpdate()
                        part.rotation = currentRotation
                    }
            )
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
