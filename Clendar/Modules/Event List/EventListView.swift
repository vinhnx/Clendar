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
    @State private var selectedEvent: ClendarEvent?
    var events = [ClendarEvent]()

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(events, id: \.self) { event in
                    NavigationLink(
                        destination:
                            EventViewer(event: event)
                            .navigationBarTitle("", displayMode: .inline)
                            .environmentObject(store)
                            .modifier(ModalBackgroundModifier(backgroundColor: store.appBackgroundColor))
                    ) {
                        EventListRow(event: event)
                    }
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
