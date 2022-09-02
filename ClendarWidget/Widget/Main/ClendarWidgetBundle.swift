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
        CalendarGridWidgetBundle().body
        DateInfoWidgetBundle().body
        LunarWidgetBundle().body
        EventListWidgetBundle().body
        LockScreenWidgetBundle().body
    }
}

struct DateInfoWidgetBundle: WidgetBundle {
    var body: some Widget {
        DateInfoWidget()
    }
}

struct EventListWidgetBundle: WidgetBundle {
    var body: some Widget {
        EventListWidget()
    }
}

struct CalendarGridWidgetBundle: WidgetBundle {
    var body: some Widget {
        CalendarGridWidget()
    }
}

struct LunarWidgetBundle: WidgetBundle {
    var body: some Widget {
        LunarDateInfoWidget()
    }
}

struct LockScreenWidgetBundle: WidgetBundle {
    var body: some Widget {
        LockScreenWidgetIconNextEvent()
        LockScreenWidgetIconCounter()

        LockScreenWidgetTranslucentAllNextEvent()
        LockScreenWidgetTranslucentAllCounter()

        LockScreenWidgetTranslucentContentNextEvent()
        LockScreenWidgetTranslucentContentCounter()

        LockScreenWidgetMinimalLeadingNextEvent()
        LockScreenWidgetMinimalTrailingNextEvent()

        LockScreenWidgetLeadingLineNextEvent()
        LockScreenWidgetTrailingLineNextEvent()
    }
}
