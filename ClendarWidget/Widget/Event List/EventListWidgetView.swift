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
            EventsListWidgetView(entry: entry, minimizeContents: true)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .widgetBackground(WidgetBackgroundView())
        }
        .configurationDisplayName(NSLocalizedString("Event List Widget", comment: ""))
        .description(NSLocalizedString("Your day events at a glance", comment: ""))
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
