//
//  EventKitWrapper.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import EventKit
import Foundation

/// <#Description#>
final class EventKitWrapper {

    // MARK: - Properties

    /// <#Description#>
    public private(set) var eventStore = EKEventStore()

    /// <#Description#>
    public var defaultCalendar: EKCalendar {
        eventStore.calendarForApp()
    }

    // MARK: - Life cycle

    static let shared = EventKitWrapper()
    private init() {} // This prevents others from using the default '()' initializer for this class.

    // MARK: - Flow

    /// <#Description#>
    /// - Parameter completion: <#completion description#>
    func requestEventStoreAuthorization(completion: ((EKAuthorizationStatus) -> Void)?) {
        let status = EKEventStore.authorizationStatus(for: .event)

        switch status {
        case .authorized:
            DispatchQueue.main.async { completion?(status) }

        case .denied,
             .restricted:
            AlertManager.showSettingsAlert(message: "Please authorize \(AppInfo.appName) to create Calendar events")
            DispatchQueue.main.async { completion?(status) }

        case .notDetermined:
            requestCalendarAccess { DispatchQueue.main.async { completion?(status) } }

        @unknown default:
            DispatchQueue.main.async { completion?(status) }
        }
    }

    // MARK: - CRUD

    /// <#Description#>
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - startDate: <#startDate description#>
    ///   - endDate: <#endDate description#>
    ///   - completion: <#completion description#>
    func createEvent(_ title: String, startDate: Date, endDate: Date?, completion: EventCompletion?) {
        requestEventStoreAuthorization { [weak self] status in
            guard status == .authorized else { return }
            guard let self = self else { return }
            self.accessCalendar { [weak self] calendar in
                guard let self = self else { return }
                self.eventStore.createEvent(title: title, startDate: startDate, endDate: endDate, calendar: calendar, completion: completion)
            }
        }
    }

    /// <#Description#>
    /// - Parameters:
    ///   - identifier: <#identifier description#>
    ///   - span: <#span description#>
    ///   - completion: <#completion description#>
    func deleteEvent(identifier: String, span: EKSpan = .thisEvent, completion: VoidHandler?) {
        requestEventStoreAuthorization { [weak self] status in
            guard status == .authorized else { return }
            guard let self = self else { return }
            self.accessCalendar { [weak self] _ in
                guard let self = self else { return }
                self.eventStore.deleteEvent(identifier: identifier, span: span, completion: completion)
            }
        }
    }

    // MARK: - Fetch Events

    /// <#Description#>
    /// - Parameter completion: <#completion description#>
    func fetchEventsForToday(completion: EventsCompletion? = nil) {
        let today = Date()
        fetchEvents(startDate: today.startDate, endDate: today.endDate, completion: completion)
    }

    /// <#Description#>
    /// - Parameters:
    ///   - date: <#date description#>
    ///   - completion: <#completion description#>
    func fetchEvents(for date: Date, completion: EventsCompletion?) {
        fetchEvents(startDate: date.startDate, endDate: date.endDate, completion: completion)
    }

    /// <#Description#>
    /// - Parameters:
    ///   - startDate: <#startDate description#>
    ///   - endDate: <#endDate description#>
    ///   - completion: <#completion description#>
    func fetchEvents(startDate: Date, endDate: Date, completion: EventsCompletion?) {
        requestEventStoreAuthorization { [weak self] status in
            guard status == .authorized else { return }
            guard let self = self else { return }

            let calendars = self.eventStore.calendars(for: .event)
            let predicate = self.eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars)
            let events = self.eventStore.events(matching: predicate)

            DispatchQueue.main.async {
                completion?(events)
            }
        }
    }

    // MARK: - Private

    /// <#Description#>
    /// - Parameter completion: <#completion description#>
    private func accessCalendar(completion: EventCalendarHandler?) {
        requestEventStoreAuthorization { [weak self] status in
            guard status == .authorized else { return }
            guard let self = self else { return }
            completion?(self.eventStore.calendarForApp())
        }
    }

    /// Prompt the user for access to their Calendar
    /// - Parameter onAuthorized: on authorized
    private func requestCalendarAccess(onAuthorized: VoidHandler?) {
        eventStore.requestAccess(to: .event) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .didAuthorizeCalendarAccess, object: nil)
                    onAuthorized?()
                }
            }
            else {
                DispatchQueue.main.async {
                    error.flatMap { logError($0) }
                }
            }
        }
    }
}
