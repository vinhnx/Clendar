//
//  Date+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftDate
import CVCalendar

var isUSLocale: Bool { SwiftDate.defaultRegion.locale.identifier == Locales.englishUnitedStates.rawValue }

var weekdays: [WeekDay] { [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday] }

var weekdayNames: [String] { weekdays.map { day in day.name() } }

func weekdayName(_ weekday: WeekDay) -> String { weekday.name() }

func weekdayName(_ weekdayIndex: Int) -> String {
    let weekday = WeekDay(rawValue: weekdayIndex) ?? defaultFirstWeekday
    return weekday.name()
}

var defaultFirstWeekday: WeekDay { isUSLocale ? .sunday : .monday }

var cv_defaultFirstWeekday: CVCalendarWeekday { isUSLocale ? .sunday : .monday }

extension Date {
    var startDate: Date {
        dateAtStartOf(.day)
    }

    var endDate: Date {
        dateAtEndOf(.day)
    }

    var toHourAndMinuteString: String {
        self.toString(.custom("HH:mm"))
    }

    var toDateString: String {
        self.toString(.custom("dd"))
    }

    var toFullDateString: String {
        self.toString(.custom("EEEE, MMM d, yyyy"))
    }

    var toChineseDate: Date {
        let date = convertTo(region: Region(calendar: Calendars.chinese))
        return Date(year: date.year, month: date.month, day: date.day, hour: 0, minute: 0)
    }

    var toGregorianDate: Date {
        let date = convertTo(region: Region(calendar: Calendars.gregorian))
        return Date(year: date.year, month: date.month, day: date.day, hour: 0, minute: 0)
    }
}
