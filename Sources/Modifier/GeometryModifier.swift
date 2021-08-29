#if canImport(SwiftUI)
import SwiftUI

/// https://swiftwithmajid.com/2020/01/15/the-magic-of-view-preferences-in-swiftui/
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension GeometryModifier {
    struct SizePreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGSize = .zero

        static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
            value = nextValue()
        }
    }

    struct FramePreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGRect = .zero

        static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
            value = nextValue()
        }
    }

    enum PreferenceKey {
        case size
        case frame
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
struct GeometryModifier: ViewModifier {
    let preferenceKey: PreferenceKey

    private var backgroundView: some View {
        GeometryReader { geometry in
            switch preferenceKey {
            case .size:
                Color.clear.preference(key: SizePreferenceKey.self, value: geometry.size)
            case .frame:
                Color.clear.preference(key: FramePreferenceKey.self, value: geometry.frame(in: .global))
            }
        }
    }

    func body(content: Content) -> some View {
        content.background(backgroundView)
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension View {
    public func onSizeChange(perform: @escaping (CGSize) -> Void) -> some View {
        ModifiedContent(content: self, modifier: GeometryModifier(preferenceKey: .size))
            .onPreferenceChange(GeometryModifier.SizePreferenceKey.self, perform: perform)
    }

    public func onFrameChange(perform: @escaping (CGRect) -> Void) -> some View {
        ModifiedContent(content: self, modifier: GeometryModifier(preferenceKey: .frame))
            .onPreferenceChange(GeometryModifier.FramePreferenceKey.self, perform: perform)
    }
}
#endif
