//
//  DateParser.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftDate
import SwiftyChrono

enum CalendarTypeSegment {
	case lunar
	case solar
}

// english, spanish, french, japanese, german, chinese
func naturalLanguageCodeFromSelectedLanguage() -> Language {
    let appLanguage = Locale.autoupdatingCurrent.languageCode
    switch appLanguage {
    case "es": return .spanish
    case "fr": return .french
    case "ja": return .japanese
    case "zh": return .chinese
    case "de": return .german
    default: return .english
    }
}

final class NaturalInputParser {
	// MARK: Lifecycle

	init() {
		Chrono.preferredLanguage = naturalLanguageCodeFromSelectedLanguage()
	}

	// MARK: Internal

	struct InputParserResult {
		var parsedText: String
		var startDate: Date
		var endDate: Date?
	}

	func parse(_ input: String, type: CalendarTypeSegment = .solar) -> InputParserResult? {
		guard input.isEmpty == false else { return nil }
		let results = chrono.parse(text: input)
		let process = results.process(with: input)
		let startDate = process.startDate
		let endDate = process.endDate

		switch type {
		case .lunar:
			let gregorianStartDate = startDate.toGregorianDate
			let gregorianEndDate = endDate?.toGregorianDate
			return InputParserResult(parsedText: process.action,
			                         startDate: gregorianStartDate,
			                         endDate: gregorianEndDate)

		case .solar:
			return InputParserResult(parsedText: process.action,
			                         startDate: startDate,
			                         endDate: endDate)
		}
	}

	// MARK: Private

	private lazy var chrono = Chrono()
}
