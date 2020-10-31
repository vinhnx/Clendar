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
import UserNotifications

/*
 TODO:
 + [DONE, BUT could have settings configuration style -- IAP/pro...] IMPORTANT iOS 14 widget https://developer.apple.com/news/?id=yv6so7ie
 + [WIP] badge app style <- NOTE: should have background fetch to update badge as date change, disable for now!
 + refactor with https://github.com/devxoul/Then
 + local notification << IMPORTANT
 + future: reminders
 + onboarding
 + rating prompt
 + app icon
 + IMPORTANT: Vietnamese translation, because aim for Vietnamese market or myself https://github.com/yonaskolb/Stringly
 + force touch shortcut from homescreen
 + gan admob google ads earn money ~1-2$ day or IAP?
 + settings:
    > [?] hightlight weekends (sat and sunday)
    > ???? not sure how to reload CVconfiguration?] start of week
    > ??? Everything under CVCalendar configs
 + lunar converter (+)
 + lunar event (+)
 + [optional] build macOS app, non currently for am lich

 + IAP  => make more money
 + haptic
 + duong lich <-> am lich
 + iPad app
 + watch app (?)
 + mac app (?)
 + write tests (?)
 + automation (try github action, fastlane, ci-cd)
 ==
 DONE:
 + [done] move dependencies from Cocoapod to SPM as much as possible
 + [done] form/settings builder: https://github.com/neoneye/SwiftyFORM
 + [done] show list of events of day
 + [done] [Experimental] use natural date parsing for creating new event
 + [done] show lunar date
 + [done] event stack highlight (check old code)
 + [done] theme
 + [done] month/week view
 + [done] show days out
 + [done] dark/light mode
 + [done] edit calendar event
 + [done] option when creating an event
 + [done] selectable calendar to shown EKCalendarChooser
 */

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configure()

        window?.overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
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
