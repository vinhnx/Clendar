//
//  AppEvents.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation

extension Notification.Name {
	// MARK: - General

	static let addEventShortcutAction = Notification.Name(rawValue: "addEventShortcutAction")

	// MARK: - Calendar

	static let didAuthorizeCalendarAccess = Notification.Name(rawValue: "didAuthorizeCalendarAccess")
	static let didDeleteEvent = Notification.Name(rawValue: "didDeleteEvent")
	static let didSaveEvent = Notification.Name(rawValue: "didSaveEvent")

	// MARK: - Settings

	static let didChangeMonthViewCalendarModePreferences = Notification.Name(rawValue: "didChangeMonthViewCalendarModePreferences")
	static let didChangeUserInterfacePreferences = Notification.Name(rawValue: "didChangeUserInterfacePreferences")
	static let didChangeShowDaysOutPreferences = Notification.Name(rawValue: "didChangeShowDaysOutPreferences")
	static let didChangeDaySupplementaryTypePreferences = Notification.Name(rawValue: "didChangeDaySupplementaryTypePreferences")
	static let didChangeSavedCalendarsPreferences = Notification.Name(rawValue: "didChangeSavedCalendarsPreferences")
	static let didChangeUseExperimentalCreateEventMode = Notification.Name(rawValue: "didChangeUseExperimentalCreateEventMode")
	static let justReloadCalendar = Notification.Name(rawValue: "justReloadCalendar")
	static let didChangeDefaultEventDurationPreferences = Notification.Name(rawValue: "didChangeDefaultEventDurationPreferences")
}

extension Notification.Name {
	var asPublisher: NotificationCenter.Publisher {
		NotificationCenter.default.publisher(for: self)
	}
}
