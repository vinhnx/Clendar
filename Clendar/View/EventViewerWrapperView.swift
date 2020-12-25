//
//  EventViewerWrapperView.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 11/19/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKitUI
import SwiftUI

// swiftformat:disable all
internal class EventViewerWrapperViewCoordinator: NSObject, EKEventViewDelegate {
    var wrapperView: EventViewerWrapperView
    init(_ wrapperView: EventViewerWrapperView) {
        self.wrapperView = wrapperView
    }

    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.wrapperView.store.selectedDate = controller.event.startDate
        }
    }
}

struct EventViewerWrapperView: UIViewControllerRepresentable {
    @EnvironmentObject var store: Store

    var event: ClendarEvent?

    func makeCoordinator() -> EventViewerWrapperViewCoordinator {
        EventViewerWrapperViewCoordinator(self)
    }

    func makeUIViewController(context: Context) -> EventViewerNavigationController {
        guard let event = event?.event else { return EventViewerNavigationController() }
        return EventViewerNavigationController(event: event, delegate: context.coordinator)
    }

    func updateUIViewController(_ uiViewController: EventViewerNavigationController, context: Context) {}
}
// swiftformat:enable all
