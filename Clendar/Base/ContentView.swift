//
//  MainView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKit
import SwiftUI
import CalendarView
import ClendarTheme
import Shift
import Then
import ConfettiSwiftUI

// TODO: refactor, cleanup with ViewModifier

struct ContentView: View {
    @EnvironmentObject var store: SharedStore
    @StateObject var eventKitWrapper = Shift.shared
    @State private var createdEvent: EKEvent?
    @State private var confettiCounter = 0
    @State private var showDateSwitcher = false

    // MARK: - Views Compositions

    private var monthHeaderView: some View {
        HStack {
            Button {} label: {
                VStack(alignment: .trailing) {
                    Text(store.selectedDate.toMonthString(calendar: store.calendar))
                        .modifier(BoldTextModifider(fontSize: 20, color: .appRed))
                    Text(store.selectedDate.toDayAndDateString(calendar: store.calendar).localizedUppercase)
                        .modifier(BoldTextModifider())
                }
            }
            .accessibility(addTraits: .isHeader)
            .simultaneousGesture(
                LongPressGesture().onEnded { _ in
                    genLightHaptic()
                    withAnimation {
                        showDateSwitcher.toggle()
                    }
                }
            )
            .highPriorityGesture(
                TapGesture().onEnded {
                    store.selectedDate = Date()
                }
            )
            .keyboardShortcut("h", modifiers: [.command, .shift])
        }
    }

    private var topView: some View {
        HStack {
            menuView
            Spacer()
            monthHeaderView
        }
    }

    private var addEventButton: some View {
        Button(
            action: {
                genLightHaptic()
                store.showCreateEventState.toggle()
            }, label: {})
        .buttonStyle(
            SolidButtonStyle(imageName: "square.and.pencil")
        )
        .sheet(isPresented: $store.showCreateEventState) {
            if SettingsManager.useExperimentalCreateEventMode {
                QuickEventView()
                    .environmentObject(store)
                    .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
            }
            else {
                NewEventView(
                    eventStore: eventKitWrapper.eventStore,
                    event: EKEvent(eventStore: eventKitWrapper.eventStore)
                        .then {
                            $0.startDate = store.selectedDate
                            $0.endDate = store.selectedDate
                        }
                ).environmentObject(store)
            }
        }
        .keyboardShortcut("n", modifiers: [.command])
    }

    private var eventListView: some View {
        EventListView(events: eventKitWrapper.events.compactMap(ClendarEvent.init))
            .environmentObject(store)
    }

    private var eventView: some View {
        VStack(spacing: 20) {
            topView
            Divider()

            makeCalendarGroupView()
            if showDateSwitcher {
                makeQuickDateSwitcherView()
            }

            Divider()
            eventListView
        }
    }

    var menuView: some View {
        HStack {
            makeMenuButton()
            makeDateSwitcherToggle()
        }
        .accentColor(.appRed)
        .font(.mediumFontWithSize(20))
    }

    // MARK: - Body

    fileprivate func buildContainerView() -> some View {
        ZStack(alignment: .bottomTrailing) {
            eventView
            addEventButton
            ConfettiCannon(counter: $confettiCounter, repetitions: 5, repetitionInterval: 0.8)
        }
        .padding()
        .preferredColorScheme(appColorScheme)
        .environment(\.colorScheme, appColorScheme)
        .background(store.appBackgroundColor.edgesIgnoringSafeArea(.all))
        .modifier(HideNavigationBarModifier())
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    var body: some View {
        if #available(iOS 16.0, *) {
            return NavigationSplitView {
                buildContainerView()
            } detail: {}
                .modifier(
                    ContentViewModifier(store: store, eventKitWrapper: eventKitWrapper, confettiCounter: confettiCounter)
                )
        } else {
            return NavigationView {
                buildContainerView()
            }
            .modifier(
                ContentViewModifier(store: store, eventKitWrapper: eventKitWrapper, confettiCounter: confettiCounter)
            )
        }
    }
}

extension ContentView {
    private func configure() {
        selectDate(Date())
    }

    private func selectDate(_ date: Date) {
        genLightHaptic()
        fetchEvents(for: date)
    }

    private func fetchEvents(for date: Date = Date()) {
        Task {
            try await eventKitWrapper.fetchEvents(for: date, filterCalendarIDs: UserDefaults.savedCalendarIDs, calendar: CalendarIdentifier.current.calendar)
        }
    }

    private func makeQuickDateSwitcherView() -> some View {
        DatePicker(selection: $store.selectedDate, displayedComponents: [.date], label: {})
            .datePickerStyle(.wheel)
            .labelsHidden()
    }

    private func makeDateSelectionResetView() -> some View {
        Button(
            action: {
                genLightHaptic()
                store.selectedDate = Date()
                showDateSwitcher = false
            },
            label: {
                Image(systemName: "arrow.uturn.left.circle.fill")
            }
        ).keyboardShortcut("r", modifiers: [.command])
    }

    private func makeDateSwitcherToggle() -> some View {
        Toggle(isOn: $showDateSwitcher.animation(.easeInOut)) {
            Image(systemName: "arrow.left.arrow.right")
        }
        .controlSize(.small)
        .toggleStyle(.button)
        .keyboardShortcut("o", modifiers: [.command, .shift])
    }

    private func makeCalendarGroupView() -> some View {
        CalendarView(
            calendar: store.calendar,
            date: $store.selectedDate,
            content: { date in
                Button(action: { store.selectedDate = date }) {
                    Text("000")
                        .padding(3)
                        .foregroundColor(.clear)
                        .background(
                            store.calendar.isDate(date, inSameDayAs: store.selectedDate) ? Color.appRed
                            : store.calendar.isDateInToday(date) ? .primaryColor
                            : .clear
                        )
                        .clipShape(Circle())
                        .accessibilityHidden(true)
                        .overlay(
                            Text(date.toNumericDateString(calendar: store.calendar))
                                .minimumScaleFactor(0.5)
                                .font(.boldFontWithSize(17))
                                .foregroundColor(
                                    store.calendar.isDate(date, inSameDayAs: store.selectedDate) ? Color.white
                                    : store.calendar.isDateInToday(date) ? .white
                                    : .appDark
                                )
                        )
                }
            },
            trailing: { date in
                Text(date.toNumericDateString(calendar: store.calendar))
                    .minimumScaleFactor(0.5)
                    .font(.boldFontWithSize(15))
                    .foregroundColor(Color(.gray).opacity(0.3))
            },
            header: { date in
                Text(date.toNumericDateString(calendar: store.calendar).localizedUppercase)
                    .minimumScaleFactor(0.5)
                    .font(.regularFontWithSize(12))
                    .foregroundColor(.appGray)
            },
            title: { _  in })
        .equatable()
        .gesture(
            DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                .onEnded { value in
                    if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                        withAnimation {
                            let newDate = store.selectedDate.dateByAdding(1, .month).date
                            showDateSwitcher = false
                            store.selectedDate = newDate
                        }
                    }
                    else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                        withAnimation {
                            let newDate = store.selectedDate.dateByAdding(-1, .month).date
                            showDateSwitcher = false
                            store.selectedDate = newDate
                        }
                    }
                }
        )
    }

    private func makeMenuButton() -> some View {
        Button(
            action: {
                genLightHaptic()
                store.showSettingsState.toggle()
            },
            label: {
                Image(systemName: "line.3.horizontal.decrease")
            }
        ).sheet(isPresented: $store.showSettingsState) {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    SettingsWrapperView()
                        .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
                }
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
            } else {
                SettingsWrapperView()
                    .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
            }
        }.keyboardShortcut(",", modifiers: [.command])
    }

    private func handleDidChangeCalendarTypeEvent(_ notification: Notification) {
        guard let calendar = notification.object as? Calendar else { return }
        store.calendar = calendar
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SharedStore())
    }
}
