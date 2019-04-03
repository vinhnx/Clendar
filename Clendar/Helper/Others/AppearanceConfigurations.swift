//
//  CalendarColor.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

// swiftlint:disable force_unwrapping
struct FontConfig {
    static func regularFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Medium", size: size)!
    }

    static func boldFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNext-Bold", size: size)!
    }
}
// swiftlint:enable force_unwrapping

struct CalendarColorsConfig {
    static let selectedText = UIColor.white
    static let text = UIColor.darkGray
    static let textDisabled = text.withAlphaComponent(0.5)
    static let selectionBackground = UIColor.red
    static let sundayText = UIColor.red
    static let sundayTextDisabled = sundayText.withAlphaComponent(0.5)
    static let sundaySelectionBackground = sundayText
}
