//  UIColor+Themes.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/22/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import UIKit

extension UIColor {
    var swiftUIColor: Color {
        Color(self)
    }

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
    static let appGray = UIColor.gray
    static let appLightGray = UIColor.lightGray
    static let appRed = UIColor.moianesD
    static let appLightRed = UIColor.appRed.withAlphaComponent(0.5)
    static var appDark: UIColor {
        #if os(iOS)
        return UIColor { color in color.userInterfaceStyle == .dark ? .appLightGray : .darkGray }
        #else
        return .darkGray
        #endif
    }

    static var backgroundColor: UIColor {
        #if os(iOS)
        return UIColor { color in
            switch SettingsManager.currentAppTheme {
            case AppTheme.light.rawValue: return .hueC
            case AppTheme.trueLight.rawValue: return .white
            case AppTheme.dark.rawValue: return .lavixA
            case AppTheme.trueDark.rawValue: return .black
            case AppTheme.E4ECF5.rawValue: return UIColor(hex: "E4ECF5")
            default:
                return color.userInterfaceStyle == .dark ? .lavixA : .hueC
            }
        }
        #else
        return .hueC
        #endif
    }

    static var inversedBackgroundColor: UIColor {
        #if os(iOS)
        return UIColor { color in color.userInterfaceStyle == .dark ? .hueC : .lavixA }
        #else
        return .hueC
        #endif
    }

    static var primaryColor: UIColor {
        #if os(iOS)
        return UIColor { color in color.userInterfaceStyle == .dark ? .hueA : .hueD }
        #else
        return .hueA
        #endif
    }

    static var secondaryColor: UIColor {
        #if os(iOS)
        return UIColor { color in color.userInterfaceStyle == .dark ? .hueD : .hueA }
        #else
        return .hueD
        #endif
    }

    static var buttonTintColor: UIColor {
        #if os(iOS)
        return UIColor { color in color.userInterfaceStyle == .dark ? .hueB : .hueC }
        #else
        return .hueB
        #endif
    }

    static var detructiveColor: UIColor { .moianesD }

    static var confirmationColor: UIColor { .moianesA }
}

// MARK: - LIGHT THEME

extension UIColor {
    // MARK: - Hue https://color.adobe.com/hue-color-theme-16137798

    static let hueA = UIColor(hex: "949EA8")
    static let hueB = UIColor(hex: "E4ECF5")
    static let hueC = UIColor(hex: "F6F5F0")
    static let hueD = UIColor(hex: "A094A8")
    static let hueE = UIColor(hex: "EBDCF5")
}

extension UIColor {
    // MARK: - Repi https://color.adobe.com/Repi-color-theme-16137836

    static let repiA = UIColor(hex: "D9D9D9")
    static let repiB = UIColor(hex: "F2F2F2")
    static let repiC = UIColor(hex: "737373")
    static let repiD = UIColor(hex: "8C8C8C")
    static let repiE = UIColor(hex: "78BFBF")
}

// MARK: - DARK THEME

extension UIColor {
    // MARK: - Moianes https://color.adobe.com/Copy-of-Moianes-color-theme-3262188

    static let moianesA = UIColor(hex: "273F3F")
    static let moianesB = UIColor(hex: "C4B087")
    static let moianesC = UIColor(hex: "87775A")
    static let moianesD = UIColor(hex: "993D31")
    static let moianesE = UIColor(hex: "382C21")
}

extension UIColor {
    // MARK: - Lavix https://color.adobe.com/color-theme-2694557

    static let lavixA = UIColor(hex: "1F2126")
    static let lavixB = UIColor(hex: "192640")
    static let lavixC = UIColor(hex: "386273")
    static let lavixD = UIColor(hex: "818C7B")
    static let lavixE = UIColor(hex: "BBBF99")
}

extension Color {
    static let appGray = Color(.appGray)
    static let appLightGray = Color(.appLightGray)
    static let appRed = Color(.appRed)
    static let appLightRed = Color(.appLightRed)
    static let appDark = Color(.appDark)
    static var backgroundColor = Color(.backgroundColor)
    static var inversedBackgroundColor = Color(.inversedBackgroundColor)
    static var primaryColor = Color(.primaryColor)
    static var secondaryColor = Color(.secondaryColor)
    static var buttonTintColor = Color(.buttonTintColor)
    static var detructiveColor = Color(.detructiveColor)
    static var confirmationColor = Color(.confirmationColor)
}

var appColorScheme: ColorScheme {
    #if os(watchOS)
    return ColorScheme.dark
    #else
    switch SettingsManager.currentAppTheme {
    case AppTheme.light.rawValue,
         AppTheme.trueLight.rawValue,
         AppTheme.E4ECF5.rawValue:
        return .light
    case AppTheme.dark.rawValue,
         AppTheme.trueDark.rawValue:
        return .dark
    default:
        return .dark
    }
    #endif
}
