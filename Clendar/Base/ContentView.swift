//
//  MainView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKit
import SwiftUI
import ConfettiSwiftUI
// import Shift

// https://www.swiftbysundell.com/articles/defining-dynamic-colors-in-swift/

struct ContentView: View {
    @EnvironmentObject var store: SharedStore

    @StateObject var eventKitWrapper = Shift.shared
    @State private var createdEvent: EKEvent?
    @State private var isMonthView = SettingsManager.isOnMonthViewSettings
    @State private var confettiCounter = 0

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
                        .font(.boldFontWithSize(20))
                    Text(store.selectedDate.toDayAndDateString)
                        .modifier(BoldTextModifider())
                }
            }
            .accessibility(addTraits: .isHeader)
            .keyboardShortcut("h", modifiers: [.command, .shift])
        }
    }

    private var topView: some View {
        HStack(spacing: 10) {
            menuView
            Spacer()
            monthHeaderView
        }
    }

    private func makeCalendarGroupView(_ geometry: GeometryProxy? = nil) -> some View {
        Group {
            CalendarHeaderView()
                .frame(
                    width: geometry?.frame(in: .local).width,
                    height: Constants.CalendarView.calendarHeaderHeight
                )
            calendarWrapperView
                .frame(
                    width: geometry?.frame(in: .local).width,
                    height: isMonthView ? Constants.CalendarView.calendarMonthViewHeight : Constants.CalendarView.calendarWeekViewHeight
                )
                .padding(.top, -20)
        }
        .padding()
    }

    private var addEventButton: some View {
        Button(
            action: {
                genLightHaptic()
                store.showCreateEventState.toggle()
            }, label: {})
            .buttonStyle(SolidButtonStyle(imageName: "square.and.pencil"))
            .sheet(isPresented: $store.showCreateEventState) {
                if SettingsManager.useExperimentalCreateEventMode {
                    QuickEventView(
                        startTime: Binding(get: {
                            store.selectedDate
                        }, set: { newValue in
                            store.selectedDate = newValue
                        }),
                        endTime: Binding(get: {
                            store.selectedDate
                        }, set: { newValue in
                            store.selectedDate = newValue
                        })
                    )
                    .environmentObject(store)
                    .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
                }
                else {
                    NewEventView(
                        eventStore: eventKitWrapper.eventStore,
                        event: EKEvent.init(eventStore: eventKitWrapper.eventStore)
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
                    store.showSettingsState.toggle()
                },
                label: {
                    Image(systemName: "line.horizontal.2.decrease.circle")
                        .frame(width: 50, height: 50)
                }
            )
            .sheet(
                isPresented: $store.showSettingsState,
                content: {
                    SettingsWrapperView()
                        .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
                }
            )
            .keyboardShortcut(",", modifiers: [.command])
        }
        .accentColor(.appRed)
        .font(.regularFontWithSize(20))
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
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

            Text("No event selected")
                .modifier(BoldTextModifider())
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
            calendarView.changeDaysOutShowingState(shouldShow: SettingsManager.showDaysOut)
            calendarView.reloadData()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeDaySupplementaryTypePreferences)) { _ in
            calendarView.reloadData()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeUserInterfacePreferences)) { _ in
            store.appBackgroundColor = .backgroundColor()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeMonthViewCalendarModePreferences)) { _ in
            isMonthView = SettingsManager.isOnMonthViewSettings
            calendarView.changeModePerSettings()
            calendarView.commitCalendarViewUpdate()
        }
        .onReceive(NotificationCenter.default.publisher(for: .inAppPurchaseSuccess)) { (_) in
            confettiCounter += 1
            AlertManager.show(message: "Tip received. Thank you so much and wish you have a nice day! 😊")
        }
    }
}

extension ContentView {
    private func configure() {
        isMonthView = SettingsManager.isOnMonthViewSettings
        selectDate(Date())
    }

    private func selectDate(_ date: Date) {
        genLightHaptic()
        fetchEvents(for: date)
    }

    private func fetchEvents(for date: Date = Date()) {
        eventKitWrapper.fetchEvents(for: date, filterCalendarIDs: UserDefaults.savedCalendarIDs)
//        Task {
//            try await eventKitWrapper.fetchEvents(for: date, filterCalendarIDs: UserDefaults.savedCalendarIDs)
//        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SharedStore())
    }
}
