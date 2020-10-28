//
//  EventStore+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 25/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import EventKit
import Foundation

extension EKEventStore {

    // MARK: - CRUD

    /// <#Description#>
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - startDate: <#startDate description#>
    ///   - endDate: <#endDate description#>
    ///   - calendar: <#calendar description#>
    ///   - span: <#span description#>
    ///   - completion: <#completion description#>
    func createEvent(title: String, startDate: Date, endDate: Date?, calendar: EKCalendar, span: EKSpan = .thisEvent, completion: EventCompletion? = nil) {
        let event = EKEvent(eventStore: self)
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = calendar

        do {
            try save(event, span: span, commit: true)

            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .didCreateEvent, object: nil)
                completion?(event)
            }
        } catch {
            logError(error)
            AlertManager.showNoCancelAlertWithMessage(message: error.localizedDescription)
        }
    }

    /// <#Description#>
    /// - Parameters:
    ///   - identifier: <#identifier description#>
    ///   - span: <#span description#>
    ///   - completion: <#completion description#>
    func deleteEvent(identifier: String, span: EKSpan = .thisEvent, completion: VoidHandler? = nil) {
        guard let event = fetchEvent(identifier: identifier) else { return }

        do {
            try remove(event, span: span, commit: true)

            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .didDeleteEvent, object: nil)
                completion?()
            }
        } catch {
            logError(error)
            AlertManager.showNoCancelAlertWithMessage(message: error.localizedDescription)
        }
    }

    // MARK: - Fetch

    /// <#Description#>
    /// - Returns: <#description#>
    /// - Parameter name: <#name description#>
    func calendarForApp(with name: String = AppInfo.appName) -> EKCalendar {
        let calendars = self.calendars(for: .event)

        if let clendar = calendars.first(where: { $0.title == name }) {
            return clendar
        }
        else {
            let newClendar = EKCalendar(for: .event, eventStore: self)
            newClendar.title = name
            newClendar.source = defaultCalendarForNewEvents?.source
            try? saveCalendar(newClendar, commit: true)
            return newClendar
        }
    }

    /// <#Description#>
    /// - Parameter identifier: <#identifier description#>
    /// - Returns: <#description#>
    func fetchEvent(identifier: String) -> EKEvent? {
        event(withIdentifier: identifier)
    }
}
