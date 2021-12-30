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

final class EventEditorWrapperViewCoordinator: NSObject, EKEventEditViewDelegate {
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

final class EventEditViewController: EKEventEditViewController {
    // MARK: Lifecycle

    init(
        event: EKEvent? = nil,
        eventStore: EKEventStore,
        delegate: EKEventEditViewDelegate?
    ) {
        super.init(nibName: nil, bundle: nil)
        self.eventStore = eventStore
        self.event = event
        editViewDelegate = delegate
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Internal

    override func viewDidLoad() {
        super.viewDidLoad()

        checkUIMode()

        NotificationCenter.default.addObserver(forName: .didChangeUserInterfacePreferences, object: nil, queue: .main) { _ in
            self.checkUIMode()
        }
    }

    func checkUIMode() {
        overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
    }
}
