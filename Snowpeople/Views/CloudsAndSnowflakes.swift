import SwiftUI

struct CloudsAndSnowflakes: View {
    let isNight: Bool
    
    @State private var snowflakes: [Snowflake] = []
    @State private var clouds: [Cloud] = []
    @State private var isFirstLoad = true
    @State private var isAnimating = false
    
    private let numberOfSnowflakes = 100
    private let numberOfClouds = 20
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.blue
                    .brightness(isNight ? -0.5 : 0)
                
                ForEach($clouds, id: \.id) { $clouds in
                    CloudView(cloud: $clouds, isAnimating: $isAnimating, size: geometry.size, isNight: isNight)
                }
                .opacity(0.5)
                .blur(radius: 10)
                .shadow(color: .white.opacity(isNight ? 0.2 : 0.5), radius: 10)
                    
                ForEach($snowflakes, id: \.id) { $snowflake in
                    SnowflakeView(snowflake: $snowflake, isAnimating: $isAnimating, size: geometry.size)
                }
                
                Rectangle()
                    .fill(Gradient(colors: [isNight ? .white.opacity(0.3) : .white, .clear]))
                    .frame(height: 100)
                    .blur(radius: 5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .onAppear {
                isAnimating = true
                
                if isFirstLoad {
                    isFirstLoad = false
                    
                    for _ in 0 ..< self.numberOfSnowflakes {
                        snowflakes.append(.init(size: geometry.size))
                    }
                    
                    for _ in 0 ..< self.numberOfClouds {
                        clouds.append(.init(size: geometry.size))
                    }
                }
            }
            .onDisappear {
                isAnimating = false
            }
        }
        .ignoresSafeArea()
    }
}

private struct SnowflakeView: View {
    @Binding var snowflake: Snowflake
    @Binding var isAnimating: Bool
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
        rotation = snowflake.rotation
        
        withAnimation(.linear(duration: snowflake.duration)) {
            position = snowflake.end
            rotation = snowflake.rotation
        } completion: {
            if isAnimating {
                snowflake.reset(size: size)
                
                animate()
            }
        }
    }
}

private struct CloudView: View {
    @Binding var cloud: Cloud
    @Binding var isAnimating: Bool
    let size: CGSize
    let isNight: Bool
    
    @State private var position: CGPoint = .zero
    @State private var isFirstAppear = true
    
    var body: some View {
        SwiftUI.Image(cloud.resource)
            .resizable()
            .renderingMode(.template)
            .foregroundStyle(isNight ? .black : .white)
            .frame(width: cloud.size, height: 100)
            .position(position)
            .onAppear {
                if isFirstAppear {
                    isFirstAppear = false
                    
                    animate()
                }
            }
    }
    
    private func animate() {
        position = cloud.start
        
        withAnimation(.linear(duration: cloud.duration)) {
            position = cloud.end
        } completion: {
            if isAnimating {
                cloud.reset(size: size)
                
                animate()
            }
        }
    }
}

private struct Snowflake: Identifiable {
    let id = UUID()
    var start: CGPoint
    var end: CGPoint
    var size: Double
    var duration: Double
    var points: Int
    var rotation: Double
    
    init(size: CGSize) {
        let percentage = Double.random(in: 0 ... 1)
        let initialValues = Self.getRandomValues(size: size)
        self.start = .init(x: initialValues.start.x + (initialValues.end.x - initialValues.end.x) * percentage, y: initialValues.end.y * percentage)
        self.end = initialValues.end
        self.size = initialValues.size
        self.duration = initialValues.duration * (1.0 - percentage)
        self.points = initialValues.points
        self.rotation = initialValues.rotation
    }
    
    mutating func reset(size: CGSize) {
        let randomValues = Self.getRandomValues(size: size)
        self.start = randomValues.start
        self.end = randomValues.end
        self.size = randomValues.size
        self.duration = randomValues.duration
        self.points = randomValues.points
        self.rotation = randomValues.rotation
    }
    
    static func getRandomValues(size: CGSize) -> (start: CGPoint,
                                                  end: CGPoint,
                                                  size: Double,
                                                  duration: Double,
                                                  points: Int,
                                                  rotation: Double) {
        let start = CGPoint(x: .random(in: -2 ... size.width + 2), y: -10)
        let end = CGPoint(x: .random(in: -2 ... size.width + 2), y: size.height + 10)
        let size = Double.random(in: 4 ... 10)
        let duration = Double.random(in: 10 ... 20)
        let points = Int.random(in: 4 ... 8)
        let rotation = Double.random(in: 0 ... 360)
        
        return (start, end, size, duration, points, rotation)
    }
}

private struct Cloud: Identifiable {
    let id = UUID()
    var start: CGPoint
    var end: CGPoint
    var resource: ImageResource
    var size: Double
    var duration: Double
    
    init(size: CGSize) {
        let percentage = Double.random(in: 0 ... 1)
        let initialValues = Self.getRandomValues(size: size)
        self.start = .init(x: initialValues.start.x + (initialValues.end.x - initialValues.start.x) * percentage, y: initialValues.start.y)
        self.end = initialValues.end
        self.resource = initialValues.resource
        self.size = initialValues.size
        self.duration = initialValues.duration * (1.0 - percentage)
    }
    
    mutating func reset(size: CGSize) {
        let randomValues = Self.getRandomValues(size: size)
        self.start = randomValues.start
        self.end = randomValues.end
        self.resource = randomValues.resource
        self.size = randomValues.size
        self.duration = randomValues.duration
    }
    
    static func getRandomValues(size: CGSize) -> (start: CGPoint,
                                                  end: CGPoint,
                                                  resource: ImageResource,
                                                  size: Double,
                                                  duration: Double) {
        let isGoingLeft = Bool.random()
        let cloudSize = Double.random(in: 300 ... 400)
        let endX = isGoingLeft ? -cloudSize : size.width + cloudSize
        let startX = isGoingLeft ? size.width + cloudSize : -cloudSize
        let start = CGPoint(x: startX, y: 50)
        let end = CGPoint(x: endX, y: 50)
        let resource = [ImageResource.cloud1, ImageResource.cloud2, ImageResource.cloud3, ImageResource.cloud4, ImageResource.cloud5].randomElement() ?? .cloud1
        let size = cloudSize
        let duration = Double.random(in: 15 ... 20)
        
        return (start, end, resource, size, duration)
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

#Preview {
    CloudsAndSnowflakes(isNight: false)
}
