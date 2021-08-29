#if os(iOS) && canImport(SwiftUI)
import SwiftUI
import UIKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public struct ActivityIndicator: UIViewRepresentable {
    private let style: UIActivityIndicatorView.Style
    @Binding private var isAnimating: Bool

    public init(style: UIActivityIndicatorView.Style, isAnimating: Binding<Bool>) {
        self.style = style
        self._isAnimating = isAnimating
    }

    public func makeUIView(context: Context) -> UIActivityIndicatorView {
        .init(style: style)
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
#endif
