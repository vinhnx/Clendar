//
//  QuickEventWrapperView.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 11/19/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKit
import SwiftUI

internal struct EventOverride {
	let text: String
	let startDate: Date
	let endDate: Date?
	let isAllDay: Bool
}

internal class QuickEventStore: ObservableObject {
	@Published var query = ""
}

struct QuickEventView: View {
	@EnvironmentObject var store: Store
	@StateObject private var quickEventStore = QuickEventStore()
	@State private var parsedText = ""
	@State private var startTime = Date()
	@State private var endTime = Date().offsetWithDefaultDuration
	@State private var isAllDay = true
	@Binding var showCreateEventState: Bool
	@Binding var createdEvent: EKEvent?

	var body: some View {
		VStack {
			HStack {
				Button(
					action: { self.showCreateEventState.toggle() },
					label: { Image(systemName: "chevron.down") }
				).accentColor(.primaryColor)

				Spacer()
				Text(parsedText.isEmpty ? "New Event" : parsedText)
					.font(.boldFontWithSize(18))
					.foregroundColor(.appDark)
					.lineLimit(1)
				Spacer()

				Button(
					action: { self.createNewEvent() },
					label: { Image(systemName: "plus") }
				)
				.accentColor(.primaryColor)
				.disabled(quickEventStore.query.isEmpty)
			}

			Divider()

			ScrollView(showsIndicators: false) {
				VStack(spacing: 20) {
					Spacer()
					TextField(
						"write something at Friday 8PM...",
						text: $quickEventStore.query,
						onEditingChanged: { _ in
							self.parse(quickEventStore.query)
						}, onCommit: {
							self.parse(quickEventStore.query)
						}
					)
					.font(.regularFontWithSize(15))
					.foregroundColor(.appDark)

					Toggle("All day", isOn: $isAllDay)

					if !isAllDay {
						Divider()
						DatePicker("Starts", selection: $startTime)
							.datePickerStyle(CompactDatePickerStyle())
						DatePicker("Ends", selection: $endTime)
							.datePickerStyle(CompactDatePickerStyle())
					}
				}
			}
		}
		.onReceive(quickEventStore.$query) { output in
			self.parse(output)
		}
		.padding(20)
		.frame(maxWidth: .infinity)
		.preferredColorScheme(appColorScheme)
		.environment(\.colorScheme, appColorScheme)
		.background(store.appBackgroundColor.edgesIgnoringSafeArea(.all))
	}
}

extension QuickEventView {
	// MARK: - Private

	@discardableResult
	private func parse(_ text: String) -> Bool {
		guard text.isEmpty == false else { return false }
		guard let result = NaturalInputParser().parse(text) else { return false }
		parsedText = result.parsedText
		startTime = result.startDate
		endTime = result.endDate ?? result.startDate.offsetWithDefaultDuration
		return true
	}

	private func createNewEvent(_: EventOverride? = nil) {
		let input = quickEventStore.query

		guard input.isEmpty == false else { return }

		parse(input)

		EventKitWrapper.shared.createEvent(parsedText, startDate: startTime, endDate: endTime, isAllDay: isAllDay) { result in
			switch result {
			case let .success(event):
				genSuccessHaptic()
				self.createdEvent = event
				self.showCreateEventState.toggle()

			case let .failure(error):
				genErrorHaptic()
				AlertManager.showWithError(error)
			}
		}
	}
}
