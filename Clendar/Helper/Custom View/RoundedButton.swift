//
//  RoundedButton.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit
import Haptica

class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    // MARK: - Private

    func configure() {
        if SettingsManager.enableHapticFeedback {
            isHaptic = true
            hapticType = .impact(.light)
        } else {
            isHaptic = false
        }
        
        titleLabel?.font = .boldFontWithSize(20)
        applyCircle()
    }
}
