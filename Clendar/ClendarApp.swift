//
//  ClendarApp.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftDate
import SwiftUI
import SwiftyStoreKit
import Shift
import WhatsNewKit

// swiftlint:disable:next private_over_fileprivate
fileprivate var shortcutItemToProcess: UIApplicationShortcutItem?

@main
struct ClendarApp: App {

    // swiftlint:disable:next weak_delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) var phase
    @StateObject private var store = SharedStore()

    init() {
        configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.whatsNew,
                     .init(
                        // Specify in which way the presented WhatsNew Versions are stored.
                        // In default the `UserDefaultsWhatsNewVersionStore` is used.
                        versionStore: UserDefaultsWhatsNewVersionStore(),

                        // Pass a `WhatsNewCollectionProvider` or an array of WhatsNew instances
                        whatsNewCollection: self
                     )
                )
                .environmentObject(store)
                .onContinueUserActivity(Constants.SiriShortcut.addEvent) { (_) in
                    store.showCreateEventState = true
                }
                .onContinueUserActivity(Constants.SiriShortcut.openSettings) { (_) in
                    store.showSettingsState = true
                }
                .onContinueUserActivity(Constants.SiriShortcut.openShortcutsView) { (_) in
                    store.showSiriShortcuts = true
                }
        }
        .onChange(of: phase) { (newPhase) in
            switch newPhase {
            case .active:
                // store.selectedDate = Date() // reset selected date to current date on active

                guard let name = shortcutItemToProcess?.userInfo?[Constants.addEventQuickActionKey] as? String else { return }

                defer { shortcutItemToProcess = nil } // IMPORTANT: reset shortcutItem instance to clear action

                switch name {
                case Constants.addEventQuickActionID:
                    store.showCreateEventState = true
                default:
                    break
                }

            case .background:
                addQuickActions()

            case .inactive: break
            @unknown default: break
            }
        }
        .commands {
            CommandGroup(replacing: .newItem) {
                Button("Create new event") {
                    store.showCreateEventState = true
                }.keyboardShortcut("n", modifiers: [.command])

                Button("Switch to current date") {
                    store.selectedDate = Date()
                }.keyboardShortcut("h", modifiers: [.command, .shift])
            }

            CommandGroup(after: .appInfo) {
                Button("Preferences") {
                    store.showSettingsState = true
                }.keyboardShortcut(",", modifiers: [.command])
            }
        }
    }
}

extension ClendarApp {

    // MARK: - Private

    private func configure() {
#if os(iOS)
        UIApplication.shared.applicationIconBadgeNumber = 0
        UITableView.appearance().showsVerticalScrollIndicator = false
#endif

        setupStoreKit()
        logger.logLevel = .debug
        
        if SettingsManager.currentAppTheme == AppTheme.dark.rawValue {
            SettingsManager.darkModeActivated = isDarkMode
        }

        Shift.configureWithAppName(AppInfo.appName)
    }

    private func setupStoreKit() {
        // this is App Store purchase handling
        // ref: https://github.com/bizz84/SwiftyStoreKit/wiki/App-Store-Purchases

        // handle transaction
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }

                    // Unlock content
                    NotificationCenter.default.post(name: .inAppPurchaseSuccess, object: nil)
                case .failed, .purchasing, .deferred:
                    break // do nothing
                @unknown default:
                    break
                }
            }
        }

        // handle App Store transaction
        SwiftyStoreKit.shouldAddStorePaymentHandler = { _, product in
            // return true if the content can be delivered by your app
            // return false otherwise
            PurchaseProductIdentifier.allCases.compactMap { $0.rawValue }.contains(product.productIdentifier)
        }
    }

    /**
     During the transition to a background state is a good time to update any dynamic quick actions because this code is always executed before the user returns to the Home screen.
     */
    private func addQuickActions() {
        var userInfo: [String: NSSecureCoding] {
            [Constants.addEventQuickActionKey : Constants.addEventQuickActionID as NSSecureCoding]
        }

        UIApplication.shared.shortcutItems = [
            UIApplicationShortcutItem(
                type: Constants.addEventQuickActionID,
                localizedTitle: NSLocalizedString("New Event", comment: ""),
                localizedSubtitle: nil,
                icon: UIApplicationShortcutIcon(type: .compose),
                userInfo: userInfo
            )
        ]
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        if let shortcutItem = options.shortcutItem {
            shortcutItemToProcess = shortcutItem
        }

        let sceneConfiguration = UISceneConfiguration(name: "Custom Configuration", sessionRole: connectingSceneSession.role)
        sceneConfiguration.delegateClass = CustomSceneDelegate.self
        return sceneConfiguration
    }
}

class CustomSceneDelegate: UIResponder, UIWindowSceneDelegate {
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        shortcutItemToProcess = shortcutItem
    }
}
