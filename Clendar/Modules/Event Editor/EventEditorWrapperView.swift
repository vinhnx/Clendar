//
//  EventViewWrapperView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKitUI
import SwiftUI
import Shift

internal class EventEditorWrapperViewCoordinator: NSObject, EKEventEditViewDelegate {
    var wrapperView: EventEditorWrapperView

    init(_ wrapperView: EventEditorWrapperView) {
        self.wrapperView = wrapperView
    }

    // MARK: - EKEventEditViewDelegate

    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true) {
            switch action {
            case .canceled, .deleted:
                break
            case .saved:
                guard let event = controller.event else { return }
                self.wrapperView.store.selectedDate = event.startDate
                NotificationCenter.default.post(name: .didSaveEvent, object: event.startDate)
            @unknown default:
                break
            }

        }
    }

    func eventEditViewControllerDefaultCalendar(forNewEvents _: EKEventEditViewController) -> EKCalendar {
        Shift.shared.defaultCalendar ?? EKCalendar(for: .event, eventStore: EKEventStore())
    }
}

struct EventEditorWrapperView: UIViewControllerRepresentable {
    @EnvironmentObject var store: SharedStore

    var event: ClendarEvent?

    // MARK: - UIViewControllerRepresentable

    func makeCoordinator() -> EventEditorWrapperViewCoordinator {
        EventEditorWrapperViewCoordinator(self)
    }

    func makeUIViewController(context: Context) -> EventEditViewController {
        EventEditViewController(
            event: event?.event,
            eventStore: Shift.shared.eventStore,
            delegate: context.coordinator
        )
    }

    func updateUIViewController(_: EventEditViewController, context _: Context) {}
}
