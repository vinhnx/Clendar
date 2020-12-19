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
    @EnvironmentObject var store: Store
    @State private var didShowEventEdit = false
    var event: Event

    private var editButton: some View {
        Button(action: { didShowEventEdit.toggle() }, label: {})
            .buttonStyle(SolidButtonStyle(imageName: "square.and.pencil", title: "Edit Event", backgroundColor: .primaryColor))
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
            InfoView(title: "Recurring event", titleImageName: "repeat", subtitle: event.isDetached.asString)
            if event.isDetached {
                InfoView(title: "Recurring date", titleImageName: "calendar", subtitle: event.occurrenceDate.toString(.dateTime(.medium)))
            }

            InfoView(title: "All day", titleImageName: "tray.full.fill", subtitle: event.isAllDay.asString)
            InfoView(title: "Start time", titleImageName: "clock", subtitle: event.startDate.toString(.dateTime(.medium)))
            InfoView(title: "End time", titleImageName: "clock", subtitle: event.endDate.toString(.dateTime(.medium)))
        }
    }

    private var eventContentView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                Unwrap(event.event) { (event: EKEvent) in
                    Text(event.title)
                        .modifier(BoldTextModifider(fontSize: 20, color: .appRed))

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
