//
//  EventViewWrapperView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKitUI
import SwiftUI

#warning("// TODO: SwiftUI migration")

struct EventViewWrapperView: UIViewControllerRepresentable {
	class Coordinator: NSObject, EKEventEditViewDelegate {
		func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
			controller.dismiss(animated: true) {
				guard action != .canceled else { return }
				guard let event = controller.event else { return }
				//                self.fetchEvents(for: event.startDate)
			}
		}
	}

	func makeCoordinator() -> Coordinator {
		Coordinator()
	}

	func makeUIViewController(context: Context) -> EventEditViewController {
		let view = EventEditViewController(
			eventStore: EventKitWrapper.shared.eventStore,
			delegate: context.coordinator
		)
		return view
	}

	func updateUIViewController(_: EventEditViewController, context _: Context) {}
}
