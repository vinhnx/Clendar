//
//  SettingsManager.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftUI

struct SettingsManager {
    @UserDefault("currentAppTheme", defaultValue: AppTheme.defaultValue.rawValue)
    static var currentAppTheme: Int

    @UserDefault("darkModeActivated", defaultValue: isDarkMode)
    static var darkModeActivated: Bool

    @UserDefault("calendarViewMode", defaultValue: CalendarViewMode.defaultValue.rawValue)
    static var calendarViewMode: Int

    @UserDefault("showDaysOut", defaultValue: true)
    static var showDaysOut: Bool

    @UserDefault("daySupplementaryType", defaultValue: DaySupplementaryType.defaultValue.rawValue)
    static var daySupplementaryType: Int

//    @UserDefault("useExperimentalCreateEventMode", defaultValue: false)
//    static var useExperimentalCreateEventMode: Bool

    @UserDefault("shouldAutoSelectDayOnCalendarChange", defaultValue: false)
    static var shouldAutoSelectDayOnCalendarChange: Bool

    @UserDefault("defaultEventDuration", defaultValue: 60)
    static var defaultEventDuration: Int

    @UserDefault("enableHapticFeedback", defaultValue: true)
    static var enableHapticFeedback: Bool

    @UserDefault("currentAppIcon", defaultValue: AppIcon.defaultValue.rawValue)
    static var currentAppIcon: Int

    @UserDefault("widgetTheme", defaultValue: WidgetTheme.defaultValue.rawValue)
    static var widgetTheme: Int
}

extension SettingsManager {
    static var isOnMonthViewSettings: Bool {
        calendarViewMode == CalendarViewMode.month.rawValue
    }
}
