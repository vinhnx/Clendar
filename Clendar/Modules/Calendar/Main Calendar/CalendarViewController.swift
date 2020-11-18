//
//  CalendarViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 23/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import CVCalendar
import EventKit
import EventKitUI
import UIKit

final class CalendarViewController: BaseViewController {
	// MARK: Internal

	@IBOutlet var monthLabel: UILabel! {
		didSet {
			monthLabel.textColor = .primaryColor
			monthLabel.font = .boldFontWithSize(15)
			monthLabel.text = Date().toMonthAndYearString.uppercased()
			monthLabel.textAlignment = .right
		}
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		calendarView.commitCalendarViewUpdate()
		dayView.commitMenuViewUpdate()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		addGestures()
		addObservers()
		selectToday()

		view.backgroundColor = .backgroundColor
		dayView.backgroundColor = .backgroundColor
		eventListContainerView.backgroundColor = .backgroundColor
		addChildViewController(eventList, containerView: eventListContainerView)

		calendarConfiguration.didSelectDayView = { [weak self] dayView, _ in
			guard let self = self else { return }
			let selectedDate = dayView.convertedDate
			self.selectedDateLabel.text = Date().toFullDateString.uppercased()
			self.fetchEvents(selectedDate)
		}

		calendarConfiguration.presentedDateUpdated = { [weak self] date in
			guard let self = self else { return }
			self.monthLabel.text = date.convertedDate()?.toMonthAndYearString.uppercased()
		}

		settingsButton.addTarget(self, action: #selector(onTapSettingsButton), for: .touchUpInside)

		addEventButton.addTarget(self, action: #selector(onTapAddEventButton), for: .touchUpInside)
	}

	func createEvent() {
		if SettingsManager.useExperimentalCreateEventMode {
			guard let createEventViewController = R.storyboard.createEventViewController.instantiateInitialViewController() else { return }
			present(createEventViewController, animated: true, completion: nil)
		} else {
			let createEventViewController = EventEditViewController(
				eventStore: EventKitWrapper.shared.eventStore,
				delegate: self
			)
			present(createEventViewController, animated: true)
		}
	}

	// MARK: Private

	@IBOutlet private var eventListContainerView: UIView!

	private lazy var eventList = EventListViewController()

	private lazy var calendarConfiguration = CalendarViewConfiguration(
		calendar: CalendarManager.shared.calendar,
		mode: .monthView
	)

	@IBOutlet private var previousMonthButton: UIButton! {
		didSet {
			previousMonthButton.addTarget(self, action: #selector(selectPreviousDay), for: .touchUpInside)
		}
	}

	@IBOutlet private var nextMonthButton: UIButton! {
		didSet {
			nextMonthButton.addTarget(self, action: #selector(selectNextDay), for: .touchUpInside)
		}
	}

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

	@IBOutlet private var selectedDateLabel: UILabel! {
		didSet {
			selectedDateLabel.font = .boldFontWithSize(13)
			selectedDateLabel.adjustsFontForContentSizeCategory = true
			selectedDateLabel.textColor = .appDark
			selectedDateLabel.text = Date().toFullDateString.uppercased()
		}
	}

	private func addObservers() {
		NotificationCenter.default.addObserver(forName: .didAuthorizeCalendarAccess, object: nil, queue: .main) { _ in
			self.selectToday()
		}

		NotificationCenter.default.addObserver(forName: .EKEventStoreChanged, object: nil, queue: .main) { _ in
			self.calendarView.reloadData()
		}

		NotificationCenter.default.addObserver(forName: .didDeleteEvent, object: nil, queue: .main) { _ in
			self.calendarView.reloadData()
		}

		NotificationCenter.default.addObserver(forName: .didChangeMonthViewCalendarModePreferences, object: nil, queue: .main) { _ in
			let calendarMode: CVCalendarViewPresentationMode = SettingsManager.monthViewCalendarMode ? .monthView : .weekView
			self.calendarView.changeMode(calendarMode)
		}

		NotificationCenter.default.addObserver(forName: .didChangeShowDaysOutPreferences, object: nil, queue: .main) { _ in
			self.calendarView.changeDaysOutShowingState(shouldShow: SettingsManager.showDaysOut)
			self.calendarView.reloadData()
		}

		NotificationCenter.default.addObserver(forName: .didChangeDaySupplementaryTypePreferences, object: nil, queue: .main) { _ in
			self.calendarView.reloadData()
		}

		NotificationCenter.default.addObserver(forName: .didChangeSavedCalendarsPreferences, object: nil, queue: .main) { [weak self] _ in
			guard let self = self else { return }
			self.fetchEvents(self.calendarView.selectedDate)
		}

		NotificationCenter.default.addObserver(forName: .justReloadCalendar, object: nil, queue: .main) { _ in
			self.calendarView.reloadData()
		}
	}

	private func selectToday() {
		genLightHaptic()
		calendarView.toggleCurrentDayView()
		eventList.fetchEvents()
	}

	@objc private func selectPreviousDay() {
		genLightHaptic()
		calendarView.loadPreviousView()
	}

	@objc private func selectNextDay() {
		genLightHaptic()
		calendarView.loadNextView()
	}

	private func addGestures() {
		monthLabel.isUserInteractionEnabled = true
		monthLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapMonthLabel)))
	}

	private func fetchEvents(_ date: Date?) {
		guard let date = date else { return }
		eventList.fetchEvents(for: date)
	}

	@objc private func didTapMonthLabel() {
		selectToday()
	}

	@objc private func onTapSettingsButton() {
		genLightHaptic()
		let settings = SettingsNavigationController()
		present(settings, animated: true)
	}

	@objc private func onTapAddEventButton() {
		createEvent()
	}
}

extension CalendarViewController: EKEventEditViewDelegate {
	func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith _: EKEventEditViewAction) {
		dimissModal()
		guard let event = controller.event else { return }
		guard let date = event.startDate else { return }
		fetchEvents(date)
		calendarView.toggleViewWithDate(date)
	}

	func eventEditViewControllerDefaultCalendar(forNewEvents _: EKEventEditViewController) -> EKCalendar {
		EventKitWrapper.shared.defaultCalendar
	}
}
