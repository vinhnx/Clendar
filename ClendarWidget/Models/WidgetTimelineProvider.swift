//
//  ClendarWidgetTimeline.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

// Reference: https://wwdcbysundell.com/2020/getting-started-with-widgetkit/

struct WidgetTimelineProvider: TimelineProvider {
    typealias Entry = WidgetEntry

    // MARK: - TimelineProvider

    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        let entry = WidgetEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        var entries = [WidgetEntry]()

        let date = Date()
        EventKitWrapper.shared.fetchEvents(for: date) { result in
            switch result {
            case .success(let events):
                let clendarEvents = events.compactMap(Event.init)
                let entry = WidgetEntry(date: date, events: clendarEvents)
                entries.append(entry)

                let timeline = Timeline(entries: entries, policy: .atEnd)
                completion(timeline)

            case .failure(let error):
                logError(error)

            }
        }
    }

    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(date: Date())
    }
}
