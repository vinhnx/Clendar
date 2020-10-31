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
import EventKitUI

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
            monthLabel.font = .boldFontWithSize(30)
            monthLabel.text = Date().monthName(.default)
            monthLabel.textAlignment = .right
        }
    }

    private lazy var eventList = EventListViewController()

    private lazy var calendarConfiguration = CalendarViewConfiguration(
        calendar: CalendarManager.shared.calendar,
        mode: .monthView
    )

    // MARK: - Life cycle

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarView.commitCalendarViewUpdate()
        dayView.commitMenuViewUpdate()
    }

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        addGestures()
        addObservers()
        selectToday()

        view.backgroundColor = .backgroundColor
        dayView.backgroundColor = .backgroundColor
        eventListContainerView.backgroundColor = .backgroundColor
        addChildViewController(eventList, containerView: eventListContainerView)

        calendarConfiguration.didSelectDayView = { [weak self] dayView, animationDidFinish in
            guard let self = self else { return }
            self.fetchEvents(dayView.convertedDate)
        }

        calendarConfiguration.presentedDateUpdated = { [weak self] date in
            guard let self = self else { return }
            self.monthLabel.text = date.convertedDate()?.monthName(.default)
        }

        settingsButton.addTarget(self, action: #selector(onTapSettingsButton), for: .touchUpInside)

        addEventButton.addTarget(self, action: #selector(onTapAddEventButton), for: .touchUpInside)
    }

    // MARK: - Private

    private func addObservers() {
        NotificationCenter.default.addObserver(forName: .didAuthorizeCalendarAccess, object: nil, queue: .main) { (_) in
            self.selectToday()
        }

        NotificationCenter.default.addObserver(forName: .EKEventStoreChanged, object: nil, queue: .main) { (_) in
            self.calendarView.reloadData()
        }

        NotificationCenter.default.addObserver(forName: .didDeleteEvent, object: nil, queue: .main) { (_) in
            self.calendarView.reloadData()
        }

        NotificationCenter.default.addObserver(forName: .didChangeMonthViewCalendarModePreferences, object: nil, queue: .main) { (_) in
            let calendarMode: CVCalendarViewPresentationMode = SettingsManager.monthViewCalendarMode ? .monthView : .weekView
            self.calendarView.changeMode(calendarMode)
        }

        NotificationCenter.default.addObserver(forName: .didChangeShowDaysOutPreferences, object: nil, queue: .main) { (_) in
            self.calendarView.changeDaysOutShowingState(shouldShow: SettingsManager.showDaysOut)
            self.calendarView.reloadData()
        }

        NotificationCenter.default.addObserver(forName: .didChangeDaySupplementaryTypePreferences, object: nil, queue: .main) { (_) in
            self.calendarView.reloadData()
        }

        NotificationCenter.default.addObserver(forName: .didChangeSavedCalendarsPreferences, object: nil, queue: .main) { [weak self] (_) in
            guard let self = self else { return }
            self.fetchEvents(self.calendarView.selectedDate)
        }

        NotificationCenter.default.addObserver(forName: .justReloadCalendar, object: nil, queue: .main) { (_) in
            self.calendarView.reloadData()
        }
    }

    private func selectToday() {
        calendarView.toggleCurrentDayView()
        eventList.fetchEvents()
    }

    private func addGestures() {
        monthLabel.isUserInteractionEnabled = true
        monthLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapMonthLabel)))
    }

    private func fetchEvents(_ date: Date?) {
        guard let date = date else { return }
        eventList.fetchEvents(for: date)
    }

    private func createEvent() {
        if SettingsManager.useExperimentalCreateEventMode {
            guard let createEventViewController = R.storyboard.createEventViewController.instantiateInitialViewController() else { return }
            self.present(createEventViewController, animated: true, completion: nil)
        } else {
            let createEventViewController = EventEditViewController(
                eventStore: EventKitWrapper.shared.eventStore,
                delegate: self
            )
            self.present(createEventViewController, animated: true)
        }
    }

    // MARK: - Actions

    @objc private func didTapMonthLabel() {
        selectToday()
    }

    @objc private func onTapSettingsButton() {
        let settings = SettingsNavigationController()
        present(settings, animated: true)
    }

    @objc private func onTapAddEventButton() {
        createEvent()
    }

}

extension CalendarViewController: EKEventEditViewDelegate {
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true)
        guard let event = controller.event else { return }
        guard let date = event.startDate else { return }
        fetchEvents(date)
        calendarView.toggleViewWithDate(date)
    }

    func eventEditViewControllerDefaultCalendar(forNewEvents controller: EKEventEditViewController) -> EKCalendar {
        EventKitWrapper.shared.defaultCalendar
    }
}
