#if canImport(SwiftUI)
import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension Animation {
    public static let normal = Animation.spring(dampingFraction: 1.5).speed(2.5)
    public static let fast = Animation.spring(response: 0.3, dampingFraction: 1).speed(2)
    public static let slow = Animation.spring(dampingFraction: 1.5).speed(1)
}
#endif
