import Combine
import SwiftUI

struct OriginalBackground: View {
    let isNight: Bool
    
    @State var frame = CGSize.zero
    @State private var snowflakes: [Snowflake] = []
    @State private var clouds: [Cloud] = []
    private let numberOfSnowflakes = 100
    private let numberOfClouds = 20
    private let groundHeight = 100.0
    private let skyColor = Color.blue
    
    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { g in
            ZStack(alignment: .bottom) {
                ForEach(snowflakes, id: \.id) { flake in
                    SnowflakeShape(numberOfPoints: flake.points)
                        .stroke(.snow, lineWidth: 0.75)
                        .rotationEffect(.degrees(flake.rotation))
                        .frame(width: flake.size, height: flake.size)
                        .position(x: flake.x, y: flake.y)
                }
            
                ForEach(clouds, id: \.id) { cloud in
                    SwiftUI.Image(cloud.resource)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(isNight ? .black : .white)
                        .frame(width: cloud.size, height: 100)
                        .offset(x: cloud.x)
                }
                .opacity(0.5)
                .blur(radius: 10)
                .shadow(color: .white.opacity(isNight ? 0.2 : 0.5), radius: 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
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
            .background {
                skyColor
                    .brightness(isNight ? -0.5 : 0)
            }
            .onReceive(timer, perform: { _ in
                onTimerTick(size: g.frame(in: .global).size)
            })
            .onAppear {
                startSnowfall(size: g.frame(in: .global).size)
            }
        }
        .ignoresSafeArea()
    }
    
    private func startSnowfall(size: CGSize) {
        var clouds: [Cloud] = []
        for _ in 0 ... numberOfClouds {
            clouds.append(.init(size: size))
        }
        self.clouds = clouds
        
        var snowflakes: [Snowflake] = []
        for _ in 0 ..< numberOfSnowflakes {
            snowflakes.append(.init(size: size))
        }
        self.snowflakes = snowflakes
    }
    
    private func onTimerTick(size: CGSize) {
        for i in 0 ..< clouds.count {
            clouds[i].move(size: size)
            
            let leftEdge = -size.width / 2 - clouds[i].size
            let rightEdge = size.width / 2 + clouds[i].size
            let needsReset =
                if clouds[i].speed > 0 {
                    clouds[i].x > rightEdge
                } else {
                    clouds[i].x < leftEdge
                }
            
            if needsReset {
                var newCloud = Cloud(size: size)
                if newCloud.speed > 0 {
                    newCloud.x = leftEdge
                } else {
                    newCloud.x = rightEdge
                }
                clouds[i] = newCloud
            }
        }
        
        for i in 0 ..< snowflakes.count {
            snowflakes[i].move(size: size)
            
            if snowflakes[i].y > size.height {
                var newFlake = Snowflake(size: size)
                newFlake.y = -10
                snowflakes[i] = newFlake
            }
        }
    }
}

private struct SnowflakeShape: Shape {
    let numberOfPoints: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        var endPoints: [CGPoint] = []
        
        for i in 0 ..< numberOfPoints {
            let angle = (Double(i) * (360.0 / Double(numberOfPoints))) * Double.pi / 180
            let pointX = center.x + rect.width / 2 * cos(CGFloat(angle))
            let pointY = center.y + rect.height / 2 * sin(CGFloat(angle))
            let endpoint = CGPoint(x: pointX, y: pointY)
            endPoints.append(endpoint)
            
            let start = i == 0 ? endPoints.last! : endPoints[i - 1]
            path.move(to: center)
            path.addLine(to: start)
            path.move(to: center)
            path.addLine(to: endpoint)
            
            let circleRect = CGRect(x: endpoint.x - rect.width / 20,
                                    y: endpoint.y - rect.width / 20,
                                    width: rect.width / 10,
                                    height: rect.width / 10)
            path.addEllipse(in: circleRect)
        }
        
        path.addEllipse(in: .init(x: rect.width / 4, y: rect.height / 4, width: rect.width / 2, height: rect.height / 2))

        return path
    }
}

private struct Snowflake: Identifiable {
    var x: Double
    var y: Double
    
    let id = UUID()
    let startX: Double
    let endX: Double
    let xDifference: Double
    let size: Double
    let speed: Double
    let points: Int
    let rotation: Double
    
    init(size: CGSize) {
        let startX = Double.random(in: -2 ... size.width + 2)
        self.startX = startX
        self.x = startX
        self.y = .random(in: -10 ... size.height)
        self.size = .random(in: 4 ... 10)
        self.speed = .random(in: 0.5 ... 1.0)
        self.endX = .random(in: startX - 200 ... startX + 200)
        self.xDifference = self.endX - self.x
        self.points = .random(in: 4 ... 8)
        self.rotation = .random(in: 0 ... 360)
    }
    
    mutating func move(size: CGSize) {
        self.y += self.speed
        let percentageDownScreen = max(0, self.y / size.height)
        self.x = startX + xDifference * percentageDownScreen
    }
}

private struct Cloud: Identifiable {
    var x: Double
    
    let id = UUID()
    let resource: ImageResource
    let size: Double
    let speed: Double
    
    init(size: CGSize) {
        self.x = Double.random(in: -size.width / 2 ... size.width / 2)
        self.resource = [ImageResource.cloud1, ImageResource.cloud2, ImageResource.cloud3, ImageResource.cloud4, ImageResource.cloud5].randomElement() ?? .cloud1
        self.size = Double.random(in: 300 ... 400)
        self.speed = Bool.random() ? -1 : 1 * .random(in: 0.1 ... 0.15)
    }
    
    mutating func move(size _: CGSize) {
        self.x += self.speed
    }
}

struct Test: View {
    @State private var snowflakes: [Snowflake] = []
    
    private let numberOfFlakes = 100
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.blue
                
                ForEach($snowflakes, id: \.id) { $snowflake in
                    SnowflakeView(snowflake: $snowflake, size: geometry.size)
                }
            }
            .onAppear {
                for _ in 0 ..< self.numberOfFlakes {
                    snowflakes.append(.init(size: geometry.size))
                }
            }
        }
        .ignoresSafeArea()
    }
    
    struct SnowflakeView: View {
        @Binding var snowflake: Snowflake
        let size: CGSize
        
        @State private var position: CGPoint = .zero
        @State private var rotation: Double = 0
        @State private var isFirstAppear = true
        
        var body: some View {
            SnowflakeShape(numberOfPoints: snowflake.points)
                .stroke(.snow, lineWidth: 0.75)
                .rotationEffect(.degrees(rotation))
                .frame(width: snowflake.size, height: snowflake.size)
                .position(position)
                .onAppear {
                    if isFirstAppear {
                        isFirstAppear = false
                        
                        animate()
                    }
                }
        }
        
        private func animate() {
            position = snowflake.start
            
            withAnimation(.linear(duration: snowflake.duration)) {
                position = snowflake.end
                rotation = snowflake.rotation
            } completion: {
                snowflake.reset(size: size)
                
                animate()
            }
        }
    }
    
    struct Snowflake: Identifiable {
        let id = UUID()
        var start: CGPoint
        var end: CGPoint
        var size: Double
        var duration: Double
        var points: Int
        var rotation: Double
        
        init(size: CGSize) {
            let percentage = Double.random(in: 0 ... 1)
            let endX = Double.random(in: -2 ... size.width + 2)
            let startX = Double.random(in: -2 ... size.width + 2)
            self.start = .init(x: (endX - startX) * percentage, y: size.height * percentage)
            self.end = .init(x: endX, y: size.height + 10)
            self.size = .random(in: 4 ... 10)
            self.duration = .random(in: 10 ... 20) * percentage
            self.points = .random(in: 4 ... 8)
            self.rotation = .random(in: 0 ... 360)
        }
        
        mutating func reset(size: CGSize) {
            self.start = .init(x: .random(in: -2 ... size.width + 2), y: -10)
            self.end = .init(x: .random(in: -2 ... size.width + 2), y: size.height + 10)
            self.size = .random(in: 4 ... 10)
            self.duration = .random(in: 10 ... 20)
            self.points = .random(in: 4 ... 8)
            self.rotation = .random(in: 0 ... 360)
        }
    }
}

#Preview {
    Test()
}

#Preview {
    OriginalBackground(isNight: true)
}
