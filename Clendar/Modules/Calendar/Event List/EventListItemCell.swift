//
//  EventListItemCell.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftDate
import UIKit

class EventListItemCell: UICollectionViewCell {

    // MARK: - ViewModel

    struct ViewModel {
        var title: String = ""
        var message: String = ""
        var titleAndMessage: String = ""
        var dateDisplay: String = ""
        var calendarColor: UIColor = .clear
        var textColor: UIColor = .appGray

        init(event: Event? = nil) {
            guard let event = event?.event else { return }
            message = event.title
            title = event.durationText()
            titleAndMessage = "[\(title)] \(message)"
            let color = UIColor(cgColor: event.calendar.cgColor)
            calendarColor = event.startDate.isInPast ? color.withAlphaComponent(0.3) : color
            dateDisplay = event.startDate?.toDateString ?? ""
            textColor = event.startDate.isInPast ? .appLightGray : .appGray
        }
    }

    var viewModel = ViewModel() {
        didSet {
            titleLabel.textColor = viewModel.textColor
            titleLabel.text = viewModel.titleAndMessage
            barView.backgroundColor = viewModel.calendarColor
        }
    }

    // MARK: - Views

    static var reuseID = String(describing: EventListItemCell.self)

    @IBOutlet private var barView: UIView! {
        didSet { barView.applyCornerRadius() }
    }

    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 2
            titleLabel.font = .mediumFontWithSize(13)
            titleLabel.textColor = .appGray
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.adjustsFontForContentSizeCategory = true
            titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        }
    }

}
