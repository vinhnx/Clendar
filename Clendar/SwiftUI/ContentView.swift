//
//  MainView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKit
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store
    @StateObject var eventKitWrapper = EventKitWrapper.shared
    @State private var showCreateEventState = false
    @State private var showSettingsState = false
    @State private var createdEvent: EKEvent?

    let calendarWrapperView = CalendarWrapperView()

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    makeCalendarHeaderView()
                        .padding(.bottom, 30)
                    makeCalendarGroupView(with: geometry)
                    makeEventListView()
                        .padding(.top, -30)
                        .frame(minHeight: 300)
                }
                makeAddButton()
            }
        }
        .onAppear(perform: {
            self.selectDate(Date())
        })
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
        .padding()
        .preferredColorScheme(appColorScheme)
        .environment(\.colorScheme, appColorScheme)
        .background(store.appBackgroundColor.edgesIgnoringSafeArea(.all))
    }
}

extension ContentView {
    private func selectDate(_ date: Date) {
        fetchEvents(for: date)
    }

    private func fetchEvents(for date: Date = Date()) {
        eventKitWrapper.fetchEvents(for: date)
    }

    private func makeAddButton() -> some View {
        Button(
            action: { self.showCreateEventState.toggle() }
        ) {
            HStack {
                Image(systemName: "calendar.badge.plus")
                Text("Add event".localizedUppercase)
                    .font(.boldFontWithSize(15))
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.appRed)
            .cornerRadius(40)
        }
        .accentColor(.appRed)
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

    private func makeSettingsButton() -> some View {
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

    private func makeMonthHeaderView() -> some View {
        HStack(spacing: 20) {
            Button {
                store.selectedDate = Date()
            } label: {
                VStack {
                    Text(store.selectedDate.toMonthString.localizedUppercase)
                        .modifier(TextModifider(fontSize: 18, color: .appRed))
                    Text(store.selectedDate.toFullDayString)
                        .modifier(TextModifider())
                }
            }
            .accessibility(addTraits: .isHeader)
        }
    }

    private func makeCalendarHeaderView() -> some View {
        HStack {
            makeSettingsButton()
            Spacer()
            makeMonthHeaderView()
        }
    }

    private func makeCalendarGroupView(with geometry: GeometryProxy) -> some View {
        VStack {
            CalendarHeaderView()
                .frame(width: geometry.size.width, height: Constants.CalendarView.calendarHeaderHeight)
            calendarWrapperView
                .frame(width: geometry.size.width, height: Constants.CalendarView.calendarHeight)
        }
    }

    private func makeEventListView() -> some View {
        EventListView(events: eventKitWrapper.events)
            .environmentObject(store)
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Store())
    }
}
