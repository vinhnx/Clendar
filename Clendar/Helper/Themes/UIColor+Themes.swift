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
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

extension UIColor {
    static let appGray = UIColor.systemGray
    static let appLightGray = UIColor.systemGray3
    static let nativeLightGray = UIColor.lightGray
    static let appRed = UIColor.systemRed
    static let appDark = UIColor.label
    static let appPlaceholder = UIColor.placeholderText
}

extension UIColor {

    // MARK: - Special Accent Color:

    static let accentBlue = UIColor(hex: "#4787AC")
    static let accentBrown = UIColor(hex: "#A19B91")
    static let accentMilk = UIColor(hex: "#BDB4A8")
    static let accentDarkBrown = UIColor(hex: "#8C5F53")
    static let accentDarkRed = UIColor(hex: "#A0685C")

}
