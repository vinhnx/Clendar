//
//  SettingsManager.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation

enum BadgeSettings: String, CaseIterable {
    case none = "None"
    case date = "Date"
    case month = "Month"
    
    static var titles: [String] { Self.allCases.map { $0.rawValue } }
    static var defaultValue: Self { .none }
}

struct SettingsManager {

    @UserDefault("darkModeActivated", defaultValue: isDarkMode)
    static var darkModeActivated: Bool

    @UserDefault("monthViewCalendarMode", defaultValue: true)
    static var monthViewCalendarMode: Bool

    @UserDefault("showDaysOut", defaultValue: false)
    static var showDaysOut: Bool

    @UserDefault("daySupplementaryType", defaultValue: DaySupplementaryType.defaultValue.rawValue)
    static var daySupplementaryType: String

    @UserDefault("useExperimentalCreateEventMode", defaultValue: false)
    static var useExperimentalCreateEventMode: Bool

    @UserDefault("shouldAutoSelectDayOnCalendarChange", defaultValue: false)
    static var shouldAutoSelectDayOnCalendarChange: Bool

    @UserDefault("badgeSettings", defaultValue: BadgeSettings.none.rawValue)
    static var badgeSettings: String

}
