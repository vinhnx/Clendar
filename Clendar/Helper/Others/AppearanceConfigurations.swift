//
//  CalendarColor.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

struct FontConfig {
    static func regularFontWithSize(_ size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .medium)
    }

    static func boldFontWithSize(_ size: CGFloat) -> UIFont {
        return .boldSystemFont(ofSize: size)
    }
}

struct CalendarColorsConfig {
    static let selectedText = UIColor.white
    static let text = UIColor.darkGray
    static let textDisabled = text.withAlphaComponent(0.5)
    static let selectionBackground = UIColor.red
    static let sundayText = UIColor.red
    static let sundayTextDisabled = sundayText.withAlphaComponent(0.5)
    static let sundaySelectionBackground = sundayText
}
