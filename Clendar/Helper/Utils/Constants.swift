//
//  AppWideConstants.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

// typealiasing
typealias VoidBlock = () -> Void

struct Constants {
    static let supportEmail = "clendar.app@outlook.com"

    static let addEventQuickActionKey = "type"
    static let addEventQuickActionID = "com.vinhnx.Clendar.addEventShortcut"

    struct SiriShortcut {
        static let prefix = "com.vinhnx.Clendar.SiriShortcut"
        static let addEvent = prefix + ".addEvent"
        static let openSettings = prefix + ".openSettings"
        static let openShortcutsView = prefix + ".openShortcuts"
    }

    struct CalendarView {
        static var calendarWidth: CGFloat {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 260
            } else {
                return UIScreen.main.bounds.size.width - (30 * 2)
            }
        }

        static let calendarMonthViewHeight: CGFloat = 250
        static let calendarWeekViewHeight: CGFloat = 30
        static let calendarHeaderHeight: CGFloat = 10
    }

    struct AppStore {
        static let url = "https://apps.apple.com/app/id1548102041"
        static let reviewURL = url + "?action=write-review"
    }

    enum WidgetKind: String, CaseIterable {
        case calendarGridWidget = "CalendarGridWidget"
        case dateInfoWidget = "DateInfoWidget"
        case lunarDateInfoWidget = "LunarDateInfoWidget"
        case eventListWidget = "EventListWidget"
    }
}
