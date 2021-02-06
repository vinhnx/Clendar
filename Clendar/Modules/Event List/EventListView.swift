//
//  EventListView.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 11/19/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import Shift

struct EventListView: View {
    @EnvironmentObject var store: Store
    @State private var selectedEvent: ClendarEvent?
    var events = [ClendarEvent]()

    var body: some View {
            ScrollView(showsIndicators: false) {
                if events.isEmpty {
                    EmptyView()
                } else {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(events, id: \.self) { event in
                            NavigationLink(
                                destination:
                                    EventViewer(event: event)
                                    .navigationBarTitle("", displayMode: .inline)
                                    .environmentObject(store)
                                    .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
                            ) {
                                EventListRow(event: event)
                            }
                            .id(UUID()) // NOTE: should this fix for "Fatal error: each layout item may only occur once: file SwiftUI, line 0"?
                            .contextMenu(menuItems: {
                                Button(
                                    action: { self.selectedEvent = event },
                                    label: {
                                        Text("Edit")
                                        Image(systemName: "square.and.pencil")
                                    }
                                )
                                .help("Edit Event")

                                Button(
                                    action: { handleDeleteEvent(event) },
                                    label: {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    }
                                )
                                .help("Delete Event")
                            })
                        }
                    }
                }
            }
            .sheet(item: $selectedEvent) { event in
                EventViewerWrapperView(event: event)
                    .environmentObject(store)
                    .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
            }
    }

    private func handleDeleteEvent(_ event: ClendarEvent) {
        guard let id = event.id else { return }
        AlertManager.showActionSheet(message: "Are you sure you want to delete this event?", showDelete: true, deleteAction: {
            Shift.shared.deleteEvent(identifier: id) { (result) in
                switch result {
                case .success:
                    genSuccessHaptic()
                    Popup.showInfo("Event deleted!")
                case .failure(let error):
                    genErrorHaptic()
                    Popup.showError(error)
                }
            }
        })
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView(events: []).environmentObject(Store())
    }
}
