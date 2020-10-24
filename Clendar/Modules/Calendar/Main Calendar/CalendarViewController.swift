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
import EasyClosure
import SPLarkController
import SwiftDate

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
            monthLabel.font = .serifFontWithSize(30)
            monthLabel.text = CVDate(date: Date(), calendar: currentCalendar).globalDescription
            monthLabel.textAlignment = .right

        }
    }

    private lazy var currentCalendar: Calendar = CalendarManager.shared.calendar

    private lazy var eventList: EventListViewController = {
        let proxy = EventListViewController()
        proxy.contentSizeDidChange = { [weak self] size in
            self?.eventListHeightConstraint.constant = size.height
            self?.view.setNeedsLayout()
            self?.view.layoutIfNeeded()
        }

        return proxy
    }()

    private lazy var inputParser = InputParser()
    internal var currentInput: InputParser.InputParserResult?
    private var calendarMode: CalendarMode = .monthView
    private var selectedDay: DayView? {
        didSet {
            let date = selectedDay?.date.convertedDate()
            selectDate(date)
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

        checkUIMode()

        settingsButton.on.tap { [weak self] in
            guard let self = self else { return }
            let settings = SettingsViewController()
            self.presentLark(settings: settings)
        }

        addEventButton.on.tap { [weak self] in
            guard let self = self else { return }
            self.bottomButtonStackView.isHidden = true
            self.inputTextField.isHidden = false
            self.inputTextField.becomeFirstResponder()
        }

        view.backgroundColor = .backgroundColor
        dayView.backgroundColor = .backgroundColor
        eventListContainerView.backgroundColor = .backgroundColor

        addGestures()
        addEventListContainer()
        addObservers()
        selectDate()
    }

    // MARK: - Private

    private func checkUIMode() {
        overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleDidAuthorizeCalendarAccess), name: kDidAuthorizeCalendarAccess, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        NotificationCenter.default.addObserver(forName: .didChangeUserInterfacePreferences, object: nil, queue: .main) { (_) in
            self.checkUIMode()
        }

        NotificationCenter.default.addObserver(forName: .didChangeShowLunarCalendarPreferences, object: nil, queue: .main) { (_) in
            self.calendarView.reloadData()
        }
    }

    @objc private func handleDidAuthorizeCalendarAccess() {
        selectDate()
    }

    private func addGestures() {
        monthLabel.isUserInteractionEnabled = true
        monthLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapMonthLabel)))
    }

    private func addEventListContainer() {
        addChildViewController(eventList, containerView: eventListContainerView)
    }

    private func handleInput(textField: UITextField) {
        let input = textField.text ?? ""
        guard input.isEmpty == false else { return }
        guard let result = inputParser.parse(input) else { return }

        EventHandler.shared.createEvent(result.action, startDate: result.startDate, endDate: result.endDate) { [weak self] in
            guard let self = self else { return }
            textField.text = ""
            let date = result.startDate
            self.selectDate(date)
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
        selectDate()
    }

    private func selectDate(_ date: Date? = Date()) {
        guard let date = date else { return }
        calendarView.toggleViewWithDate(date)
        eventList.fetchEvents(for: date)
    }
}

extension CalendarViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {

    // MARK: - CVCalendarViewDelegate, CVCalendarMenuViewDelegate

    func presentationMode() -> CalendarMode { calendarMode }

    func firstWeekday() -> Weekday { Region.current.locale.identifier == LocaleIdentifer.Vietnam.rawValue ? .monday : .sunday }
//    func firstWeekday() -> Weekday { .sunday }

    func calendar() -> Calendar? { currentCalendar }

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
        .serifFontWithSize(15)
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
        DateHighlightView.viewForDayView(dayView, isOut: dayView.isOut) ?? UIView()
    }

    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool { true }
}

extension CalendarViewController: CVCalendarViewAppearanceDelegate {

    // MARK: - CVCalendarViewAppearanceDelegate

    func spaceBetweenDayViews() -> CGFloat { 0 }

    func dayLabelWeekdayDisabledColor() -> UIColor { .appLightGray }

    func dayLabelPresentWeekdayInitallyBold() -> Bool { true }

    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont {
        .serifFontWithSize(20)
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        defer { textField.resignFirstResponder() }
        handleInput(textField: textField)
        return true
    }
}
