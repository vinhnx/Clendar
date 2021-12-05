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

	static func format(_ date: Date, format: String) -> String {
		let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.autoupdatingCurrent
		dateFormatter.setLocalizedDateFormatFromTemplate(format)
		return dateFormatter.string(from: date)
	}
}

public class CalendarManager {
	// MARK: Lifecycle

	private init() { calendar = Calendar.shared() } // This prevents others from using the default '()' initializer for this class.

	// MARK: Public

	public private(set) var calendar: Calendar

	// MARK: Internal

	static let shared = CalendarManager()
}
