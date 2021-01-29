//
//  QuickEventWrapperView.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 11/19/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKit
import SwiftUI
import Shift

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
    @State private var isAllDay = false
    @Binding var showCreateEventState: Bool
    @Binding var createdEvent: EKEvent?

    var body: some View {
        VStack {
            HStack {
                Button(
                    action: {
                        genLightHaptic()
                        showCreateEventState = false
                    },
                    label: {
                        Image(systemName: "chevron.down")
                            .font(.boldFontWithSize(20))
                            .accessibility(label: Text("Collapse this view"))
                    }
                )
                .accentColor(.appRed)
                .keyboardShortcut(.escape)

                Spacer()
                Text("New Event")
                    .font(.semiboldFontWithSize(15))
                Spacer()

                Button(
                    action: {
                        createNewEvent()
                    },
                    label: {
                        Image(systemName: "calendar.badge.plus")
                            .font(.boldFontWithSize(20))
                            .accessibility(label: Text("Create new event"))
                    }
                )
                .accentColor(.appRed)
                .disabled(quickEventStore.query.isEmpty)
                .keyboardShortcut("s", modifiers: [.command])
            }

            Divider()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    Spacer()
                    MultilineTextField(
                        "read a book this Friday 8PM...",
                        text: $quickEventStore.query,
                        onCommit: {
                            self.parse(quickEventStore.query)
                        }
                    )
                    .accessibility(label: Text("Input event"))
                    .font(.regularFontWithSize(18))
                    .foregroundColor(.appDark)

                    Toggle("All day", isOn: $isAllDay)
                        .keyboardShortcut(.tab)
                        .font(.mediumFontWithSize(15))
                        .toggleStyle(SwitchToggleStyle(tint: .appRed))
                        .fixedSize()

                    if !isAllDay {
                        Divider()
                        DatePicker("Start", selection: $startTime)
                            .datePickerStyle(CompactDatePickerStyle())
                            .font(.mediumFontWithSize(15))
                            .accessibility(label: Text("Select event's start time"))
                        DatePicker("End", selection: $endTime)
                            .datePickerStyle(CompactDatePickerStyle())
                            .font(.mediumFontWithSize(15))
                            .accessibility(label: Text("Select event's end time"))
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

        Shift.shared.createEvent(parsedText, startDate: startTime, endDate: endTime, isAllDay: isAllDay) { result in
            switch result {
            case let .success(event):
                genSuccessHaptic()
                self.createdEvent = event
                self.showCreateEventState = false

            case let .failure(error):
                genErrorHaptic()
                AlertManager.showWithError(error)
            }
        }
    }
}
