//
//  ClendarWidget.swift
//  ClendarWidget
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

@main
struct ClendarWidget: Widget {
    private let kind = "ClendarWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: ClendarWidgetTimeline()
        ) { (entry) in
            ClendarWidgetEntryView(entry: entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.lavixA))
        }
        .configurationDisplayName("Clendar Widget")
        .description("Check calendar at a glance")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }

}
