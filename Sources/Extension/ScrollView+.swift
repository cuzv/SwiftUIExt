import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, macCatalyst 13.0, *)
public extension View {
  func inScrollView(axis: Axis.Set = .vertical, showsIndicators: Bool = true) -> ScrollView<Self> {
    ScrollView(axis, showsIndicators: showsIndicators) {
      self
    }
  }

  func inScrollViewReader(alignment: Alignment = .center) -> some View {
    GeometryReader { geometry in
      ScrollView {
        frame(
          minHeight: geometry.size.height,
          maxHeight: .infinity,
          alignment: alignment
        )
      }
    }
  }
}
