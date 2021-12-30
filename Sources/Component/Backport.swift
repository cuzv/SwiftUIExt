import SwiftUI

public struct Backport<Content> {
  public let content: Content
}

extension View {
  public var backport: Backport<Self> {
    Backport(content: self)
  }
}

extension Backport where Content: View {
  @available(iOS 13.0, macOS 12.0, *)
  @ViewBuilder public func badge(_ count: Int) -> some View {
    if #available(iOS 15, *) {
      content.badge(count)
    } else {
      content
    }
  }
}
