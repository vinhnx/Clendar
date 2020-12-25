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

    // MARK: - Views Compositions

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

    private var eventListView: some View {
        EventListView(events: eventKitWrapper.events.compactMap(ClendarEvent.init))
            .environmentObject(store)
    }

    private let calendarView = NewCalendarView()

    private var eventView: some View {
        VStack {
            calendarView
                .frame(maxHeight: Constants.CalendarView.calendarHeight)
            eventListView
                .padding(.bottom, 50)
        }
    }

    private var menuView: some View {
        HStack(spacing: 20) {
            Button(
                action: { showSettingsState.toggle() },
                label: { Image(systemName: "gearshape") }
            )
            .sheet(
                isPresented: $showSettingsState,
                content: {
                    SettingsWrapperView()
                        .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
                }
            )

            Button(
                action: { calendarView.calendar.scrollTo(Date()) },
                label: { Image(systemName: "calendar.circle") }
            )
        }
        .accentColor(.appRed)
        .font(.mediumFontWithSize(20))
    }

    private var bottomBarView: some View {
        HStack {
            menuView
            Spacer()
            addButton
        }
        .padding(EdgeInsets(top: 5, leading: 15, bottom: 0, trailing: 15))
        .background(Color.backgroundColor)
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                eventView
                bottomBarView
            }
            .padding()
            .preferredColorScheme(appColorScheme)
            .environment(\.colorScheme, appColorScheme)
            .background(store.appBackgroundColor.edgesIgnoringSafeArea(.all))
            .modifier(HideNavigationBarModifier())
        }
        .onAppear {
            selectDate(Date())
        }
        .onReceive(store.$selectedDate) { date in
            selectDate(date)
        }
        .onReceive(NotificationCenter.default.publisher(for: .didAuthorizeCalendarAccess)) { _ in
            selectDate(Date())
        }
        .onReceive(NotificationCenter.default.publisher(for: .EKEventStoreChanged)) { _ in
            selectDate(store.selectedDate)
        }
        .onReceive(NotificationCenter.default.publisher(for: .didDeleteEvent)) { _ in
            selectDate(store.selectedDate)
        }
        .onReceive(NotificationCenter.default.publisher(for: .justReloadCalendar)) { _ in
            calendarView.calendar.reloadData()
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
