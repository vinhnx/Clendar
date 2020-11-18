//
//  AppDelegate.swift
//  Clendar
//
//  Created by Vinh Nguyen on 23/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import IQKeyboardManagerSwift
import Logging
import SwiftDate
import UIKit
import UserNotifications

/*
  Issues tracking
  https://github.com/vinhnx/Clendar/issues

==
 TODO:
 + IMPORTANT: SwiftUI migration -> NOW OR NEVER -> it's not too difficult
    ==> use SwiftUI_migration branch

 + renew Apple Account -> create bundle id, setup IAP -> tip jar: https://github.com/lionheart/TipJarViewController
 + landing page https://github.com/emilbaehr/automatic-app-landing-page
 + [!] IAP, tip jars  => make more money
 + rating prompt https://developer.apple.com/documentation/storekit/skstorereviewcontroller/requesting_app_store_reviews
 + lunar converter (+)
 + lunar event (+)
 + duong lich <-> am lich
 + watch app (?)
 ==
 OPTIONAL
 + accessibilty (use lib)
 + badge app style <- NOTE: should have background fetch to update badge as date change, disable for now!
 + local notification
 + [future] future: reminders/tasks
 + settings:
    > [?] hightlight weekends (sat and sunday)
    > ???? not sure how to reload CVconfiguration?] start of week
    > ??? Everything under CVCalendar configs
 ==
 DONE:
 + [done] IMPORTANT: Vietnamese translation, because aim for Vietnamese market or myself https://github.com/yonaskolb/Stringly
    > https://www.raywenderlich.com/250-internationalizing-your-ios-app-getting-started
 + [done] Plist gen https://github.com/mono0926/LicensePlist
 + [done] add switch option for quick event as all l day event
 + [done] change app icon
 + [done] menu context:
        [https://developer.apple.com/documentation/uikit/uicontextmenuinteraction
        https://useyourloaf.com/blog/adding-context-menus-in-ios-13/
        https://kylebashour.com/posts/ios-13-context-menus]
 + [done] + 3D/haptic touch shortcut from homescreen (https://developer.apple.com/documentation/uikit/menus_and_shortcuts/add_home_screen_quick_actions)
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

//@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    /// Temporary variable to hold a shortcut item from the launching or activation of the app.
    var shortcutItemToProcess: UIApplicationShortcutItem?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configure()

        // If launchOptions contains the appropriate launch options key, a Home screen quick action
        // is responsible for launching the app. Store the action for processing once the app has
        // completed initialization.
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            shortcutItemToProcess = shortcutItem
        }

        window?.overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
        window?.tintColor = .primaryColor
//        window?.rootViewController = R.storyboard.calendarViewController.instantiateInitialViewController()
        window?.makeKeyAndVisible()

        return true
    }

    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        // Alternatively, a shortcut item may be passed in through this delegate method if the app was
        // still in memory when the Home screen quick action was used. Again, store it for processing.
        shortcutItemToProcess = shortcutItem
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        processShortcutEvent()
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

        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    // MARK: - Shortcuts

    private func processShortcutEvent() {
        guard let shortcutItem = shortcutItemToProcess else { return }
        defer {
            shortcutItemToProcess = nil // Reset the shortcut item so it's never processed twice.
        }

        if shortcutItem.type == R.info.uiApplicationShortcutItems.addEventAction.uiApplicationShortcutItemType {
//            (window?.rootViewController as? CalendarViewController)?.createEvent()
        }
    }

}
