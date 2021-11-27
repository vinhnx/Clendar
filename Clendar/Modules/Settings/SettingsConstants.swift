//
//  SettingsConstans.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsValueMappable {
    static func mapFromText(_ text: String?) -> Self
}

enum AppIcon: Int, CaseIterable {
    case `default`
    case icon1
    case icon2
    case icon3
    case icon4
    case original

    // MARK: Internal

    static var titles: [String] = Self.allCases.map(\.localizedText)

    static var defaultValue: Self { AppIcon.default }

    var iconName: String? {
        switch self {
        case .default: return nil
        case .icon1: return "icon1"
        case .icon2: return "icon2"
        case .icon3: return "icon3"
        case .icon4: return "icon4"
        case .original: return "original"
        }
    }

    var localizedText: String {
        switch self {
        case .default: return "Default"
        default: return iconName ?? "Icon \(rawValue)"
        }
    }

    var displayImage: UIImage? {
        switch self {
        case .default: return Bundle.main.icon
        case .icon1, .icon2, .icon3, .icon4: return "\(iconName ?? "")_120".asImage
        case .original: return "original_120".asImage
        }
    }
}

// TODO: add all current color schemes pallete as premium features?
enum AppTheme: Int, CaseIterable, SettingsValueMappable {
    case system
    case light
    case dark
    case trueLight
    case trueDark
    case E4ECF5

    // MARK: Internal

    static var titles: [String] = Self.allCases.map(\.localizedText)

    static var defaultValue: Self { .light }

    var localizedText: String {
        switch self {
        case .system: return NSLocalizedString("Follow system", comment: "")
        case .dark: return NSLocalizedString("Dark", comment: "")
        case .light: return NSLocalizedString("Light", comment: "")
        case .trueDark: return NSLocalizedString("True Dark", comment: "")
        case .trueLight: return NSLocalizedString("True Light", comment: "")
        case .E4ECF5: return NSLocalizedString("E4ECF5", comment: "")
        }
    }

    // MARK: - SettingsValueMappable

    static func mapFromText(_ text: String?) -> Self {
        switch text {
        case AppTheme.system.localizedText: return .system
        case AppTheme.dark.localizedText: return .dark
        case AppTheme.light.localizedText: return .light
        case AppTheme.trueDark.localizedText: return .trueDark
        case AppTheme.trueLight.localizedText: return .trueLight
        case AppTheme.E4ECF5.localizedText: return .E4ECF5
        default: return .light
        }
    }
}

enum DaySupplementaryType: Int, CaseIterable, SettingsValueMappable {
    case none
    case lunarDate

    // MARK: Internal

    static var titles: [String] = Self.allCases.map(\.localizedText)

    static var defaultValue: Self { .none }

    var localizedText: String {
        switch self {
        case .none: return NSLocalizedString("None", comment: "")
        case .lunarDate: return NSLocalizedString("Lunar date", comment: "")
        }
    }

    // MARK: - SettingsValueMappable

    static func mapFromText(_ text: String?) -> Self {
        switch text {
        case DaySupplementaryType.lunarDate.localizedText: return .lunarDate
        case DaySupplementaryType.none.localizedText: return .none
        default: return .none
        }
    }

}

// as minutes
var DefaultEventDurations: [Int] = [0, 15, 30, 45, 60, 90, 120, 180]

enum WidgetTheme: Int, CaseIterable, SettingsValueMappable {
    case system
    case light
    case dark
    case E4ECF5

    // MARK: Internal

    static var titles: [String] = Self.allCases.map(\.localizedText)

    static var defaultValue: Self { .system }

    var localizedText: String {
        switch self {
        case .system: return NSLocalizedString("Follow system", comment: "")
        case .light: return NSLocalizedString("Light", comment: "")
        case .dark: return NSLocalizedString("Dark", comment: "")
        case .E4ECF5: return "E4ECF5"
        }
    }

    // MARK: - SettingsValueMappable

    static func mapFromText(_ text: String?) -> Self {
        switch text {
        case WidgetTheme.system.localizedText: return .system
        case WidgetTheme.light.localizedText: return .light
        case WidgetTheme.dark.localizedText: return .dark
        case WidgetTheme.E4ECF5.localizedText: return .E4ECF5
        default: return .system
        }
    }
}

enum CalendarViewMode: Int, CaseIterable, SettingsValueMappable {
    case month
    case week

    // MARK: Internal

    static var titles: [String] = Self.allCases.map(\.localizedText)

    static var defaultValue: Self { .month }

    var localizedText: String {
        switch self {
        case .month: return NSLocalizedString("Month", comment: "")
        case .week: return NSLocalizedString("Week", comment: "")
        }
    }

    // MARK: - SettingsValueMappable

    static func mapFromText(_ text: String?) -> Self {
        switch text {
        case CalendarViewMode.month.localizedText: return .month
        case CalendarViewMode.week.localizedText: return .week
        default: return .month
        }
    }
}
