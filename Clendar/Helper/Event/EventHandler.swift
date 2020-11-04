//
//  EventHandler.swift
//  Clendar
//
//  Created by Vinh Nguyen on 11/4/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import EventKit
import EventKitUI

class EventHandler {

    static func viewEvent(_ event: Event?, delegate: EKEventViewDelegate?) {
        guard let ekEvent = event?.event else { return }
        let eventViewer = EventViewerNavigationController(event: ekEvent, delegate: delegate)
        UIViewController.topViewController?.present(eventViewer, animated: true, completion: nil)
    }

    static func editEvent(_ event: Event?, delegate: EKEventEditViewDelegate?) {
        guard let ekEvent = event?.event else { return }
        let eventViewer = EventEditViewController(delegate: delegate)
        eventViewer.event = ekEvent
        UIViewController.topViewController?.present(eventViewer, animated: true, completion: nil)
    }

    static func deleteEvent(_ event: Event?) {
        UIViewController.topViewController?.dismissKeyboard()

        guard let eventID = event?.id else { return }

        AlertManager.showActionSheet(message: "Are you sure you want to delete this event?", showDelete: true, deleteAction: {
            EventKitWrapper.shared.deleteEvent(identifier: eventID) { result in
                switch result {
                case .success:
                    genSuccessHaptic()
                    UIViewController.topViewController?.dimissModal()
                case .failure(let error):
                    AlertManager.showWithError(error)
                }
            }
        })
    }
}
