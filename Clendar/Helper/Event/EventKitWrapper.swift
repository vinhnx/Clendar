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
    func requestEventStoreAuthorization(completion: ((Result<EKAuthorizationStatus, ClendarError>) -> Void)?) {
        let status = EKEventStore.authorizationStatus(for: .event)

        switch status {
        case .authorized:
            DispatchQueue.main.async { completion?(.success(status)) }

        case .denied,
             .restricted:
            DispatchQueue.main.async { completion?(.failure(ClendarError.failedToAuthorizeEventPersmissson(status))) }

        case .notDetermined:
            requestCalendarAccess { (result) in
                switch result {
                case .success(let granted):
                    if granted { DispatchQueue.main.async { completion?(.success(status)) } }
                    else { DispatchQueue.main.async { completion?(.failure(ClendarError.unableToAccessCalendar)) } }

                case .failure(let error):
                    DispatchQueue.main.async { completion?(.failure(ClendarError.mapFromError(error))) }

                }
            }

        @unknown default:
            DispatchQueue.main.async { completion?(.failure(ClendarError.failedToAuthorizeEventPersmissson(status))) }

        }
    }

    // MARK: - CRUD

    /// Create an event
    /// - Parameters:
    ///   - title: event title
    ///   - startDate: event start date
    ///   - endDate: event end date
    ///   - completion: completion handler
    func createEvent(
        _ title: String,
        startDate: Date,
        endDate: Date?,
        span: EKSpan = .thisEvent,
        isAllDay: Bool = false,
        completion: ((Result<EKEvent, ClendarError>) -> Void)?
    ) {
        requestEventStoreAuthorization { [weak self] result in
            switch result {
            case .success(let status):
                guard let self = self else { return }
                guard status == .authorized else { return }

                self.accessCalendar { [weak self] calendarResult in
                    guard let self = self else { return }

                    switch calendarResult {
                    case .success(let calendar):
                        self.eventStore.createEvent(title: title, startDate: startDate, endDate: endDate, calendar: calendar, span: span, isAllDay: isAllDay, completion: completion)

                    case .failure(let error):
                        DispatchQueue.main.async { completion?(.failure(error)) }

                    }
                }

            case .failure(let error):
                DispatchQueue.main.async { completion?(.failure(error)) }

            }
        }
    }

    /// Delete an event
    /// - Parameters:
    ///   - identifier: event identifier
    ///   - span: An object that indicates whether modifications should apply to a single event or all future events of a recurring event.
    ///   - completion: completion handler
    func deleteEvent(identifier: String, span: EKSpan = .thisEvent, completion: ((Result<Void, ClendarError>) -> Void)?) {
        requestEventStoreAuthorization { [weak self] result in
            switch result {
            case .success(let status):
                guard let self = self else { return }
                guard status == .authorized else { return }

                self.accessCalendar { [weak self] calendarResult in
                    guard let self = self else { return }

                    switch calendarResult {
                    case .success:
                        self.eventStore.deleteEvent(identifier: identifier, span: span, completion: completion)

                    case .failure(let error):
                        DispatchQueue.main.async { completion?(.failure(error)) }

                    }
                }

            case .failure(let error):
                DispatchQueue.main.async { completion?(.failure(error)) }

            }
        }
    }

    // MARK: - Fetch Events

    /// Fetch events for today
    /// - Parameter completion: completion handler
    func fetchEventsForToday(completion: ((Result<[EKEvent], ClendarError>) -> Void)? = nil) {
        let today = Date()
        fetchEvents(startDate: today.startDate, endDate: today.endDate, completion: completion)
    }

    /// Fetch events for a specific day
    /// - Parameters:
    ///   - date: day to fetch events from
    ///   - completion: completion handler
    func fetchEvents(for date: Date, completion: ((Result<[EKEvent], ClendarError>) -> Void)?) {
        fetchEvents(startDate: date.startDate, endDate: date.endDate, completion: completion)
    }

    /// Fetch events for a specific day
    /// - Parameters:
    ///   - date: day to fetch events from
    ///   - completion: completion handler
    func fetchEventsRangeUntilEndOfDay(from startDate: Date, completion: ((Result<[EKEvent], ClendarError>) -> Void)?) {
        fetchEvents(startDate: startDate, endDate: startDate.endDate, completion: completion)
    }

    /// Fetch events from date range
    /// - Parameters:
    ///   - startDate: start date range
    ///   - endDate: end date range
    ///   - completion: completion handler
    func fetchEvents(startDate: Date, endDate: Date, completion: ((Result<[EKEvent], ClendarError>) -> Void)?) {
        requestEventStoreAuthorization { [weak self] result in
            switch result {
            case .success(let status):
                guard let self = self else { return }
                guard status == .authorized else { return }

                let _calendars = self.eventStore.calendars(for: .event)
                self.allDefaultCalendars = _calendars // IMPORTANT

                let predicate = self.eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: self.savedCalendars)
                let events = self.eventStore.events(matching: predicate)
                DispatchQueue.main.async { completion?(.success(events)) }

            case .failure(let error):
                DispatchQueue.main.async {
                    completion?(.failure(error))
                }
            }

        }
    }

    // MARK: - Private

    /// Request access to calendar
    /// - Parameter completion: calendar object
    private func accessCalendar(completion: ((Result<EKCalendar, ClendarError>) -> Void)?) {
        requestEventStoreAuthorization { [weak self] result in
            switch result {
            case .success(let status):
                guard let self = self else { return }
                guard status == .authorized else { return }

                DispatchQueue.main.async {
                    completion?(.success(self.eventStore.calendarForApp()))
                }

            case .failure(let error):
                DispatchQueue.main.async {
                    completion?(.failure(error))
                }

            }
        }
    }

    /// Prompt the user for access to their Calendar
    /// - Parameter onAuthorized: on authorized
    private func requestCalendarAccess(completion: ((Result<Bool, Error>) -> Void)?) {
        eventStore.requestAccess(to: .event) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .didAuthorizeCalendarAccess, object: nil)
                    completion?(.success(granted))
                }
            }
            else if let error = error {
                DispatchQueue.main.async { completion?(.failure(error)) }
            }
            else {
                DispatchQueue.main.async { completion?(.failure(ClendarError.unableToAccessCalendar)) }
            }
        }
    }
    
}
