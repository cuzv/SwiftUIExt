import SwiftUI

/// https://swiftwithmajid.com/2020/03/18/anchor-preferences-in-swiftui/
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public struct Grid<Data: RandomAccessCollection, ElementView: View>: View where Data.Element: Hashable {
  private let data: Data
  private let itemView: (Data.Element) -> ElementView

  @State private var preferences: [Data.Element: CGRect] = [:]

  public init(_ data: Data, @ViewBuilder itemView: @escaping (Data.Element) -> ElementView) {
    self.data = data
    self.itemView = itemView
  }

  public var body: some View {
    GeometryReader { geometry in
      ZStack(alignment: .topLeading) {
        ForEach(data, id: \.self) { element in
          itemView(element)
            .alignmentGuide(.leading) { _ in
              -preferences[element, default: .zero].origin.x
            }.alignmentGuide(.top) { _ in
              -preferences[element, default: .zero].origin.y
            }.anchorPreference(
              key: SizePreferences<Data.Element>.self,
              value: .bounds
            ) {
              [element: geometry[$0].size]
            }
        }
      }
      .onPreferenceChange(SizePreferences<Data.Element>.self) { sizes in
        var newPreferences: [Data.Element: CGRect] = [:]
        var bounds: [CGRect] = []
        for element in data {
          let size = sizes[element, default: .zero]
          let rect: CGRect
          if let lastBounds = bounds.last {
            if lastBounds.maxX + size.width > geometry.size.width {
              let origin = CGPoint(x: 0, y: lastBounds.maxY)
              rect = CGRect(origin: origin, size: size)
            } else {
              let origin = CGPoint(x: lastBounds.maxX, y: lastBounds.minY)
              rect = CGRect(origin: origin, size: size)
            }
          } else {
            rect = CGRect(origin: .zero, size: size)
          }
          bounds.append(rect)
          newPreferences[element] = rect
        }
        preferences = newPreferences
      }
    }
  }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension Grid {
  struct SizePreferences<Item: Hashable>: PreferenceKey {
    typealias Value = [Item: CGSize]

    static var defaultValue: Value { [:] }

    static func reduce(
      value: inout Value,
      nextValue: () -> Value
    ) {
      value.merge(nextValue()) { $1 }
    }
  }
}
