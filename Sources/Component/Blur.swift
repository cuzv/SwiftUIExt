#if os(iOS)
import SwiftUI
import UIKit

@available(iOS 13.0, *)
public struct Blur: UIViewRepresentable {
  private let style: UIBlurEffect.Style

  public init(style: UIBlurEffect.Style) {
    self.style = style
  }

  public func makeUIView(context: UIViewRepresentableContext<Blur>) -> UIView {
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: style))
    blurView.translatesAutoresizingMaskIntoConstraints = false

    let view = UIView(frame: .zero)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    view.addSubview(blurView)

    NSLayoutConstraint.activate([
      blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
      blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
    ])

    return view
  }

  public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Blur>) {
  }
}

@available(iOS 13.0, *)
extension View {
  public func blurBackground(style: UIBlurEffect.Style) -> some View {
    ZStack {
      Blur(style: style)
      self
    }
  }
}
#endif
