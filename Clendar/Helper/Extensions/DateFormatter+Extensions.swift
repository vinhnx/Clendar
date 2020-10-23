//
//  DateFormatter+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/20/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation

enum LocaleIdentifer: String {
    case Vietnam = "vi"
    case enUS = "en-US"
}

extension DateFormatter {

    static func lunarDateString(
        forDate date: Date = Date(),
        localeIdentifier: LocaleIdentifer = .Vietnam,
        dateFormatTemplate: String = "MMdd"
    ) -> String {
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: localeIdentifier.rawValue)
        dateFormater.setLocalizedDateFormatFromTemplate(dateFormatTemplate)
        dateFormater.calendar = Calendar(identifier: .chinese)
        return dateFormater.string(from: date)
    }

}

public class CalendarManager {
    public private(set) var calendar: Calendar

    static let shared = CalendarManager()
    private init() {
        calendar = Calendar.makeGregorianCalendar()
    } // This prevents others from using the default '()' initializer for this class.

}
