//  UIColor+Themes.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/22/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import UIKit

extension UIColor {
    public var swiftUIColor: Color {
        Color(self)
    }

    public convenience init(hex: String) {
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
    public static let appGray = UIColor.gray
    public static let appLightGray = UIColor.lightGray
    public static let appRed = UIColor.moianesD
    public static let appLightRed = UIColor.appRed.withAlphaComponent(0.5)
    public static var appDark: UIColor {
        #if os(iOS)
        return UIColor { color in color.userInterfaceStyle == .dark ? .appLightGray : .darkGray }
        #else
        return .darkGray
        #endif
    }

    public static var inversedBackgroundColor: UIColor {
        #if os(iOS)
        return UIColor { color in color.userInterfaceStyle == .dark ? .hueC : .lavixA }
        #else
        return .hueC
        #endif
    }

    public static var primaryColor: UIColor {
        #if os(iOS)
        return UIColor { color in color.userInterfaceStyle == .dark ? .hueA : .hueD }
        #else
        return .hueA
        #endif
    }

    public static var secondaryColor: UIColor {
        #if os(iOS)
        return UIColor { color in color.userInterfaceStyle == .dark ? .hueD : .hueA }
        #else
        return .hueD
        #endif
    }

    public static var buttonTintColor: UIColor {
        #if os(iOS)
        return UIColor { color in color.userInterfaceStyle == .dark ? .hueB : .hueC }
        #else
        return .hueB
        #endif
    }

    public static var detructiveColor: UIColor { .moianesD }

    public static var confirmationColor: UIColor { .moianesA }
}

// MARK: - LIGHT THEME

extension UIColor {
    // MARK: - Hue https://color.adobe.com/hue-color-theme-16137798

    public static let hueA = UIColor(hex: "949EA8")
    public static let hueB = UIColor(hex: "E4ECF5")
    public static let hueC = UIColor(hex: "F6F5F0")
    public static let hueD = UIColor(hex: "A094A8")
    public static let hueE = UIColor(hex: "EBDCF5")
}

extension UIColor {
    // MARK: - Repi https://color.adobe.com/Repi-color-theme-16137836

    public static let repiA = UIColor(hex: "D9D9D9")
    public static let repiB = UIColor(hex: "F2F2F2")
    public static let repiC = UIColor(hex: "737373")
    public static let repiD = UIColor(hex: "8C8C8C")
    public static let repiE = UIColor(hex: "78BFBF")
}

// MARK: - DARK THEME

extension UIColor {
    // MARK: - Moianes https://color.adobe.com/Copy-of-Moianes-color-theme-3262188

    public static let moianesA = UIColor(hex: "273F3F")
    public static let moianesB = UIColor(hex: "C4B087")
    public static let moianesC = UIColor(hex: "87775A")
    public static let moianesD = UIColor(hex: "993D31")
    public static let moianesE = UIColor(hex: "382C21")
}

extension UIColor {
    // MARK: - Lavix https://color.adobe.com/color-theme-2694557

    public static let lavixA = UIColor(hex: "1F2126")
    public static let lavixB = UIColor(hex: "192640")
    public static let lavixC = UIColor(hex: "386273")
    public static let lavixD = UIColor(hex: "818C7B")
    public static let lavixE = UIColor(hex: "BBBF99")
}

extension Color {
    public static let appGray = Color(.appGray)
    public static let appLightGray = Color(.appLightGray)
    public static let appRed = Color(.appRed)
    public static let appLightRed = Color(.appLightRed)
    public static let appDark = Color(.appDark)
    public static var inversedBackgroundColor = Color(.inversedBackgroundColor)
    public static var primaryColor = Color(.primaryColor)
    public static var secondaryColor = Color(.secondaryColor)
    public static var buttonTintColor = Color(.buttonTintColor)
    public static var detructiveColor = Color(.detructiveColor)
    public static var confirmationColor = Color(.confirmationColor)
}
