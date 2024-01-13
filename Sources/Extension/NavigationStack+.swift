import SwiftUI

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
public extension View {
  func inNavigationLink(value: (some Decodable & Encodable & Hashable)?) -> some View {
    NavigationLink(value: value) {
      self
    }
  }

  func inNavigationStack() -> some View {
    NavigationStack {
      self
    }
  }

  func inNavigationStack<Data>(path: Binding<Data>) -> some View where Data: MutableCollection, Data: RandomAccessCollection, Data: RangeReplaceableCollection, Data.Element: Hashable {
    NavigationStack(path: path) {
      self
    }
  }

  func inNavigationStack(path: Binding<NavigationPath>) -> some View {
    NavigationStack(path: path) {
      self
    }
  }
}
