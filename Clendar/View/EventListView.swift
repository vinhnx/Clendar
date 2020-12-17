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
	@State private var selectedEvent: Event?
	var events = [Event]()

	var body: some View {
		ScrollView(showsIndicators: false) {
			LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(events, id: \.id) { event in
					EventListRow(event: event)
						.onTapGesture { self.selectedEvent = event }
						.contextMenu {
							Button(
								action: { self.selectedEvent = event },
								label: {
                                    Text("Edit Event")
                                        .accessibility(label: Text("Edit Event"))
									Image(systemName: "square.and.pencil")
								}
							)
						}
				}
			}
		}
		.sheet(item: $selectedEvent) { event in
			EventViewerWrapperView(event: event)
				.environmentObject(store)
                .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
		}
	}
}

struct EventListView_Previews: PreviewProvider {
	static var previews: some View {
		EventListView(events: []).environmentObject(Store())
	}
}
