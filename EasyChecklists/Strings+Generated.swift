// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Checklists are a simple but effective tool that can help you to be more productive and efficient.
  /// They can help you to prioritize your work, and make it easier to delegate tasks to others.
  /// In addition, checklists can serve as a record of your progress and accomplishments, and can be used to identify areas for improvement.
  internal static let aboutChecklists = L10n.tr("Localizable", "AboutChecklists", fallback: "Checklists are a simple but effective tool that can help you to be more productive and efficient.\nThey can help you to prioritize your work, and make it easier to delegate tasks to others.\nIn addition, checklists can serve as a record of your progress and accomplishments, and can be used to identify areas for improvement.")
  /// Type task title here..
  internal static let addItemTextFieldPlaceholder = L10n.tr("Localizable", "AddItemTextFieldPlaceholder", fallback: "Type task title here..")
  /// plus
  internal static let addListIcon = L10n.tr("Localizable", "AddListIcon", fallback: "plus")
  /// Pick a checklist color
  internal static let addListPickColorLabel = L10n.tr("Localizable", "AddListPickColorLabel", fallback: "Pick a checklist color")
  /// Pick a checklist icon
  internal static let addListPickIconLabel = L10n.tr("Localizable", "AddListPickIconLabel", fallback: "Pick a checklist icon")
  /// e.g. Shopping list
  internal static let addListTextFieldPlaceholder = L10n.tr("Localizable", "AddListTextFieldPlaceholder", fallback: "e.g. Shopping list")
  /// Add new checklist
  internal static let addListViewTitle = L10n.tr("Localizable", "AddListViewTitle", fallback: "Add new checklist")
  /// All Checklists
  internal static let allChecklistsTabBarLabel = L10n.tr("Localizable", "AllChecklistsTabBarLabel", fallback: "All Checklists")
  /// My checklists
  internal static let allListsViewTitle = L10n.tr("Localizable", "AllListsViewTitle", fallback: "My checklists")
  /// Cancel
  internal static let cancelButtonTitle = L10n.tr("Localizable", "CancelButtonTitle", fallback: "Cancel")
  /// blue
  internal static let categoryDefaultColor = L10n.tr("Localizable", "CategoryDefaultColor", fallback: "blue")
  /// doc
  internal static let categoryDefaultIcon = L10n.tr("Localizable", "CategoryDefaultIcon", fallback: "doc")
  /// Default
  internal static let categoryDefaultName = L10n.tr("Localizable", "CategoryDefaultName", fallback: "Default")
  /// Please type a category name
  internal static let categoryNameAlert = L10n.tr("Localizable", "CategoryNameAlert", fallback: "Please type a category name")
  /// checklist
  internal static let checklistsIcon = L10n.tr("Localizable", "ChecklistsIcon", fallback: "checklist")
  /// checklist.checked
  internal static let checkListsIconSelected = L10n.tr("Localizable", "CheckListsIconSelected", fallback: "checklist.checked")
  /// Done
  internal static let doneButtonTitle = L10n.tr("Localizable", "DoneButtonTitle", fallback: "Done")
  /// Edit item
  internal static let editItemAlertMessage = L10n.tr("Localizable", "EditItemAlertMessage", fallback: "Edit item")
  /// Edit
  internal static let editItemAlertTitle = L10n.tr("Localizable", "EditItemAlertTitle", fallback: "Edit")
  /// Cancel
  internal static let editItemCancelButton = L10n.tr("Localizable", "EditItemCancelButton", fallback: "Cancel")
  /// Please update item
  internal static let editItemTextFieldPlaceholder = L10n.tr("Localizable", "EditItemTextFieldPlaceholder", fallback: "Please update item")
  /// Save
  internal static let editItemUpdateButton = L10n.tr("Localizable", "EditItemUpdateButton", fallback: "Save")
  /// Type task title here..
  internal static let enterItemTitleMessage = L10n.tr("Localizable", "EnterItemTitleMessage", fallback: "Type task title here..")
  /// Edit
  internal static let itemsViewEditButton = L10n.tr("Localizable", "ItemsViewEditButton", fallback: "Edit")
  /// gearshape
  internal static let settingsIcon = L10n.tr("Localizable", "SettingsIcon", fallback: "gearshape")
  /// gearshape.fill
  internal static let settingsIconSelected = L10n.tr("Localizable", "SettingsIconSelected", fallback: "gearshape.fill")
  /// Settings
  internal static let settingsTabBarLabel = L10n.tr("Localizable", "SettingsTabBarLabel", fallback: "Settings")
  /// Settings
  internal static let settingsViewTitle = L10n.tr("Localizable", "SettingsViewTitle", fallback: "Settings")
  /// Edit
  internal static let tapToReorderCellsButtonText = L10n.tr("Localizable", "TapToReorderCellsButtonText", fallback: "Edit")
  /// Done
  internal static let tapToSaveCellsOrder = L10n.tr("Localizable", "TapToSaveCellsOrder", fallback: "Done")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
