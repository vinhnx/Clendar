//
//  Font+Styles.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/22/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import UIKit

extension UIFont {
    public static func fontWithSize(_ size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        let font: UIFont

        if #available(iOS 13.0, *) {
            if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
                font = UIFont(descriptor: descriptor, size: size)
            } else {
                font = systemFont
            }
        } else {
            font = systemFont
        }

        return font
    }

    public static func regularFontWithSize(_ size: CGFloat) -> UIFont {
        fontWithSize(size)
    }

    public static func boldFontWithSize(_ size: CGFloat) -> UIFont {
        fontWithSize(size, weight: .bold)
    }

    public static func semiboldFontWithSize(_ size: CGFloat) -> UIFont {
        fontWithSize(size, weight: .semibold)
    }

    public static func mediumFontWithSize(_ size: CGFloat) -> UIFont {
        fontWithSize(size, weight: .medium)
    }
}

extension Font {
    public static func fontWithSize(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        Font.system(size: size, weight: weight, design: .rounded)
    }

    public static func regularFontWithSize(_ size: CGFloat) -> Font {
        .fontWithSize(size, weight: .regular)
    }

    public static func boldFontWithSize(_ size: CGFloat) -> Font {
        .fontWithSize(size, weight: .bold)
    }

    public static func semiboldFontWithSize(_ size: CGFloat) -> Font {
        .fontWithSize(size, weight: .semibold)
    }

    public static func mediumFontWithSize(_ size: CGFloat) -> Font {
        .fontWithSize(size, weight: .medium)
    }
}
