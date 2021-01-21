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
    @State private var isMonthView = true

    let calendarWrapperView = CalendarWrapperView()

    // MARK: - Views Compositions

    private var monthHeaderView: some View {
        HStack(spacing: 20) {
            Button {
                store.selectedDate = Date()
            } label: {
                VStack {
                    Text(store.selectedDate.toMonthString.localizedUppercase)
                        .modifier(BoldTextModifider(fontSize: 18, color: .appRed))
                    Text(store.selectedDate.toDayAndDateString)
                        .modifier(BoldTextModifider())
                }
            }
            .accessibility(addTraits: .isHeader)
        }
    }

    private var topView: some View {
        HStack {
            menuView
            Spacer()
            monthHeaderView
        }
        .padding([.leading, .trailing], 20)
    }

    private func makeCalendarGroupView(_ geometry: GeometryProxy? = nil) -> some View {
        Group {
            CalendarHeaderView()
                .frame(height: Constants.CalendarView.calendarHeaderHeight)
            calendarWrapperView
                .frame(
                    width: geometry?.frame(in: .local).width,
                    height: isMonthView ? Constants.CalendarView.calendarMonthViewHeight : Constants.CalendarView.calendarWeekViewHeight
                )
                .padding(.top, -20)
        }
        .padding()
    }

    private var addButton: some View {
        Button(
            action: {
                genLightHaptic()
                showCreateEventState.toggle()
        }, label: {})
            .buttonStyle(SolidButtonStyle(imageName: "square.and.pencil", title: "New Event"))
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
            .padding(.top, isMonthView ? -50 : 0)
    }

    private var eventView: some View {
        VStack {
            topView
            makeCalendarGroupView()
            eventListView
        }
    }

    private var menuView: some View {
        HStack(spacing: 30) {
            Button(
                action: {
                    genLightHaptic()
                    showSettingsState.toggle()
                },
                label: { Image(systemName: "slider.horizontal.3") }
            )
            .sheet(
                isPresented: $showSettingsState,
                content: {
                    SettingsWrapperView()
                        .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
                }
            )
        }
        .accentColor(.appRed)
        .font(.boldFontWithSize(18))
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                eventView
                addButton
            }
            .padding()
            .preferredColorScheme(appColorScheme)
            .environment(\.colorScheme, appColorScheme)
            .background(store.appBackgroundColor.edgesIgnoringSafeArea(.all))
            .modifier(HideNavigationBarModifier())
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .onAppear {
            configure()
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
        .onReceive(NotificationCenter.default.publisher(for: .didChangeSavedCalendarsPreferences)) { _ in
            selectDate(store.selectedDate)
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeShowDaysOutPreferences)) { _ in
            calendarWrapperView.calendarView.changeDaysOutShowingState(shouldShow: SettingsManager.showDaysOut)
            calendarWrapperView.calendarView.reloadData()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeDaySupplementaryTypePreferences)) { _ in
            calendarWrapperView.calendarView.reloadData()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeMonthViewCalendarModePreferences)) { _ in
            isMonthView = SettingsManager.isOnMonthViewSettings
            calendarWrapperView.calendarView.changeModePerSettings()
            calendarWrapperView.calendarView.commitCalendarViewUpdate()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeUserInterfacePreferences)) { _ in
            store.appBackgroundColor = .backgroundColor
        }
        .onReceive(NotificationCenter.default.publisher(for: .addEventShortcutAction)) { (_) in
            showCreateEventState = true // show create event view
        }
    }
}

extension ContentView {
    private func configure() {
        RatingManager().askForReviewIfNeeded()
        isMonthView = SettingsManager.isOnMonthViewSettings
        selectDate(Date())
    }

    private func selectDate(_ date: Date) {
        genLightHaptic()
        fetchEvents(for: date)
    }

    private func fetchEvents(for date: Date = Date()) {
        eventKitWrapper.fetchEvents(for: date, filterCalendarIDs: UserDefaults.savedCalendarIDs)
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Store())
    }
}
