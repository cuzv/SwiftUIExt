import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
struct LinearGradientModifier: ViewModifier {
  let colors: [Color]
  let startPoint: UnitPoint
  let endPoint: UnitPoint

  func body(content: Content) -> some View {
    content
      .background(
        Rectangle()
          .fill(
            LinearGradient(
              gradient: Gradient(colors: colors),
              startPoint: startPoint,
              endPoint: endPoint
            )
          )
      )
  }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension View {
  func linearGradient(
    colors: [Color],
    startPoint: UnitPoint = .topLeading,
    endPoint: UnitPoint = .bottomTrailing
  ) -> some View {
    modifier(
      LinearGradientModifier(
        colors: colors,
        startPoint: startPoint,
        endPoint: endPoint
      )
    )
  }
}
