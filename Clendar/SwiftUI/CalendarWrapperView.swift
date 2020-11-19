//
//  CalendarView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import CVCalendar
import SwiftUI

struct CalendarWrapperView: UIViewRepresentable {
	@EnvironmentObject var sharedState: SharedState
	let calendarView = CVCalendarView(frame: CGRect(x: 0, y: 0, width: 300, height: 250))

	// MARK: - UIViewRepresentable

	func makeCoordinator() -> CalendarViewCoordinator {
		CalendarViewCoordinator(
			calendar: CalendarManager.shared.calendar,
			mode: .monthView
		)
	}

	func makeUIView(context: Context) -> CVCalendarView {
		calendarView.calendarAppearanceDelegate = context.coordinator
		calendarView.animatorDelegate = context.coordinator
		calendarView.calendarDelegate = context.coordinator
		calendarView.commitCalendarViewUpdate()
		calendarView.setContentHuggingPriority(.required, for: .horizontal)
		return calendarView
	}

	func updateUIView(_ view: CVCalendarView, context: Context) {
		view.toggleViewWithDate(sharedState.selectedDate)
		context.coordinator.calendarView = view // NOTE: this is to keep reference to UIView, not sure which is better way
		context.coordinator.selectedDate = { date in
			guard let convertedDate = date.convertedDate() else { return }
			self.sharedState.selectedDate = convertedDate
		}
	}
}

struct CalendarWrapperView_Previews: PreviewProvider {
	static var previews: some View {
        CalendarWrapperView().environmentObject(SharedState())
	}
}
