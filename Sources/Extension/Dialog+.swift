import SwiftUI

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, macCatalyst 15.0, *)
public extension View {
  func confirmationDialog<A, M, T>(
    _ titleKey: LocalizedStringKey,
    item: Binding<T?>,
    titleVisibility: Visibility = .automatic,
    @ViewBuilder actions: (T) -> A,
    @ViewBuilder message: (T) -> M
  ) -> some View where A: View, M: View {
    confirmationDialog(
      titleKey,
      isPresented: Binding(
        get: { item.wrappedValue != nil },
        set: { value in
          // There's shouldn't be a way for SwiftUI to set `true` here.
          if !value {
            item.wrappedValue = nil
          }
        }
      ),
      titleVisibility: titleVisibility,
      presenting: item.wrappedValue,
      actions: actions,
      message: message
    )
  }

  func confirmationDialog<A, T>(
    _ title: Text,
    item: Binding<T?>,
    titleVisibility: Visibility = .automatic,
    @ViewBuilder actions: (T) -> A
  ) -> some View where A: View {
    confirmationDialog(
      title,
      isPresented: Binding(
        get: { item.wrappedValue != nil },
        set: { value in
          // There's shouldn't be a way for SwiftUI to set `true` here.
          if !value {
            item.wrappedValue = nil
          }
        }
      ),
      titleVisibility: titleVisibility,
      actions: {
        if let value = item.wrappedValue {
          actions(value)
        }
      }
    )
  }
}

