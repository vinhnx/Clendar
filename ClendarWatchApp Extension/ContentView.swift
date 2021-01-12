//
//  ContentView.swift
//  ClendarWatchApp Extension
//
//  Created by Vinh Nguyen on 15/12/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import Shift

struct ContentView: View {
    @StateObject var eventKitWrapper = Shift.shared
    @State private var selectedEvent: ClendarEvent?

    var body: some View {
        NavigationView {
            if eventKitWrapper.events.isEmpty {
                EmptyView()
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        Section(
                            header:
                                Text(Date().toFullDateString.localizedUppercase)
                                .font(.boldFontWithSize(11))
                                .foregroundColor(Color(.moianesB))
                        ) {
                            ForEach(eventKitWrapper.events.compactMap(ClendarEvent.init), id: \.self) { event in
                                NavigationLink(destination: EventViewer(event: event)) {
                                    WidgetEventRow(event: event)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear { eventKitWrapper.fetchEventsForToday() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
