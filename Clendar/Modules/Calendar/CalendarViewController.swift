//
//  CalendarViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 23/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import CVCalendar

final class CalendarViewController: BaseViewController {

    // MARK: - Properties
    
    @IBOutlet private var menuView: CVCalendarMenuView!
    @IBOutlet private var calendarView: CVCalendarView!

    // MARK: - Life Cycle

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    // MARK: - Private

    private func commitCalendarViewUpdates() {
        self.menuView.commitMenuViewUpdate()
        self.calendarView.commitCalendarViewUpdate()
    }
}
