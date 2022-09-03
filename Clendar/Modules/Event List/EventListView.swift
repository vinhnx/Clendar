//
//  EventListView.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 11/19/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import EventKit
import Shift
import ClendarTheme

struct EventListView: View {
    @EnvironmentObject var store: SharedStore
    @State private var editingEvent: ClendarEvent?

    var events = [ClendarEvent]()

    var body: some View {
        if events.isEmpty {
            EventEmptyView()
        }
        else {
            if #available(iOS 16.0, *) {
                buildListView
                    .scrollContentBackground(.hidden) // https://mobile.twitter.com/sarunw/status/1545006078404227072
            } else {
                buildListView
                    .background(Color(.backgroundColor))
            }
        }
    }
}

extension EventListView {
    var buildListView: some View {
        List(events, id: \.id) { event in
            NavigationLink(
                destination:
                    EventViewer(event: event)
                    .navigationBarTitle("", displayMode: .inline)
                    .environmentObject(store)
                    .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
            ) {
                EventListRow(event: event)
                    .contextMenu(
                        ContextMenu(menuItems: {
                            Button { editingEvent = event } label: {
                                Text("Edit")
                                Image(systemName: "square.and.pencil")
                            }
                            .tint(.teal)
                            .help("Edit Event")

                            Button { handleDeleteEvent(event) } label: {
                                Text("Delete")
                                Image(systemName: "trash")
                            }
                            .tint(.appRed)
                            .help("Delete Event")
                        })
                    )
            }
            .listRowBackground(Color.backgroundColor())
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: -5, leading: -5, bottom: 0, trailing: -15))
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button {
                    handleDeleteEvent(event)
                } label: {
                    Text("Delete")
                    Image(systemName: "trash")
                }
                .tint(.appRed)
                .help("Delete Event")
            }
            .swipeActions(edge: .trailing) {
                Button {
                    editingEvent = event
                } label: {
                    Text("Edit")
                    Image(systemName: "square.and.pencil")
                }
                .tint(.teal)
                .help("Edit Event")
            }
        }
        .listStyle(.plain)
        .sheet(item: $editingEvent) { (event) in
            EventEditorWrapperView(event: event)
                .environmentObject(store)
                .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
        }
    }

}

extension View where Self == EventListView {

    // MARK: - Private

    fileprivate func handleDeleteEvent(_ event: ClendarEvent) {
        guard let id = event.id else { return }
        let isRepeatingEvent = event.event?.hasRecurrenceRules == true
        let message = NSLocalizedString(isRepeatingEvent ? "This is a repeating event." : "Are you sure you want to delete this event?", comment: "")
        if isRepeatingEvent {
            DispatchQueue.main.async {

                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel)
                alertController.addAction(cancelAction)

                let deleteOne = UIAlertAction(title: NSLocalizedString("Delete This Event Only", comment: ""), style: .destructive) { _ in

                    Task {
                        do {
                            try await Shift.shared.deleteEvent(identifier: id, span: .thisEvent)
                            genSuccessHaptic()
                        } catch {
                            genErrorHaptic()
                        }
                    }

                }
                alertController.addAction(deleteOne)

                let deleteAll = UIAlertAction(title: NSLocalizedString("Delete All Future Events", comment: ""), style: .destructive) { _ in

                    Task {
                        do {
                            try await Shift.shared.deleteEvent(identifier: id, span: .futureEvents)
                            genSuccessHaptic()
                        } catch {
                            genErrorHaptic()
                        }
                    }

                }
                alertController.addAction(deleteAll)

                UINavigationController.topViewController?.present(alertController, animated: true, completion: nil)
            }
        } else {
            DispatchQueue.main.async {
                AlertManager.showAlert(message: NSLocalizedString("Are you sure you want to delete this event?", comment: ""), showDelete: true, deleteAction: {

                    Task {
                        do {
                            try await Shift.shared.deleteEvent(identifier: id)
                            genSuccessHaptic()
                        } catch {
                            genErrorHaptic()
                        }
                    }
                })
            }
        }
    }

}
