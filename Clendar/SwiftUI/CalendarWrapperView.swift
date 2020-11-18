//
//  CalendarView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import CVCalendar

#warning("// TODO: SwiftUI imigrat")

struct CalendarWrapperView: UIViewRepresentable {

    @Binding var date: Date

    func makeCoordinator() -> CalendarViewConfiguration {
        CalendarViewConfiguration(
            calendar: CalendarManager.shared.calendar,
            mode: .monthView,
            date: $date
        )
    }

    func makeUIView(context: Context) -> CVCalendarView {
        let view = CVCalendarView(frame: CGRect(x: 0, y: 0, width: 300, height: 250))
        view.calendarAppearanceDelegate = context.coordinator
        view.animatorDelegate = context.coordinator
        view.calendarDelegate = context.coordinator


        context.coordinator.calendarView = view // NOTE: this is to keep reference to UIView, not sure which is better way


        view.commitCalendarViewUpdate()
        view.setContentHuggingPriority(.required, for: .horizontal)
        return view
    }

    func updateUIView(_ uiView: CVCalendarView, context: Context) {
        uiView.toggleViewWithDate(date)
    }

    func foo() {
        print(#line)
    }
}

struct CalenderView_Previews: PreviewProvider {
    @State static var date = Date()

    static var previews: some View {
        CalendarWrapperView(date: $date)
    }
}
