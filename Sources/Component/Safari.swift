#if os(iOS)
import SafariServices
import SwiftUI
import UIKit

@available(iOS 13.0, *)
public struct Safari: UIViewControllerRepresentable {
  private let url: URL
  private let readerMode: Bool
  private let onFinished: (() -> Void)?

  public init(url: URL, readerMode: Bool = true, onFinished: (() -> Void)? = nil) {
    self.url = url
    self.readerMode = readerMode
    self.onFinished = onFinished
  }

  public func makeUIViewController(context: UIViewControllerRepresentableContext<Safari>) -> SFSafariViewController {
    let configuration = SFSafariViewController.Configuration()
    configuration.entersReaderIfAvailable = readerMode
    let controller = SFSafariViewController(url: url, configuration: configuration)
    controller.delegate = context.coordinator
    return controller
  }

  public func updateUIViewController(
    _ uiViewController: SFSafariViewController,
    context: UIViewControllerRepresentableContext<Safari>
  ) {}

  public func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  public final class Coordinator: NSObject, SFSafariViewControllerDelegate {
    private let parent: Safari

    init(_ parent: Safari) {
      self.parent = parent
    }

    public func safariViewControllerDidFinish(_: SFSafariViewController) {
      parent.onFinished?()
    }
  }
}
#endif
