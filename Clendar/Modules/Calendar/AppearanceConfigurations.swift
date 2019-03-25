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
        return UIFont(name: "Futura", size: size)!
    }

    static func boldFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Futura-Bold", size: size)!
    }

    static func mediumFontWithSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Futura-Medium", size: size)!
    }
}
// swiftlint:enable force_unwrapping

struct CalendarColorsConfig {
    static let selectedText = UIColor.white
    static let text = UIColor.darkGray
    static let textDisabled = UIColor.gray
    static let selectionBackground = UIColor(red: 0.2, green: 0.2, blue: 1.0, alpha: 1.0)
    static let sundayText = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0)
    static let sundayTextDisabled = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0)
    static let sundaySelectionBackground = sundayText
}
