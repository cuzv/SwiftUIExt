import SwiftUI

public extension EdgeInsets {
  var reversed: EdgeInsets {
    .init(top: -top, leading: -leading, bottom: -bottom, trailing: -trailing)
  }

  init(vertical: CGFloat, horizontal: CGFloat) {
    self.init(
      top: vertical, leading: horizontal,
      bottom: vertical, trailing: horizontal
    )
  }

  init(vertical: CGFloat) {
    self.init(vertical: vertical, horizontal: 0)
  }

  init(horizontal: CGFloat) {
    self.init(vertical: 0, horizontal: horizontal)
  }

  init(value: CGFloat) {
    self.init(top: value, leading: value, bottom: value, trailing: value)
  }
}
