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

    var toHourAndMinuteString: String {
        DateFormatter.format(self, format: "HH:mm")
    }

    var toShortDateString: String {
        DateFormatter.format(self, format: "d")
    }

    var toDateString: String {
        DateFormatter.format(self, format: "dd")
    }

    var toDateAndMonthString: String {
        DateFormatter.format(self, format: "MMM d")
    }

    var toDayString: String {
        DateFormatter.format(self, format: "E")
    }

    var toMonthString: String {
        DateFormatter.format(self, format: "MMMM")
    }

    var toMonthAndYearString: String {
        DateFormatter.format(self, format: "MMMM yyyy")
    }

    var toFullDateString: String {
        DateFormatter.format(self, format: "EEEE, MMM d, yyyy")
    }

    var toFullDayString: String {
        DateFormatter.format(self, format: "EEEE")
    }

    var toDayAndDateString: String {
        DateFormatter.format(self, format: "EEEE dd")
    }

    var toChineseDate: Date {
        let date = convertTo(region: Region(calendar: Calendars.chinese))
        return Date(year: date.year, month: date.month, day: date.day, hour: 0, minute: 0)
    }

    var toGregorianDate: Date {
        let date = convertTo(region: Region(calendar: Calendars.gregorian))
        return Date(year: date.year, month: date.month, day: date.day, hour: 0, minute: 0)
    }

    var midnight: Date {
        Calendar.current.startOfDay(for: self)
    }

    func asStringWithTemplate(_ format: String) -> String {
        DateFormatter.format(self, format: format)
    }

    var nextHour: Date {
        dateByAdding(1, .hour).dateAtStartOf(.hour).date
    }

    #if !os(watchOS)
    var offsetWithDefaultDuration: Date {
        dateByAdding(SettingsManager.defaultEventDuration, .minute).date
    }
    #endif
}
