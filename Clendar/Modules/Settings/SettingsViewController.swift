//
//  SettingsViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 29/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit
import SPLarkController

enum Settings: Int, CaseIterable {
    case darkMode = 0
    case showLunarCalendar
}

final class SettingsViewController: SPLarkSettingsController {

    // MARK: - Override

    override func settingsCount() -> Int {
        return Settings.allCases.count
    }

    override func settingTitle(index: Int, highlighted: Bool) -> String {
        switch index {
        case Settings.darkMode.rawValue: return "Dark mode"
        case Settings.showLunarCalendar.rawValue: return "Lunar date"
        default: return ""
        }
    }

    override func settingSubtitle(index: Int, highlighted: Bool) -> String? {
        switch index {
        case Settings.darkMode.rawValue: return SettingsManager.darkModeActivated.asString
        case Settings.showLunarCalendar.rawValue: return SettingsManager.showLunarCalendar.asString
        default: return nil
        }
    }

    override func settingHighlighted(index: Int) -> Bool {
        switch index {
        case Settings.darkMode.rawValue: return SettingsManager.darkModeActivated
        case Settings.showLunarCalendar.rawValue: return SettingsManager.showLunarCalendar
        default: return false
        }
    }

    override func settingColorHighlighted(index: Int) -> UIColor {
        .appTeal
    }

    override func settingDidSelect(index: Int, completion: @escaping () -> ()) {
        switch index {
        case Settings.darkMode.rawValue:
            SettingsManager.darkModeActivated.toggle()
            NotificationCenter.default.post(name: .didChangeUserInterfacePreferences, object: nil)
            dismiss(animated: true, completion: nil)

        case Settings.showLunarCalendar.rawValue:
            SettingsManager.showLunarCalendar.toggle()
            NotificationCenter.default.post(name: .didChangeShowLunarCalendarPreferences, object: nil)
            dismiss(animated: true, completion: nil)

        default:
            break
        }
    }

}
