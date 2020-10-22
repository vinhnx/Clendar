//
//  UIFont+Themes.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/22/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static func fontWithSize(_ size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        return .systemFont(ofSize: size, weight: weight)
    }

    static func regularFontWithSize(_ size: CGFloat) -> UIFont {
        return fontWithSize(size, weight: .regular)
    }

    static func boldFontWithSize(_ size: CGFloat) -> UIFont {
        return fontWithSize(size, weight: .bold)
    }
}
