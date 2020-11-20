//
//  ClendarApp.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import IQKeyboardManagerSwift
import SwiftDate
import SwiftUI

#warning("// TODO: SwiftUI migration")

// check old AppDelegate.swift file for reference

/*
 SwiftUI articles to read:
 https://www.swiftbysundell.com/articles/swiftui-layout-system-guide-part-1/
 https://www.swiftbysundell.com/articles/swiftui-state-management-guide/
 https://www.swiftbysundell.com/articles/handling-loading-states-in-swiftui/
 https://www.swiftbysundell.com/tips/building-an-observable-type-for-swiftui-views/
 https://www.swiftbysundell.com/tips/adding-swiftui-viewbuilder-to-functions/
 https://www.swiftbysundell.com/articles/encapsulating-swiftui-view-styles/
 https://www.swiftbysundell.com/articles/avoiding-massive-swiftui-views/
 https://www.swiftbysundell.com/tips/swiftui-extensions-using-generics/
 https://www.swiftbysundell.com/articles/propagating-user-facing-errors-in-swift/
 https://www.swiftbysundell.com/articles/configuring-swiftui-views/
 https://www.swiftbysundell.com/tips/swiftui-automatic-placeholders/
 https://www.swiftbysundell.com/articles/rendering-textured-views-with-swiftui/
 https://www.swiftbysundell.com/articles/building-swiftui-debugging-utilities/
 https://www.swiftbysundell.com/articles/shifting-paradigms-in-swift/
 https://www.swiftbysundell.com/articles/deciding-whether-to-adopt-new-swift-technologies/
 https://www.swiftbysundell.com/articles/learning-swiftui-by-building-tools-and-prototypes/

 https://swiftwithmajid.com/2020/07/08/mastering-grids-in-swiftui/
 https://swiftwithmajid.com/2020/06/29/new-property-wrappers-in-swiftui/ << ---- IMPORTANT
 https://swiftwithmajid.com/2020/07/02/the-difference-between-stateobject-environmentobject-and-observedobject-in-swiftui/  << ---- IMPORTANT
 https://swiftwithmajid.com/2020/06/23/what-is-new-in-swiftui/
 https://swiftwithmajid.com/2020/06/17/the-magic-of-animatable-values-in-swiftui/
 https://swiftwithmajid.com/2020/05/20/fitting-and-filling-view-in-swiftui/
 https://swiftwithmajid.com/2020/05/13/template-view-pattern-in-swiftui/
 https://swiftwithmajid.com/2020/05/06/building-calendar-without-uicollectionview-in-swiftui/
 https://swiftwithmajid.com/2020/04/29/the-magic-of-fixed-size-modifier-in-swiftui/
 https://swiftwithmajid.com/2020/04/15/layout-priorities-in-swiftui/
 https://swiftwithmajid.com/2020/04/08/binding-in-swiftui/
 https://swiftwithmajid.com/2020/03/18/anchor-preferences-in-swiftui/
 https://swiftwithmajid.com/2020/03/11/alignment-guides-in-swiftui/
 https://swiftwithmajid.com/2020/03/04/customizing-toggle-in-swiftui/
 https://swiftwithmajid.com/2020/02/26/textfield-in-swiftui/
 https://swiftwithmajid.com/2020/02/19/mastering-buttons-in-swiftui/
 https://swiftwithmajid.com/2020/02/12/customizing-the-shape-of-views-in-swiftui/
 https://swiftwithmajid.com/2020/02/05/building-viewmodels-with-combine-framework/
 https://swiftwithmajid.com/2020/01/29/using-uikit-views-in-swiftui/
 https://swiftwithmajid.com/2020/01/22/optimizing-views-in-swiftui-using-equatableview/
 https://swiftwithmajid.com/2020/01/15/the-magic-of-view-preferences-in-swiftui/
 https://swiftwithmajid.com/2020/01/08/building-networking-layer-using-functions/
 https://swiftwithmajid.com/2019/12/31/swiftui-learning-curve-in-2019/
 https://swiftwithmajid.com/2019/12/25/building-pager-view-in-swiftui/
 https://swiftwithmajid.com/2019/12/18/the-power-of-viewbuilder-in-swiftui/
 https://swiftwithmajid.com/2019/12/04/must-have-swiftui-extensions/
 https://swiftwithmajid.com/2019/11/27/combine-and-swiftui-views/
 https://swiftwithmajid.com/2019/11/19/you-have-to-change-mindset-to-use-swiftui/
 https://swiftwithmajid.com/2019/11/13/gradient-in-swiftui/
 https://swiftwithmajid.com/2019/11/06/the-power-of-closures-in-swiftui/
 https://swiftwithmajid.com/2019/10/30/view-composition-in-swiftui/
 https://swiftwithmajid.com/2019/10/23/reusing-swiftui-views-across-apple-platforms/
 https://swiftwithmajid.com/2019/10/16/localization-in-swiftui/
 https://swiftwithmajid.com/2019/10/09/dynamic-type-in-swiftui/
 https://swiftwithmajid.com/2019/09/18/redux-like-state-container-in-swiftui/
 https://swiftwithmajid.com/2019/09/25/redux-like-state-container-in-swiftui-part2/
 https://swiftwithmajid.com/2019/10/02/redux-like-state-container-in-swiftui-part3/
 https://swiftwithmajid.com/2019/09/10/accessibility-in-swiftui/
 https://swiftwithmajid.com/2019/09/04/modeling-app-state-using-store-objects-in-swiftui/
 https://swiftwithmajid.com/2019/08/28/composable-styling-in-swiftui/
 https://swiftwithmajid.com/2020/10/22/the-magic-of-redacted-modifier-in-swiftui/
 https://swiftwithmajid.com/2019/07/10/gestures-in-swiftui/
 https://swiftwithmajid.com/2019/06/12/understanding-property-wrappers-in-swiftui/
 https://swiftwithmajid.com/2019/05/29/the-power-of-delegate-design-pattern/
 https://swiftwithmajid.com/2019/06/05/swiftui-making-real-world-app/
 https://swiftwithmajid.com/2019/06/19/building-forms-with-swiftui/
 https://swiftwithmajid.com/2019/06/26/animations-in-swiftui/
 https://swiftwithmajid.com/2019/07/03/managing-data-flow-in-swiftui/
 https://swiftwithmajid.com/2019/07/17/navigation-in-swiftui/
 https://swiftwithmajid.com/2019/07/24/alerts-actionsheets-modals-and-popovers-in-swiftui/
 https://swiftwithmajid.com/2019/07/31/introducing-container-views-in-swiftui/
 https://swiftwithmajid.com/2019/08/07/viewmodifiers-in-swiftui/
 https://swiftwithmajid.com/2019/08/14/building-barchart-with-shape-api-in-swiftui/
 https://swiftwithmajid.com/2019/08/21/the-power-of-environment-in-swiftui/

 https://github.com/Juanpe/About-SwiftUI#-books

 https://heckj.github.io/swiftui-notes/

 */

/*
   Issues tracking
   https://github.com/vinhnx/Clendar/issues

 ==
  TODO:

  + IMPORTANT: SwiftUI migration -> NOW OR NEVER -> it's not too difficult
     ==> use SwiftUI_migration branch

 + [done for UIKit, try to do in SwiftUI] menu context:
        [https://developer.apple.com/documentation/uikit/uicontextmenuinteraction
        https://useyourloaf.com/blog/adding-context-menus-in-ios-13/
        https://kylebashour.com/posts/ios-13-context-menus]
 + [done for UIKit, try to do in SwiftUI] + 3D/haptic touch shortcut from homescreen (https://developer.apple.com/documentation/uikit/menus_and_shortcuts/add_home_screen_quick_actions)

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

class AppDelegate: NSObject, UIApplicationDelegate {
	func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		configure()
		return true
	}

	// MARK: - Private

	private func configure() {
		logger.logLevel = .debug
		SwiftDate.defaultRegion = Region.local
		IQKeyboardManager.shared.enable = true
		IQKeyboardManager.shared.enableAutoToolbar = false
		IQKeyboardManager.shared.shouldResignOnTouchOutside = true
		UIApplication.shared.applicationIconBadgeNumber = 0
	}
}

@main
struct ClendarApp: App {
	// swiftlint:disable:next weak_delegate
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

	var body: some Scene {
		WindowGroup {
			MainContentView()
				.environmentObject(Store())
		}
	}
}
