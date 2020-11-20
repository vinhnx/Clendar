//
//  CDTextField.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

class CDTextField: UITextField {
	override func awakeFromNib() {
		super.awakeFromNib()
		font = .mediumFontWithSize(18)
		backgroundColor = .backgroundColor
		attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.appPlaceholder])
	}
}
