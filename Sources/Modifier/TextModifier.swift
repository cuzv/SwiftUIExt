#if os(iOS)
import SwiftUI

// https://swiftwithmajid.com/2019/08/28/composable-styling-in-swiftui/

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
struct TitleModifier: ViewModifier {
    let lineSpacing: CGFloat
    let foregroundColor: Color

    func body(content: Content) -> some View {
        content
            .font(.title)
            .lineSpacing(lineSpacing)
            .foregroundColor(foregroundColor)
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
struct ContentModifier: ViewModifier {
    let lineSpacing: CGFloat
    let foregroundColor: Color

    func body(content: Content) -> some View {
        content
            .font(.body)
            .lineSpacing(lineSpacing)
            .foregroundColor(foregroundColor)
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension View {
    @ViewBuilder
    public func textModifier(_ modifier: SwiftUIExtensions.TextModifier) -> some View {
        switch modifier {
        case let .title(value):
            ModifiedContent(
                content: self,
                modifier: TitleModifier(
                    lineSpacing: value.spacing,
                    foregroundColor: value.color
                )
            )
        case let .content(value):
            ModifiedContent(
                content: self,
                modifier: ContentModifier(
                    lineSpacing: value.spacing,
                    foregroundColor: value.color
                )
            )
        }
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension SwiftUIExtensions {
    public enum TextModifier {
        case title(Title)
        case content(Content)

        public struct Title {
            let spacing: CGFloat
            let color: Color

            public init(spacing: CGFloat = 8, color: Color = .label) {
                self.spacing = spacing
                self.color = color
            }

            public static let `default` = Title()
        }

        public struct Content {
            let spacing: CGFloat
            let color: Color

            public init(spacing: CGFloat = 4, color: Color = .secondaryLabel) {
                self.spacing = spacing
                self.color = color
            }

            public static let `default` = Content()
        }
    }
}
#endif
