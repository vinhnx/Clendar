//
//  CalendarViewModel.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/28/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import CVCalendar

enum CalendarViewMode: Int, CaseIterable {
    case week
    case month

    var mode: CVCalendarViewPresentationMode {
        switch self {
        case .week: return .weekView
        case .month: return .monthView
        }
    }

    var text: String {
        switch self {
        case .week: return "Week view"
        case .month: return "Month view"
        }
    }

    static var titles: [String] = CalendarViewMode.allCases.map { $0.text }
}
