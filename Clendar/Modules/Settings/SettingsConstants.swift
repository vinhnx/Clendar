//
//  SettingsConstans.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

enum AppIcon: CaseIterable {
    case light
    case dark
    case dimmedDark

    // MARK: Internal

    static var titles: [String] = Self.allCases.map(\.localizedText)
    static var defaultValue: String { AppIcon.light.localizedText }

    var iconName: String? {
        switch self {
        case .light: return nil
        case .dark: return "dark_icon"
        case .dimmedDark: return "dim_dark_icon"
        }
    }

    var localizedText: String {
        switch self {
        case .light: return NSLocalizedString("Light", comment: "")
        case .dark: return NSLocalizedString("Dark", comment: "")
        case .dimmedDark: return NSLocalizedString("Dim", comment: "")
        }
    }

    var displayImage: UIImage? {
        switch self {
        case .light: return Bundle.main.icon
        case .dark: return "dark_icon_120".asImage
        case .dimmedDark: return "dim_dark_icon_120".asImage
        }
    }

    static func mapFromString(_ string: String?) -> Self {
        switch string {
        case AppIcon.dark.localizedText: return .dark
        case AppIcon.dimmedDark.localizedText: return .dimmedDark
        default: return .light
        }
    }
}

enum Theme: Int, CaseIterable {
    case dark
    case light

    // MARK: Internal

    static var titles: [String] = Self.allCases.map(\.localizedText)

    var localizedText: String {
        switch self {
        case .dark: return NSLocalizedString("Dark", comment: "")
        case .light: return NSLocalizedString("Light", comment: "")
        }
    }
}

enum DaySupplementaryType: String, CaseIterable {
    case none = "None"
    case lunarDate = "Lunar date"
    case oneDot = "One dot"

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
}

// as minutes
var DefaultEventDurations: [Int] = [
    0,
    15,
    30,
    45,
    60,
    90,
    120,
    180
]

enum BadgeSettings: String, CaseIterable {
    case none = "None"
    case date = "Date"
    case month = "Month"

    // MARK: Internal

    static var titles: [String] { Self.allCases.map(\.rawValue) }
    static var defaultValue: Self { .none }

    var localizedText: String {
        switch self {
        case .none: return NSLocalizedString("None", comment: "")
        case .date: return NSLocalizedString("Date", comment: "")
        case .month: return NSLocalizedString("Month", comment: "")
        }
    }
}

enum WidgetTheme: CaseIterable {
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
}

enum CalendarViewMode: Int, CaseIterable {
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
}
