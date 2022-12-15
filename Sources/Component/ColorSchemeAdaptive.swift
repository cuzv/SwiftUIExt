import SwiftUI

public struct ColorSchemeAdaptive<Content: View>: View {
  public let lightContent: () -> Content
  public let darkContent: () -> Content

  public init(lightContent: @escaping () -> Content, darkContent: @escaping () -> Content) {
    self.lightContent = lightContent
    self.darkContent = darkContent
  }

  @Environment(\.colorScheme) private var colorScheme

  public var body: some View {
    switch colorScheme {
    case .light:
      lightContent()
    case .dark:
      darkContent()
    @unknown default:
      lightContent()
    }
  }
}
