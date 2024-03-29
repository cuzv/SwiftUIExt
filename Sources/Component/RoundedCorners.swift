#if os(iOS)
import Foundation
import SwiftUI

/// Copied from https://stackoverflow.com/questions/56760335/round-specific-corners-swiftui
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public struct RoundedCorners: Shape {
  private let tl: CGFloat
  private let tr: CGFloat
  private let bl: CGFloat
  private let br: CGFloat

  public init(
    tl: CGFloat = 0.0,
    tr: CGFloat = 0.0,
    bl: CGFloat = 0.0,
    br: CGFloat = 0.0
  ) {
    self.tl = tl
    self.tr = tr
    self.bl = bl
    self.br = br
  }

  public func path(in rect: CGRect) -> Path {
    var path = Path()

    let w = rect.size.width
    let h = rect.size.height

    // Make sure we do not exceed the size of the rectangle
    let tr = min(min(tr, h / 2), w / 2)
    let tl = min(min(tl, h / 2), w / 2)
    let bl = min(min(bl, h / 2), w / 2)
    let br = min(min(br, h / 2), w / 2)

    path.move(to: CGPoint(x: w / 2.0, y: 0))
    path.addLine(to: CGPoint(x: w - tr, y: 0))
    path.addArc(
      center: CGPoint(x: w - tr, y: tr),
      radius: tr,
      startAngle: Angle(degrees: -90),
      endAngle: Angle(degrees: 0),
      clockwise: false
    )

    path.addLine(to: CGPoint(x: w, y: h - br))
    path.addArc(
      center: CGPoint(x: w - br, y: h - br),
      radius: br,
      startAngle: Angle(degrees: 0),
      endAngle: Angle(degrees: 90),
      clockwise: false
    )

    path.addLine(to: CGPoint(x: bl, y: h))
    path.addArc(
      center: CGPoint(x: bl, y: h - bl),
      radius: bl,
      startAngle: Angle(degrees: 90),
      endAngle: Angle(degrees: 180),
      clockwise: false
    )

    path.addLine(to: CGPoint(x: 0, y: tl))
    path.addArc(
      center: CGPoint(x: tl, y: tl),
      radius: tl,
      startAngle: Angle(degrees: 180),
      endAngle: Angle(degrees: 270),
      clockwise: false
    )

    return path
  }
}
#endif
