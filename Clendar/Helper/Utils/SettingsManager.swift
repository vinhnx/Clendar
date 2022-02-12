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
    @UserDefault(key: "currentAppTheme", defaultValue: AppTheme.defaultValue.rawValue)
    static var currentAppTheme: Int

    @UserDefault(key: "darkModeActivated", defaultValue: isDarkMode)
    static var darkModeActivated: Bool

    @UserDefault(key: "calendarViewMode", defaultValue: CalendarViewMode.defaultValue.rawValue)
    static var calendarViewMode: Int

    @UserDefault(key: "showDaysOut", defaultValue: true)
    static var showDaysOut: Bool

    @UserDefault(key: "daySupplementaryType", defaultValue: DaySupplementaryType.defaultValue.rawValue)
    static var daySupplementaryType: Int

    @UserDefault(key: "useExperimentalCreateEventMode", defaultValue: true)
    static var useExperimentalCreateEventMode: Bool

    @UserDefault(key: "defaultEventDuration", defaultValue: 60)
    static var defaultEventDuration: Int

    @UserDefault(key: "enableHapticFeedback", defaultValue: true)
    static var enableHapticFeedback: Bool

    @UserDefault(key: "currentAppIcon", defaultValue: AppIcon.defaultValue.rawValue)
    static var currentAppIcon: Int

    @UserDefault(key: "widgetTheme", defaultValue: WidgetTheme.defaultValue.rawValue)
    static var widgetTheme: Int
}

extension SettingsManager {
    static var isOnMonthViewSettings: Bool {
        calendarViewMode == CalendarViewMode.month.rawValue
    }
}
