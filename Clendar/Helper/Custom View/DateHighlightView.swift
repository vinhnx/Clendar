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
    static func viewForDayView(_ dayView: DayView) -> DateHighlightView? {
        guard let date = dayView.date.convertedDate() else { return nil }
        let size: CGFloat = 5.0
        let view = DateHighlightView(frame: CGRect(x: dayView.frame.origin.x,
                                                   y: dayView.frame.size.height,
                                                   width: dayView.frame.size.width * 0.9,
                                                   height: size))
        view.axis = .horizontal
        view.distribution = .fillEqually
        EventHandler.shared.fetchEvents(for: date) { (result) in
            switch result {
            case .success(let events):
                for event in events {
                    let colorView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
                    colorView.backgroundColor = UIColor.init(cgColor: event.calendar.cgColor)
                    colorView.applyCircle()
                    view.addArrangedSubview(colorView)
                }

            case .failure:
                break
            }
        }

        return view
    }
}
