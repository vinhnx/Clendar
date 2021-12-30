//
//  DaySupplementaryView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 7/4/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import CVCalendar
import UIKit
import Shift

final class DaySupplementaryView: UIStackView {
    static func viewForDayView(_ dayView: DayView, isOut: Bool, type: DaySupplementaryType = DaySupplementaryType.defaultValue) -> UIView? {
        guard let date = dayView.date.convertedDate() else { return nil }

        switch type {
        case .lunarDate:
            let lunarDate = DateFormatter.lunarDateString(forDate: date)
            let label = UILabel(frame: CGRect(x: dayView.frame.origin.x, y: dayView.frame.size.height * 0.7,
                                              width: dayView.frame.size.width, height: 10))
            label.textColor = isOut ? .lightGray : .systemGray
            label.font = .mediumFontWithSize(10)
            label.text = lunarDate
            label.textAlignment = .center
            return label

        case .none:
            return nil
        }
    }
}
