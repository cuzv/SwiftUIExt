import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension View {
   func inHStack(justify: HorizontalAlignment = .leading, spacing: CGFloat? = nil) -> some View {
    HStack(spacing: spacing) {
      if [.trailing, .center].contains(justify) {
        Spacer()
      }
      self
      if [.leading, .center].contains(justify) {
        Spacer()
      }
    }
  }

  func inVStack(justify: VerticalAlignment = .top, spacing: CGFloat? = nil) -> some View {
    VStack(spacing: spacing) {
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
  func inLazyHStack(justify: HorizontalAlignment = .leading, spacing: CGFloat? = nil) -> some View {
    LazyHStack(spacing: spacing) {
      if [.trailing, .center].contains(justify) {
        Spacer()
      }
      self
      if [.leading, .center].contains(justify) {
        Spacer()
      }
    }
  }

  func inLazyVStack(justify: VerticalAlignment = .top, spacing: CGFloat? = nil) -> some View {
    LazyVStack(spacing: spacing) {
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
