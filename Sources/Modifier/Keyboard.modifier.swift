import SwiftUI
import Combine

#if os(iOS) || os(tvOS) || os(watchOS)
/// https://swiftwithmajid.com/2019/11/27/combine-and-swiftui-views/
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
struct KeyboardAwareModifier: ViewModifier {
  @State private var keyboardHeight: CGFloat = 0

  private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
    Publishers.Merge(
      NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
        .map { $0.height },
      NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat(0) }
    ).eraseToAnyPublisher()
  }

  func body(content: Content) -> some View {
    content
      .padding(.bottom, keyboardHeight)
      .onReceive(keyboardHeightPublisher) {
        keyboardHeight = $0
      }
  }
}
#endif

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension View {
  func keyboardAwarePadding() -> some View {
#if os(iOS) || os(tvOS) || os(watchOS)
    ModifiedContent(content: self, modifier: KeyboardAwareModifier())
#else
    self
#endif
  }
}
