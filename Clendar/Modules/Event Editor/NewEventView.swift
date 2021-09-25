//
//  NewEventView.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 10/28/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKitUI
import UIKit
import SwiftUI
// import Shift

struct NewEventView: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    @Environment(\.presentationMode) var presentationMode

    let eventStore: EKEventStore
    let event: EKEvent?

    func makeUIViewController(context: UIViewControllerRepresentableContext<NewEventView>) -> EKEventEditViewController {

        let eventEditViewController = EKEventEditViewController()
        eventEditViewController.eventStore = eventStore
        eventEditViewController.editViewDelegate = context.coordinator

        if let event = event {
            eventEditViewController.event = event // when set to nil the controller would not display anything
        }

        return eventEditViewController
    }

    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: UIViewControllerRepresentableContext<NewEventView>) {

    }

    class Coordinator: NSObject, EKEventEditViewDelegate {
        let parent: NewEventView

        init(_ parent: NewEventView) {
            self.parent = parent
        }

        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            parent.presentationMode.wrappedValue.dismiss()
            controller.dismiss(animated: true) {
                switch action {
                case .canceled, .deleted:
                    break
                case .saved:
                    guard let event = controller.event else { return }
                    NotificationCenter.default.post(name: .didSaveEvent, object: event.startDate)
                @unknown default:
                    break
                }

            }
        }

        @MainActor func eventEditViewControllerDefaultCalendar(forNewEvents _: EKEventEditViewController) -> EKCalendar {
            Shift.shared.defaultCalendar ?? EKCalendar(for: .event, eventStore: EKEventStore())
        }
    }
}
