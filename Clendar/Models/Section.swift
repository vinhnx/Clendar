//
//  Section.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/27/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import EventKit

class Section: Hashable {
    var id = UUID()
    var date: Date?
    var events: [Event]

    init(date: Date?, events: [Event]) {
        self.date = date
        self.events = events
    }

    // MARK: - Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }
}
