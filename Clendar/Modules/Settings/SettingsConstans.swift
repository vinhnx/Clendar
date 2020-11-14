//
//  SettingsConstans.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import CVCalendar
import UIKit

enum AppIcon: CaseIterable {
    case light
    case dark
    case dimmedDark

    static func mapFromString(_ string: String?) -> Self {
        switch string {
        case AppIcon.dark.text: return .dark
        case AppIcon.dimmedDark.text: return .dimmedDark
        default: return .light
        }
    }

    var iconName: String? {
        switch self {
        case .light: return nil
        case .dark: return "dark_icon"
        case .dimmedDark: return "dim_dark_icon"
        }
    }

    var text: String {
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

    static var titles: [String] = Self.allCases.map { $0.text }
    static var defaultValue: String { AppIcon.light.text }
}

enum Theme: Int, CaseIterable {
    case dark
    case light

    var text: String {
        switch self {
        case .dark: return NSLocalizedString("Dark", comment: "")
        case .light: return NSLocalizedString("Light", comment: "")
        }
    }

    static var titles: [String] = Self.allCases.map { $0.text }
}

enum DaySupplementaryType: String, CaseIterable {
    case none = "None"
    case lunarDate = "Lunar date"
    case oneDot = "One dot"

    var localizedText: String {
        switch self {
        case .none: return NSLocalizedString("None", comment: "")
        case .lunarDate: return NSLocalizedString("Lunar date", comment: "")
        case .oneDot: return NSLocalizedString("One dot", comment: "")
        }
    }
    
    static var titles: [String] = Self.allCases.map { $0.localizedText }
    static var defaultValue: Self { .none }
}

enum CalendarViewMode: Int, CaseIterable {
    case month
    case week

    var mode: CVCalendarViewPresentationMode {
        switch self {
        case .week: return .weekView
        case .month: return .monthView
        }
    }

    var text: String {
        switch self {
        case .week: return NSLocalizedString("Week view", comment: "")
        case .month: return NSLocalizedString("Month view", comment: "")
        }
    }

    static var titles: [String] = Self.allCases.map { $0.text }
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

    var text: String {
        switch self {
        case .none: return NSLocalizedString("None", comment: "")
        case .date: return NSLocalizedString("Date", comment: "")
        case .month: return NSLocalizedString("Month", comment: "")
        }
    }

    static var titles: [String] { Self.allCases.map { $0.rawValue } }
    static var defaultValue: Self { .none }
}
