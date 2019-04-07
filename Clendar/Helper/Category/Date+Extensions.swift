//
//  Date+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation

extension Date {
    var startDate: Date {
        return Calendar.current.startOfDay(for: self)
    }

    // swiftlint:disable force_unwrapping
    var endDate: Date {
        let dateComponents = DateComponents(day: 1, second: -1)
        return Calendar.current.date(byAdding: dateComponents, to: self.startDate)!
    }
    // swiftlint:enable force_unwrapping

    var within24h: (startTime: Date, endTime: Date) {
        return (
            startTime: self.startDate,
            endTime: self.endDate
        )
    }

    var toHourAndMinuteString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }

    var toDateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }

    var toFullDateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: self)
    }

    var components: DateComponents {
        return Calendar.current.dateComponents([.day, .calendar, .era, .hour, .minute, .month, .nanosecond, .quarter, .second, .weekday, .timeZone, .weekdayOrdinal, .weekOfMonth, .weekOfYear, .year, .yearForWeekOfYear], from: self)
    }

    var day: Int? {
        return self.components.day
    }

    var month: Int? {
        return self.components.month
    }

    var year: Int? {
        return self.components.year
    }
}
