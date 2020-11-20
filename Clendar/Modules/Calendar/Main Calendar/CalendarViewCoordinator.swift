//
//  CalendarConfiguration.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/27/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import CVCalendar
import Foundation
import UIKit

class CalendarViewCoordinator: NSObject, CVCalendarViewDelegate, CVCalendarMenuViewDelegate, CVCalendarViewAppearanceDelegate {
	// MARK: Lifecycle

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	init(
		calendar: Calendar,
		mode: CalendarMode
	) {
		currentCalendar = calendar
		self.mode = mode
	}

	// MARK: Public

	public private(set) var mode: CalendarMode

	public private(set) var currentCalendar: Calendar

	var selectedDate: ((CVDate) -> Void)?

	var calendarView: CVCalendarView?

	// MARK: - CVCalendarViewDelegate, CVCalendarMenuViewDelegate

	func presentationMode() -> CalendarMode { mode }

	func firstWeekday() -> Weekday { CVCalendarWeekday(rawValue: Calendar.autoupdatingCurrent.firstWeekday) ?? .monday }

	func calendar() -> Calendar? { currentCalendar }

	func shouldShowWeekdaysOut() -> Bool { SettingsManager.showDaysOut }

	func shouldAutoSelectDayOnMonthChange() -> Bool { SettingsManager.shouldAutoSelectDayOnCalendarChange }

	func shouldAutoSelectDayOnWeekChange() -> Bool { SettingsManager.shouldAutoSelectDayOnCalendarChange }

	func didSelectDayView(_: CVCalendarDayView, animationDidFinish _: Bool) {
		genLightHaptic()
	}

	func presentedDateUpdated(_ date: CVDate) {
		genLightHaptic()
		selectedDate?(date)
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

	func supplementaryView(shouldDisplayOnDayView _: DayView) -> Bool { true }

	// MARK: - CVCalendarViewAppearanceDelegate

	func spaceBetweenDayViews() -> CGFloat { 5 }

	func dayLabelWeekdayDisabledColor() -> UIColor { .appLightGray }

	func dayLabelPresentWeekdayInitallyBold() -> Bool { true }

	func dayLabelFont(by _: Weekday, status _: CVStatus, present _: CVPresent) -> UIFont {
		.mediumFontWithSize(18)
	}

	func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
		switch (weekDay, status, present) {
		case (_, .selected, _),
		     (_, .highlighted, _): return .white
		case (.sunday, .out, _): return .appLightRed
		case (.sunday, _, _): return .appRed
		case (_, .in, _): return .appDark
		default: return .appLightGray
		}
	}

	func dayLabelBackgroundColor(by _: Weekday, status _: CVStatus, present _: CVPresent) -> UIColor? {
		.appRed
	}
}
