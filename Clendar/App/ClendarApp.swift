//
//  ClendarApp.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

#if os(iOS)
import IQKeyboardManagerSwift
#endif

import SwiftDate
import SwiftUI
import Shift

/*
 Issues tracking
 https://github.com/vinhnx/Clendar/issues

 ==
 TODO:
 + [!] IAP, tip jars  => make more money
    > Testing IAP https://github.com/vinhnx/notes/issues/352
 + double check Vietnamese translation
 + [done for UIKit, try to do in SwiftUI] + 3D/haptic touch shortcut from homescreen (https://developer.apple.com/documentation/uikit/menus_and_shortcuts/add_home_screen_quick_actions)
 + renew Apple Account -> create bundle id, setup IAP -> tip jar: https://github.com/lionheart/TipJarViewController
 + landing page https://github.com/emilbaehr/automatic-app-landing-page
 + rating prompt https://developer.apple.com/documentation/storekit/skstorereviewcontroller/requesting_app_store_reviews
 + lunar converter (+)
 + lunar event (+)
 + duong lich <-> am lich
 ==
 OPTIONAL
 + macOS app https://developer.apple.com/forums/thread/649675
 + badge app style <- NOTE: should have background fetch to update badge as date change, disable for now!
 + local notification
 + [future] future: reminders/tasks
 + settings:
 > [?] highlight weekends (sat and sunday)
 > ???? not sure how to reload CVconfiguration?] start of week
 > ??? Everything under CVCalendar configs
 ==
 DONE:
 + [done] iPad app ?
 + [done] watch app (?)
 + [basic -- view only done] watchOS app
 + [00:11 21/11/2020 --- DONE now] IMPORTANT: SwiftUI migration
 ==> use SwiftUI_migration branch
 + [done for UIKit, try to do in SwiftUI] menu context:
 [https://developer.apple.com/documentation/uikit/uicontextmenuinteraction
 https://useyourloaf.com/blog/adding-context-menus-in-ios-13/
 https://kylebashour.com/posts/ios-13-context-menus]
 + [done] IMPORTANT: Vietnamese translation, because aim for Vietnamese market or myself https://github.com/yonaskolb/Stringly
 > https://www.raywenderlich.com/250-internationalizing-your-ios-app-getting-started
 + [done] Plist gen https://github.com/mono0926/LicensePlist
 + [done] add switch option for quick event as all l day event
 + [done] change app icon
 + [done] haptic feedback
 + [done for UIKit, try to do in SwiftUI] menu context:
 [https://developer.apple.com/documentation/uikit/uicontextmenuinteraction
 https://useyourloaf.com/blog/adding-context-menus-in-ios-13/
 https://kylebashour.com/posts/ios-13-context-menus]
 + [done for UIKit, try to do in SwiftUI] + 3D/haptic touch shortcut from homescreen (https://developer.apple.com/documentation/uikit/menus_and_shortcuts/add_home_screen_quick_actions)
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
// Reference: https://swiftwithmajid.com/2020/08/19/managing-app-in-swiftui/

@main
struct ClendarApp: App {
    @Environment(\.scenePhase) var scenePhase

    let store = Store()

    init() { configure() }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}

extension ClendarApp {

    // MARK: - Private

    private func configure() {
        #if os(iOS)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        UIApplication.shared.applicationIconBadgeNumber = 0
        #endif

        logger.logLevel = .debug
        SwiftDate.defaultRegion = Region.local
        Shift.configureWithAppName(AppInfo.appName)
    }

}
