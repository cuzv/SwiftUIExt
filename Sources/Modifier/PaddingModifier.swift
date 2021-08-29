import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
struct PaddingModifier: ViewModifier {
    let padding: SwiftUIExtensions.Padding

    func body(content: Content) -> some View {
        content
            .padding(.leading, padding.leading)
            .padding(.trailing, padding.trailing)
            .padding(.top, padding.top)
            .padding(.bottom, padding.bottom)
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension View {
    public func padding(_ horizontal: CGFloat, _ vertical: CGFloat) -> some View {
        padding(horizontal, horizontal, vertical, vertical)
    }

    public func padding(_ padding: SwiftUIExtensions.Padding) -> some View {
        modifier(PaddingModifier(padding: padding))
    }

    public func padding(_ leading: CGFloat, _ trailing: CGFloat, _ top: CGFloat, _ bottom: CGFloat) -> some View {
        ModifiedContent(
            content: self,
            modifier: PaddingModifier(
                padding: .init(
                    leading: leading,
                    trailing: trailing,
                    top: top,
                    bottom: bottom
                )
            )
        )
    }
}
