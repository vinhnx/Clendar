//
//  DateInfoWidget.swift
//  DateInfoWidget
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

/*
 Reference
 + https://developer.apple.com/design/human-interface-guidelines/ios/system-capabilities/widgets
 + https://developer.apple.com/documentation/widgetkit/creating-a-widget-extension
 + https://wwdcbysundell.com/2020/getting-started-with-widgetkit/
 + https://github.com/pawello2222/WidgetExamples
 */
struct DateInfoWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "DateInfoWidget",
            provider: DateInfoWidgetTimelineProvider()
        ) { (entry) in
            DateInfoWidgetEntryView(entry: entry)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.backgroundColor))
        }
        .configurationDisplayName("Date Info Widget")
        .description("Check calendar at a glance")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }

}
