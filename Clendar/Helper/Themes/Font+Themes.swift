//
//  UIFont+Themes.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/22/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

extension UIFont {
	static func fontWithSize(_ size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
		.systemFont(ofSize: size, weight: weight)
	}

	static func regularFontWithSize(_ size: CGFloat) -> UIFont {
		fontWithSize(size)
	}

	static func boldFontWithSize(_ size: CGFloat) -> UIFont {
		fontWithSize(size, weight: .bold)
	}

	static func semiboldFontWithSize(_ size: CGFloat) -> UIFont {
		fontWithSize(size, weight: .semibold)
	}

	static func mediumFontWithSize(_ size: CGFloat) -> UIFont {
		fontWithSize(size, weight: .medium)
	}
}

extension Font {
	static func fontWithSize(_ size: CGFloat, weight: UIFont.Weight = .regular) -> Font {
		Font(UIFont.fontWithSize(size, weight: weight))
	}

	static func regularFontWithSize(_ size: CGFloat) -> Font {
		Font(UIFont.fontWithSize(size))
	}

	static func boldFontWithSize(_ size: CGFloat) -> Font {
		Font(UIFont.fontWithSize(size, weight: .bold))
	}

	static func semiboldFontWithSize(_ size: CGFloat) -> Font {
		Font(UIFont.fontWithSize(size, weight: .semibold))
	}

	static func mediumFontWithSize(_ size: CGFloat) -> Font {
		Font(UIFont.fontWithSize(size, weight: .medium))
	}
}
