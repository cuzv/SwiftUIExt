#if os(iOS)
import SwiftUI
import UIKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public struct ActivityIndicator: UIViewRepresentable {
  private let style: UIActivityIndicatorView.Style
  private let color: UIColor?
  @Binding private var isAnimating: Bool

  public init(
    style: UIActivityIndicatorView.Style,
    color: UIColor? = nil,
    isAnimating: Binding<Bool> = .constant(true)
  ) {
    self.style = style
    self.color = color
    self._isAnimating = isAnimating
  }

  public func makeUIView(context: Context) -> UIActivityIndicatorView {
    let view = UIActivityIndicatorView(style: style)
    view.color = color
    return view
  }

  public func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
  }
}
#endif
