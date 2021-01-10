//
//  String+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import UIKit

extension String {
	func trim(text: String) -> String {
		replacingOccurrences(of: text, with: "", options: .literal)
	}
}

// https://github.com/vincent-pradeilles/swift-tips#shorter-syntax-to-deal-with-optional-strings
extension Optional where Wrapped == String {
	var orEmpty: String {
		switch self {
		case let .some(value):
			return value
		case .none:
			return ""
		}
	}
}

extension String {
	func parseInt() -> Int? {
        // ref: https://stackoverflow.com/questions/30342744/swift-how-to-get-integer-from-string-and-convert-it-into-integer
		Int(components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
	}

	var asImage: UIImage? { UIImage(named: self) }
}
