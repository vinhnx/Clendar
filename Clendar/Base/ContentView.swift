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
    @State private var createdEvent: EKEvent?
    @State private var isMonthView = SettingsManager.isOnMonthViewSettings
    @State private var showPlusView: Bool = false

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
            .keyboardShortcut("h", modifiers: [.command, .shift])
            .hoverEffect()
        }
    }

    private var topView: some View {
        HStack(spacing: 10) {
            menuView
            shortcutsView
            plusView
            Spacer()
            monthHeaderView
        }
        .padding([.leading, .trailing], 10)
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

    private var createEventButton: some View {
        Button(
            action: {
                genLightHaptic()
                store.showCreateEventState = true
            }, label: {})
            .buttonStyle(SolidButtonStyle(imageName: "square.and.pencil", title: "New Event"))
            .sheet(isPresented: $store.showCreateEventState) {
                if SettingsManager.useExperimentalCreateEventMode {
                    QuickEventView(
                        showCreateEventState: $store.showCreateEventState,
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
                    store.showSettingsState = true
                },
                label: { Image(systemName: "slider.horizontal.3") }
            )
            .sheet(
                isPresented: $store.showSettingsState,
                content: {
                    SettingsWrapperView()
                        .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
                }
            )
            .frame(width: 44, height: 44)
            .keyboardShortcut(",", modifiers: [.command])
            .hoverEffect()
        }
        .accentColor(.appRed)
        .font(.boldFontWithSize(18))
    }

    private var shortcutsView: some View {
        HStack(spacing: 30) {
            Button(
                action: {
                    genLightHaptic()
                    store.showSiriShortcuts = true
                },
                label: { Image(systemName: "wand.and.stars") }
            )
            .sheet(
                isPresented: $store.showSiriShortcuts,
                content: {
                    SiriShortcutsView(showView: $store.showSiriShortcuts)
                        .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
                }
            )
            .frame(width: 44, height: 44)
            .keyboardShortcut("o", modifiers: [.command, .shift])
            .hoverEffect()
        }
        .accentColor(Color(.moianesB))
        .font(.boldFontWithSize(18))
    }

    private var plusView: some View {
        HStack(spacing: 30) {
            Button(
                action: {
                    genLightHaptic()
                    showPlusView = true
                },
                label: { Image(systemName: "giftcard.fill") }
            )
            .sheet(
                isPresented: $showPlusView,
                content: {
                    ClendarPlusView(showView: $showPlusView)
                        .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
                }
            )
            .frame(width: 44, height: 44)
            .hoverEffect()
        }
        .accentColor(Color(.moianesB))
        .font(.boldFontWithSize(18))
    }

    // MARK: - Body

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                eventView
                createEventButton
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
            calendarView.changeDaysOutShowingState(shouldShow: SettingsManager.showDaysOut)
            calendarView.reloadData()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeDaySupplementaryTypePreferences)) { _ in
            calendarView.reloadData()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeUserInterfacePreferences)) { _ in
            store.appBackgroundColor = .backgroundColor
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeMonthViewCalendarModePreferences)) { _ in
            isMonthView = SettingsManager.isOnMonthViewSettings
            calendarView.changeModePerSettings()
            calendarView.commitCalendarViewUpdate()
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
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Store())
    }
}
