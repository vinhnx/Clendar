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
            provider: DateInfoWidgetTimelineProvider()
        ) { (entry) in
            CalendarGridView(entry: entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.backgroundColor))
        }
        .configurationDisplayName("Calendar grid view")
        .description("Month view calendar")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
