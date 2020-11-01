//
//  CalendarsChooserViewController.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 10/29/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import UIKit
import EventKitUI

class CalendarsChooserNavigationController: UINavigationController {

    // MARK: - Life Cycle

    init(
        selectionStyle style: EKCalendarChooserSelectionStyle = .multiple,
        displayStyle: EKCalendarChooserDisplayStyle = .allCalendars,
        entityType: EKEntityType = .event,
        eventStore: EKEventStore = EventKitWrapper.shared.eventStore,
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

    override func viewDidLoad() {
        super.viewDidLoad()

        checkUIMode()

        NotificationCenter.default.addObserver(forName: .didChangeUserInterfacePreferences, object: nil, queue: .main) { (_) in
            self.checkUIMode()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Private

    func checkUIMode() {
        overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
    }

}

class CalendarsChooserViewController: EKCalendarChooser {

    // MARK: - Life Cycle

    convenience init() {
        self.init(selectionStyle: .multiple, displayStyle: .allCalendars, entityType: .event, eventStore: EventKitWrapper.shared.eventStore)
        self.delegate = self
        self.selectedCalendars = EventKitWrapper.shared.savedCalendars.asSet
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        checkUIMode()

        NotificationCenter.default.addObserver(forName: .didChangeUserInterfacePreferences, object: nil, queue: .main) { (_) in
            self.checkUIMode()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Private

    func checkUIMode() {
        overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
    }

}

extension CalendarsChooserViewController: EKCalendarChooserDelegate {

    func calendarChooserSelectionDidChange(_ calendarChooser: EKCalendarChooser) {
        EventKitWrapper.shared.savedCalendarIDs = calendarChooser.selectedCalendars.map { $0.calendarIdentifier }
    }

    func calendarChooserDidFinish(_ calendarChooser: EKCalendarChooser) {
        dimissModal()
    }

    func calendarChooserDidCancel(_ calendarChooser: EKCalendarChooser) {
        dimissModal()
    }

}
