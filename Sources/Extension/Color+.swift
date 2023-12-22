import SwiftUI

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension Color {
  init(hex: String) {
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

  /// 0x3300cc or 0x30c
  init(hex: UInt32, opacity: Double = 1) {
    let short = hex <= 0xfff
    let divisor: CGFloat = short ? 15 : 255
    let red   = CGFloat(short  ? (hex & 0xF00) >> 8 : (hex & 0xFF0000) >> 16) / divisor
    let green = CGFloat(short  ? (hex & 0x0F0) >> 4 : (hex & 0xFF00)   >> 8)  / divisor
    let blue  = CGFloat(short  ? (hex & 0x00F)      : (hex & 0xFF))           / divisor
    self.init(red: red, green: green, blue: blue, opacity: opacity)
  }

  static var random: Color {
    .init(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
  }
}

#if os(macOS)

@available(macOS 10.10, *)
public extension Color {
  // MARK: - Label Colors

  /// The color for text labels that contain primary content.
  static let label: Color = .init(.labelColor)
  /// The color for text labels that contain secondary content.
  static let secondaryLabel: Color = .init(.secondaryLabelColor)
  /// The color for text labels that contain tertiary content.
  static let tertiaryLabel: Color = .init(.tertiaryLabelColor)

  // MARK: - Texts Colors

  /// The color for placeholder text in controls or text views.
  static let placeholderText: Color = .init(.placeholderTextColor)

  // MARK: - Link Colors

  /// The color for links.
  static let link: Color = .init(.linkColor)

  // MARK: - Fill Colors

  /// An overlay fill color for thin and small shapes.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill thin or small shapes, such as the track of a slider.
  @available(macOS 14.0, *)
  static let fill: Color = .init(nsColor: .systemFill)

  /// An overlay fill color for medium-size shapes.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill medium-size shapes, such as the background of a switch.
  @available(macOS 14.0, *)
  static let secondaryFill: Color = .init(nsColor: .secondarySystemFill)

  /// An overlay fill color for large shapes.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill large shapes, such as input fields, search bars, or buttons.
  @available(macOS 14.0, *)
  static let tertiaryFill: Color = .init(nsColor: .tertiarySystemFill)

  /// An overlay fill color for large areas that contain complex content.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill large areas that contain complex content, such as an expanded table cell.
  @available(macOS 14.0, *)
  static let quaternaryFill: Color = .init(nsColor: .quaternarySystemFill)

  // MARK: - Background Colors

  /// Background for windows. This should not be used for drawing, and NSVisualEffectMaterialWindowBackground should be used instead.
  static let windowBackground: Color = .init(.windowBackgroundColor)

  /// Background areas revealed behind documents. This should not be used for drawing, and NSVisualEffectMaterialUnderPageBackground should be used instead.
  static let underPageBackground: Color = .init(.underPageBackgroundColor)

  /// Background for content areas: scroll views, table views, collection views. This should not be used for drawing, and NSVisualEffectMaterialContentBackground should be used instead.
  static let controlBackground: Color = .init(.controlBackgroundColor)

  /// The background color of selected and emphasized (focused) content: table views rows, collection views, etc. Alias for +alternateSelectedControlColor
  @available(macOS 10.14, *)
  static let selectedContentBackground: Color = .init(.selectedContentBackgroundColor)

  /// The background color of selected and unemphasized content: table views rows, collection views, etc. Alias for +secondarySelectedControlColor
  @available(macOS 10.14, *)
  static let unemphasizedSelectedContentBackground: Color = .init(.unemphasizedSelectedContentBackgroundColor)

  /// Background color of find indicators: the bubbles that show inline search result hits
  @available(macOS 10.14, *)
  static let findHighlight: Color = .init(.findHighlightColor)

  // MARK: - Separators

  /// The color for thin borders or divider lines that allows some underlying content to be visible.
  ///
  /// This color may be partially transparent to allow the underlying content to show through.
  /// It adapts to the underlying trait environment.
  @available(macOS 10.14, *)
  static let separator: Color = .init(.separatorColor)

  static let grid: Color = .init(.gridColor)
}

@available(macOS 10.10, *)
public extension Color {
  static let background: Color = windowBackground
}

#else

@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macCatalyst 13.0, *)
public extension Color {
  // MARK: - Label Colors

  /// The color for text labels that contain primary content.
  static let label: Color = .init(.label)
  /// The color for text labels that contain secondary content.
  static let secondaryLabel: Color = .init(.secondaryLabel)
  /// The color for text labels that contain tertiary content.
  static let tertiaryLabel: Color = .init(.tertiaryLabel)

  // MARK: - Texts Colors

  /// The color for placeholder text in controls or text views.
  static let placeholderText: Color = .init(.placeholderText)

  // MARK: - Link Colors

  /// The color for links.
  static let link: Color = .init(.link)

  // MARK: - Fill Colors

  /// An overlay fill color for thin and small shapes.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill thin or small shapes, such as the track of a slider.
  static let fill: Color = .init(.systemFill)

  /// An overlay fill color for medium-size shapes.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill medium-size shapes, such as the background of a switch.
  static let secondaryFill: Color = .init(.secondarySystemFill)

  /// An overlay fill color for large shapes.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill large shapes, such as input fields, search bars, or buttons.
  static let tertiaryFill: Color = .init(.tertiarySystemFill)

  /// An overlay fill color for large areas that contain complex content.
  ///
  /// Use system fill colors for items situated on top of an existing background color.
  /// System fill colors incorporate transparency to allow the background color to show through.
  ///
  /// Use this color to fill large areas that contain complex content, such as an expanded table cell.
  static let quaternaryFill: Color = .init(.quaternarySystemFill)

  // MARK: - Background Colors

  /// The color for the main background of your interface.
  static let background: Color = .init(.systemBackground)
  /// The color for content layered on top of the main background.
  static let secondaryBackground: Color = .init(.secondarySystemBackground)
  /// The color for content layered on top of secondary backgrounds.
  static let tertiaryBackground: Color = .init(.tertiarySystemBackground)

  // MARK: - Grouped Background Colors

  /// The color for the main background of your grouped interface.
  static let groupedBackground: Color = .init(.systemGroupedBackground)
  /// The color for content layered on top of the main background of your grouped interface.
  static let secondaryGroupedBackground: Color = .init(.secondarySystemGroupedBackground)
  /// The color for content layered on top of secondary backgrounds of your grouped interface.
  static let tertiaryGroupedBackground: Color = .init(.tertiarySystemGroupedBackground)

  // MARK: - Separators

  /// The color for thin borders or divider lines that allows some underlying content to be visible.
  ///
  /// This color may be partially transparent to allow the underlying content to show through.
  /// It adapts to the underlying trait environment.
  static let separator: Color = .init(.separator)

  /// The color for borders or divider lines that hides any underlying content.
  ///
  /// This color is always opaque. It adapts to the underlying trait environment.
  static let opaqueSeparator: Color = .init(.opaqueSeparator)
}

#endif
