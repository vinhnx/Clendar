//
//  CalendarGridWidget.swift
//  Clendar
//
//  Created by Vinh Nguyen on 14/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

struct CalendarGridWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "CalendarGridWidget",
            provider: CalendarGridWidgetTimelineProvider()
        ) { (entry) in
            CalendarGridView(entry: entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.backgroundColor))
        }
        .configurationDisplayName("Clendar Grid View Widget")
        .description("Get month view calendar")
        .supportedFamilies([.systemSmall])
    }
}
