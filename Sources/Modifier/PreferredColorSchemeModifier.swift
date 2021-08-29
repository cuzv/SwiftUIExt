#if canImport(SwiftUI)
import SwiftUI

/// https://github.com/rizwankce/SwiftUIColorSchemeTest
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
struct PreferredColorSchemeModifier: ViewModifier {
    @Binding var colorScheme: SwiftUI.ColorScheme?

    @ViewBuilder
    func body(content: Content) -> some View {
        if let colorScheme = colorScheme {
            content
                .environment(\.colorScheme, colorScheme)
        } else {
            content
        }
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension View {
    public func applyPreferredColorScheme(_ colorScheme: Binding<SwiftUI.ColorScheme?>) -> some View {
        modifier(PreferredColorSchemeModifier(colorScheme: colorScheme))
    }
}
#endif
