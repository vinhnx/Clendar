//
//  ClendarWidgetBundle.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 11/1/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

@main
struct ClendarWidgetBundle: WidgetBundle {
    var body: some Widget {
        DateInfoWidgetBundle().body
        CalendarGridWidgetBundle().body
    }
}

struct CalendarGridWidgetBundle: WidgetBundle {
    var body: some Widget {
        CalendarGridWidget()
    }
}

struct DateInfoWidgetBundle: WidgetBundle {
    var body: some Widget {
        DateInfoWidget()
    }
}
