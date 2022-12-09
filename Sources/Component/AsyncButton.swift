#if os(iOS)
import SwiftUI

/// https://www.swiftbysundell.com/articles/building-an-async-swiftui-button/
public struct AsyncButton<Label: View>: View {
  private let options: Set<ActionOption>
  private let action: () async throws -> Void
  private let onError: (any Error) -> Void
  @ViewBuilder private let label: () -> Label
  
  @State private var isDisabled = false
  @State private var showProgressView = false
  
  public init(
    options: Set<ActionOption> = Set(ActionOption.allCases),
    action: @escaping () async throws -> Void,
    error: @escaping (any Error) -> Void = { _ in },
    @ViewBuilder label: @escaping () -> Label
  ) {
    self.options = options
    self.action = action
    self.onError = error
    self.label = label
  }
  
  public var body: some View {
    Button(
      action: {
        if options.contains(.disableButton) {
          isDisabled = true
        }
        
        Task {
          var progressViewTask: Task<Void, Error>?
          
          if options.contains(.showProgressView) {
            progressViewTask = Task {
              try await Task.sleep(nanoseconds: 100_000_000)
              showProgressView = true
            }
          }

          do {
            try await action()
          } catch {
            onError(error)
          }

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
    options: Set<ActionOption> = Set(ActionOption.allCases),
    action: @escaping () async throws -> Void
  ) {
    self.init(options: options, action: action) {
      Text(titleKey)
    }
  }
  
  public init<S: StringProtocol>(
    _ title: S,
    options: Set<ActionOption> = Set(ActionOption.allCases),
    action: @escaping () async throws -> Void
  ) {
    self.init(options: options, action: action) {
      Text(title)
    }
  }
}
#endif
