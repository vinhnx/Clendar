//
//  DateHighlightView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 7/4/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import CVCalendar

class DateHighlightView: UIStackView {
    static func viewForDayView(_ dayView: DayView, isOut: Bool) -> UIView? {
        guard SettingsManager.showLunarCalendar else { return nil }
        guard let date = dayView.date.convertedDate() else { return nil }
        
        let lunarDate = DateFormatter.lunarDateString(forDate: date)
        let label = UILabel(frame: CGRect(x: dayView.frame.origin.x, y: dayView.frame.size.height * 0.8,
                                          width: dayView.frame.size.width, height: 10))
        label.textColor = isOut ? .lightGray : .systemGray
        label.font = .sansFontWithSize(11)
        label.text = lunarDate
        label.textAlignment = .center
        return label
    }
}
