//
//  EventHandler.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import EventKit
import Foundation

final class EventHandler {

    // MARK: - Properties

    private var eventStore = EKEventStore()

    // MARK: - Flow

    func request(onAuthorized: VoidHandler?) {
        let status = EKEventStore.authorizationStatus(for: .event)
        switch status {
        case .authorized: break
        case .denied, .restricted:
            AlertManager.showSettingsAlert(message: "Please authorize \(calendarName) to create Calendar events")

        case .notDetermined:
            self.requestCreatingEventAccess(onAuthorized: onAuthorized)
        }
    }

    func createEvent(_ title: String, startDate: Date, endDate: Date?, onDone: VoidHandler?) {
        let status = EKEventStore.authorizationStatus(for: .event)
        guard status == .authorized else {
            self.request { [weak self] in
                self?.createEvent(title, startDate: startDate, endDate: endDate, onDone: onDone)
            }

            return
        }

        self.accessCalendar { [weak self] calendar in
            self?.eventStore.createEvent(title: title,
                                         startDate: startDate,
                                         endDate: endDate,
                                         calendar: calendar,
                                         completion: onDone)
        }
    }

    // MARK: - Private

    private func accessCalendar(completion: EventCalendarHandler?) {
        let status = EKEventStore.authorizationStatus(for: .event)
        guard status == .authorized else {
            self.request { [weak self] in
                self?.accessCalendar(completion: completion)
            }

            return
        }

        self.eventStore.calendarForApp(completion: completion)
    }

    private func requestCreatingEventAccess(onAuthorized: VoidHandler?) {
        self.eventStore.requestAccess(to: .event) { granted, error in
            guard granted == true else {
                error.flatMap { print($0) }
                return
            }

            onAuthorized.flatMap { $0() }
        }
    }
}
