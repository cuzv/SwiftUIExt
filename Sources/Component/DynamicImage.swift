import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public struct DynamicImage: View {
  private let template: Text
  private let image: Image

  public init(
    template: Text,
    image: Image
  ) {
    self.template = template
    self.image = image
  }

  public var body: some View {
    template
      .hidden()
      .overlay(
        image
          .resizable()
          .scaledToFit()
      )
  }
}
