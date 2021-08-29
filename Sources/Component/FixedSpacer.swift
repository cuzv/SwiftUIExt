#if canImport(SwiftUI)
import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public struct FixedSpacer: View {
    private let length: CGFloat

    public init(length: CGFloat) {
        self.length = length
    }

    public var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: length, height: length)
    }
}
#endif
