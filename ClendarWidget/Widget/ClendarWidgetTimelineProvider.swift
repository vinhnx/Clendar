//
//  ClendarWidgetTimeline.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

struct ClendarWidgetTimelineProvider: TimelineProvider {
    typealias Entry = ClendarWidgetEntry

    func getSnapshot(in context: Context, completion: @escaping (ClendarWidgetEntry) -> Void) {
        let entry = ClendarWidgetEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ClendarWidgetEntry>) -> Void) {
        var entries = [ClendarWidgetEntry]()
        let currentDate = Date()

        for dayOffset in 0..<7 {
            guard let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: currentDate) else { continue }
            let entry = ClendarWidgetEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

    func placeholder(in context: Context) -> ClendarWidgetEntry {
        ClendarWidgetEntry(date: Date())
    }
}
