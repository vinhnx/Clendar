//
//  String+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation

extension String {
    func trim(text: String) -> String {
        return self.replacingOccurrences(of: text, with: "", options: .literal)
    }
}

// https://github.com/vincent-pradeilles/swift-tips#shorter-syntax-to-deal-with-optional-strings
extension Optional where Wrapped == String {
    var orEmpty: String {
        switch self {
        case .some(let value):
            return value
        case .none:
            return ""
        }
    }
}
