//
//  CalendarView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import CVCalendar
import SwiftUI
import Then

struct CalendarWrapperView: UIViewRepresentable {
	@EnvironmentObject var store: Store
	let calendarView = CVCalendarView().then {
		$0.frame = CGRect(
			x: 0, y: 0,
			width: Constants.CalendarView.calendarWidth,
			height: Constants.CalendarView.calendarHeight
		)
	}

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
		// resist being made larger than the intrinsicContentSize
		calendarView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		calendarView.setContentHuggingPriority(.defaultHigh, for: .vertical)
		return calendarView
	}

	func updateUIView(_ view: CVCalendarView, context: Context) {
		view.toggleViewWithDate(store.selectedDate)
		view.commitCalendarViewUpdate()
		context.coordinator.calendarView = view // NOTE: this is to keep reference to UIView, not sure which is better way
		context.coordinator.selectedDate = { date in
			guard let convertedDate = date.convertedDate() else { return }
			self.store.selectedDate = convertedDate
		}
	}
}

struct CalendarWrapperView_Previews: PreviewProvider {
	static var previews: some View {
		CalendarWrapperView().environmentObject(Store())
	}
}
