//
//  Date+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftDate

extension Date {
    var startDate: Date {
        dateAtStartOf(.day)
    }

    var endDate: Date {
        dateAtEndOf(.day)
    }

    var within24h: (startTime: Date, endTime: Date) {
        return (
            startTime: startDate,
            endTime: endDate
        )
    }

    var toHourAndMinuteString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.setLocalizedDateFormatFromTemplate("HH:mm")
        return formatter.string(from: self)
    }

    var toDateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.setLocalizedDateFormatFromTemplate("dd")
        return formatter.string(from: self)
    }

    var toFullDateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.setLocalizedDateFormatFromTemplate("EEEE, MMM d, yyyy")
        return formatter.string(from: self)
    }

    var components: DateComponents {
        return Calendar.current.dateComponents([.day, .calendar, .era, .hour, .minute, .month, .nanosecond, .quarter, .second, .weekday, .timeZone, .weekdayOrdinal, .weekOfMonth, .weekOfYear, .year, .yearForWeekOfYear], from: self)
    }

    var day: Int? {
        return components.day
    }

    var month: Int? {
        return components.month
    }

    var year: Int? {
        return components.year
    }
}
