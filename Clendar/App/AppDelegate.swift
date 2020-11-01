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
 + for widget https://github.com/pawello2222/WidgetExamples
 + force touch shortcut from homescreen
 + [!] IAP  => make more money
 + [!] gan admob google ads earn money ~1-2$ day or IAP? -- but consider if better than IAP
 + [WIP] badge app style <- NOTE: should have background fetch to update badge as date change, disable for now!
 + local notification << IMPORTANT
 + [future] future: reminders/tasks
 + onboarding
 + rating prompt
 + app icon
 + IMPORTANT: Vietnamese translation, because aim for Vietnamese market or myself https://github.com/yonaskolb/Stringly
 + settings:
    > [?] hightlight weekends (sat and sunday)
    > ???? not sure how to reload CVconfiguration?] start of week
    > ??? Everything under CVCalendar configs
 + lunar converter (+)
 + lunar event (+)
 + duong lich <-> am lich
 + watch app (?)
 ==
 DONE:
 + [done] haptic feedback
 + [DONE, BUT could have settings configuration style -- IAP/pro...] IMPORTANT iOS 14 widget https://developer.apple.com/news/?id=yv6so7ie
        > use SwiftUI Calendar to diplay calendar view
            > https://gist.github.com/mecid/f8859ea4bdbd02cf5d440d58e936faec
            > https://gist.github.com/mecid/f8859ea4bdbd02cf5d440d58e936faec#gistcomment-3354849
            > https://gist.github.com/vinhnx/6dec7399d4b980d73166cb2e42b2a6c2
 + [done] iPad app
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

@UIApplicationMain
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
