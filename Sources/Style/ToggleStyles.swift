#if os(iOS) && canImport(SwiftUI)
import SwiftUI

/// https://swiftwithmajid.com/2020/03/04/customizing-toggle-in-swiftui/
@available(macOS 11.0, iOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 22, height: 22)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

@available(macOS 11.0, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension View {
    @ViewBuilder
    public func toggleStyle(_ style: SwiftUIExtensions.ToggleStyle) -> some View {
        switch style {
        case .switch:
            self
        case .checkbox:
            toggleStyle(CheckboxToggleStyle())
        }
    }
}

@available(macOS 11.0, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension SwiftUIExtensions {
    public enum ToggleStyle {
        case `switch`
        case checkbox
    }
}
#endif
