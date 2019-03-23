//
//  AppDelegate.swift
//  Clendar
//
//  Created by Vinh Nguyen on 23/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureWindow()
        return true
    }

    // MARK: - Window

    private func configureWindow() {
        self.window?.rootViewController = UIStoryboard(name: "CalendarViewController", bundle: nil).instantiateInitialViewController()
        self.window?.makeKeyAndVisible()
    }
}
