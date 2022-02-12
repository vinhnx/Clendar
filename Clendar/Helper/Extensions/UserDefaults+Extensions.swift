//
//  UserDefaults+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/29/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation

// thanks https://www.avanderlee.com/swift/property-wrappers/
extension UserDefaults {
    // swiftlint:disable:next force_unwrapping
    static let groupUserDefaults = UserDefaults(suiteName: "group.com.vinhnx.Clendar")!

    @UserDefault(key: "defaultCalendarName", defaultValue: AppInfo.appName)
    static var defaultCalendarName: String

    @UserDefault(key: "savedCalendarIDs", defaultValue: [])
    static var savedCalendarIDs: [String]

    @UserDefault(key: "didChangeAlternativeAppIcon", defaultValue: false)
    static var didChangeAlternativeAppIcon: Bool

    @UserDefault(key: "selectedCalendarIdentifier", defaultValue: CalendarIdentifier.defaultCalendarIdentifier.rawValue)
    static var selectedCalendarIdentifier: Int

    @UserDefault(key: "firstWeekday", defaultValue: "")
    static var firstWeekDay: String

    @UserDefault(key: "timeFormat", defaultValue: TimeAndHourFormat.hhmm.rawValue)
    static var timeFormat: Int
}

extension UserDefaults {
    static var timeAndHourFormat: TimeAndHourFormat {
        TimeAndHourFormat(rawValue: UserDefaults.timeFormat) ?? TimeAndHourFormat.hhmm
    }
}
