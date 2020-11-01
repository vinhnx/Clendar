//
//  SettingsManager.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation

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

    @UserDefault("defaultEventDuration", defaultValue: 60)
    static var defaultEventDuration: Int

    @UserDefault("enableHapticFeedback", defaultValue: true)
    static var enableHapticFeedback: Bool

}
