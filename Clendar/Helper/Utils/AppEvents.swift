//
//  AppEvents.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let didAuthorizeCalendarAccess = Notification.Name(rawValue: "didAuthorizeCalendarAccess")
    static let didDeleteEvent = Notification.Name(rawValue: "didDeleteEvent")
    static let didSaveEvent = Notification.Name(rawValue: "didSaveEvent")
    static let didChangeUserInterfacePreferences = Notification.Name(rawValue: "didChangeUserInterfacePreferences")
    static let didChangeSavedCalendarsPreferences = Notification.Name(rawValue: "didChangeSavedCalendarsPreferences")
    static let justReloadCalendar = Notification.Name(rawValue: "justReloadCalendar")
    static let didChangeDefaultEventDurationPreferences = Notification.Name(rawValue: "didChangeDefaultEventDurationPreferences")
    static let inAppPurchaseSuccess = Notification.Name(rawValue: "inAppPurchaseSuccess")
}

extension Notification.Name {
    var asPublisher: NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: self)
    }
}
