//
//  MainView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKit
import SwiftUI

#warning("// TODO: SwiftUI migration")

struct MainContentView: View {
	@EnvironmentObject var sharedState: SharedState
	@StateObject var eventKitWrapper = EventKitWrapper.shared
	@State private var showCreateEventState = false
	@State private var showSettingsState = false

	let calendarWrapperView = CalendarWrapperView()

	var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                VStack(spacing: 10) {
                    makeCalendarHeaderView()
                    makeCalendarGroupView(with: geometry)
                    makeSelectedDateLabel()
                    makeEventListView()
                    Spacer()
                }
                makeAddButton()
            }
        }
        .onAppear(perform: {
            self.selectDate(Date())
        })
        .onReceive(sharedState.$selectedDate) { date in
            self.selectDate(date)
        }
        .onReceive(NotificationCenter.default.publisher(for: .didAuthorizeCalendarAccess)) { _ in
            self.selectDate(Date())
        }
        .onReceive(NotificationCenter.default.publisher(for: .EKEventStoreChanged)) { _ in
            self.selectDate(sharedState.selectedDate)
        }
        .onReceive(NotificationCenter.default.publisher(for: .didDeleteEvent)) { _ in
            self.selectDate(sharedState.selectedDate)
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeMonthViewCalendarModePreferences)) { _ in
            self.calendarWrapperView.calendarView.changeModePerSettings()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeShowDaysOutPreferences)) { _ in
            self.calendarWrapperView.calendarView.changeDaysOutShowingState(shouldShow: SettingsManager.showDaysOut)
            self.calendarWrapperView.calendarView.reloadData()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeDaySupplementaryTypePreferences)) { _ in
            self.calendarWrapperView.calendarView.reloadData()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeSavedCalendarsPreferences)) { _ in
            guard let selectedDate = self.calendarWrapperView.calendarView.selectedDate else { return }
            self.fetchEvents(for: selectedDate)
        }
        .onReceive(NotificationCenter.default.publisher(for: .justReloadCalendar)) { _ in
            self.calendarWrapperView.calendarView.reloadData()
        }
        .onReceive(NotificationCenter.default.publisher(for: .didChangeUserInterfacePreferences)) { _ in
            sharedState.backgroundColor = Color(.backgroundColor)
        }
        .padding()
        .preferredColorScheme(appColorScheme)
        .environment(\.colorScheme, appColorScheme)
        .background(sharedState.backgroundColor.edgesIgnoringSafeArea(.all))
    }
}

extension MainContentView {
	private func selectDate(_ date: Date) {
        guard calendarWrapperView.calendarView.contentController != nil else { return }
		calendarWrapperView.calendarView.toggleViewWithDate(date)
		fetchEvents(for: date)
	}

	private func fetchEvents(for date: Date = Date()) {
		eventKitWrapper.fetchEvents(for: date)
	}

	private func makeAddButton() -> some View {
		Button(action: {
			self.showCreateEventState.toggle()
		}, label: {
			Image(systemName: "plus.circle.fill")
		}).sheet(isPresented: $showCreateEventState) {
			if SettingsManager.useExperimentalCreateEventMode {
				QuickEventWrapperView().styleModalBackground(sharedState.backgroundColor)
			} else {
				EventEditorWrapperView()
					.environmentObject(sharedState)
					.styleModalBackground(sharedState.backgroundColor)
			}
		}
	}

	private func makeSettingsButton() -> some View {
		Button(action: {
			self.showSettingsState.toggle()
		}, label: {
			Image(systemName: "slider.horizontal.3")
		}).sheet(isPresented: $showSettingsState, content: {
			SettingsWrapperView().styleModalBackground(sharedState.backgroundColor)
		})
	}

	private func makeMonthHeaderView() -> some View {
		HStack {
			Button(action: { calendarWrapperView.calendarView.loadPreviousView() },
			       label: { Image(systemName: "chevron.backward") })

			Button(sharedState.selectedDate.toMonthAndYearString.uppercased()) {
				sharedState.selectedDate = Date()
			}

			Button(action: { calendarWrapperView.calendarView.loadNextView() },
			       label: { Image(systemName: "chevron.forward") })
		}
	}

	private func makeSelectedDateLabel() -> some View {
		Text(sharedState.selectedDate.toFullDateString)
	}

	private func makeCalendarHeaderView() -> some View {
		HStack {
			makeSettingsButton()
			Spacer()
			makeMonthHeaderView()
		}
	}

	private func makeCalendarGroupView(with geometry: GeometryProxy) -> some View {
		Group {
			CalendarHeaderView().frame(width: geometry.size.width, height: 10)
			calendarWrapperView.frame(width: geometry.size.width, height: 300)
		}
	}

	private func makeEventListView() -> some View {
        EventListView(events: eventKitWrapper.events)
            .environmentObject(sharedState)
	}
}

struct MainContentView_Previews: PreviewProvider {
	static var previews: some View {
		MainContentView().environmentObject(SharedState())
	}
}
