import SwiftUI

public struct Backport<Content> {
  public let content: Content
}

public extension View {
  var backport: Backport<Self> {
    Backport(content: self)
  }
}

public extension Backport where Content: View {
  @available(iOS 13.0, macOS 12.0, *)
  @ViewBuilder func badge(_ count: Int) -> some View {
    if #available(iOS 15, *) {
      content.badge(count)
    } else {
      content
    }
  }
}
