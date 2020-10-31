//
//  WidgetEntryView.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import SwiftDate

struct WidgetEntryView: View {
    @Environment(\.widgetFamily) var family

    let entry: WidgetEntry

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemMedium:
            MediumCalendarWidgetView(entry: entry)

        case .systemLarge:
            LargeCalendarWidgetView(entry: entry)

        case .systemSmall:
            SmallCalendarWidgetView(entry: entry)

        @unknown default:
            SmallCalendarWidgetView(entry: entry)
        }
    }
}

// MARK: - Main Views

struct SmallCalendarWidgetView: View {
    let entry: WidgetEntry

    var body: some View {
        VStack(alignment: .center) {
            Text(entry.date.toMonthString.uppercased())
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.gray)
            Text(entry.date.widgetDayString)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color(.moianesD))
            Text(entry.date.toDateString)
                .font(.system(size: 45, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
    }
}

struct MediumCalendarWidgetView: View {
    let entry: WidgetEntry

    var body: some View {
        HStack {
            SmallCalendarWidgetView(entry: entry).padding(20)
            DividerView()
            EventsListWidgetView(entry: entry).padding(10)
        }
    }
}

struct LargeCalendarWidgetView: View {
    let entry: WidgetEntry

    var body: some View {
        HStack {
            SmallCalendarWidgetView(entry: entry).padding(20)

            DividerView()

            VStack {
                TodayOverviewWidgetView(entry: entry).padding(20)

                if entry.events.isEmpty == false {
                    DividerView()
                    EventsListWidgetView(entry: entry).padding(10)
                    Spacer()
                }
            }
        }
    }
}

// MARK: - Helper Views

struct TodayOverviewWidgetView: View {
    let entry: WidgetEntry

    var body: some View {
        VStack(alignment: .center) {
            let events = entry.events
            let text = events.isEmpty
                ? "🎉 No more events today,\nenjoy your day!\n"
                : "Today has \(events.count) events"

            Text(text)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.gray)
                .multilineTextAlignment(.leading)
        }
    }
}

struct EventsListWidgetView: View {
    let entry: WidgetEntry

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 10) {
            Section(
                header:
                    Text(entry.date.toFullDateString.uppercased())
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundColor(Color(.moianesB))
            ) {
                ForEach(entry.events, id: \.self) { (event) in
                    WidgetEventRow(event: event)
                }
            }
        }
    }
}

struct DividerView: View {
    var body: some View { Divider().background(Color.black) }
}
