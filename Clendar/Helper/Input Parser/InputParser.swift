//
//  DateParser.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftyChrono
import SwiftDate

final class InputParser {

    // MARK: - Model

    struct InputParserResult {
        var action: String
        var startDate: Date
        var endDate: Date
    }

    // MARK: - Properties

    var preferredLanguage: Language = .english {
        didSet {
            Chrono.preferredLanguage = preferredLanguage
        }
    }

    private lazy var chrono = Chrono()

    // MARK: - Public

    func parse(_ input: String) -> InputParserResult? {
        guard input.isEmpty == false else { return nil }
        let results = chrono.parse(text: input)
        let process = results.process(with: input)
        let startDate = process.startDate
        let endDate = process.endDate
        
//        // to chinese date
//        log("normal date: \(startDate)")
//        log("chinese date: \(startDate.toChineseDate)")

        return InputParserResult(action: process.action,
                                 startDate: startDate,
                                 endDate: endDate)
    }
}
