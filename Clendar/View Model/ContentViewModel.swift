//
//  ContentViewModel.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 02/03/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import Foundation
import EventKit
import Shift

class ContentViewModel: ObservableObject {
    @Published var events: [ClendarEvent] = []
    @Published var error: Error?

    func fetchEvents(for date: Date = Date()) {
        Shift.shared.fetchEvents(for: date, filterCalendarIDs: UserDefaults.savedCalendarIDs) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let ekEvents):
                self.events = ekEvents.compactMap(ClendarEvent.init)
            case .failure(let error):
                self.error = error
            }
        }
    }
}
