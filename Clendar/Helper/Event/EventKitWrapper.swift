//
//  EventKitWrapper.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import EventKit
import Foundation

/// [WIP] Wrapper for EventKit
final class EventKitWrapper {

    // MARK: - Properties

    /// Event store: An object that accesses the user’s calendar and reminder events and supports the scheduling of new events.
    public private(set) var eventStore = EKEventStore()

    /// Returns calendar object from event kit
    public var defaultCalendar: EKCalendar {
        eventStore.calendarForApp()
    }

    /// Return all accessible calendars from user's authorization
    public private(set) var allDefaultCalendars = [EKCalendar]()

    /// Saved calendars from settings
    public var savedCalendars: [EKCalendar] {
        let result = allDefaultCalendars.filter { calendar in savedCalendarIDs.contains(calendar.calendarIdentifier) }
        if result.isEmpty { return allDefaultCalendars }
        return result
    }

    // Storage
    private var _savedCalendarIDs = [String]()
    public var savedCalendarIDs: [String] {
        get { UserDefaults.savedCalendarIDs }
        set {
            UserDefaults.savedCalendarIDs = newValue
            NotificationCenter.default.post(name: .didChangeSavedCalendarsPreferences, object: nil)
        }
    }

    // MARK: - Life cycle

    static let shared = EventKitWrapper()
    private init() {} // This prevents others from using the default '()' initializer for this class.

    // MARK: - Flow

    /// Request event store authorization
    /// - Parameter completion: completion handler with an EKAuthorizationStatus enum
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

    /// Create an event
    /// - Parameters:
    ///   - title: event title
    ///   - startDate: event start date
    ///   - endDate: event end date
    ///   - completion: completion handler
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

    /// Delete an event
    /// - Parameters:
    ///   - identifier: event identifier
    ///   - span: An object that indicates whether modifications should apply to a single event or all future events of a recurring event.
    ///   - completion: completion handler
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

    /// Fetch events for today
    /// - Parameter completion: completion handler
    func fetchEventsForToday(completion: EventsCompletion? = nil) {
        let today = Date()
        fetchEvents(startDate: today.startDate, endDate: today.endDate, completion: completion)
    }

    /// Fetch events for a specific day
    /// - Parameters:
    ///   - date: day to fetch events from
    ///   - completion: completion handler
    func fetchEvents(for date: Date, completion: EventsCompletion?) {
        fetchEvents(startDate: date.startDate, endDate: date.endDate, completion: completion)
    }

    /// Fetch events from date range
    /// - Parameters:
    ///   - startDate: start date range
    ///   - endDate: end date range
    ///   - completion: completion handler
    func fetchEvents(startDate: Date, endDate: Date, completion: EventsCompletion?) {
        requestEventStoreAuthorization { [weak self] status in
            guard status == .authorized else { return }
            guard let self = self else { return }

            let _calendars = self.eventStore.calendars(for: .event)
            self.allDefaultCalendars = _calendars

            let predicate = self.eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: self.savedCalendars)
            let events = self.eventStore.events(matching: predicate)

            DispatchQueue.main.async {
                completion?(events)
            }
        }
    }

    // MARK: - Private

    /// Request access to calendar
    /// - Parameter completion: calendar object
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
