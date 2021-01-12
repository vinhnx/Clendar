//
//  ClendarEvent.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/27/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import UIKit
import EventKit
import SwiftUI

extension EKEvent: Identifiable {}

class ClendarEvent: Hashable, Identifiable {
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

	static func == (lhs: ClendarEvent, rhs: ClendarEvent) -> Bool {
		lhs.id == rhs.id
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}

extension ClendarEvent {
    var calendarUIColor: UIColor {
        guard let calendarColor = event?.calendar.cgColor else { return .primaryColor }
        return UIColor(cgColor: calendarColor)
    }

    var calendarColor: Color {
        Color(calendarUIColor)
    }
}
