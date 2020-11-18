//
//  EventListItemCell.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import UIKit

class SectionHeaderReusableView: UICollectionReusableView {
	// MARK: Lifecycle

	//

	override init(frame: CGRect) {
		super.init(frame: frame)

		backgroundColor = .clear
		addSubview(titleLabel)

		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			titleLabel.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
		])
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	// MARK: Internal

	//

	static var reuseID = String(describing: SectionHeaderReusableView.self)

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .mediumFontWithSize(15)
		label.adjustsFontForContentSizeCategory = true
		label.textColor = .appDark
		label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		return label
	}()
}

class EventListItemCell: UICollectionViewCell {
	// MARK: Internal

	//

	struct ViewModel {
		// MARK: Lifecycle

		//

		init(event: Event? = nil) {
			guard let event = event?.event else { return }
			message = event.title
			title = event.displayText
			titleAndMessage = "[\(title)] \(message)"
			calendarColor = UIColor(cgColor: event.calendar.cgColor)
			dateDisplay = event.creationDate?.toDateString ?? ""
		}

		// MARK: Internal

		//

		var title: String = ""
		var message: String = ""
		var titleAndMessage: String = ""
		var dateDisplay: String = ""
		var calendarColor: UIColor = .clear
	}

	static var reuseID = String(describing: EventListItemCell.self)

	var viewModel = ViewModel() {
		didSet {
			titleLabel.text = viewModel.titleAndMessage
			barView.backgroundColor = viewModel.calendarColor
		}
	}

	// MARK: Private

	//

	@IBOutlet private var barView: UIView!

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
