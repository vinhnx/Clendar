//
//  Date+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation

extension Date {
    var startDate: Date {
        return Calendar.current.startOfDay(for: self)
    }

    // swiftlint:disable force_unwrapping
    var endDate: Date {
        let dateComponents = DateComponents(day: 1, second: -1)
        return Calendar.current.date(byAdding: dateComponents, to: self.startDate)!
    }
    // swiftlint:enable force_unwrapping

    var within24h: (startTime: Date, endTime: Date) {
        return (
            startTime: self.startDate,
            endTime: self.endDate
        )
    }

    var toString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
