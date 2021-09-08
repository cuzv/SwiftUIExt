import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
/// template & text should have the same font.
public struct DynamicText: View {
  private let template: Text
  private let text: Text

  public init(
    template: Text,
    text: Text
  ) {
    self.template = template
    self.text = text
  }

  public var body: some View {
    template
      .hidden()
      .padding(4)
      .overlay(text)
  }
}
