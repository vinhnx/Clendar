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
    @EnvironmentObject var store: SharedStore
    @State private var editingEvent: ClendarEvent?

    var events = [ClendarEvent]()

    var body: some View {
        ScrollView(showsIndicators: false) {
            if events.isEmpty {
                EmptyView()
            } else {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(events, id: \.id) { event in
                        NavigationLink(
                            destination:
                                EventViewer(event: event)
                                .navigationBarTitle("", displayMode: .inline)
                                .environmentObject(store)
                                .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
                        ) {
                            EventListRow(event: event)
                        }
                        .contextMenu(menuItems: {
                            Button(action: { editingEvent = event }, label: {
                                Text("Edit")
                                Image(systemName: "square.and.pencil")
                            })
                            .help("Edit Event")

                            Button(action: { handleDeleteEvent(event) }, label: {
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
        .sheet(item: $editingEvent) { (event) in
            EventEditorWrapperView(event: event)
                .environmentObject(store)
                .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
        }
    }

    private func handleDeleteEvent(_ event: ClendarEvent) {
        guard let id = event.id else { return }
        let isRepeatingEvent = event.event?.hasRecurrenceRules == true
        let message = isRepeatingEvent ? "This is a repeating event." : "Are you sure you want to delete this event?"
        if isRepeatingEvent {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel)
                alertController.addAction(cancelAction)

                let deleteOne = UIAlertAction(title: "Delete This Event Only", style: .destructive) { _ in

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

                let deleteAll = UIAlertAction(title: "Delete All Future Events", style: .destructive) { _ in

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

                if let presenter = alertController.popoverPresentationController {
                    presenter.permittedArrowDirections = .init(rawValue: 0)
                    presenter.sourceView = UIViewController.topViewController?.view
                    presenter.sourceRect = CGRect(x: UIViewController.topViewController?.view.bounds.midX ?? 0, y: UIViewController.topViewController?.view.bounds.midY ?? 0, width: 0, height: 0)
                }

                UINavigationController.topViewController?.present(alertController, animated: true, completion: nil)
            }
        } else {
            DispatchQueue.main.async {
                AlertManager.showActionSheet(message: "Are you sure you want to delete this event?", showDelete: true, deleteAction: {

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

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView(events: []).environmentObject(SharedStore())
    }
}
