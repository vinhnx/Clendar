//
//  ClendarWidgetTimeline.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

// Reference: https://wwdcbysundell.com/2020/getting-started-with-widgetkit/

struct DateInfoWidgetTimelineProvider: TimelineProvider {
	typealias Entry = WidgetEntry

	func getSnapshot(in _: Context, completion: @escaping (WidgetEntry) -> Void) {
		let entry = WidgetEntry(date: Date())
		completion(entry)
	}

	func getTimeline(in _: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
		var entries = [WidgetEntry]()

		let currentDate = Date()

		// swiftlint:disable:next force_unwrapping
		let interval = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!

		EventKitWrapper.shared.fetchEventsRangeUntilEndOfDay(from: currentDate) { result in
			switch result {
			case let .success(events):
				let clendarEvents = events.compactMap(Event.init)
				let entry = WidgetEntry(date: interval, events: clendarEvents)
				entries.append(entry)

				let timeline = Timeline(entries: entries, policy: .after(interval))
				completion(timeline)

			case let .failure(error):
				logError(error)
			}
		}
	}

	func placeholder(in _: Context) -> WidgetEntry {
		WidgetEntry(date: Date())
	}
}
