//
//  MultipleCalendarsChooserViewController.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 21/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import EventKitUI
import UIKit
import Shift

class MultipleCalendarsChooserViewController: EKCalendarChooser {

    // MARK: Lifecycle

    convenience init() {
        self.init(eventStore: Shift.shared.eventStore)
    }

    init(eventStore: EKEventStore) {
        super.init(selectionStyle: .multiple, displayStyle: .allCalendars, entityType: .event, eventStore: eventStore)
        self.selectedCalendars = Set(eventStore.selectableCalendarsFromSettings)
        self.delegate = self
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Internal

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = NSLocalizedString("Calendars Visibility", comment: "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        checkUIMode()

        NotificationCenter.default.addObserver(forName: .didChangeUserInterfacePreferences, object: nil, queue: .main) { _ in
            self.checkUIMode()
        }
    }

    // MARK: - Private

    private func updateSelectedCalendarIDs(_ calendarIDs: [String]) {
        UserDefaults.savedCalendarIDs = calendarIDs
        NotificationCenter.default.post(name: .didChangeSavedCalendarsPreferences, object: nil)
    }

    private func checkUIMode() {
        overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
    }
}

extension MultipleCalendarsChooserViewController: EKCalendarChooserDelegate {

    // MARK: - EKCalendarChooserDelegate

    func calendarChooserDidFinish(_ calendarChooser: EKCalendarChooser) {
        let calendarIDs = calendarChooser.selectedCalendars.compactMap { $0.calendarIdentifier }
        updateSelectedCalendarIDs(calendarIDs)
        dismiss(animated: true, completion: nil)
    }

    func calendarChooserSelectionDidChange(_ calendarChooser: EKCalendarChooser) {
        let calendarIDs = calendarChooser.selectedCalendars.compactMap { $0.calendarIdentifier }
        updateSelectedCalendarIDs(calendarIDs)
    }

    func calendarChooserDidCancel(_ calendarChooser: EKCalendarChooser) {
        dismiss(animated: true, completion: nil)
    }
}
