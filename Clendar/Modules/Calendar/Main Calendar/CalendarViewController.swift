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

    @IBOutlet private var eventListHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var eventListContainerView: UIView!
    @IBOutlet private var bottomButtonStackView: UIStackView!
    @IBOutlet private var bottomConstraint: NSLayoutConstraint!

    @IBOutlet private var calendarView: CVCalendarView! {
        didSet {
            calendarView.calendarAppearanceDelegate = self
            calendarView.animatorDelegate = self
            calendarView.calendarDelegate = self
        }
    }

    @IBOutlet private var dayView: CVCalendarMenuView! {
        didSet {
            dayView.delegate = self
        }
    }

    @IBOutlet private var inputTextField: TextField! {
        didSet {
            inputTextField.delegate = self
            inputTextField.applyRoundWithOffsetShadow()
        }
    }

    @IBOutlet private var addEventButton: Button! {
        didSet {
            addEventButton.tintColor = .buttonTintColor
            addEventButton.backgroundColor = .primaryColor
        }
    }

    @IBOutlet private var settingsButton: Button! {
        didSet {
            settingsButton.tintColor = .primaryColor
        }
    }

    @IBOutlet var monthLabel: UILabel! {
        didSet {
            monthLabel.textColor = .appDark
            monthLabel.font = UIFont.fontWithSize(30, weight: .medium)
            monthLabel.text = CVDate(date: Date(), calendar: currentCalendar).globalDescription
            monthLabel.textAlignment = .right

        }
    }

    private lazy var currentCalendar: Calendar = CalendarManager.shared.calendar

    private lazy var eventList: EventListViewController = {
        let proxy = EventListViewController()
        proxy.contentSizeDidChange = { [weak self] size in
            self?.eventListHeightConstraint.constant = size.height
            self?.view.layoutIfNeeded()
        }

        return proxy
    }()

    private lazy var inputParser = InputParser()
    internal var currentInput: InputParser.InputParserResult?
    private var calendarMode: CalendarMode = .monthView
    private var selectedDay: DayView? {
        didSet {
            handleDayViewSelection(selectedDay)
        }
    }

    // MARK: - Life cycle

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarView.commitCalendarViewUpdate()
        dayView.commitMenuViewUpdate()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Override

    override func setupViews() {
        super.setupViews()

        view.backgroundColor = .backgroundColor
        dayView.backgroundColor = .backgroundColor
        eventListContainerView.backgroundColor = .backgroundColor
        addGestures()
        addEventListContainer()
        addObservers()
        selectToday()
    }

    // MARK: - Private

    private func handleDisplaySubDayView(_ dayView: DayView) -> Bool {
        var display = false

        fetchEventsFor(dayView) { result in
            switch result {
            case .success(let response):
                display = response.isEmpty == false
            case .failure:
                break
            }
        }

        return display
    }

    private func selectToday() {
        calendarView.toggleCurrentDayView()
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleDidAuthorizeCalendarAccess), name: kDidAuthorizeCalendarAccess, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    @objc private func handleDidAuthorizeCalendarAccess() {
        selectToday()
    }

    private func addGestures() {
        monthLabel.isUserInteractionEnabled = true
        monthLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapMonthLabel)))
    }

    private func handleDayViewSelection(_ dayView: DayView?) {
        guard let dayView = dayView else { return }

        fetchEventsFor(dayView) { [weak self] result in
            guard let self = self else { return }

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
        addChildViewController(eventList, containerView: eventListContainerView)
    }

    private func throttleParseInput(_ input: String) {
        currentInput = inputParser.parse(input)
    }

    private func handleInput(textField: UITextField) {
        guard let result = currentInput else { return }
        EventHandler.shared.createEvent(result.action, startDate: result.startDate, endDate: result.endDate) { [weak self] in
            textField.text = ""
            self?.eventList.fetchEvents()
            self?.calendarView.toggleViewWithDate(result.startDate)
        }
    }

    @objc private func resignTextField() {
        inputTextField.resignFirstResponder()
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

    // MARK: - Actions

    @objc private func didTapMonthLabel() {
        selectToday()
    }

    @IBAction func didTapAddEventButton() {
        bottomButtonStackView.isHidden = true
        inputTextField.isHidden = false
        inputTextField.becomeFirstResponder()
    }

    @IBAction private func didTapSettingsButton() {
        let settings = SettingsNavigationController()
        presentPanModal(settings)
    }
}

extension CalendarViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {

    // MARK: - CVCalendarViewDelegate, CVCalendarMenuViewDelegate

    func presentationMode() -> CalendarMode { calendarMode }

    func firstWeekday() -> Weekday { .monday }

    func calendar() -> Calendar? { currentCalendar }

    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        return weekday == .sunday ? .appRed : .appGray
    }

    func shouldShowWeekdaysOut() -> Bool { true }

    func shouldAutoSelectDayOnMonthChange() -> Bool { false }

    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        selectedDay = dayView
        resignTextField()
    }

    func presentedDateUpdated(_ date: CVDate) {
        monthLabel.text = date.globalDescription
    }

    func dayOfWeekFont() -> UIFont {
        return .fontWithSize(15, weight: .medium)
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

    private func fetchEventsFor(_ dayView: DayView, completion: EventResultHandler?) {
        guard let date = dayView.date.convertedDate() else { return }
        EventHandler.shared.fetchEvents(for: date, completion: completion)
    }

    private func fetchEventsFor(_ date: Date, completion: @escaping EventResultHandler) {
        EventHandler.shared.fetchEvents(for: date, completion: completion)
    }

    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        DateHighlightView.viewForDayView(dayView, isOut: dayView.isOut)
    }

    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        true
    }
}

extension CalendarViewController: CVCalendarViewAppearanceDelegate {

    // MARK: - CVCalendarViewAppearanceDelegate

    func spaceBetweenDayViews() -> CGFloat { 0 }

    func dayLabelWeekdayDisabledColor() -> UIColor { .appLightGray }

    func dayLabelPresentWeekdayInitallyBold() -> Bool { true }

    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont {
        .fontWithSize(20, weight: .medium)
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

extension CalendarViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        bottomButtonStackView.isHidden = true
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
        throttleParseInput(substring)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        defer { textField.resignFirstResponder() }
        handleInput(textField: textField)
        return true
    }
}
