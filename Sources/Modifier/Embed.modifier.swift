import SwiftUI

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, macCatalyst 14.0, *)
struct EmbedInStackModifier: ViewModifier {
  @Environment(\.sizeCategory) var sizeCategory

  @ViewBuilder
  func body(content: Content) -> some View {
    if sizeCategory > ContentSizeCategory.medium {
      VStack { content }
    } else {
      HStack { content }
    }
  }
}

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, macCatalyst 14.0, *)
extension Group where Content: View {
  public func embedInStack() -> some View {
    modifier(EmbedInStackModifier())
  }
}

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, macCatalyst 14.0, *)
struct EmbedInLazyStackModifier: ViewModifier {
  @Environment(\.sizeCategory) var sizeCategory

  @ViewBuilder
  func body(content: Content) -> some View {
    if sizeCategory > ContentSizeCategory.medium {
      LazyVStack { content }
    } else {
      LazyHStack { content }
    }
  }
}

@available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, macCatalyst 14.0, *)
extension Group where Content: View {
  public func embedInLazyStack() -> some View {
    modifier(EmbedInLazyStackModifier())
  }
}
