import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension View {
  func inHStack(
    justify: HorizontalAlignment = .leading,
    align: VerticalAlignment = .center,
    spacing: CGFloat? = nil
  ) -> some View {
    HStack(alignment: align, spacing: spacing) {
      if [.trailing, .center].contains(justify) {
        Spacer()
      }
      self
      if [.leading, .center].contains(justify) {
        Spacer()
      }
    }
  }

  func inVStack(
    justify: VerticalAlignment = .top,
    alignment: HorizontalAlignment = .center,
    spacing: CGFloat? = nil
  ) -> some View {
    VStack(alignment: alignment, spacing: spacing) {
      if [.bottom, .center].contains(justify) {
        Spacer()
      }
      self
      if [.top, .center].contains(justify) {
        Spacer()
      }
    }
  }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, macCatalyst 14.0, *)
public extension View {
  func inLazyHStack(
    justify: HorizontalAlignment = .leading,
    align: VerticalAlignment = .center,
    spacing: CGFloat? = nil
  ) -> some View {
    LazyHStack(alignment: align, spacing: spacing) {
      if [.trailing, .center].contains(justify) {
        Spacer()
      }
      self
      if [.leading, .center].contains(justify) {
        Spacer()
      }
    }
  }

  func inLazyVStack(
    justify: VerticalAlignment = .top,
    alignment: HorizontalAlignment = .center,
    spacing: CGFloat? = nil
  ) -> some View {
    LazyVStack(alignment: alignment, spacing: spacing) {
      if [.bottom, .center].contains(justify) {
        Spacer()
      }
      self
      if [.top, .center].contains(justify) {
        Spacer()
      }
    }
  }
}
