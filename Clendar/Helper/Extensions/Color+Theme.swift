//
//  UIColor+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 26/02/2022.
//  Copyright © 2022 Vinh Nguyen. All rights reserved.
//

import UIKit
import SwiftUI
import ClendarTheme

extension UIColor {
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
        return SettingsManager.darkModeActivated ? .dark : .light
    }
#endif
}

extension Color {
    static var backgroundColor = { return Color(.backgroundColor) }
}
