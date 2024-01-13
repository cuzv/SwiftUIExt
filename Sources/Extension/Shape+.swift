import SwiftUI

public extension Shape {
  /// Stroking and filling a SwiftUI shape at the same time
  ///
  /// https://www.swiftbysundell.com/articles/stroking-and-filling-a-swiftui-shape-at-the-same-time/
  func style(
    stroke strokeContent: some ShapeStyle,
    lineWidth: CGFloat = 1,
    fill fillContent: some ShapeStyle
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
