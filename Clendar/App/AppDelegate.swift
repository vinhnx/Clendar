//
//  AppDelegate.swift
//  Clendar
//
//  Created by Vinh Nguyen on 23/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit
import Logging
import SwiftDate
import IQKeyboardManagerSwift

/*
 TODO:

 + app icon
 + move dependencies from Cocoapod to SPM as much as possible
 + localized https://github.com/yonaskolb/Stringly
 + form/settings builder: https://github.com/neoneye/SwiftyFORM
 + force touch shortcut from homescreen
 + gan admob google ads earn money ~1-2$ day
 + iOS 14 widget
 + IMPORTANT: Vietnamese translation, because aim for Vietnamese market or myself
 + [done] show list of events of day
 + settings:
    + [done] show lunar date
    + event stack highlight (check old code)
    + [done] theme
    + date type (12 or 24h)
    + start of week
    + Everything under CVCalendar configs
    + month/week view
 + lunar converter (+)
 + lunar event (+)
 + write tests (?)
 + automation (?)
 + [optional] build macOS app, non currently for am lich
 + [done] dark/light mode
 + [done] edit calendar event
 + [done] option when creating an event
 + selectable calendar to shown
 + IAP  => make more money
 + haptic
 + duong lich <-> am lich
 + iPad app
 + watch app (?)
 + mac app (?)

 + https://www.raywenderlich.com/10718147-supporting-dark-mode-adapting-your-app-to-support-dark-mode
 */

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configure()

        window?.tintColor = .primaryColor
        window?.rootViewController = R.storyboard.calendarViewController.instantiateInitialViewController()
        window?.makeKeyAndVisible()

        return true
    }

}

extension AppDelegate {

    // MARK: - Window

    private func configure() {

        logger.logLevel = .debug

        SwiftDate.defaultRegion = Region.local

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
}
