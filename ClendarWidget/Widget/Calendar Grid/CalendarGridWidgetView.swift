//
//  CalendarGridView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 14/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

/*
 reference:
 + https://swiftwithmajid.com/2020/05/06/building-calendar-without-uicollectionview-in-swiftui/
 + https://gist.github.com/jz709u/ed97507a8655ce5b23e205b0feea80bb
 */

extension DateFormatter {
	static var month: DateFormatter {
		let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
		formatter.setLocalizedDateFormatFromTemplate("MMMM")
		return formatter
	}

	static var monthAndYear: DateFormatter {
		let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
		formatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
		return formatter
	}
}

extension Calendar {
	func generateDates(
		inside interval: DateInterval,
		matching components: DateComponents
	) -> [Date] {
		var dates: [Date] = []
		dates.append(interval.start)

		enumerateDates(
			startingAfter: interval.start,
			matching: components,
			matchingPolicy: .nextTime
		) { date, _, stop in
			if let date = date {
				if date < interval.end {
					dates.append(date)
				} else {
					stop = true
				}
			}
		}

		return dates
	}
}

struct CalendarGridView<DateView>: View where DateView: View {
	// MARK: Lifecycle

	init(
		interval: DateInterval,
		showHeaders: Bool = true,
		@ViewBuilder content: @escaping (Date) -> DateView
	) {
		self.interval = interval
		self.showHeaders = showHeaders
		self.content = content
	}

	// MARK: Internal

	@Environment(\.calendar) var calendar

	let interval: DateInterval
	let showHeaders: Bool
	let content: (Date) -> DateView

	@ViewBuilder
	var body: some View {
		headerView()
		weekDaysView()
		daysGridView()
	}

	// MARK: Private

	private var months: [Date] {
		calendar.generateDates(
			inside: interval,
			matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
		)
	}

	private var weeks: [Date] {
		guard let monthInterval = calendar.dateInterval(of: .month, for: Date()) else { return [] }

		return calendar.generateDates(
			inside: monthInterval,
			matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
		)
	}

	private func headerView(for month: Date = Date()) -> some View {
		let component = calendar.component(.month, from: month)
		let formatter = component == 1 ? DateFormatter.monthAndYear : .month

		return Group {
			if showHeaders {
				Text(formatter.string(from: month).localizedUppercase)
					.font(.boldFontWithSize(11))
					.foregroundColor(.appRed)
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
			}
		}
	}

	private func weekDaysView() -> some View {
		HStack(spacing: 12) {
			ForEach(0 ..< 7) { index in
				Text(getWeekDaysSorted()[index].localizedUppercase)
					.font(.boldFontWithSize(9))
                    .frame(height: 10)
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.appDark)
			}
		}
	}

	private func daysGridView() -> some View {
		LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
			ForEach(months, id: \.self) { month in
				ForEach(days(for: month), id: \.self) { date in
					if calendar.isDate(date, equalTo: month, toGranularity: .month) {
						content(date).id(date)
					} else {
						content(date).hidden()
					}
				}
			}
		}
	}

	private func days(for month: Date) -> [Date] {
		guard
			let monthInterval = calendar.dateInterval(of: .month, for: month),
			let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
			let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
		else { return [] }

		return calendar.generateDates(
			inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
			matching: DateComponents(hour: 0, minute: 0, second: 0)
		)
	}

	private func getWeekDaysSorted() -> [String] {
		let weekDays = Calendar.current.veryShortWeekdaySymbols
		let sortedWeekDays = Array(weekDays[Calendar.current.firstWeekday - 1 ..< Calendar.current.shortWeekdaySymbols.count] + weekDays[0 ..< Calendar.current.firstWeekday - 1])
		return sortedWeekDays
	}
}

struct CalendarGridWidgetView: View {
	@Environment(\.widgetFamily) var family

	let entry: WidgetEntry

	@ViewBuilder
	var body: some View {
		switch family {
		case .systemSmall:
			SmallCalendarGridView(entry: entry)
		case .systemMedium:
			MediumCalendarGridView(entry: entry)
		case .systemLarge, .systemExtraLarge:
			LargeCalendarGridView(entry: entry)
		@unknown default:
			SmallCalendarGridView(entry: entry)
		}
	}
}

struct SmallCalendarGridView: View {
	let entry: WidgetEntry

	var body: some View {
		VStack(alignment: .center) {
			// swiftlint:disable:next force_unwrapping
			CalendarGridView(interval: Calendar.current.dateInterval(of: .month, for: Date())!) { date in
				Text(date.toShortDateString)
					.font(.boldFontWithSize(10))
					.foregroundColor(Calendar.current.isDateInToday(date) ? .appRed : .gray)
					.frame(width: 15, height: 10)
					.multilineTextAlignment(.trailing)
			}
		}.padding(.all)
	}
}

struct MediumCalendarGridView: View {
	let entry: WidgetEntry

	var body: some View {
		HStack {
			SmallCalendarGridView(entry: entry)
			DividerView()
			EventsListWidgetView(entry: entry, minimizeContents: true)
		}
	}
}

struct LargeCalendarGridView: View {
	let entry: WidgetEntry

	var body: some View {
		HStack {
			VStack {
				SmallCalendarWidgetView(entry: entry)
				DividerView()
				SmallCalendarGridView(entry: entry)
			}
			DividerView()
			EventsListWidgetView(entry: entry, minimizeContents: true)
		}
	}
}
