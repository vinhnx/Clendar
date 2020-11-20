//
//  EventListView.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 11/19/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct EventListView: View {
	@EnvironmentObject var store: Store
	@State var selectedEvent: Event?
	var events = [Event]()

	var body: some View {
		ScrollView {
			LazyVStack(alignment: .leading, spacing: 10) {
				ForEach(events, id: \.self.id) { event in
					EventListRow(event: event)
						.onTapGesture { self.selectedEvent = event }
				}
			}
		}
		.sheet(item: $selectedEvent) { event in
			EventViewerWrapperView(event: event)
				.environmentObject(store)
				.styleModalBackground(store.appBackgroundColor)
		}
	}
}

struct EventListView_Previews: PreviewProvider {
	static var previews: some View {
		EventListView(events: []).environmentObject(Store())
	}
}
