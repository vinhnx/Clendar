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

    // MARK: - Life cycle

    static let shared = EventHandler()
    private init() {} // This prevents others from using the default '()' initializer for this class.

    // MARK: - Flow

    func request(onAuthorized: VoidHandler?) {
        let status = EKEventStore.authorizationStatus(for: .event)
        switch status {
        case .authorized:
            break

        case .denied, .restricted:
            AlertManager.showSettingsAlert(message: "Please authorize \(AppName) to create Calendar events")

        case .notDetermined:
            requestCreatingEventAccess(onAuthorized: onAuthorized)

        @unknown default:
            break
        }
    }

    func createEvent(_ title: String, startDate: Date, endDate: Date?, onDone: VoidHandler?) {
        let status = EKEventStore.authorizationStatus(for: .event)
        guard status == .authorized else {
            request { [weak self] in
                self?.createEvent(title, startDate: startDate, endDate: endDate, onDone: onDone)
            }

            return
        }

        accessCalendar { [weak self] calendar in
            self?.eventStore.createEvent(title: title,
                                         startDate: startDate,
                                         endDate: endDate,
                                         calendar: calendar,
                                         completion: onDone)
        }
    }

    // MARK: - Fetch Events

    func fetchEventsForToday(completion: EventResultHandler? = nil) {
        let today = Date()
        fetchEvents(startDate: today.startDate, endDate: today.endDate, completion: completion)
    }

    func fetchEvents(for date: Date, completion: EventResultHandler?) {
        fetchEvents(startDate: date.startDate, endDate: date.endDate, completion: completion)
    }
    
    func fetchEvents(startDate: Date, endDate: Date, completion: EventResultHandler?) {
        let status = EKEventStore.authorizationStatus(for: .event)
        guard status == .authorized else {
            request { [weak self] in
                self?.fetchEvents(startDate: startDate, endDate: endDate, completion: completion)
            }

            completion.flatMap { $0(.failure(.failedToAuthorizeEventPersmissson)) }
            return
        }

        let calendars = eventStore.calendars(for: .event)
        let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars)
        let events = eventStore.events(matching: predicate)
        completion.flatMap { $0(.success(events)) }
    }

    // MARK: - Private

    private func accessCalendar(completion: EventCalendarHandler?) {
        let status = EKEventStore.authorizationStatus(for: .event)
        guard status == .authorized else {
            request { [weak self] in
                self?.accessCalendar(completion: completion)
            }

            return
        }

        eventStore.calendarForApp(completion: completion)
    }

    private func requestCreatingEventAccess(onAuthorized: VoidHandler?) {
        eventStore.requestAccess(to: .event) { granted, error in
            guard granted == true else {
                error.flatMap { logError($0) }
                return
            }

            NotificationCenter.default.post(name: kDidAuthorizeCalendarAccess, object: nil)
            onAuthorized.flatMap { $0() }
        }
    }
}
