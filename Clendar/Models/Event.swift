//
//  Event.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/27/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKit
import Foundation

extension EKEvent: Identifiable {}

class Event: Hashable, Identifiable {
	// MARK: Lifecycle

	init(event: EKEvent?) {
		self.event = event
		id = event?.eventIdentifier
	}

	// MARK: Internal

	var id: String?

	var event: EKEvent? {
		didSet { id = event?.eventIdentifier }
	}

	static func == (lhs: Event, rhs: Event) -> Bool {
		lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
