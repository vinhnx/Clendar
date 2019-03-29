//
//  DateParser.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftyChrono

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
            Chrono.preferredLanguage = self.preferredLanguage
        }
    }

    private lazy var chrono = Chrono()

    // MARK: - Public

    func parse(_ input: String) -> InputParserResult? {
        guard input.isEmpty == false else { return nil }
        let results = chrono.parse(text: input)
        let process = results.process(with: input)
        return InputParserResult(action: process.action,
                                 startDate: process.startDate,
                                 endDate: process.endDate)
    }
}
