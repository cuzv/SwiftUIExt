#if os(iOS)
import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension Color {
  public init(hex: String) {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int = UInt64()
    Scanner(string: hex).scanHexInt64(&int)

    // swiftlint:disable:next identifier_name
    let a, r, g, b: UInt64
    switch hex.count {
    case 3: // RGB (12-bit)
      (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
      (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
      (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
      (a, r, g, b) = (255, 0, 0, 0)
    }
    self.init(red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
  }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
extension Color {
  public static var random: Color { .init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)) }

  // MARK: - Label Colors

  /// The color for text labels that contain primary content.
  public static let label: Color = .init(.label)
  /// The color for text labels that contain secondary content.
  public static let secondaryLabel: Color = .init(.secondaryLabel)
  /// The color for text labels that contain tertiary content.
  public static let tertiaryLabel: Color = .init(.tertiaryLabel)

  // MARK: - Texts Colors

  /// The color for placeholder text in controls or text views.
  public static let placeholderText: Color = .init(.placeholderText)

  // MARK: - Link Colors

  /// The color for links.
  public static let link: Color = .init(.link)

  // MARK: - Fill Colors

  /// An overlay fill color for thin and small shapes.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill thin or small shapes, such as the track of a slider.
  public static let fill: Color = .init(.systemFill)

  /// An overlay fill color for medium-size shapes.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill medium-size shapes, such as the background of a switch.
  public static let secondaryFill: Color = .init(.secondarySystemFill)

  /// An overlay fill color for large shapes.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill large shapes, such as input fields, search bars, or buttons.
  public static let tertiaryFill: Color = .init(.tertiarySystemFill)

  /// An overlay fill color for large areas that contain complex content.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill large areas that contain complex content, such as an expanded table cell.
  public static let quaternaryFill: Color = .init(.quaternarySystemFill)

  // MARK: - Background Colors

  /// The color for the main background of your interface.
  public static let background: Color = .init(.systemBackground)
  /// The color for content layered on top of the main background.
  public static let secondaryBackground: Color = .init(.secondarySystemBackground)
  /// The color for content layered on top of secondary backgrounds.
  public static let tertiaryBackground: Color = .init(.tertiarySystemBackground)

  // MARK: - Grouped Background Colors

  /// The color for the main background of your grouped interface.
  public static let groupedBackground: Color = .init(.systemGroupedBackground)
  /// The color for content layered on top of the main background of your grouped interface.
  public static let secondaryGroupedBackground: Color = .init(.secondarySystemGroupedBackground)
  /// The color for content layered on top of secondary backgrounds of your grouped interface.
  public static let tertiaryGroupedBackground: Color = .init(.tertiarySystemGroupedBackground)

  // MARK: - Separators

  /// The color for thin borders or divider lines that allows some underlying content to be visible.
  ///
  /// This color may be partially transparent to allow the underlying content to show through.
  /// It adapts to the underlying trait environment.
  public static let separator: Color = .init(.separator)

  /// The color for borders or divider lines that hides any underlying content.
  ///
  /// This color is always opaque. It adapts to the underlying trait environment.
  public static let opaqueSeparator: Color = .init(.opaqueSeparator)
}
#endif
