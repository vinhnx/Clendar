//
//  ClendarEvent+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 03/09/2022.
//  Copyright © 2022 Vinh Nguyen. All rights reserved.
//

import Foundation

extension Array where Element == ClendarEvent {
    var nonAllDayEvents: [ClendarEvent] {
        filter { $0.event?.isAllDay == false }
    }

    var allDayEvents: [ClendarEvent] {
        filter { $0.event?.isAllDay == false }
    }
}
