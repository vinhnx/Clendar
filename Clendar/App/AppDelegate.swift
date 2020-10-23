//
//  AppDelegate.swift
//  Clendar
//
//  Created by Vinh Nguyen on 23/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit
import Logging

/*
 TODO:

 + iOS 14 widget
 + IMPORTANT: Vietnamese translation, because aim for Vietnamese market or myself
 + [done] show list of events of day
 + settings:
    + show lunar date or event stack highlight
    + theme
    + date type (12 or 24h)
    + start of week
    + Everything under CVCalendar configs
 + lunar converter (+)
 + lunar event (+)
 + write tests
 + automation
 + [optional] build macOS app, non currently for am lich
 + [done] dark/light mode

 + https://www.raywenderlich.com/10718147-supporting-dark-mode-adapting-your-app-to-support-dark-mode
 */

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureWindow()
        configureLogger()
        return true
    }

}

extension AppDelegate {

    // MARK: - Window

    private func configureWindow() {
        window?.rootViewController = R.storyboard.calendarViewController.instantiateInitialViewController()
        window?.makeKeyAndVisible()
    }

    fileprivate func configureLogger() {
        logger.logLevel = .debug
    }
}
