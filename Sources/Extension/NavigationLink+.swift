import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension NavigationLink where Label == EmptyView {
  // See https://fivestars.blog/swiftui/programmatic-navigation.html
  public init?<V: Identifiable>(
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
extension NavigationLink {
  public init<V: View>(
    destination: @escaping @autoclosure () -> V,
    label: () -> Label
  ) where LazyView<V> == Destination {
    self.init(destination: LazyView(content: destination()), label: label)
  }

  public init<T, V: View>(
    destination: @escaping @autoclosure () -> V,
    tag: T,
    selection: Binding<T?>
  ) where T: Hashable, Label == EmptyView, LazyView<V> == Destination {
    self.init(destination: LazyView(content: destination()), tag: tag, selection: selection, label: Label.init)
  }
}

// MARK: -

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension View {
  @available(*, deprecated, message: "iOS 14.5+ has no push animation, use NavigationLink.init(destination:tag:selection:) or NavigationLink.init(destination:label:) instead.")
  public func navigation<V: Identifiable, Destination: View>(
    item: Binding<V?>,
    destination: @escaping (V) -> Destination
  ) -> some View {
    background(NavigationLink(item: item, destination: destination))
  }

  @ViewBuilder
  public func navigation<Destination: View>(
    isActive: Binding<Bool>? = nil,
    destination: @autoclosure @escaping () -> Destination
  ) -> some View {
    if let isActive = isActive {
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

  public func onNavigation(_ action: @escaping () -> Void) -> some View {
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
