//
//  Event.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/27/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import EventKit

class Event: Hashable {
    var id:  String?

    var event: EKEvent? {
        didSet { id = event?.eventIdentifier }
    }

    init(event: EKEvent?) {
        self.event = event
        self.id = event?.eventIdentifier
    }

    // MARK: - Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Event, rhs: Event) -> Bool {
        lhs.id == rhs.id
    }

}
