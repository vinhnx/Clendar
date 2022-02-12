//
//  Date+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftDate

enum TimeAndHourFormat: Int, CaseIterable {
    case hhmm
    case HHmm

    var format: String {
        switch self {
        case .hhmm: return "h:mma"
        case .HHmm: return "HH:mm"
        }
    }

    var localizedTitle: String {
        switch self {
        case .hhmm: return NSLocalizedString("12 hour", comment: "") + " " + "(\(DateFormatter.asString(Date(), format: self.format)))"
        case .HHmm: return NSLocalizedString("24 hour", comment: "") + " " + "(\(DateFormatter.asString(Date(), format: self.format)))"
        }
    }

    static var localizedTitles: [String] {
        allCases.map(\.localizedTitle)
    }

    static func mapFromTitle(_ value: String) -> Self {
        switch value {
        case TimeAndHourFormat.HHmm.localizedTitle: return .HHmm
        default: return .hhmm
        }
    }
}

extension Date {
    var startDate: Date {
        dateAtStartOf(.day)
    }

    var endDate: Date {
        dateAtEndOf(.day)
    }

    func toHourAndMinuteString(calendar: Calendar = CalendarIdentifier.current.calendar) -> String {
        DateFormatter.asString(
            self,
            format: UserDefaults.timeAndHourFormat.format,
            calendar: calendar
        )
    }

    func toShortDateString(calendar: Calendar = CalendarIdentifier.current.calendar) -> String {
        DateFormatter.asString(self, format: "d", calendar: calendar)
    }

    func toDateString(calendar: Calendar = CalendarIdentifier.current.calendar) -> String {
        DateFormatter.asString(self, format: "d", calendar: calendar)
    }

    func toDateAndMonthString(calendar: Calendar = CalendarIdentifier.current.calendar) -> String {
        DateFormatter.asString(self, format: "MMM d", calendar: calendar)
    }

    func toDayString(calendar: Calendar = CalendarIdentifier.current.calendar) -> String {
        DateFormatter.asString(self, format: "E", calendar: calendar)
    }

    func toMonthString(calendar: Calendar = CalendarIdentifier.current.calendar) -> String {
        DateFormatter.asString(self, format: "MMMM", calendar: calendar)
    }

    func toMonthAndYearString(calendar: Calendar = CalendarIdentifier.current.calendar) -> String {
        DateFormatter.asString(self, format: "MMMM yyyy", calendar: calendar)
    }

    func toYearString(calendar: Calendar = CalendarIdentifier.current.calendar) -> String {
        DateFormatter.asString(self, format: "yyyy", calendar: calendar)
    }

    func toFullDateString(calendar: Calendar = CalendarIdentifier.current.calendar) -> String {
        DateFormatter.asString(self, format: "EEEE, MMM d, yyyy", calendar: calendar)
    }

    func toFullDayString(calendar: Calendar = CalendarIdentifier.current.calendar) -> String {
        DateFormatter.asString(self, format: "EEEE", calendar: calendar)
    }

    func toDayAndDateString(calendar: Calendar = CalendarIdentifier.current.calendar) -> String {
        DateFormatter.asString(self, format: "EEEE d", calendar: calendar)
    }

    func asStringWithTemplate(_ format: String, calendar: Calendar = CalendarIdentifier.current.calendar) -> String {
        DateFormatter.asString(self, format: format, calendar: calendar)
    }

    var nextHour: Date {
        dateByAdding(1, .hour).dateAtStartOf(.hour).date
    }

    func toFullEventDate(calendar: Calendar = CalendarIdentifier.current.calendar) -> String {
        let format = String("EEEE, MMM d, yyyy. \(UserDefaults.timeAndHourFormat.format)")
        return DateFormatter.asString(self, format: format, calendar: calendar)
    }

    #if !os(watchOS)
    var offsetWithDefaultDuration: Date {
        dateByAdding(SettingsManager.defaultEventDuration, .minute).date
    }
    #endif
}
