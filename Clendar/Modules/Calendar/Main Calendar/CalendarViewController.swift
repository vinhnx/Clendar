//
//  CalendarViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 23/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit
import CVCalendar
import EventKit
import Foundation
import PanModal

#warning("TODO: needs refator")

final class CalendarViewController: BaseViewController {

    // MARK: - Properties

    @IBOutlet private var todayButton: UIButton!
    @IBOutlet private var eventListHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var eventListContainerView: UIView!
    @IBOutlet private var bottomButtonStackView: UIStackView!
    @IBOutlet private var bottomConstraint: NSLayoutConstraint!

    @IBOutlet private var calendarView: CVCalendarView! {
        didSet {
            self.calendarView.calendarAppearanceDelegate = self
            self.calendarView.animatorDelegate = self
            self.calendarView.calendarDelegate = self
        }
    }

    @IBOutlet private var dayView: CVCalendarMenuView! {
        didSet {
            self.dayView.delegate = self
        }
    }

    @IBOutlet private var inputTextField: TextField! {
        didSet {
            self.inputTextField.delegate = self
            self.inputTextField.applyRoundWithOffsetShadow()
        }
    }

    @IBOutlet private var addEventButton: UIButton!
    @IBOutlet var monthLabel: UILabel! {
        didSet {
            self.monthLabel.font = FontConfig.boldFontWithSize(30)
            self.monthLabel.text = CVDate(date: Date(), calendar: self.currentCalendar).globalDescription
        }
    }

    private lazy var eventList: EventListViewController = {
        let proxy = EventListViewController()
        proxy.contentSizeDidChange = { [weak self] size in
            self?.eventListHeightConstraint.constant = size.height
            self?.view.layoutIfNeeded()
        }

        return proxy
    }()

    private lazy var currentCalendar: Calendar = {
        var proxy = Calendar(identifier: .gregorian)
        proxy.locale = Locale(identifier: "en_US_POSIX")
        return proxy
    }()

    private lazy var inputParser = InputParser()
    internal var currentInput: InputParser.InputParserResult?
    private var calendarMode: CalendarMode = .monthView
    private var selectedDay: DayView? {
        didSet {
            self.handleDayViewSelection(selectedDay)
            self.handleTodayButton(switchingDate: selectedDay?.date.convertedDate() ?? Date())
        }
    }

    // MARK: - Life cycle

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.calendarView.commitCalendarViewUpdate()
        self.dayView.commitMenuViewUpdate()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Override

    override func setupViews() {
        super.setupViews()
        self.addGestures()
        self.addEventListContainer()
        self.addObservers()
        self.selectToday()
    }

    // MARK: - Private

    private func handleDisplaySubDayView(_ dayView: DayView) -> Bool {
        var display = false

        self.fetchEventsFor(dayView) { result in
            switch result {
            case .success(let response):
                display = response.isEmpty == false
            case .failure:
                break
            }
        }

        return display
    }

    private func handleTodayButton(switchingDate: Date) {
        defer {
            self.resignTextField()
        }

        self.todayButton.isHidden = switchingDate.day == Date().day
    }

    private func selectToday() {
        DispatchQueue.main.async {
            self.calendarView.toggleCurrentDayView()
        }
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleDidAuthorizeCalendarAccess), name: kDidAuthorizeCalendarAccess, object: nil)
    }

    @objc private func handleDidAuthorizeCalendarAccess() {
        self.selectToday()
    }

    private func addGestures() {
        self.monthLabel.isUserInteractionEnabled = true
        self.monthLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapMonthLabel)))
    }

    private func handleDayViewSelection(_ dayView: DayView?) {
        guard let dayView = dayView else { return }
        self.fetchEventsFor(dayView) { result in
            switch result {
            case .success(let response):
                self.eventList.updateDataSource(response)
                self.eventList.updateHeader(dayView.date.convertedDate() ?? Date())
            case .failure:
                break
            }
        }
    }

    private func addEventListContainer() {
        self.addChildViewController(self.eventList, containerView: self.eventListContainerView)
    }

    private func throttleParseInput(_ input: String) {
        self.currentInput = self.inputParser.parse(input)
    }

    private func handleInput(textField: UITextField) {
        guard let result = self.currentInput else { return }
        EventHandler.shared.createEvent(result.action, startDate: result.startDate, endDate: result.endDate) { [weak self] in
            textField.text = ""
            self?.eventList.fetchEvents()
            self?.calendarView.toggleViewWithDate(result.startDate)
        }
    }

    @objc private func resignTextField() {
        self.inputTextField.resignFirstResponder()
    }

    // swiftlint:disable force_cast
    @objc func keyboardNotification(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        // Get keyboard frame
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue

        // Set new bottom constraint constant
        let bottomConstraintConstant = keyboardFrame.origin.y >= UIScreen.main.bounds.size.height ? 0.0 : keyboardFrame.size.height + 20

        // Set animation properties
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve = UIView.AnimationOptions(rawValue: animationCurveRaw)

        // Animate the view you care about
        UIView.animate(withDuration: duration, delay: 0, options: animationCurve, animations: {
            self.bottomConstraint.constant = bottomConstraintConstant
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    // swiftlint:enable force_cast
}

extension CalendarViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {

    // MARK: - CVCalendarViewDelegate, CVCalendarMenuViewDelegate

    func presentationMode() -> CalendarMode { return self.calendarMode }

    func firstWeekday() -> Weekday { return .sunday }

    func calendar() -> Calendar? { return self.currentCalendar }

    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        return weekday == .sunday ? .red : .black
    }

    func shouldShowWeekdaysOut() -> Bool { return true }

    func shouldAutoSelectDayOnMonthChange() -> Bool { return false }

    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        self.selectedDay = dayView
        self.resignTextField()
    }

    func presentedDateUpdated(_ date: CVDate) {
        self.monthLabel.text = date.globalDescription
    }

    func weekdaySymbolType() -> WeekdaySymbolType { return .short }

    func dayOfWeekTextColor() -> UIColor { return .black }

    func dayOfWeekBackGroundColor() -> UIColor { return .white }

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

    func didShowNextMonthView(_ date: Foundation.Date) {
        self.handleTodayButton(switchingDate: date)
    }

    func didShowPreviousMonthView(_ date: Foundation.Date) {
        self.handleTodayButton(switchingDate: date)
    }

    private func fetchEventsFor(_ dayView: DayView, completion: EventResultHandler?) {
        guard let date = dayView.date.convertedDate() else { return }
        EventHandler.shared.fetchEvents(for: date, completion: completion)
    }

    private func fetchEventsFor(_ date: Date, completion: @escaping EventResultHandler) {
        EventHandler.shared.fetchEvents(for: date, completion: completion)
    }

    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        guard let view = DateHighlightView.viewForDayView(dayView, isOut: dayView.isOut) else { return UIView() }
        return view
    }

    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        return true
    }
}

extension CalendarViewController: CVCalendarViewAppearanceDelegate {

    // MARK: - CVCalendarViewAppearanceDelegate

    func dayLabelWeekdayDisabledColor() -> UIColor { return .lightGray }

    func dayLabelPresentWeekdayInitallyBold() -> Bool { return false }

    func spaceBetweenDayViews() -> CGFloat { return 0 }

    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont {
        return FontConfig.regularFontWithSize(20)
    }

    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (_, .selected, _), (_, .highlighted, _): return CalendarColorsConfig.selectedText
        case (.sunday, .in, _): return CalendarColorsConfig.sundayText
        case (.sunday, _, _): return CalendarColorsConfig.sundayTextDisabled
        case (_, .in, _): return CalendarColorsConfig.text
        default: return CalendarColorsConfig.textDisabled
        }
    }

    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (.sunday, .selected, _), (.sunday, .highlighted, _): return CalendarColorsConfig.sundaySelectionBackground
        case (_, .selected, _), (_, .highlighted, _): return CalendarColorsConfig.selectionBackground
        default: return nil
        }
    }

    // MARK: - Actions

    @IBAction private func didTapTodayButton() {
        self.selectToday()
    }

    @objc private func didTapMonthLabel() {
        self.selectToday()
    }

    @IBAction func didTapAddEventButton() {
        self.bottomButtonStackView.isHidden = true
        self.inputTextField.isHidden = false
        self.inputTextField.becomeFirstResponder()
    }

    @IBAction private func didTapSettingsButton() {
        let settings = SettingsNavigationController()
        self.presentPanModal(settings)
    }
}

extension CalendarViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.bottomButtonStackView.isHidden = true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.bottomButtonStackView.isHidden = false
        }, completion: { finished in
            if finished {
                self.inputTextField.isHidden = true
            }
        })
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let substring = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        self.throttleParseInput(substring)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        defer { textField.resignFirstResponder() }
        self.handleInput(textField: textField)
        return true
    }
}
