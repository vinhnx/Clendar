//
//  EventListView.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 11/19/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct EventListView: View {
    @EnvironmentObject var sharedState: SharedState
    @State var selectedEvent: Event?
    var events = [Event]()

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(events, id: \.self.id) { event in
                    if let ekEvent = event.event {
                        GroupBox(
                            label: Label(ekEvent.title, systemImage: "calendar")
                                .lineLimit(nil)
                                .foregroundColor(Color(ekEvent.calendar.cgColor)),
                            content: {
                                Text(ekEvent.durationText()).font(.footnote)
                            }
                        )
                        .onTapGesture { self.selectedEvent = event }
                    }
                    else {
                        EmptyView().redacted(reason: .placeholder)
                    }
                }
            }
        }
        .sheet(item: self.$selectedEvent) { event in
            EventViewerWrapperView(event: event)
                .environmentObject(sharedState)
                .styleModalBackground(sharedState.backgroundColor)
        }
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView(events: []).environmentObject(SharedState())
    }
}
