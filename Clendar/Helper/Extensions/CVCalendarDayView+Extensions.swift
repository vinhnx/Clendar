//
//  CVCalendarDayView+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/24/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import CVCalendar

extension CVCalendarDayView {
    var convertedDate: Date? {
        return date.convertedDate()
    }
}
