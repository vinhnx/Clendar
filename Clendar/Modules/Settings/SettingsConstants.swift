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
    case `default`
    case icon1
    case icon3
    case icon4
    case icon6

    // MARK: Internal

    static var titles: [String] = Self.allCases.map(\.localizedText)
    static var defaultValue: String { AppIcon.default.localizedText }

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
        switch self {
        case .default: return NSLocalizedString("Default", comment: "")
        case .icon1: return "icon1"
        case .icon3: return "icon3"
        case .icon4: return "icon4"
        case .icon6: return "icon6"
        }
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

// TODO: add more theme: (#E4ECF5 looks good, true OLED...)
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
