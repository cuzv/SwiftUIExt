import SwiftUI

// https://swiftwithmajid.com/2019/08/28/composable-styling-in-swiftui/
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
struct OutlineStyle: ButtonStyle {
    let padding: SwiftUIExtensions.Padding
    let cornerRadius: CGFloat

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(padding)
            .foregroundColor(configuration.isPressed ? Color.accentColor.opacity(0.25) : .accentColor)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(configuration.isPressed ? Color.accentColor.opacity(0.25) : .accentColor)
            )
    }
}

// https://swiftwithmajid.com/2019/08/28/composable-styling-in-swiftui/
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
struct FillStyle: ButtonStyle {
    let padding: SwiftUIExtensions.Padding
    let pressedColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(padding)
            .foregroundColor(configuration.isPressed ? pressedColor.opacity(0.75) : pressedColor)
            .background(configuration.isPressed ? Color.accentColor.opacity(0.25) : .accentColor)
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 14.0, watchOS 6.0, macCatalyst 13.0, *)
struct LongPressStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .gesture(
                LongPressGesture()
                    .onEnded { _ in
                        configuration.trigger()
                    }
            )
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 14.0, watchOS 6.0, macCatalyst 13.0, *)
extension View {
    @ViewBuilder
    public func buttonStyle(_ style: SwiftUIExtensions.ButtonStyle) -> some View {
        switch style {
        case let .outline(value):
            buttonStyle(OutlineStyle(padding: value.padding, cornerRadius: value.cornerRadius))
        case let .fill(value):
            buttonStyle(FillStyle(padding: value.padding, pressedColor: value.pressedColor))
        case .longPress:
            buttonStyle(LongPressStyle())
        }
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension SwiftUIExtensions {
    public enum ButtonStyle {
        case outline(Outline)
        case fill(Fill)
        case longPress

        public struct Outline {
            let padding: Padding
            let cornerRadius: CGFloat

            public init(padding: Padding = .init(horizontal: 8, vertical: 4), cornerRadius: CGFloat = 6) {
                self.padding = padding
                self.cornerRadius = cornerRadius
            }

            public static let `default` = Outline()
        }

        public struct Fill {
            let padding: Padding
            let pressedColor: Color

            public init(padding: Padding = .init(horizontal: 8, vertical: 4), pressedColor: Color = .white) {
                self.padding = padding
                self.pressedColor = pressedColor
            }

            public static let `default` = Fill()
        }
    }
}
