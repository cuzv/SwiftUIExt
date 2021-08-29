import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public struct Spinner: View {
    private let backgroundColor: Color
    private let foregroundColor: Color
    @State private var rotation: Double = 0

    public init(
        circleColor: Color = Color(.gray),
        lineColor: Color = Color(.green)
    ) {
        self.backgroundColor = circleColor
        self.foregroundColor = lineColor
    }

    public var body: some View {
        let gradientColors = Gradient(colors: [backgroundColor, foregroundColor])
        let conic = AngularGradient(
            gradient: gradientColors,
            center: .center,
            startAngle: .zero,
            endAngle: .degrees(360)
        )
        let lineWidth: CGFloat = 4
        let animation = Animation
            .linear(duration: 1.5)
            .repeatForever(autoreverses: false)

        return ZStack {
            Circle()
                .stroke(backgroundColor, lineWidth: lineWidth)

            Circle()
                .trim(from: lineWidth / 500, to: 1 - lineWidth / 100)
                .stroke(conic, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(rotation))
                .onAppear {
                    rotation = 0
                    withAnimation(animation) {
                        rotation = 360
                    }
                }
        }
    }
}
