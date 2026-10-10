//
//  EventListWidgetView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 03/02/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

struct EventListWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: Constants.WidgetKind.eventListWidget.rawValue,
            provider: DateInfoWidgetTimelineProvider()) { entry in
            EventListWidgetEntryView(entry: entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .widgetBackground(WidgetBackgroundView())
        }
        .configurationDisplayName(NSLocalizedString("Event List Widget", comment: ""))
        .description(NSLocalizedString("Your day events at a glance", comment: ""))
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// MARK: - StandBy support (iOS 17 nightstand landscape mode, issue #255)
//
// The large widget is wide in landscape (Home Screen and StandBy), so it
// shows the full event list instead of the minimized 3-row version used by
// the compact sizes.
struct EventListWidgetEntryView: View {
    @Environment(\.widgetFamily) var family

    let entry: WidgetEntry

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemLarge, .systemExtraLarge:
            EventsListWidgetView(entry: entry, minimizeContents: false)
        @unknown default:
            EventsListWidgetView(entry: entry, minimizeContents: true)
        }
    }
}
