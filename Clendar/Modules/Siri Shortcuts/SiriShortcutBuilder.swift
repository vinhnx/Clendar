//
//  SiriShortcutBuilder.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import UIKit
import Intents
import CoreSpotlight
import MobileCoreServices

struct ShortcutBuilder {
    static let addEventShortcut: INShortcut = {
        makeSiriShortcut(
            id: Constants.SiriShortcut.addEvent,
            title: R.string.localizable.createNewClendarEventS(),
            phase: R.string.localizable.newClendarEvent()
        )
    }()

    static let openSettingsShortcut: INShortcut = {
        makeSiriShortcut(
            id: Constants.SiriShortcut.openSettings,
            title: R.string.localizable.openClendarSettings(),
            phase: R.string.localizable.openSettings()
        )
    }()

    static let openSiriShortcut: INShortcut = {
        makeSiriShortcut(
            id: Constants.SiriShortcut.openShortcutsView,
            title: R.string.localizable.showSiriShortcutsView(),
            phase: R.string.localizable.openClendarSiriShortcuts()
        )
    }()

    // MARK: - Builder

    static func makeSiriShortcut(id: String, title: String, phase: String) -> INShortcut {
        let activity = NSUserActivity(activityType: id)
        activity.isEligibleForPrediction = true
        activity.isEligibleForSearch = true
        activity.persistentIdentifier = NSUserActivityPersistentIdentifier(id)
        activity.title = title
        activity.suggestedInvocationPhrase = phase

        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        attributes.thumbnailData = UIImage(named: "spotlight_icon")?.jpegData(compressionQuality: 1.0)
        activity.contentAttributeSet = attributes
        activity.becomeCurrent()
        return INShortcut(userActivity: activity)
    }
}
