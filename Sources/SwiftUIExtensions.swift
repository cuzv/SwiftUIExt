import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public enum SwiftUIExtensions {
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension SwiftUIExtensions {
  public struct Padding {
    let leading: CGFloat
    let trailing: CGFloat
    let top: CGFloat
    let bottom: CGFloat

    public init(leading: CGFloat, trailing: CGFloat, top: CGFloat, bottom: CGFloat) {
      self.leading = leading
      self.trailing = trailing
      self.top = top
      self.bottom = bottom
    }

    public init(value: CGFloat) {
      self.init(leading: value, trailing: value, top: value, bottom: value)
    }

    public init(horizontal: CGFloat, vertical: CGFloat) {
      self.init(leading: horizontal, trailing: horizontal, top: vertical, bottom: vertical)
    }
  }
}
