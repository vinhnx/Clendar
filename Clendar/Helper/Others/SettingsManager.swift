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

    @UserDefault("showLunarCalendar", defaultValue: true)
    static var showLunarCalendar: Bool

    @UserDefault("monthViewCalendarMode", defaultValue: true)
    static var monthViewCalendarMode: Bool
}
