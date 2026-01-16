import SwiftUI

struct SnowRectangle: View {
    @State private var width = 0.0
    
    var body: some View {
        WavySquareBorder(frequency: 10)
            .background {
                WavySquareBorder()
                    .stroke(lineWidth: pow(width, 1 / 2) * 0.3)
                    .foregroundStyle(.black)
            }
            .onGeometryChange(for: Double.self) { proxy in
                proxy.size.width
            } action: { newValue in
                width = newValue
            }
    }
}

struct WavySquareBorder: Shape {
    var amplitude: Double = 1.0
    var frequency: Double = 20.0

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: .zero)

        for width in stride(from: 0, through: rect.width, by: 1) {
            let wavyRadius = sin(width / rect.width * frequency) * amplitude
            
            let x = width
            let y = 0.0 + wavyRadius

            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        for height in stride(from: 0, through: rect.height, by: 1) {
            let wavyRadius = sin(height / rect.height * frequency) * amplitude
            
            let x = rect.width + wavyRadius
            let y = height

            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        for width in stride(from: rect.width, through: 0, by: -1) {
            let wavyRadius = sin(width / rect.width * frequency) * amplitude
            
            let x = width
            let y = rect.height + wavyRadius

            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        for height in stride(from: rect.height, through: 0, by: -1) {
            let wavyRadius = sin(height / rect.height * frequency) * amplitude
            
            let x = 0.0 + wavyRadius
            let y = height

            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.closeSubpath()
        return path
    }
}

#Preview {
    SnowRectangle()
        .padding()
        .foregroundStyle(.snow)
        .background(.blue)
}
