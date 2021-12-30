//
//  SingleCalendarChooserViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 03/12/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import EventKitUI
import UIKit
import Shift

final class SingleCalendarChooserViewController: EKCalendarChooser {

    // MARK: Lifecycle

    convenience init() {
        self.init(eventStore: Shift.shared.eventStore)
    }

    init(eventStore: EKEventStore) {
        super.init(selectionStyle: .single, displayStyle: .writableCalendarsOnly, entityType: .event, eventStore: eventStore)
        if let defaultCalendarFromSettings = eventStore.defaultCalendarFromSettings {
            self.selectedCalendars = Set([defaultCalendarFromSettings])
        }

        self.showsDoneButton = true
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
        title = NSLocalizedString("Default Calendar", comment: "")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        checkUIMode()

        NotificationCenter.default.addObserver(forName: .didChangeUserInterfacePreferences, object: nil, queue: .main) { _ in
            self.checkUIMode()
        }
    }

    // MARK: - Private

    private func updateSelectedCalendar(_ name: String) {
        Shift.appName = name
        UserDefaults.defaultCalendarName = name
        NotificationCenter.default.post(name: .didChangeSavedCalendarsPreferences, object: nil)
    }

    private func checkUIMode() {
        overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
    }
}

extension SingleCalendarChooserViewController: EKCalendarChooserDelegate {

    // MARK: - EKCalendarChooserDelegate

    func calendarChooserDidFinish(_ calendarChooser: EKCalendarChooser) {
        guard let name = calendarChooser.selectedCalendars.first?.title else { return }
        updateSelectedCalendar(name)
        dismiss(animated: true, completion: nil)
    }

    func calendarChooserSelectionDidChange(_ calendarChooser: EKCalendarChooser) {
        guard let name = calendarChooser.selectedCalendars.first?.title else { return }
        updateSelectedCalendar(name)
    }

    func calendarChooserDidCancel(_ calendarChooser: EKCalendarChooser) {
        dismiss(animated: true, completion: nil)
    }
}
