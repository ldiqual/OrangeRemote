// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum L10n {
  internal static func settingsNetwork(_ p1: String) -> String {
    return L10n.tr("Localizable", "settings_network", p1)
  }
  internal static let settingsPower = L10n.tr("Localizable", "settings_power")
  internal static let settingsTitle = L10n.tr("Localizable", "settings_title")
  internal static let settingsWifi = L10n.tr("Localizable", "settings_wifi")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
