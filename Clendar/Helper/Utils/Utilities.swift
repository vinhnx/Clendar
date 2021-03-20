//
//  Utilities.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Haptica
import SwiftUI
import UIKit

// MARK: - UI

var isDarkMode: Bool {
	UITraitCollection.current.userInterfaceStyle == .dark
}

// MARK: - Haptic

func genLightHaptic() {
	guard SettingsManager.enableHapticFeedback else { return }
    Haptic.impact(.soft).generate()
}

func genErrorHaptic() {
	guard SettingsManager.enableHapticFeedback else { return }
	Haptic.notification(.error).generate()
}

func genSuccessHaptic() {
	guard SettingsManager.enableHapticFeedback else { return }
	Haptic.notification(.success).generate()
}
