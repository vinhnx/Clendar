//
//  EKEvent+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKit
import Foundation
import Shift

extension EKEvent {
    func durationText(startDateOnly: Bool = false) -> String {
        if isAllDay {
            return NSLocalizedString("All day", comment: "")
        }
        else if startDateOnly {
            let startDateString = startDate.toHourAndMinuteString
            return startDateString
        }
        else {
            let startDateString = startDate.toHourAndMinuteString
            let endDateString = endDate.toHourAndMinuteString
            return startDate != endDate
                ? "\(startDateString) - \(endDateString)"
                : startDateString
        }
    }
}

extension EKEventStore {
    var selectableCalendarsFromSettings: [EKCalendar] {
        let savedCalendarIDs = UserDefaults.savedCalendarIDs
        return calendars(for: .event)
            .filter { calendar in
                if savedCalendarIDs.isEmpty { return true }
                return savedCalendarIDs.contains(calendar.calendarIdentifier)
            }
    }

    var defaultCalendarFromSettings: EKCalendar? {
        let name = UserDefaults.defaultCalendarName
        return calendars(for: .event).first { $0.title == name } ?? Shift.shared.defaultCalendar
    }
}
