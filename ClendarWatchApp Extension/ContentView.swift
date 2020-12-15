//
//  ContentView.swift
//  ClendarWatchApp Extension
//
//  Created by Vinh Nguyen on 15/12/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @StateObject
    var eventKitWrapper = EventKitWrapper.shared

    @State
    private var selectedEvent: Event?

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 10) {
            Section(
                header:
                    Text(Date().toFullDateString.localizedUppercase)
                    .font(.boldFontWithSize(11))
                    .foregroundColor(Color(.moianesB))
            ) {
                ForEach(eventKitWrapper.events, id: \.self) { event in
                    WidgetEventRow(event: event)
                }
            }
        }
        .padding()
        .onAppear { eventKitWrapper.fetchEventsForToday() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
