//
//  ClendarApp.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import SwiftDate

#warning("// TODO: SwiftUI migration")

// check old AppDelegate.swift file for reference

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        logger.logLevel = .debug
        SwiftDate.defaultRegion = Region.local
        return true
    }
}

@main
struct ClendarApp: App {
    // swiftlint:disable:next weak_delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

	var body: some Scene {
		WindowGroup {
			MainContentView()
				.environmentObject(SharedState())
		}
	}
}
