//
//  DateFormatter+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/20/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftDate

extension DateFormatter {
	static func lunarDateString(
		forDate date: Date = Date(),
		dateFormat: String = "dd/MM"
	) -> String {
		let dateFormater = DateFormatter()
		dateFormater.locale = Locales.vietnamese.toLocale()
		dateFormater.dateFormat = dateFormat
		dateFormater.calendar = Calendar(identifier: .chinese)
		return dateFormater.string(from: date)
	}

    static func asString(
        _ date: Date,
        format: String,
        calendar: Calendar = CalendarIdentifier.current.calendar
    ) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.setLocalizedDateFormatFromTemplate(format)
        dateFormatter.calendar = calendar
		return dateFormatter.string(from: date)
	}
}
