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
}

final class SettingsViewController: SPLarkSettingsController {

    // MARK: - Override

    override func settingsCount() -> Int {
        return Settings.allCases.count
    }

    override func settingTitle(index: Int, highlighted: Bool) -> String {
        switch index {
        case Settings.darkMode.rawValue:
            return "Dark mode"
        default:
            return ""
        }
    }

    override func settingSubtitle(index: Int, highlighted: Bool) -> String? {
        switch index {
        case Settings.darkMode.rawValue:
            return ThemeManager.darkModeActivated ? "On" : "Off"
        default:
            return nil
        }
    }

    override func settingHighlighted(index: Int) -> Bool {
        switch index {
        case Settings.darkMode.rawValue:
            return ThemeManager.darkModeActivated
        default:
            return false
        }
    }

    override func settingColorHighlighted(index: Int) -> UIColor {
        switch index {
        case Settings.darkMode.rawValue:
            return .appTeal
        default:
            return .clear
        }
    }

    override func settingDidSelect(index: Int, completion: @escaping () -> ()) {
        switch index {
        case Settings.darkMode.rawValue:
            ThemeManager.darkModeActivated.toggle()
            NotificationCenter.default.post(name: .didChangeUserInterfacePreferences, object: nil)
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }

}
