import SwiftUI

/// https://swiftwithmajid.com/2020/09/24/mastering-scrollview-in-swiftui/
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public struct Scroller<Content: View>: View {
  private let axes: Axis.Set
  private let showsIndicators: Bool
  private let offsetChanged: (CGPoint) -> Void
  private let content: Content

  public init(
    axes: Axis.Set = .vertical,
    showsIndicators: Bool = true,
    offsetChanged: @escaping (CGPoint) -> Void = { _ in },
    @ViewBuilder content: () -> Content
  ) {
    self.axes = axes
    self.showsIndicators = showsIndicators
    self.offsetChanged = offsetChanged
    self.content = content()
  }

  public var body: some View {
    SwiftUI.ScrollView(axes, showsIndicators: showsIndicators) {
      GeometryReader { proxy in
        Color.clear.preference(
          key: ScrollOffsetPreferenceKey.self,
          value: proxy.frame(in: .named("scrollView")).origin
        )
      }.frame(width: 0, height: 0)
      content
    }
    .coordinateSpace(name: "scrollView")
    .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
  }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
private struct ScrollOffsetPreferenceKey: PreferenceKey {
  static var defaultValue: CGPoint = .zero

  static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    value = nextValue()
  }
}
