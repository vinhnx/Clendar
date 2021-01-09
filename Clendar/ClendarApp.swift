//
//  ClendarApp.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftDate
import SwiftUI
import Shift

@main
struct ClendarApp: App {
    let store = Store()

    init() { configure() }

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}

extension ClendarApp {

    // MARK: - Private

    private func configure() {
        #if os(iOS)
        UIApplication.shared.applicationIconBadgeNumber = 0
        ReviewManager().trackLaunch()
        #endif

        logger.logLevel = .debug
        SwiftDate.defaultRegion = Region.local
        Shift.configureWithAppName(AppInfo.appName)
    }
}
