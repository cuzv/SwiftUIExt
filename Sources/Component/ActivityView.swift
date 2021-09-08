#if os(iOS)
import UIKit
import SwiftUI
import CoreServices

/// https://gist.github.com/shaps80/8ee53f7e3f07e3cf44f2331775edff98
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public struct ActivityView: UIViewControllerRepresentable {
  private let activityItems: () -> [Any]
  private let applicationActivities: [UIActivity]?
  private let completion: UIActivityViewController.CompletionWithItemsHandler?
  @Binding private var isPresented: Bool

  public init(
    items: Binding<[Any]>,
    activities: [UIActivity]? = nil,
    onComplete: UIActivityViewController.CompletionWithItemsHandler? = nil
  ) {
    let isActive: Binding<Bool> = Binding(
      get: { !items.wrappedValue.isEmpty },
      set: { values in
        // There's shouldn't be a way for SwiftUI to set `true` here.
        if !values {
          items.wrappedValue = []
        }
      }
    )

    _isPresented = isActive
    activityItems = { items.wrappedValue }
    applicationActivities = activities
    completion = onComplete
  }

  public func makeUIViewController(context: Context) -> ActivityViewControllerWrapper {
    ActivityViewControllerWrapper(
      isPresented: $isPresented,
      activityItems: activityItems,
      applicationActivities: applicationActivities,
      onComplete: completion
    )
  }

  public func updateUIViewController(_ uiViewController: ActivityViewControllerWrapper, context: Context) {
    uiViewController.isPresented = $isPresented
    uiViewController.activityItems = activityItems
    uiViewController.applicationActivities = applicationActivities
    uiViewController.completion = completion
    uiViewController.updateState()
  }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
final public class ActivityViewControllerWrapper: UIViewController {
  var activityItems: () -> [Any]
  var applicationActivities: [UIActivity]?
  var isPresented: Binding<Bool>
  var completion: UIActivityViewController.CompletionWithItemsHandler?

  init(
    isPresented: Binding<Bool>,
    activityItems: @escaping () -> [Any],
    applicationActivities: [UIActivity]? = nil,
    onComplete: UIActivityViewController.CompletionWithItemsHandler? = nil
  ) {
    self.activityItems = activityItems
    self.applicationActivities = applicationActivities
    self.isPresented = isPresented
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func didMove(toParent parent: UIViewController?) {
    super.didMove(toParent: parent)
    updateState()
  }

  fileprivate func updateState() {
    let isActivityPresented = presentedViewController != nil

    if isActivityPresented != isPresented.wrappedValue {
      if !isActivityPresented {
        let controller = UIActivityViewController(activityItems: activityItems(), applicationActivities: applicationActivities)
        controller.popoverPresentationController?.sourceView = view
        controller.completionWithItemsHandler = { [weak self] (activityType, success, items, error) in
          self?.isPresented.wrappedValue = false
          self?.completion?(activityType, success, items, error)
        }
        present(controller, animated: true, completion: nil)
      }
    }
  }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension View {
  public func activity(
    contents: Binding<[Any]>,
    activities: [UIActivity]? = nil,
    onComplete: UIActivityViewController.CompletionWithItemsHandler? = nil
  ) -> some View {
    background(
      LazyView(content: ActivityView(
                items: contents,
                activities: activities,
                onComplete: onComplete)
      )
    )
  }
}
#endif
