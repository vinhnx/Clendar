//
//  MainCalendarView.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 25/12/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftUI
import KVKCalendar
import EventKit

// TODO: convert back to CVCalendar with custom day views

struct MainCalendarView: UIViewRepresentable {
    @EnvironmentObject var store: Store

    var calendar: CalendarView = {
        var style = Style()
        style.defaultType = .month
        style.followInSystemTheme = false

        style.calendar = Calendar.shared()
        style.locale = Locale.current
        style.timezone = TimeZone.current

        style.week.colorBackground = .backgroundColor
        style.week.colorDate = .appDark
        style.week.colorWeekendDate = .appDark

        style.month.scrollDirection = .horizontal
        style.month.colorBackground = .backgroundColor
        style.month.colorBackgroundDate = .backgroundColor
        style.month.colorBackgroundWeekendDate = .backgroundColor
        style.month.colorDate = .appGray
        style.month.weekFont = .boldFontWithSize(12)
        style.month.fontTitleDate = .boldFontWithSize(20)
        style.month.fontNameDate = .mediumFontWithSize(15)
        style.month.colorTitleDate = .primaryColor
        style.month.colorBackgroundSelectDate = .appLightGray
        style.month.colorWeekendDate = .appRed
        style.month.colorBackgroundCurrentDate = .appRed
        style.month.colorNameEmptyDay = style.month.colorDate.withAlphaComponent(0.3)
        style.month.showDatesForOtherMonths = true
        style.month.isAnimateSelection = true
        style.month.colorWeekendDate = .appRed
        style.month.isHiddenSeporator = true
        return CalendarView(frame: CGRect(x: 0, y: 0, width: Constants.CalendarView.calendarWidth, height: Constants.CalendarView.calendarHeight),
                            style: style)
    }()

    func makeUIView(context: UIViewRepresentableContext<MainCalendarView>) -> CalendarView {
        calendar.dataSource = context.coordinator
        calendar.delegate = context.coordinator
        calendar.reloadData()
        return calendar
    }

    func updateUIView(_ uiView: CalendarView, context: UIViewRepresentableContext<MainCalendarView>) {}

    func makeCoordinator() -> MainCalendarView.Coordinator {
        Coordinator(self)
    }

    // MARK: Calendar DataSource and Delegate
    class Coordinator: NSObject, CalendarDataSource, CalendarDelegate {

        private let view: MainCalendarView

        init(_ view: MainCalendarView) {
            self.view = view
            super.init()
        }

        func eventsForCalendar(systemEvents: [EKEvent]) -> [Event] {
            []
        }

        func didSelectDate(_ date: Date?, type: CalendarType, frame: CGRect?) {
            if let selectedDate = date {
                view.store.selectedDate = selectedDate
            }
        }
    }
}

struct Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainCalendarView()
            MainCalendarView().environment(\.colorScheme, .dark)
        }
    }
}
