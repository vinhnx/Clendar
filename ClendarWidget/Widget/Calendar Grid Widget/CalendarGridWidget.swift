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
		) { entry in
			CalendarGridView(entry: entry)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.background(Color(.backgroundColor))
		}
		.configurationDisplayName(NSLocalizedString("Calendar grid view", comment: ""))
		.description(NSLocalizedString("Month view calendar", comment: ""))
		.supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
	}
}
