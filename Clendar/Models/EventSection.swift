//
//  EventSection.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/27/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKit
import Foundation

class EventSection: Hashable {
	// MARK: Lifecycle

	init(date: Date?, events: [ClendarEvent]) {
		self.date = date
		self.events = events
	}

	// MARK: Internal

	var id = UUID()
	var date: Date?
	var events: [ClendarEvent]

	static func == (lhs: EventSection, rhs: EventSection) -> Bool {
		lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
