#if os(iOS)
import SwiftUI
import UIKit
import WebKit
import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public struct Web: UIViewRepresentable {
  public typealias UIViewType = WKWebView
  public typealias NavigationActionHandler = (WKWebView, WKNavigationAction, WKWebpagePreferences) async -> WKNavigationActionPolicy
  public typealias NavigationResponseHandler = (WKWebView, WKNavigationResponse) async -> WKNavigationResponsePolicy

  private let url: URL
  private let progress: ((Double) -> Void)?
  private let navigationAction: NavigationActionHandler?
  private let navigationResponse: NavigationResponseHandler?

  public init(
    url: URL,
    progress: ((Double) -> Void)? = nil,
    navigationAction: NavigationActionHandler? = nil,
    navigationResponse: NavigationResponseHandler? = nil
  ) {
    self.url = url
    self.progress = progress
    self.navigationAction = navigationAction
    self.navigationResponse = navigationResponse
  }

  public func makeUIView(context: Context) -> WKWebView {
    let contentController = WKUserContentController()
    let scriptSource = """
      (function getImgElements() {
        var regex = RegExp('Google Play');
        var imgs = document.getElementsByTagName("img");
        var to = setTimeout(function(){ getImgElements() }, 100);
        if (imgs.length > 0) {
          clearTimeout(to)
          for (let img of imgs) {
            console.log(img)
            if (regex.test(img.alt)) {
              img.parentElement.style.display = "none"
            }
          }
        }
      })()
      """
    let script = WKUserScript(source: scriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    contentController.addUserScript(script)

    let configuration = WKWebViewConfiguration()
    configuration.preferences = WKPreferences()
    configuration.preferences.minimumFontSize = 12
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = false
    configuration.processPool = WKProcessPool()
    configuration.userContentController = contentController
    configuration.websiteDataStore = WKWebsiteDataStore.nonPersistent()

    let view = WKWebView(frame: .zero, configuration: configuration)
    view.uiDelegate = context.coordinator
    view.navigationDelegate = context.coordinator
    view.load(URLRequest(url: url))

    var token: AnyCancellable?
    token = view.publisher(for: \.estimatedProgress, options: .new).sink { _ in
      token?.cancel()
      token = nil
    } receiveValue: { value in
      progress?(value)
    }

    return view
  }

  public func updateUIView(_ uiView: WKWebView, context: Context) {

  }

  public func makeCoordinator() -> Coordinator {
    .init(base: self)
  }

  final public class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
    private let base: Web

    init(base: Web) {
      self.base = base
    }

    @MainActor
    public func webView(
      _ webView: WKWebView,
      decidePolicyFor navigationAction: WKNavigationAction,
      preferences: WKWebpagePreferences
    ) async -> (WKNavigationActionPolicy, WKWebpagePreferences) {
      preferences.preferredContentMode = .mobile

      if let handler = base.navigationAction {
        let policy = await handler(webView, navigationAction, preferences)
        return (policy, preferences)
      } else {
        return (.allow, preferences)
      }
    }

    @MainActor
    public func webView(
      _ webView: WKWebView,
      decidePolicyFor navigationResponse: WKNavigationResponse
    ) async -> WKNavigationResponsePolicy {
      if let handler = base.navigationResponse {
        let policy = await handler(webView, navigationResponse)
        return policy
      } else {
        return .allow
      }
    }
  }
}

#endif
