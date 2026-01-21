import Combine
import SwiftUI

struct OriginalBackground: View {
    let isNight: Bool
    
    @State var frame = CGSize.zero
    private let groundHeight = 100.0
    
    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { g in
            ZStack(alignment: .bottom) {
                CloudsAndSnowflakes(isNight: isNight)
            
                Rectangle()
                    .fill(Gradient(colors: [isNight ? .white.opacity(0.3) : .white, .clear]))
                    .frame(height: 100)
                    .blur(radius: 5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
                Circle()
                    .foregroundStyle(.snow)
                    .scaleEffect(6)
                    .offset(x: 250, y: -groundHeight + 1_270)
            
                Circle()
                    .foregroundStyle(.snow)
                    .scaleEffect(5)
                    .shadow(color: .black.opacity(0.2), radius: 10)
                    .offset(x: -200, y: -groundHeight + 1_100)
            
                Circle()
                    .foregroundStyle(.snow)
                    .scaleEffect(5)
                    .shadow(color: .black.opacity(0.2), radius: 15)
                    .offset(x: 330, y: -groundHeight + 1_170)
            
                Circle()
                    .foregroundStyle(.snow)
                    .scaleEffect(6)
                    .shadow(color: .black.opacity(0.2), radius: 10)
                    .offset(x: -100, y: -groundHeight + 1_380)
            
                SwiftUI.Image(.tree)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .brightness(isNight ? -0.2 : 0)
                    .shadow(radius: 10)
                    .offset(x: 80, y: -groundHeight)
            
                SwiftUI.Image(.tree)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 400)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .brightness(isNight ? -0.2 : 0)
                    .shadow(radius: 10)
                    .offset(x: -80, y: -groundHeight)
            
                Circle()
                    .foregroundStyle(.snow)
                    .scaleEffect(5)
                    .shadow(color: .black.opacity(0.2), radius: 10)
                    .offset(x: -360, y: -groundHeight + 1_170)
            
                Rectangle()
                    .foregroundStyle(.snow)
                    .shadow(color: .black.opacity(0.2), radius: 15)
                    .frame(height: groundHeight)
            
                if isNight {
                    Color.black.opacity(0.1)
                }
            }
        }
    }
}

#Preview {
    OriginalBackground(isNight: false)
        .ignoresSafeArea()
}
