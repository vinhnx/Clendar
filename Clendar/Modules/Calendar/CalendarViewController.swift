//
//  CalendarViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 23/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import CVCalendar
import Foundation
import MVVMKit

struct ColorsConfig {
    static let selectedText = UIColor.white
    static let text = UIColor.black
    static let textDisabled = UIColor.gray
    static let selectionBackground = UIColor(red: 0.2, green: 0.2, blue: 1.0, alpha: 1.0)
    static let sundayText = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0)
    static let sundayTextDisabled = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0)
    static let sundaySelectionBackground = sundayText
}

final class CalendarViewController: BaseViewController, ViewModelOwner {

    // MARK: - View Model

    typealias CustomViewModel = CalendarViewModel
    var viewModel: CalendarViewModel? {
        didSet { self.viewModel?.binder = self }
    }

    // MARK: - Properties
    
    @IBOutlet private var modeButton: UIButton?
    private var calendarMode: CalendarMode = .monthView
    @IBOutlet var calendarView: CVCalendarView! {
        didSet {
            self.calendarView.calendarAppearanceDelegate = self
            self.calendarView.animatorDelegate = self
            self.calendarView.calendarDelegate = self
        }
    }
    @IBOutlet var dayView: CVCalendarMenuView! {
        didSet {
            self.dayView.delegate = self
        }
    }
    @IBOutlet var monthLabel: UILabel!
    private var selectedDay: DayView!
    private lazy var currentCalendar: Calendar = {
        var proxy = Calendar(identifier: .gregorian)
        proxy.locale = Locale(identifier: "en_US_POSIX")
        return proxy
    }()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.monthLabel.text = CVDate(date: Date(), calendar: currentCalendar).globalDescription
        bind()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.calendarView.commitCalendarViewUpdate()
        self.dayView.commitMenuViewUpdate()
    }

    // MARK: - MVVM

    func bind(viewModel: CalendarViewModel) {}
}

// MARK: - CVCalendarViewDelegate & CVCalendarMenuViewDelegate

extension CalendarViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {

    func presentationMode() -> CalendarMode { return calendarMode }

    func firstWeekday() -> Weekday { return .sunday }

    func calendar() -> Calendar? { return self.currentCalendar }

    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        return weekday == .sunday ? .red : .white
    }

    func shouldShowWeekdaysOut() -> Bool { return true }

    func shouldAutoSelectDayOnMonthChange() -> Bool { return false }

    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        self.selectedDay = dayView
    }

    func presentedDateUpdated(_ date: CVDate) {
        self.monthLabel.text = date.globalDescription
    }

    func weekdaySymbolType() -> WeekdaySymbolType { return .short }

    func dayOfWeekTextColor() -> UIColor { return .white }

    func dayOfWeekBackGroundColor() -> UIColor { return .black }

    func shouldAnimateResizing() -> Bool { return true }

    func shouldShowCustomSingleSelection() -> Bool { return true }

    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.frame, shape: CVShape.circle)
        circleView.fillColor = .colorFromCode(0xCCCCCC)
        return circleView
    }

    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        return dayView.isCurrentDay
    }
}

// MARK: - CVCalendarViewAppearanceDelegate

extension CalendarViewController: CVCalendarViewAppearanceDelegate {

    func dayLabelWeekdayDisabledColor() -> UIColor { return .lightGray }

    func dayLabelPresentWeekdayInitallyBold() -> Bool { return false }

    func spaceBetweenDayViews() -> CGFloat { return 0 }

    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont { return UIFont.systemFont(ofSize: 15) }

    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (_, .selected, _), (_, .highlighted, _): return ColorsConfig.selectedText
        case (.sunday, .in, _): return ColorsConfig.sundayText
        case (.sunday, _, _): return ColorsConfig.sundayTextDisabled
        case (_, .in, _): return ColorsConfig.text
        default: return ColorsConfig.textDisabled
        }
    }

    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (.sunday, .selected, _), (.sunday, .highlighted, _): return ColorsConfig.sundaySelectionBackground
        case (_, .selected, _), (_, .highlighted, _): return ColorsConfig.selectionBackground
        default: return nil
        }
    }
}

// MARK: - Convenience API

extension CalendarViewController {
    func toggleMonthViewWithMonthOffset(offset: Int) {
        var components = Manager.componentsForDate(Date(), calendar: currentCalendar) // from today
        components.month! += offset
        let resultDate = currentCalendar.date(from: components)!
        calendarView.toggleViewWithDate(resultDate)
    }

    func didShowNextMonthView(_ date: Date) {
        let components = Manager.componentsForDate(date, calendar: currentCalendar) // from today
        print("Showing Month: \(components.month!)")
    }

    func didShowPreviousMonthView(_ date: Date) {
        let components = Manager.componentsForDate(date, calendar: currentCalendar) // from today
        print("Showing Month: \(components.month!)")
    }

    func didShowNextWeekView(from startDayView: DayView, to endDayView: DayView) {
        print("Showing Week: from \(startDayView.date.day) to \(endDayView.date.day)")
    }

    func didShowPreviousWeekView(from startDayView: DayView, to endDayView: DayView) {
        print("Showing Week: from \(startDayView.date.day) to \(endDayView.date.day)")
    }
}

extension CalendarViewController {

    // MARK: - Actions

    @IBAction private func didTapModeButton(sender: UIButton) {
        sender.isSelected.toggle()
        calendarMode = sender.isSelected ? .weekView : .monthView
        calendarView.changeMode(calendarMode)
    }

    @IBAction func todayMonthView() {
        calendarView.toggleCurrentDayView()
    }

    @IBAction func loadPrevious() {
        calendarView.loadPreviousView()
    }
    
    @IBAction func loadNext() {
        calendarView.loadNextView()
    }
}
