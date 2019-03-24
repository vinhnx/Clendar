//
//  Collection+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftyChrono

extension Collection {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    /// Reference: http://stackoverflow.com/a/30593673/1477298
    subscript(safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}

extension Array where Element == String {
    var commonText: String {
        var result = [String]()
        for loop in self.enumerated() {
            let lhs = loop.element
            guard let rhs = self[safe: loop.offset + 1] else { continue }
            let sharedText = lhs.commonPrefix(with: rhs, options: .caseInsensitive)
            result.append(sharedText)
        }

        return result.first ?? ""
    }
}

extension Array where Element == ParsedResult {
    // swiftlint:disable large_tuple
    func process(with input: String) -> (action: String, startDate: Date, endDate: Date) {
        var dateTexts = [String]()
        var startDate = Date()
        var endDate = Date()

        for result in self {
            dateTexts.append(result.text)
            startDate = result.start.date
            endDate = result.start.date
        }

        var commonAction = [String]()
        for dateText in dateTexts {
            let text = input.trim(text: dateText)
            commonAction.append(text)
        }

        var action = commonAction.first ?? input

        // find common text between candidates
        if commonAction.count > 1 {
            action = commonAction.commonText
        }

        return (action, startDate, endDate)
    }
    // swiftlint:enable large_tuple
}
