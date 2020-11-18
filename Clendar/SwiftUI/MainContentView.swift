//
//  MainView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import EventKit

#warning("// TODO: SwiftUI migration")

struct MainContentView: View {
    @ObservedObject var eventKitWrapper = EventKitWrapper.shared

    @State private var date = Date()

    @State private var showCreateEventState = false
    @State private var showSettingsState = false

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                Button(action: {
                    self.showCreateEventState.toggle()
                }, label: {
                    Image(systemName: "plus.circle.fill")
                }).sheet(isPresented: $showCreateEventState) {
                    EventViewWrapperView()
                }

                VStack(spacing: 10) {
                    HStack {
                        Button(action: {
                            self.showSettingsState.toggle()
                        }, label: {
                            Image(systemName: "slider.horizontal.3")
                        }).sheet(isPresented: $showSettingsState, content: {
                            SettingsWrapperView()
                        })

                        Spacer()

                        HStack {
                            Button(action: {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "bar"), object: nil)
                            }, label: {
                                Image(systemName: "chevron.backward")
                            })

                            Text("Month")

                            Button(action: {
                                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "foo"), object: nil)
                            }, label: {
                                Image(systemName: "chevron.forward")
                            })
                        }
                    }

                    CalendarHeaderView(date: $date)
                        .frame(width: geometry.size.width, height: 10)

                    CalendarWrapperView(date: $date).frame(width: geometry.size.width, height: 300)


                    Text("Sunday, 23rd August 1990")

                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(eventKitWrapper.events, id: \.self.id) { event in
                                EventListItemRow(event: event)
                            }
                        }
                    }

                    Spacer()
                }
            }
        }
        .padding()
        .onAppear(perform: {
            self.fetchEvents(for: date)
        })

    }

    func fetchEvents(for date: Date = Date()) {
        eventKitWrapper.fetchEvents(for: date)
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
