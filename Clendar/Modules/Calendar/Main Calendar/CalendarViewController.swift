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

final class CalendarViewController: BaseViewController {

    // MARK: - Properties

    @IBOutlet private var eventListHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet private var eventListContainerView: UIView!

    @IBOutlet private var bottomButtonStackView: UIStackView!

    @IBOutlet private var bottomConstraint: NSLayoutConstraint!

    @IBOutlet private var calendarView: CVCalendarView! {
        didSet {
            calendarView.calendarAppearanceDelegate = calendarConfiguration
            calendarView.animatorDelegate = calendarConfiguration
            calendarView.calendarDelegate = calendarConfiguration
        }
    }

    @IBOutlet private var dayView: CVCalendarMenuView! {
        didSet {
            dayView.delegate = calendarConfiguration
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
            monthLabel.font = .semiboldFontWithSize(30)
            monthLabel.text = Date().monthName(.default)
            monthLabel.textAlignment = .right

        }
    }

    private lazy var eventList = EventListViewController()

    private lazy var inputParser = InputParser()

    private lazy var calendarConfiguration: CalendarViewConfiguration = {
        let proxy = CalendarViewConfiguration(calendar: CalendarManager.shared.calendar, mode: .monthView)
        return proxy
    }()

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

    override func viewDidLoad() {
        super.viewDidLoad()

        calendarConfiguration.didSelectDayView = { [weak self] dayView, animationDidFinish in
            guard let self = self else { return }
            self.fetchEvents(dayView.convertedDate)
            self.resignTextField()
        }

        calendarConfiguration.presentedDateUpdated = { [weak self] date in
            guard let self = self else { return }
            self.monthLabel.text = date.convertedDate()?.monthName(.default)
        }

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

        addGestures()
        addEventListContainer()
        addObservers()
        selectToday()
    }

    override func setupViews() {
        super.setupViews()
        checkUIMode()
        view.backgroundColor = .backgroundColor
        dayView.backgroundColor = .backgroundColor
        eventListContainerView.backgroundColor = .backgroundColor
    }

    // MARK: - Private

    private func checkUIMode() {
        overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
    }

    private func selectToday() {
        calendarView.toggleCurrentDayView()
        eventList.fetchEvents()
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
        selectToday()
    }

    private func addGestures() {
        monthLabel.isUserInteractionEnabled = true
        monthLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapMonthLabel)))
    }

    private func fetchEvents(_ date: Date?) {
        guard let date = date else { return }
        eventList.fetchEvents(for: date)
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
            self.fetchEvents(date)
            self.calendarView.toggleViewWithDate(date)
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
