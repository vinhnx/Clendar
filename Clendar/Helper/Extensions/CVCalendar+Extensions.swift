//
//  CVCalendar+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import CVCalendar

extension CVCalendarView {
    var selectedDate: Date? {
        presentedDate.convertedDate()
    }

    func reloadData() {
        contentController.refreshPresentedMonth()
    }
}
