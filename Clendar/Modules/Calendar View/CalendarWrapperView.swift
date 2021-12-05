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

// keep a global instance to prevent crash when changing settings
let calendarView = CVCalendarView().then {
    $0.frame = CGRect(
        x: 0, y: 0,
        width: Constants.CalendarView.calendarWidth,
        height: (SettingsManager.isOnMonthViewSettings
                    ? Constants.CalendarView.calendarMonthViewHeight
                    : Constants.CalendarView.calendarWeekViewHeight)
    )
}

struct CalendarWrapperView: UIViewRepresentable {
    @EnvironmentObject var store: SharedStore
    
    // MARK: - UIViewRepresentable

    func makeCoordinator() -> CalendarViewCoordinator {
        CalendarViewCoordinator(
            calendar: CalendarManager.shared.calendar,
            calendarViewMode: SettingsManager.calendarViewModePerSettings
        )
    }

    func makeUIView(context: Context) -> CVCalendarView {
        calendarView.calendarAppearanceDelegate = context.coordinator
        calendarView.animatorDelegate = context.coordinator
        calendarView.calendarDelegate = context.coordinator
//        calendarView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        calendarView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        calendarView.commitCalendarViewUpdate()
        return calendarView
    }

    func updateUIView(_ view: CVCalendarView, context: Context) {
        view.toggleViewWithDate(store.selectedDate)

        context.coordinator.calendarView = view // NOTE: this is to keep reference to UIView, not sure which is better way
        context.coordinator.selectedDate = { date in
            guard let convertedDate = date.convertedDate() else { return }
            self.store.selectedDate = convertedDate
        }
    }
}

struct CalendarWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarWrapperView().environmentObject(SharedStore())
    }
}
