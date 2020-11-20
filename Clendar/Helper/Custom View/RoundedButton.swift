//
//  RoundedButton.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

class CDButton: UIButton {
	// MARK: Lifecycle

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		configure()
	}

	// MARK: Internal

	func configure() {
		titleLabel?.font = .boldFontWithSize(20)
		applyCircle()
	}
}
