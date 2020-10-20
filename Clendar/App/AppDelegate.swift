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

 + dribble: https://dribbble.com/search/calendar

 + trello: https://trello.com/b/pNJSMOCZ/project-clendar-solar-lunar-convert-ios-calendar-integration-natural-date-input-parsing-personal-use-first

 + color: https://color.adobe.com/cloud/aHR0cHM6Ly9jYy1hcGktYXNzZXRzLmFkb2JlLmlv/library/D8AB4910-9F0E-431F-9FCE-13B100D18746/theme/BA2604E8-FD0B-46C3-99C0-03793DED642E/

 + NOTE: can use "Chinese Calendar" instead of using custom lunar calendar converter
     > Calendar.Identifier.chinese
    > better performance

 + >> https://github.com/daniel211/LunarCalendarFunctionsInOBJC
 + show list of events of day
 + settings:
    + show lunar date or event stack highlight
    + theme
    + date type (12 or 24h)
    + start of week
 + lunar converter (+)
 + lunar event (+)
 + write tests
 + automation
 + try promisekit, async/await
 + [optional] build macOS app, non currently for am lich
 + dark/light mode (+)
 */

// TODO: convert to use SceneDelegate

// TODO: try SwiftUI

// TODO: Mac app

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
        self.window?.rootViewController = R.storyboard.calendarViewController.instantiateInitialViewController()
        self.window?.makeKeyAndVisible()
    }

    fileprivate func configureLogger() {
        logger.logLevel = .debug
    }
}
