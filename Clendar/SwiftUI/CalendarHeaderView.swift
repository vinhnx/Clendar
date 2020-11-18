//
//  CalendarHeaderView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import CVCalendar
import SwiftUI

#warning("// TODO: SwiftUI migration")

struct CalendarHeaderView: UIViewRepresentable {
	@Binding var date: Date

	func makeCoordinator() -> CalendarViewConfiguration {
		CalendarViewConfiguration(
			calendar: CalendarManager.shared.calendar,
			mode: .monthView,
			date: $date
		)
	}

	func makeUIView(context: Context) -> CVCalendarMenuView {
		let view = CVCalendarMenuView(frame: CGRect(x: 0, y: 0, width: 300, height: 10))
		view.delegate = context.coordinator
		view.commitMenuViewUpdate()
		return view
	}

	func updateUIView(_: CVCalendarMenuView, context _: Context) {}
}

struct CalendarHeaderView_Previews: PreviewProvider {
	@State static var date = Date()

	static var previews: some View {
		CalendarHeaderView(date: $date)
	}
}
