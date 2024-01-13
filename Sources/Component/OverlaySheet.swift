#if os(iOS)
import SwiftUI
import UIKit

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public struct OverlaySheet<Content: View>: View {
  private let isPresented: Binding<Bool>
  private let makeContent: () -> Content

  @GestureState private var translation = CGPoint.zero

  public init(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
    self.isPresented = isPresented
    makeContent = content
  }

  public var body: some View {
    VStack {
      Spacer()
      makeContent()
    }
    .offset(y: (isPresented.wrappedValue ? 0 : UIScreen.main.bounds.height) + max(0, translation.y))
    .animation(.interpolatingSpring(stiffness: 70, damping: 12))
    .edgesIgnoringSafeArea(.bottom)
    .gesture(panelDraggingGesture)
  }

  private var panelDraggingGesture: some Gesture {
    DragGesture()
      .updating($translation) { current, state, _ in
        state.y = current.translation.height
      }
      .onEnded { state in
        if state.translation.height > 250 {
          isPresented.wrappedValue = false
        }
      }
  }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension View {
  func overlaySheet(
    isPresented: Binding<Bool>,
    @ViewBuilder content: @escaping () -> some View
  ) -> some View {
    overlay(
      OverlaySheet(isPresented: isPresented, content: content)
    )
  }
}
#endif
