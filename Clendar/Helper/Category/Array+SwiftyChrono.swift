//
//  Array+SwiftyChrono.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftyChrono

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

        let action = commonAction.isEmpty == false ? commonAction.commonText : input
        return (action, startDate, endDate)
    }
    // swiftlint:enable large_tuple
}
