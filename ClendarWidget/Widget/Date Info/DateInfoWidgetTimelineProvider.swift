//
//  ClendarWidgetTimeline.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit
import Shift

// Reference: https://wwdcbysundell.com/2020/getting-started-with-widgetkit/

struct DateInfoWidgetTimelineProvider: TimelineProvider {
    typealias Entry = WidgetEntry

    func getSnapshot(in _: Context, completion: @escaping (WidgetEntry) -> Void) {
        let entry = WidgetEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in _: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {

        let currentDate = Date()

        // swiftlint:disable:next force_unwrapping
        let interval = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!

        Task {
            var entries = [WidgetEntry]()
            let events = (try? await Shift.shared.fetchEventsRangeUntilEndOfDay(from: currentDate)) ?? []
            let clendarEvents = events.compactMap(ClendarEvent.init)
            let entry = WidgetEntry(date: interval, events: clendarEvents)
            entries.append(entry)

            let timeline = Timeline(entries: entries, policy: .after(interval))
            completion(timeline)
        }
    }

    func placeholder(in _: Context) -> WidgetEntry {
        WidgetEntry(date: Date())
    }
}
