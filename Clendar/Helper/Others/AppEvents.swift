//
//  AppEvents.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation

extension Notification.Name {

    // MARK: - Calendar

    static let didAuthorizeCalendarAccess = Notification.Name(rawValue: "didAuthorizeCalendarAccess")
    static let didDeleteEvent = Notification.Name(rawValue: "didDeleteEvent")
    static let didCreateEvent = Notification.Name(rawValue: "didCreateEvent")

    // MARK: - Settings

    static let didChangeMonthViewCalendarModePreferences = Notification.Name(rawValue: "didChangeMonthViewCalendarModePreferences")
    static let didChangeUserInterfacePreferences = Notification.Name(rawValue: "didChangeUserInterfacePreferences")
    static let didChangeShowDaysOutPreferences = Notification.Name(rawValue: "didChangeShowDaysOutPreferences")
    static let didChangeDaySupplementaryTypePreferences = Notification.Name(rawValue: "didChangeDaySupplementaryTypePreferences")
    static let didChangeSavedCalendarsPreferences = Notification.Name(rawValue: "didChangeSavedCalendarsPreferences")
    static let didChangeUseExperimentalCreateEventMode = Notification.Name(rawValue: "didChangeUseExperimentalCreateEventMode")

    // MARK: - Others

}
