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

    private var createEventViewController: CreateEventViewController?

    // MARK: - Life cycle

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarView.commitCalendarViewUpdate()
        dayView.commitMenuViewUpdate()
    }

    // MARK: - Override

    override func viewDidLoad() {
        super.viewDidLoad()

        createEventViewController = R.storyboard.createEventViewController.instantiateInitialViewController()

        createEventViewController?.didCreateEvent = { [weak self] result in
            guard let self = self else { return }
            let date = result.startDate
            self.fetchEvents(date)
            self.calendarView.toggleViewWithDate(date)
        }

        calendarConfiguration.didSelectDayView = { [weak self] dayView, animationDidFinish in
            guard let self = self else { return }
            self.fetchEvents(dayView.convertedDate)
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
            guard let createEvent = self.createEventViewController else { return }
            self.present(createEvent, animated: true)
        }

        addGestures()
        addEventListContainer()
        addObservers()
        selectToday()

        view.backgroundColor = .backgroundColor
        dayView.backgroundColor = .backgroundColor
        eventListContainerView.backgroundColor = .backgroundColor
    }

    // MARK: - Private

    private func selectToday() {
        calendarView.toggleCurrentDayView()
        eventList.fetchEvents()
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(forName: kDidAuthorizeCalendarAccess, object: nil, queue: .main) { (_) in
            self.selectToday()
        }

        NotificationCenter.default.addObserver(forName: .didChangeShowLunarCalendarPreferences, object: nil, queue: .main) { (_) in
            self.calendarView.reloadData()
        }
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

    // MARK: - Actions

    @objc private func didTapMonthLabel() {
        selectToday()
    }
}
