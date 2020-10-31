//
//  DaySupplementaryView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 7/4/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit
import CVCalendar

class DaySupplementaryView: UIStackView {
    static func viewForDayView(_ dayView: DayView, isOut: Bool, type: DaySupplementaryType = DaySupplementaryType.defaultValue) -> UIView? {
        guard let date = dayView.date.convertedDate() else { return nil }

        switch type {
        case .lunarDate:
            let lunarDate = DateFormatter.lunarDateString(forDate: date)
            let label = UILabel(frame: CGRect(x: dayView.frame.origin.x, y: dayView.frame.size.height * 0.8,
                                              width: dayView.frame.size.width, height: 10))
            label.textColor = isOut ? .lightGray : .systemGray
            label.font = .regularFontWithSize(11)
            label.text = lunarDate
            label.textAlignment = .center
            return label

        case .oneDot:
            let size: CGFloat = 5.0
            let view = DaySupplementaryView(frame: CGRect(x: dayView.center.x, y: dayView.frame.origin.y, width: size, height: size))
            view.axis = .horizontal
            view.distribution = .fill
            EventKitWrapper.shared.fetchEvents(for: date) { (result) in
                switch result {
                case .success(let events):
                    if events.isEmpty == false {
                        let colorView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
                        colorView.backgroundColor = UIColor.primaryColor
                        colorView.applyCircle()
                        view.addArrangedSubview(colorView)
                    }

                case .failure(let error): logError(error)
                }
            }

            return view

        case .none:
            return nil
        }
    }
}
