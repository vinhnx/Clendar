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
    func createEvent(title: String, startDate: Date, endDate: Date?, calendar: EKCalendar, span: EKSpan = .thisEvent, completion: VoidHandler? = nil) {
        let event = EKEvent(eventStore: self)
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = calendar

        do {
            try self.save(event, span: span, commit: true)
            completion.flatMap { $0() }
        } catch {
            print(error)
        }
    }

    func calendarForApp(completion: EventCalendarHandler? = nil) {
        let calendars = self.calendars(for: .event)
        guard let clendar = calendars.first(where: { $0.title == calendarName }) else {
            let newClendar = EKCalendar(for: .event, eventStore: self)
            newClendar.title = calendarName
            newClendar.source = self.defaultCalendarForNewEvents?.source

            do {
                try self.saveCalendar(newClendar, commit: true)
                completion.flatMap { $0(newClendar) }
            } catch {
                print(error)
            }

            return
        }

        completion.flatMap { $0(clendar) }
    }
}
