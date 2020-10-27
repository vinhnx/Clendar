//
//  TextField.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

class TextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        font = .regularFontWithSize(20)
        backgroundColor = .backgroundColor
        attributedPlaceholder = NSAttributedString(string: (placeholder ?? ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor.appPlaceholder])
    }
}
