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
        return self.toString(.custom("HH:mm"))
    }

    var toDateString: String {
        return self.toString(.custom("dd"))
    }

    var toFullDateString: String {
        return self.toString(.custom("EEEE, MMM d, yyyy"))
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
