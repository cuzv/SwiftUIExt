import SwiftUI

public struct Blank: View {
  let width: CGFloat?
  let height: CGFloat?
  let alignment: Alignment
  let color: Color

  public init(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center, color: Color = .clear) {
    self.width = width
    self.height = height
    self.alignment = alignment
    self.color = color
  }

  public var body: some View {
    Rectangle()
      .foregroundColor(color)
      .frame(width: width, height: height, alignment: alignment)
  }
}
