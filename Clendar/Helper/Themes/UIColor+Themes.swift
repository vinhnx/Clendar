//
//  UIColor+Themes.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/22/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIColor {
    static let appGray = UIColor.systemGray
    static let appLightGray = UIColor.systemGray3
    static let nativeLightGray = UIColor.lightGray
    static let appRed = UIColor.systemRed.withAlphaComponent(0.8)
    static let appLightRed = UIColor.systemRed.withAlphaComponent(0.3)
    static let appDark = UIColor.label
    static let appPlaceholder = UIColor.placeholderText
    static let appIndigo = UIColor.systemIndigo
    static let appTeal = UIColor.systemTeal

    static var backgroundColor: UIColor {
        UIColor { trait in trait.userInterfaceStyle == .dark ? .systemBackground : .pastelC }
    }

    static var primaryColor: UIColor {
        UIColor { trait in trait.userInterfaceStyle == .dark ? .pastelA : .pastelD }
    }

    static var secondaryColor: UIColor {
        UIColor { trait in trait.userInterfaceStyle == .dark ? .pastelD : .pastelA }
    }

    static var buttonTintColor: UIColor {
        UIColor { trait in trait.userInterfaceStyle == .dark ? .pastelB : .pastelC }
    }
}

extension UIColor {

    // MARK: - Pastel

    static let pastelA = UIColor(hex: "949EA8")
    static let pastelB = UIColor(hex: "E4ECF5")
    static let pastelC = UIColor(hex: "F6F5F0")
    static let pastelD = UIColor(hex: "A094A8")
    static let pastelE = UIColor(hex: "EBDCF5")

}
