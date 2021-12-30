//
//  EventSectionHeaderView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/27/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import UIKit

final class EventSectionHeaderView: UICollectionReusableView {
	// MARK: Lifecycle

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

	static var reuseID = String(describing: EventSectionHeaderView.self)

	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .boldFontWithSize(11)
		label.adjustsFontForContentSizeCategory = true
		label.textColor = .appDark
		label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
		return label
	}()
}
