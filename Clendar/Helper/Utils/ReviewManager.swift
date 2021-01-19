//
//  ReviewManager.swift
//  Clendar
//
//  Created by Vinh Nguyen on 09/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import Foundation
import StoreKit

// reference: https://www.donnywals.com/optimizing-your-applications-reviews/
struct ReviewManager {
    let userDefaults: UserDefaults
    let minimumInstallTime: TimeInterval = 60 * 60 * 24 * 1 // 1 days
    let minimumLaunches = 3

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func trackLaunch() {
        if userDefaults.double(forKey: "firstLaunch") == 0.0 {
            userDefaults.set(Date().timeIntervalSince1970, forKey: "firstLaunch")
        }

        let numberOfLaunches = userDefaults.integer(forKey: "numberOfLaunches")
        userDefaults.set(numberOfLaunches + 1, forKey: "numberOfLaunches")
    }

    func askForReviewIfNeeded() {
        guard shouldAskForReview()
        else { return }

        // https://stackoverflow.com/a/63954318/1477298
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }

    private func shouldAskForReview() -> Bool {
        let timeInstalled = Date().timeIntervalSince1970 - userDefaults.double(forKey: "firstLaunch")
        let numberOfLaunches = userDefaults.integer(forKey: "numberOfLaunches")

        guard timeInstalled > minimumInstallTime,
              numberOfLaunches >= minimumLaunches
        else { return false }

        return true
    }
}
