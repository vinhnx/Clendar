//
//  EventListItemCell.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import UIKit

class EventListItemCell: UICollectionViewCell {

    // MARK: - ViewModel

    struct ViewModel {
        var title: String = ""
        var message: String = ""
        var titleAndMessage: String = ""
        var dateDisplay: String = ""
        var calendarColor: UIColor = .clear

        init(event: Event? = nil) {
            guard let event = event?.event else { return }
            message = event.title
            title = event.displayText()
            titleAndMessage = "[\(title)] \(message)"
            calendarColor = UIColor(cgColor: event.calendar.cgColor)
            dateDisplay = event.startDate?.toDateString ?? ""
        }
    }

    var viewModel = ViewModel() {
        didSet {
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
            titleLabel.font = .fontWithSize(15, weight: .medium)
            titleLabel.textColor = .appGray
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.adjustsFontForContentSizeCategory = true
            titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        }
    }

}
