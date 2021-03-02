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
    case icon3
    case icon4
    case icon6

    // MARK: Internal

    static var titles: [String] = Self.allCases.map(\.localizedText)

    static var defaultValue: Self { AppIcon.default }

    var iconName: String? {
        switch self {
        case .default: return nil
        case .icon1: return "icon1"
        case .icon3: return "icon3"
        case .icon4: return "icon4"
        case .icon6: return "icon6"
        }
    }

    var localizedText: String {
        "Icon \(rawValue + 1)"
    }

    var displayImage: UIImage? {
        switch self {
        case .default: return Bundle.main.icon
        case .icon1: return "icon1_120".asImage
        case .icon3: return "icon3_120".asImage
        case .icon4: return "icon4_120".asImage
        case .icon6: return "icon6_120".asImage
        }
    }
}

// TODO: add all current color schemes pallete as premium features?
enum AppTheme: Int, CaseIterable, SettingsValueMappable {
    case followSystem
    case light
    case dark
    case trueLight
    case trueDark

    // MARK: Internal

    static var titles: [String] = Self.allCases.map(\.localizedText)

    static var defaultValue: Self { .light }

    var localizedText: String {
        switch self {
        case .followSystem: return NSLocalizedString("Follow system", comment: "")
        case .dark: return NSLocalizedString("Dark", comment: "")
        case .light: return NSLocalizedString("Light", comment: "")
        case .trueDark: return NSLocalizedString("True Dark", comment: "")
        case .trueLight: return NSLocalizedString("True Light", comment: "")
        }
    }

    // MARK: - SettingsValueMappable

    static func mapFromText(_ text: String?) -> Self {
        switch text {
        case AppTheme.followSystem.localizedText: return .followSystem
        case AppTheme.dark.localizedText: return .dark
        case AppTheme.light.localizedText: return .light
        case AppTheme.trueDark.localizedText: return .trueDark
        case AppTheme.trueLight.localizedText: return .trueLight
        default: return .light
        }
    }
}

enum DaySupplementaryType: Int, CaseIterable, SettingsValueMappable {
    case none
    case lunarDate
    case oneDot

    // MARK: Internal

    static var titles: [String] = Self.allCases.map(\.localizedText)

    static var defaultValue: Self { .none }

    var localizedText: String {
        switch self {
        case .none: return NSLocalizedString("None", comment: "")
        case .lunarDate: return NSLocalizedString("Lunar date", comment: "")
        case .oneDot: return NSLocalizedString("One dot", comment: "")
        }
    }

    // MARK: - SettingsValueMappable

    static func mapFromText(_ text: String?) -> Self {
        switch text {
        case DaySupplementaryType.lunarDate.localizedText: return .lunarDate
        case DaySupplementaryType.oneDot.localizedText: return .oneDot
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

    // MARK: Internal

    static var titles: [String] = Self.allCases.map(\.localizedText)

    static var defaultValue: Self { .system }

    var localizedText: String {
        switch self {
        case .system: return NSLocalizedString("Follow system", comment: "")
        case .light: return NSLocalizedString("Light", comment: "")
        case .dark: return NSLocalizedString("Dark", comment: "")
        }
    }

    // MARK: - SettingsValueMappable

    static func mapFromText(_ text: String?) -> Self {
        switch text {
        case WidgetTheme.system.localizedText: return .system
        case WidgetTheme.light.localizedText: return .light
        case WidgetTheme.dark.localizedText: return .dark
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
