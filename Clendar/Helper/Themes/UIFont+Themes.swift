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

    static func serifFontWithSize(_ size: CGFloat) -> UIFont {
        UIFont(name: "Georgia", size: size) ?? .sansFontWithSize(size)
    }

    static func sansFontWithSize(_ size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        .systemFont(ofSize: size, weight: weight)
    }

}
