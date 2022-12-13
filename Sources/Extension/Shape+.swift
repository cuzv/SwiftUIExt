import SwiftUI

public extension Shape {
  /// Stroking and filling a SwiftUI shape at the same time
  ///
  /// https://www.swiftbysundell.com/articles/stroking-and-filling-a-swiftui-shape-at-the-same-time/
  func style<S: ShapeStyle, F: ShapeStyle>(
    stroke strokeContent: S,
    lineWidth: CGFloat = 1,
    fill fillContent: F
  ) -> some View {
    stroke(
      strokeContent,
      lineWidth: lineWidth
    )
    .background(
      fill(fillContent)
    )
  }
}
