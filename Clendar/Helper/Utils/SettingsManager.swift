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
    @UserDefault("darkModeActivated", defaultValue: isDarkMode)
    static var darkModeActivated: Bool

    @UserDefault("calendarViewMode", defaultValue: CalendarViewMode.defaultValue.localizedText)
    static var calendarViewMode: String

    @UserDefault("showDaysOut", defaultValue: true)
    static var showDaysOut: Bool

    @UserDefault("daySupplementaryType", defaultValue: DaySupplementaryType.defaultValue.rawValue)
    static var daySupplementaryType: String

    @UserDefault("useExperimentalCreateEventMode", defaultValue: true)
    static var useExperimentalCreateEventMode: Bool

    @UserDefault("shouldAutoSelectDayOnCalendarChange", defaultValue: false)
    static var shouldAutoSelectDayOnCalendarChange: Bool

    @UserDefault("badgeSettings", defaultValue: BadgeSettings.none.rawValue)
    static var badgeSettings: String

    @UserDefault("defaultEventDuration", defaultValue: 60)
    static var defaultEventDuration: Int

    @UserDefault("enableHapticFeedback", defaultValue: true)
    static var enableHapticFeedback: Bool

    @UserDefault("currentAppIconName", defaultValue: AppIcon.defaultValue)
    static var currentAppIconName: String?

    @UserDefault("widgetTheme", defaultValue: WidgetTheme.defaultValue.localizedText)
    static var widgetTheme: String
}

extension SettingsManager {
    static var isOnMonthViewSettings: Bool {
        calendarViewMode == CalendarViewMode.month.localizedText
    }
}
