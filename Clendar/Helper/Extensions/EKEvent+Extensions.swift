//
//  EKEvent+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import EventKit

extension EKEvent {

    var displayText: String {
        if isAllDay {
            return "All day"
        }
        else {
            let startDateString = startDate.toHourAndMinuteString
            let endDateString = endDate.toHourAndMinuteString
            return startDate != endDate
                ? "\(startDateString) to \(endDateString)"
                : startDateString
        }
    }
    
}
