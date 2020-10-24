//
//  DateFormatter+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/20/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftDate

// Reference: https://gist.github.com/jacobbubu/1836273

extension DateFormatter {

    static func lunarDateString(
        forDate date: Date = Date(),
        dateFormatTemplate: String = "MMdd"
    ) -> String {
        let dateFormater = DateFormatter()
        dateFormater.locale = Locales.vietnamese.toLocale()
        dateFormater.setLocalizedDateFormatFromTemplate(dateFormatTemplate)
        dateFormater.calendar = Calendar(identifier: .chinese)
        return dateFormater.string(from: date)
    }

}

public class CalendarManager {
    public private(set) var calendar: Calendar

    static let shared = CalendarManager()
    private init() {
        calendar = Calendar.shared()
    } // This prevents others from using the default '()' initializer for this class.

}
