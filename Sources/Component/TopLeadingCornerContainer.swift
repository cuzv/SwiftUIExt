#if canImport(SwiftUI)
import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public struct TopLeadingCornerContainer<Content: View>: View {
    private let v: Content

    public init(@ViewBuilder content: () -> Content) {
        v = content()
    }

    public var body: some View {
        HStack {
            Spacer()
            VStack {
                v
                Spacer()
            }
        }
    }
}
#endif
