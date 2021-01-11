//
//  CalendarGridTimelineProvider.swift
//  Clendar
//
//  Created by Vinh Nguyen on 14/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

struct CalendarGridWidgetTimelineProvider: TimelineProvider {
	typealias Entry = WidgetEntry

	func getSnapshot(in _: Context, completion: @escaping (WidgetEntry) -> Void) {
		let entry = WidgetEntry(date: Date())
		completion(entry)
	}

	func getTimeline(in _: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
		completion(Timeline(entries: [WidgetEntry(date: Date())], policy: .atEnd))
	}

	func placeholder(in _: Context) -> WidgetEntry {
		WidgetEntry(date: Date())
	}
}
