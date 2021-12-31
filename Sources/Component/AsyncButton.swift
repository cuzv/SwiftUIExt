#if os(iOS)
import SwiftUI

/// https://www.swiftbysundell.com/articles/building-an-async-swiftui-button/
public struct AsyncButton<Label: View>: View {
  private let actionOptions: Set<ActionOption>
  private let action: () async -> Void
  @ViewBuilder private let label: () -> Label
  
  @State private var isDisabled = false
  @State private var showProgressView = false
  
  public init(
    actionOptions: Set<ActionOption> = Set(ActionOption.allCases),
    action: @escaping () async -> Void,
    @ViewBuilder label: @escaping () -> Label
  ) {
    self.actionOptions = actionOptions
    self.action = action
    self.label = label
  }
  
  public var body: some View {
    Button(
      action: {
        if actionOptions.contains(.disableButton) {
          isDisabled = true
        }
        
        Task {
          var progressViewTask: Task<Void, Error>?
          
          if actionOptions.contains(.showProgressView) {
            progressViewTask = Task {
              try await Task.sleep(nanoseconds: 150_000_000)
              showProgressView = true
            }
          }
          
          await action()
          progressViewTask?.cancel()
          
          isDisabled = false
          showProgressView = false
        }
      },
      label: {
        ZStack {
          label().opacity(showProgressView ? 0 : 1)
          
          if showProgressView {
            if #available(iOS 14.0, *) {
              ProgressView()
            } else {
              ActivityIndicator(style: .medium, isAnimating: .constant(true))
            }
          }
        }
      }
    ).disabled(isDisabled)
  }
}

extension AsyncButton {
  public enum ActionOption: CaseIterable {
    case disableButton
    case showProgressView
  }
}

extension AsyncButton where Label == Text {
  public init(
    _ titleKey: LocalizedStringKey,
    actionOptions: Set<ActionOption> = Set(ActionOption.allCases),
    action: @escaping () async -> Void
  ) {
    self.init(actionOptions: actionOptions, action: action) {
      Text(titleKey)
    }
  }
  
  public init<S: StringProtocol>(
    _ title: S,
    actionOptions: Set<ActionOption> = Set(ActionOption.allCases),
    action: @escaping () async -> Void
  ) {
    self.init(actionOptions: actionOptions, action: action) {
      Text(title)
    }
  }
}
#endif
