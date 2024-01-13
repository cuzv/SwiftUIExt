import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension AnyTransition {
  static func moveInFadeOut(edge: Edge) -> Self {
    .asymmetric(
      insertion: .move(edge: edge),
      removal: .opacity
    )
  }

  static var slideInFadeOut: Self {
    .asymmetric(
      insertion: .slide,
      removal: .opacity
    )
  }
}
