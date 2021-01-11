//
//  LunarDateInfoWidget.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 11/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

struct LunarDateInfoWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "LunarDateInfoWidget",
            provider: DateInfoWidgetTimelineProvider()
        ) { entry in
            LunarSmallDateWidgetView(entry: entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.backgroundColor))
        }
        .configurationDisplayName(NSLocalizedString("Lunar Date", comment: ""))
        .description(NSLocalizedString("Lunar calendar at a glance", comment: ""))
        .supportedFamilies([.systemSmall])
    }
}
