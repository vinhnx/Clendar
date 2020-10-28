//
//  CalendarConfiguration.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/27/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import UIKit
import CVCalendar
import SwiftDate

class CalendarViewConfiguration: CVCalendarViewDelegate, CVCalendarMenuViewDelegate, CVCalendarViewAppearanceDelegate {

    // MARK: - Callbacks

    var presentedDateUpdated: ((_ date: CVDate) -> Void)?

    var didSelectDayView: ((_ dayView: CVCalendarDayView, _ animationDidFinish: Bool) -> Void)?

    // MARK: - Properties

    public private(set) var mode: CalendarMode

    public private(set) var currentCalendar: Calendar

    init(calendar: Calendar, mode: CalendarMode) {
        self.currentCalendar = calendar
        self.mode = mode
    }

    // MARK: - CVCalendarViewDelegate, CVCalendarMenuViewDelegate

    func presentationMode() -> CalendarMode { mode }

    func firstWeekday() -> Weekday { cv_defaultFirstWeekday }

    func calendar() -> Calendar? { currentCalendar }

    func shouldShowWeekdaysOut() -> Bool { SettingsManager.showDaysOut }

    func shouldAutoSelectDayOnMonthChange() -> Bool { false }

    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        didSelectDayView?(dayView, animationDidFinish)
    }

    func presentedDateUpdated(_ date: CVDate) {
        presentedDateUpdated?(date)
    }

    func dayOfWeekFont() -> UIFont {
        .mediumFontWithSize(15)
    }

    func dayOfWeekTextUppercase() -> Bool { false }

    func weekdaySymbolType() -> WeekdaySymbolType { .short }

    func dayOfWeekTextColor() -> UIColor { .appDark }

    func dayOfWeekBackGroundColor() -> UIColor { .clear }

    func spaceBetweenWeekViews() -> CGFloat { 0 }

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

    func spaceBetweenDayViews() -> CGFloat { 0 }

    func dayLabelWeekdayDisabledColor() -> UIColor { .appLightGray }

    func dayLabelPresentWeekdayInitallyBold() -> Bool { true }

    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont {
        .regularFontWithSize(20)
    }

    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (_, .selected, _), (_, .highlighted, _): return .white
        case (.sunday, .out, _): return UIColor.appLightRed
        case (.sunday, _, _): return UIColor.appRed
        case (_, .in, _): return UIColor.appDark
        default: return UIColor.appLightGray
        }
    }

    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        .appRed
    }
}
