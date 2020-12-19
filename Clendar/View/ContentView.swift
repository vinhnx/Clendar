//
//  MainView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKit
import SwiftUI
import Shift

struct ContentView: View {
    @EnvironmentObject var store: Store
    @StateObject var eventKitWrapper = Shift.shared
    @State private var showCreateEventState = false
    @State private var showSettingsState = false
    @State private var createdEvent: EKEvent?

    let calendarWrapperView = CalendarWrapperView()

    // MARK: - Views Compositions

    private var settingsButton: some View {
        Button(
            action: { self.showSettingsState.toggle() },
            label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.boldFontWithSize(12))
            }
        )
        .accentColor(.appRed)
        .sheet(isPresented: $showSettingsState, content: {
            SettingsWrapperView()
                .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
        })
    }

    private var monthHeaderView: some View {
        HStack(spacing: 20) {
            Button {
                store.selectedDate = Date()
            } label: {
                VStack {
                    Text(store.selectedDate.toMonthString.localizedUppercase)
                        .modifier(BoldTextModifider(fontSize: 18, color: .appRed))
                    Text(store.selectedDate.toFullDayString)
                        .modifier(BoldTextModifider())
                }
            }
            .accessibility(addTraits: .isHeader)
        }
    }

    private var calendarHeaderView: some View {
        HStack {
            settingsButton
            Spacer()
            monthHeaderView
        }
    }

    private var addButton: some View {
        Button(action: { showCreateEventState.toggle() }, label: {})
            .buttonStyle(SolidButtonStyle(imageName: "calendar.badge.plus", title: "Add event"))
        .sheet(isPresented: $showCreateEventState) {
            if SettingsManager.useExperimentalCreateEventMode {
                QuickEventView(
                    showCreateEventState: $showCreateEventState,
                    createdEvent: $createdEvent
                )
                .environmentObject(store)
                .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
            } else {
                EventEditorWrapperView()
                    .environmentObject(store)
                    .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
            }
        }
    }

    private func makeCalendarGroupView(_ geometry: GeometryProxy) -> some View {
        Group {
            CalendarHeaderView()
                .frame(height: Constants.CalendarView.calendarHeaderHeight)

            calendarWrapperView
                .frame(height: Constants.CalendarView.calendarHeight)
        }
        .padding()
    }

    private var eventListView: some View {
        EventListView(events: eventKitWrapper.events.compactMap(Event.init))
            .environmentObject(store)
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            GeometryReader { reader in
                ZStack(alignment: .bottomTrailing) {
                    VStack {
                        calendarHeaderView
                        makeCalendarGroupView(reader)
                        eventListView
                    }

                    addButton
                }
            }
            .padding()
            .preferredColorScheme(appColorScheme)
            .environment(\.colorScheme, appColorScheme)
            .background(store.appBackgroundColor.edgesIgnoringSafeArea(.all))
            .modifier(HideNavigationBarModifier())
        }
        .onAppear { selectDate(Date()) }
        .onReceive(store.$selectedDate) { date in
            self.selectDate(date)
        }
        .onReceive(NotificationCenter.default.publisher(for: .didAuthorizeCalendarAccess)) { _ in
            self.selectDate(Date())
        }
        .onReceive(NotificationCenter.default.publisher(for: .EKEventStoreChanged)) { _ in
            self.selectDate(store.selectedDate)
        }
        .onReceive(NotificationCenter.default.publisher(for: .didDeleteEvent)) { _ in
            self.selectDate(store.selectedDate)
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeMonthViewCalendarModePreferences)) { _ in
            self.calendarWrapperView.calendarView.changeModePerSettings()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeShowDaysOutPreferences)) { _ in
            self.calendarWrapperView.calendarView.changeDaysOutShowingState(shouldShow: SettingsManager.showDaysOut)
            self.calendarWrapperView.calendarView.reloadData()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeDaySupplementaryTypePreferences)) { _ in
            self.calendarWrapperView.calendarView.reloadData()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeSavedCalendarsPreferences)) { _ in
            guard let selectedDate = self.calendarWrapperView.calendarView.selectedDate else { return }
            self.fetchEvents(for: selectedDate)
        }
        .onReceive(NotificationCenter.default.publisher(for: .justReloadCalendar)) { _ in
            self.calendarWrapperView.calendarView.reloadData()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeUserInterfacePreferences)) { _ in
            store.appBackgroundColor = .backgroundColor
        }
    }
}

extension ContentView {
    private func selectDate(_ date: Date) {
        fetchEvents(for: date)
    }

    private func fetchEvents(for date: Date = Date()) {
        eventKitWrapper.fetchEvents(for: date)
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Store())
    }
}
