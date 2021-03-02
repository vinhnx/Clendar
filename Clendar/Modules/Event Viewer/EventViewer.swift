//
//  EventViewer.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 12/18/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKit
import SwiftUI

struct EventViewer: View {
    @EnvironmentObject var store: SharedStore
    @State private var didShowEventEdit = false
    var event: ClendarEvent

    @ViewBuilder
    private var editButton: some View {
        #if os(watchOS)
        editEventButton
        #else
        editEventButton
            .keyboardShortcut("e", modifiers: [.command, .shift])
        #endif

    }

    private var editEventButton: some View {
        Button(action: { didShowEventEdit.toggle() }, label: {})
           .buttonStyle(SolidButtonStyle(imageName: "square.and.pencil", title: "Edit Event", backgroundColor: event.calendarColor))
           .sheet(isPresented: $didShowEventEdit) {
               #if !os(watchOS)
               EventViewerWrapperView(event: event)
                   .environmentObject(store)
                   .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
               #endif
           }
    }

    private var mapViewWidth: CGFloat {
        #if os(watchOS)
        return 150
        #else
        return 300
        #endif
    }

    private func makeEventInfoListView(_ event: EKEvent) -> some View {
        VStack(alignment: .leading, spacing: 30) {
            InfoWrapView(config: InfoWrapView.InfoViewConfig(title: "Start time", titleImageName: "hourglass.tophalf.fill")) {
                Text(event.startDate.toFullEventDate).modifier(MediumTextModifider())
            }

            InfoWrapView(config: InfoWrapView.InfoViewConfig(title: "End time", titleImageName: "hourglass.bottomhalf.fill")) {
                Text(event.endDate.toFullEventDate).modifier(MediumTextModifider())
            }

            InfoWrapView(config: InfoWrapView.InfoViewConfig(title: "All day", titleImageName: "tray.full")) {
                Text(event.isAllDay.asString).modifier(MediumTextModifider())
            }

            InfoWrapView(config: InfoWrapView.InfoViewConfig(title: "Is Recurring", titleImageName: "repeat.circle")) {
                Text(event.hasRecurrenceRules.asString).modifier(MediumTextModifider())
            }

        }
    }

    private var eventContentView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Unwrap(event.event) { (event: EKEvent) in
                    Text(event.title)
                        .modifier(BoldTextModifider(fontSize: 20, color: .appDark))

                    Divider()

                    makeEventInfoListView(event)

                    #if !os(watchOS)
                    Unwrap(event.structuredLocation?.geoLocation?.coordinate) { (coordinate) in
                        Divider()

                        VStack(alignment: .leading, spacing: 10) {
                            Label("Location", systemImage: "map")
                                .modifier(BoldTextModifider(fontSize: 13, color: .primaryColor))
                            MapWrapperView(location: Location(coordinate: coordinate))
                        }
                    }
                    #endif
                }
            }
            .modifier(EventViewerPaddingModifier())
        }
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            eventContentView

            #if !os(watchOS)
            editButton
            #endif
        }
        .navigationTitle("Event")
        .accentColor(event.calendarColor)
        .modifier(EventViewerPaddingModifier())
    }
}

// swiftlint:disable:next private_over_fileprivate
fileprivate struct EventViewerPaddingModifier: ViewModifier {
    func body(content: Content) -> some View {
        #if os(watchOS)
        return content
        #else
        return content.padding()
        #endif
    }
}
