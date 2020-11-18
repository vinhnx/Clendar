//
//  CalendarConfiguration.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/27/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import CVCalendar
import SwiftDate
import SwiftUI

#warning("// TODO: SwiftUI migration")

class CalendarViewConfiguration: CVCalendarViewDelegate, CVCalendarMenuViewDelegate, CVCalendarViewAppearanceDelegate {

    // MARK: - Callbacks

    var presentedDateUpdated: ((_ date: CVDate) -> Void)?

    var didSelectDayView: ((_ dayView: CVCalendarDayView, _ animationDidFinish: Bool) -> Void)?

    // MARK: - Properties

    @Binding var date: Date

    var calendarView: CVCalendarView?

    public private(set) var mode: CalendarMode

    public private(set) var currentCalendar: Calendar

    // MARK: - Initialization

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    init(calendar: Calendar, mode: CalendarMode, date: Binding<Date>) {
        self.currentCalendar = calendar
        self.mode = mode
        self._date = date

        // NOTE: not sure which is better way

        NotificationCenter.default.addObserver(forName: NSNotification.Name("foo"), object: nil, queue: .main) { (_) in
            self.calendarView?.loadNextView()
        }

        NotificationCenter.default.addObserver(forName: NSNotification.Name("bar"), object: nil, queue: .main) { (_) in
            self.calendarView?.loadPreviousView()
        }
    }

    // MARK: - CVCalendarViewDelegate, CVCalendarMenuViewDelegate

    func presentationMode() -> CalendarMode { mode }

    func firstWeekday() -> Weekday { cv_defaultFirstWeekday }

    func calendar() -> Calendar? { currentCalendar }

    func shouldShowWeekdaysOut() -> Bool { SettingsManager.showDaysOut }

    func shouldAutoSelectDayOnMonthChange() -> Bool { SettingsManager.shouldAutoSelectDayOnCalendarChange }

    func shouldAutoSelectDayOnWeekChange() -> Bool { SettingsManager.shouldAutoSelectDayOnCalendarChange }

    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        genLightHaptic()
        didSelectDayView?(dayView, animationDidFinish)
    }

    func presentedDateUpdated(_ date: CVDate) {
        presentedDateUpdated?(date)
    }

    func dayOfWeekFont() -> UIFont { .boldFontWithSize(11) }

    func dayOfWeekTextUppercase() -> Bool { true }

    func weekdaySymbolType() -> WeekdaySymbolType { .short }

    func dayOfWeekTextColor() -> UIColor { .nativeLightGray }

    func dayOfWeekBackGroundColor() -> UIColor { .clear }

    func spaceBetweenWeekViews() -> CGFloat { 5 }

    func shouldAnimateResizing() -> Bool { true }

    func shouldShowCustomSingleSelection() -> Bool { true }

    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.frame, shape: CVShape.circle)
        circleView.fillColor = .appLightGray
        return circleView
    }

    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        dayView.isCurrentDay
    }

    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        if SettingsManager.showDaysOut == false, dayView.isOut { return UIView() }
        let type = DaySupplementaryType(rawValue: SettingsManager.daySupplementaryType) ?? DaySupplementaryType.defaultValue
        return DaySupplementaryView.viewForDayView(dayView, isOut: dayView.isOut, type: type) ?? UIView()
    }

    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool { true }

    // MARK: - CVCalendarViewAppearanceDelegate

    func spaceBetweenDayViews() -> CGFloat { 5 }

    func dayLabelWeekdayDisabledColor() -> UIColor { .appLightGray }

    func dayLabelPresentWeekdayInitallyBold() -> Bool { true }

    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont {
        .mediumFontWithSize(18)
    }

    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (_, .selected, _), (_, .highlighted, _): return .white
        case (.sunday, .out, _): return .appLightRed
        case (.sunday, _, _): return .appRed
        case (_, .in, _): return .appDark
        default: return .appLightGray
        }
    }

    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        .appRed
    }
}
