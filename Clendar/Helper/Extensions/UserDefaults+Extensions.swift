//
//  UserDefaults+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/29/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation

extension UserDefaults {
    @UserDefault("defaultCalendarName", defaultValue: AppInfo.appName)
    static var defaultCalendarName: String

    @UserDefault("savedCalendarIDs", defaultValue: [])
    static var savedCalendarIDs: [String]

    @UserDefault("didChangeAlternativeAppIcon", defaultValue: false)
    static var didChangeAlternativeAppIcon: Bool
}
