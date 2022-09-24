import SwiftUI

public struct Padding: View {
  let width: CGFloat?
  let height: CGFloat?
  let alignment: Alignment

  public init(width: CGFloat? = nil, height: CGFloat? = nil, alignment: Alignment = .center) {
    self.width = width
    self.height = height
    self.alignment = alignment
  }

  public var body: some View {
    Rectangle()
      .foregroundColor(.clear)
      .frame(width: width, height: height, alignment: alignment)
  }
}
