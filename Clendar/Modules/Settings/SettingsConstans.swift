//
//  SettingsConstans.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import CVCalendar

enum Theme: Int, CaseIterable {
    case dark
    case light

    var text: String {
        switch self {
        case .dark: return "Dark"
        case .light: return "Light"
        }
    }

    static var titles: [String] = Self.allCases.map { $0.text }
}

enum DaySupplementaryType: String, CaseIterable {
    case none = "None"
    case lunarDate = "Lunar date"
    case oneDot = "One dot"

    static var titles: [String] = Self.allCases.map { $0.rawValue }
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
        case .week: return "Week view"
        case .month: return "Month view"
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
