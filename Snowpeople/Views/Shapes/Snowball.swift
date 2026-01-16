import SwiftUI

struct Snowball: View {
    @State private var width = 0.0
    
    var body: some View {
        WavyCircleBorder(frequency: 5)
            .background {
                WavyCircleBorder()
                    .stroke(lineWidth: pow(width, 1/2) * 0.3)
                    .foregroundStyle(.black)
                    .rotationEffect(.degrees(width))
            }
            .onGeometryChange(for: Double.self) { proxy in
                proxy.size.width
            } action: { newValue in
                width = newValue
            }
    }
}

private struct WavyCircleBorder: Shape {
    var amplitude: Double = 1.0
    var frequency: Double = 10.0

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let baseRadius = min(rect.width, rect.height) / 2
        var path = Path()
        path.move(to: CGPoint(x: center.x + baseRadius, y: center.y))

        for angle in 0 ... 360 {
            let radians = Angle(degrees: Double(angle)).radians
            let computedRadius = baseRadius + sin(radians * frequency) * amplitude
            
            let x = center.x + cos(radians) * computedRadius
            let y = center.y + sin(radians) * computedRadius

            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.closeSubpath()
        return path
    }
}

#Preview {
    Snowball()
        .padding()
        .foregroundStyle(.snow)
        .background(.blue)
}
