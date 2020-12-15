//
//  EventViewWrapperView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKitUI
import SwiftUI

internal class EventEditorWrapperViewCoordinator: NSObject, EKEventEditViewDelegate {
    var wrapperView: EventEditorWrapperView

    init(_ wrapperView: EventEditorWrapperView) {
        self.wrapperView = wrapperView
    }

    // MARK: - EKEventEditViewDelegate

    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true) {
            guard action != .canceled else { return }
            guard let event = controller.event else { return }
            self.wrapperView.store.selectedDate = event.startDate
        }
    }

    func eventEditViewControllerDefaultCalendar(forNewEvents _: EKEventEditViewController) -> EKCalendar {
        EventKitWrapper.shared.defaultCalendar ?? EKCalendar(for: .event, eventStore: EKEventStore())
    }
}

struct EventEditorWrapperView: UIViewControllerRepresentable {
    @EnvironmentObject var store: Store

    // MARK: - UIViewControllerRepresentable

    func makeCoordinator() -> EventEditorWrapperViewCoordinator {
        EventEditorWrapperViewCoordinator(self)
    }

    func makeUIViewController(context: Context) -> EventEditViewController {
        EventEditViewController(
            eventStore: EventKitWrapper.shared.eventStore,
            delegate: context.coordinator
        )
    }

    func updateUIViewController(_: EventEditViewController, context _: Context) {}
}
