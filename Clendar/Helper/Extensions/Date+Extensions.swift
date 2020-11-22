//
//  Date+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import CVCalendar
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
		DateFormatter.format(self, template: "HH:mm")
	}

	var toShortDateString: String {
		DateFormatter.format(self, template: "d")
	}

	var toDateString: String {
		DateFormatter.format(self, template: "dd")
	}

	var toDayString: String {
		DateFormatter.format(self, template: "E")
	}

	var toMonthString: String {
		DateFormatter.format(self, template: "MMMM")
	}

	var toMonthAndYearString: String {
		DateFormatter.format(self, template: "MMMM yyyy")
	}

	var toFullDateString: String {
		DateFormatter.format(self, template: "EEEE, MMM d, yyyy")
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

	func asStringWithTemplate(_ template: String) -> String {
		DateFormatter.format(self, template: template)
	}

	var nextHour: Date {
		dateByAdding(1, .hour).dateAtStartOf(.hour).date
	}

	var offsetWithDefaultDuration: Date {
		dateByAdding(SettingsManager.defaultEventDuration, .minute).date
	}
}

extension Date {
	var toFullDayString: String {
		toString(.custom("EEEE"))
	}
}
