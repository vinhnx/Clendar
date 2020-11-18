//
//  CalendarsChooserViewController.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 10/29/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKitUI
import UIKit

class CalendarsChooserNavigationController: UINavigationController {
	// MARK: Lifecycle

	init(
		selectionStyle _: EKCalendarChooserSelectionStyle = .multiple,
		displayStyle _: EKCalendarChooserDisplayStyle = .allCalendars,
		entityType _: EKEntityType = .event,
		eventStore _: EKEventStore = EventKitWrapper.shared.eventStore,
		delegate: EKCalendarChooserDelegate
	) {
		let viewController = CalendarsChooserViewController(
			selectionStyle: .multiple,
			displayStyle: .allCalendars,
			entityType: .event,
			eventStore: EventKitWrapper.shared.eventStore
		)

		viewController.showsDoneButton = true
		viewController.showsCancelButton = true
		viewController.delegate = delegate
		super.init(rootViewController: viewController)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	// MARK: Internal

	override func viewDidLoad() {
		super.viewDidLoad()

		checkUIMode()

		NotificationCenter.default.addObserver(forName: .didChangeUserInterfacePreferences, object: nil, queue: .main) { _ in
			self.checkUIMode()
		}
	}

	func checkUIMode() {
		overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
	}
}

class CalendarsChooserViewController: EKCalendarChooser {
	// MARK: Lifecycle

	convenience init() {
		self.init(selectionStyle: .multiple, displayStyle: .allCalendars, entityType: .event, eventStore: EventKitWrapper.shared.eventStore)
		delegate = self
		selectedCalendars = EventKitWrapper.shared.savedCalendars.asSet
	}

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	// MARK: Internal

	override func viewDidLoad() {
		super.viewDidLoad()

		checkUIMode()

		NotificationCenter.default.addObserver(forName: .didChangeUserInterfacePreferences, object: nil, queue: .main) { _ in
			self.checkUIMode()
		}
	}

	func checkUIMode() {
		overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
	}
}

extension CalendarsChooserViewController: EKCalendarChooserDelegate {
	func calendarChooserSelectionDidChange(_ calendarChooser: EKCalendarChooser) {
		EventKitWrapper.shared.savedCalendarIDs = calendarChooser.selectedCalendars.map(\.calendarIdentifier)
	}

	func calendarChooserDidFinish(_: EKCalendarChooser) {
		dimissModal()
	}

	func calendarChooserDidCancel(_: EKCalendarChooser) {
		dimissModal()
	}
}
