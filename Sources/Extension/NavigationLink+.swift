import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension NavigationLink where Label == EmptyView {
  // See https://fivestars.blog/swiftui/programmatic-navigation.html
  init?<V: Identifiable>(
    item: Binding<V?>,
    destination: @escaping (V) -> Destination
  ) {
    if let value = item.wrappedValue {
      let isActive: Binding<Bool> = Binding(
        get: { item.wrappedValue != nil },
        set: { value in
          // There's shouldn't be a way for SwiftUI to set `true` here.
          if !value {
            item.wrappedValue = nil
          }
        }
      )

      self.init(
        destination: destination(value),
        isActive: isActive,
        label: { EmptyView() }
      )
    } else {
      return nil
    }
  }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension NavigationLink {
  init<V: View>(
    destination: @escaping @autoclosure () -> V,
    label: () -> Label
  ) where LazyView<V> == Destination {
    self.init(destination: LazyView(content: destination()), label: label)
  }

  init<T, V: View>(
    destination: @escaping @autoclosure () -> V,
    tag: T,
    selection: Binding<T?>
  ) where T: Hashable, Label == EmptyView, LazyView<V> == Destination {
    self.init(destination: LazyView(content: destination()), tag: tag, selection: selection, label: Label.init)
  }
}

// MARK: -

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension View {
  @available(*, deprecated, message: "iOS 14.5+ has no push animation, use NavigationLink.init(destination:tag:selection:) or NavigationLink.init(destination:label:) instead.")
  func navigation<V: Identifiable>(
    item: Binding<V?>,
    destination: @escaping (V) -> some View
  ) -> some View {
    background(NavigationLink(item: item, destination: destination))
  }

  @ViewBuilder
  func navigation(
    isActive: Binding<Bool>? = nil,
    destination: @autoclosure @escaping () -> some View
  ) -> some View {
    if let isActive {
      NavigationLink(
        destination: LazyView(content: destination()),
        isActive: isActive
      ) { self }
    } else {
      NavigationLink(
        destination: LazyView(content: destination())
      ) { self }
    }
  }

  func onNavigation(_ action: @escaping () -> Void) -> some View {
    let isActive = Binding(
      get: { false },
      set: { newValue in
        if newValue {
          action()
        }
      }
    )
    return NavigationLink(
      destination: EmptyView(),
      isActive: isActive
    ) {
      self
    }
  }
}
