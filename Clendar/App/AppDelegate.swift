//
//  AppDelegate.swift
//  Clendar
//
//  Created by Vinh Nguyen on 23/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

/*
 TODO:
 + trello: https://trello.com/b/pNJSMOCZ/project-clendar-solar-lunar-convert-ios-calendar-integration-natural-date-input-parsing-personal-use-first
 + color: https://color.adobe.com/cloud/aHR0cHM6Ly9jYy1hcGktYXNzZXRzLmFkb2JlLmlv/library/D8AB4910-9F0E-431F-9FCE-13B100D18746/theme/BA2604E8-FD0B-46C3-99C0-03793DED642E/
 + show list of events of day
 + lunar converter
 + lunar event
 + settings
 + write tests
 + automation
 */

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureWindow()
        return true
    }

    // MARK: - Window

    private func configureWindow() {
        self.window?.rootViewController = R.storyboard.calendarViewController.instantiateInitialViewController()
        self.window?.makeKeyAndVisible()
    }
}
