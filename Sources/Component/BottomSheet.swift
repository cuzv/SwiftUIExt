#if os(iOS)
import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public struct BottomSheet<Content: View>: View {
  @Binding private var isOpen: Bool
  private let maxHeight: CGFloat
  private let minHeight: CGFloat
  private let content: Content

  public init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
    self.minHeight = maxHeight * constants.minHeightRatio
    self.maxHeight = maxHeight
    self.content = content()
    self._isOpen = isOpen
  }

  public var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 0) {
        indicator.padding()
        content
      }
      .frame(width: geometry.size.width, height: maxHeight, alignment: .top)
      .background(Color(.secondarySystemBackground))
      .cornerRadius(constants.radius)
      .frame(height: geometry.size.height, alignment: .bottom)
      .offset(y: max(offset + translation, 0))
      .animation(.interactiveSpring())
      .gesture(
        DragGesture().updating($translation) { value, state, _ in
          state = value.translation.height
        }.onEnded { value in
          let snapDistance = maxHeight * constants.snapRatio
          guard abs(value.translation.height) > snapDistance else { return }
          isOpen = value.translation.height < 0
        }
      )
    }
  }

  private let constants = Constants()
  @GestureState private var translation: CGFloat = 0

  private var offset: CGFloat {
    isOpen ? 0 : maxHeight - minHeight
  }

  private var indicator: some View {
    RoundedRectangle(cornerRadius: constants.radius)
      .fill(Color.secondary)
      .frame(
        width: constants.indicatorWidth,
        height: constants.indicatorHeight
      ).onTapGesture {
        isOpen.toggle()
      }
  }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
private extension BottomSheet {
  struct Constants {
    let radius: CGFloat = 16
    let indicatorHeight: CGFloat = 6
    let indicatorWidth: CGFloat = 60
    let snapRatio: CGFloat = 0.25
    let minHeightRatio: CGFloat = 0.3
  }
}
#endif
