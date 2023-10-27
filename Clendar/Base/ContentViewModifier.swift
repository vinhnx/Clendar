//
//  ContentViewModifier.swift
//  Clendar
//
//  Created by Vinh Nguyen on 02/09/2022.
//  Copyright © 2022 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import Shift

struct ContentViewModifier: ViewModifier {
    @StateObject var store: SharedStore
    @StateObject var eventKitWrapper: Shift
    @State var confettiCounter = 0

    func body(content: Content) -> some View {
        content
            .whatsNewSheet()
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
            .onReceive(NotificationCenter.default.publisher(for: .didChangeUserInterfacePreferences)) { _ in
                store.appBackgroundColor = .backgroundColor()
            }
            .onReceive(NotificationCenter.default.publisher(for: .inAppPurchaseSuccess)) { (_) in
                confettiCounter += 1
            }
            .onReceive(NotificationCenter.default.publisher(for: .didChangeCalendarType)) { notification in
                handleDidChangeCalendarTypeEvent(notification)
            }
    }

    private func configure() {
        selectDate(Date())
    }

    private func selectDate(_ date: Date) {
        genLightHaptic()
        fetchEvents(for: date)
    }

    private func fetchEvents(for date: Date = Date()) {
        Task {
            do {
                try await eventKitWrapper.fetchEvents(for: date, filterCalendarIDs: UserDefaults.savedCalendarIDs, calendar: CalendarIdentifier.current.calendar)
            } catch {
                AlertManager.showAlert(message: "Unable to fetch Calendar events. Please try again or contact developer. Thank you!", actionTitle: "Cancel")
            }
        }
    }

    private func handleDidChangeCalendarTypeEvent(_ notification: Notification) {
        guard let calendar = notification.object as? Calendar else { return }
        store.calendar = calendar
    }
}
