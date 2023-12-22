import SwiftUI

/// Building custom layout in SwiftUI
///
/// Checkout https://swiftwithmajid.com/2022/12/06/building-custom-layout-in-swiftui-spacing/
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, macCatalyst 16.0, *)
public struct FlowLayout: Layout {
  public var spacing: CGFloat? = nil

  public struct Cache {
    public var sizes: [CGSize] = []
    public var spacing: [CGFloat] = []
  }

  public func makeCache(subviews: Subviews) -> Cache {
    let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
    let spacing: [CGFloat] = subviews.indices.map { index in
      guard index != subviews.count - 1 else {
        return 0
      }

      return subviews[index].spacing.distance(
        to: subviews[index+1].spacing,
        along: .horizontal
      )
    }

    return Cache(sizes: sizes, spacing: spacing)
  }

  public func updateCache(_ cache: inout Cache, subviews: Subviews) {
    cache.sizes = subviews.map { $0.sizeThatFits(.unspecified) }
  }

  public func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) -> CGSize {
    var totalHeight = 0.0
    var totalWidth = 0.0

    var lineWidth = 0.0
    var lineHeight = 0.0

    for index in subviews.indices {
      if lineWidth + cache.sizes[index].width > proposal.width ?? 0 {
        totalHeight += lineHeight
        lineWidth = cache.sizes[index].width
        lineHeight = cache.sizes[index].height
      } else {
        lineWidth += cache.sizes[index].width + (spacing ?? cache.spacing[index])
        lineHeight = max(lineHeight, cache.sizes[index].height)
      }

      totalWidth = max(totalWidth, lineWidth)
    }

    totalHeight += lineHeight

    return .init(width: totalWidth, height: totalHeight)
  }

  public func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Cache) {
    var lineX = bounds.minX
    var lineY = bounds.minY
    var lineHeight: CGFloat = 0

    for index in subviews.indices {
      if lineX + cache.sizes[index].width > (proposal.width ?? 0) {
        lineY += lineHeight
        lineHeight = 0
        lineX = bounds.minX
      }

      let position = CGPoint(
        x: lineX + cache.sizes[index].width / 2,
        y: lineY + cache.sizes[index].height / 2
      )

      lineHeight = max(lineHeight, cache.sizes[index].height)
      lineX += cache.sizes[index].width + (spacing ?? cache.spacing[index])

      subviews[index].place(
        at: position,
        anchor: .center,
        proposal: ProposedViewSize(cache.sizes[index])
      )
    }
  }
}
