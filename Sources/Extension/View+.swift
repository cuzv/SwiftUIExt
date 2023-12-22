import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, macCatalyst 13.0, *)
public extension View {
  func inButton(action: @escaping () -> Void) -> Button<Self> {
    Button(action: action) {
      self
    }
  }

  func inList() -> some View {
    List {
      self
    }
  }

  func eraseToAnyView() -> AnyView {
    AnyView(self)
  }

  @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, macCatalyst 14.0, *)
  @ViewBuilder
  func unredacted(when condition: Bool) -> some View {
    if condition {
      unredacted()
    } else {
      redacted(reason: .placeholder)
    }
  }

  func adaptiveHeight(
    alignment: VerticalAlignment,
    cacheHeight: Binding<CGFloat>
  ) -> some View {
    frame(minHeight: cacheHeight.wrappedValue)
      .alignmentGuide(alignment) { dimensions in
        let dh = dimensions.height
        if dh.isNormal {
          let nh = max(cacheHeight.wrappedValue, dh)
          if cacheHeight.wrappedValue != nh {
            DispatchQueue.main.async {
              cacheHeight.wrappedValue = nh
            }
          }
        }
        return dimensions[alignment]
      }
  }

  /// Why Conditional View Modifiers are a Bad Idea
  ///
  /// https://www.objc.io/blog/2021/08/24/conditional-view-modifiers/
  @ViewBuilder
  func applyIf<Transform: View>(
    _ condition: @autoclosure () -> Bool,
    transform: (Self) -> Transform
  ) -> some View {
    if condition() {
      transform(self)
    } else {
      self
    }
  }

  /// Why Conditional View Modifiers are a Bad Idea
  ///
  /// https://www.objc.io/blog/2021/08/24/conditional-view-modifiers/
  @ViewBuilder
  func applyGotten<Transform: View, T>(
    _ getter: @autoclosure () -> T?,
    transform: (Self, T) -> Transform
  ) -> some View {
    if let v = getter() {
      transform(self, v)
    } else {
      self
    }
  }

  @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, macCatalyst 15.0, *)
  func animatableForeground(_ color: Color) -> some View {
    overlay(
      Rectangle()
        .fill(color)
    )
    .mask {
      blendMode(.overlay)
    }
  }
}

// extension View {
//   @backDeployed(before: iOS 15.0)
//   @available(iOS 13.0, *)
//   public func background<T: View>(
//     alignment: Alignment = .center,
//     @ViewBuilder content: () -> T
//   ) -> some View {
//     background(Group(content: content), alignment: alignment)
//   }

//   @backDeployed(before: iOS 15.0)
//   @available(iOS 13.0, *)
//   public func overlay<T: View>(
//     alignment: Alignment = .center,
//     @ViewBuilder content: () -> T
//   ) -> some View {
//     overlay(Group(content: content), alignment: alignment)
//   }
// }

#if os(iOS)
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension View {
  public func snapshot() -> UIImage {
    let controller = UIHostingController(rootView: self)
    let view = controller.view

    let targetSize = controller.view.intrinsicContentSize
    view?.bounds = CGRect(origin: .zero, size: targetSize)
    view?.backgroundColor = .systemBackground

    let renderer = UIGraphicsImageRenderer(size: targetSize)

    return renderer.image { _ in
      view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
    }
  }
}
#endif

public extension View {
  func endEditing() {
#if os(iOS)
    UIApplication.shared.sendAction(
      #selector(UIResponder.resignFirstResponder),
      to: nil, from: nil, for: nil
    )
#endif
  }
}
