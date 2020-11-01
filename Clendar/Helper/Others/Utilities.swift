//
//  Utilities.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import UIKit
import Haptica

// MARK: - UI

var isDarkMode: Bool {
    UITraitCollection.current.userInterfaceStyle == .dark
}

// MARK: - Haptic

func genLightHaptic() {
    guard SettingsManager.enableHapticFeedback else { return }
    Haptic.impact(.light).generate()
}

func genErrorHaptic() {
    guard SettingsManager.enableHapticFeedback else { return }
    Haptic.notification(.error).generate()
}

func genSuccessHaptic() {
    guard SettingsManager.enableHapticFeedback else { return }
    Haptic.notification(.success).generate()
}

// MARK: - Others
