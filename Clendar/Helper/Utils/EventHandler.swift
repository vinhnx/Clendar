//
//  EventHandler.swift
//  Clendar
//
//  Created by Vinh Nguyen on 11/4/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKit
import EventKitUI
import Foundation
// import Shift

class EventHandler {
    static func viewEvent(_ event: ClendarEvent?, delegate: EKEventViewDelegate?) {
        guard let ekEvent = event?.event else { return }
        let eventViewer = EventViewerNavigationController(event: ekEvent, delegate: delegate)
        UIViewController.topViewController?.present(eventViewer, animated: true, completion: nil)
    }

#if compiler(>=5.5) && canImport(_Concurrency)
    @MainActor
#endif
    static func editEvent(_ event: ClendarEvent?, delegate: EKEventEditViewDelegate?) {
        guard let ekEvent = event?.event else { return }
        let eventViewer = EventEditViewController(eventStore: Shift.shared.eventStore, delegate: delegate)
        eventViewer.event = ekEvent
        UIViewController.topViewController?.present(eventViewer, animated: true, completion: nil)
    }

    static func deleteEvent(_ event: ClendarEvent?) {
        UIViewController.topViewController?.dismissKeyboard()

        guard let eventID = event?.id else { return }

        AlertManager.showActionSheet(message: NSLocalizedString("Are you sure you want to delete this event?", comment: ""), showDelete: true, deleteAction: {
            Shift.shared.deleteEvent(identifier: eventID) { result in
                switch result {
                case .success:
                    genSuccessHaptic()
                    UIViewController.topViewController?.dimissModal()
                case let .failure(error):
                    AlertManager.showWithError(error)
                }
            }
//            Task {
//                do {
//                    try await Shift.shared.deleteEvent(identifier: eventID)
//                } catch {
//                    AlertManager.showWithError(error)
//                }
//            }
        })
    }
}
