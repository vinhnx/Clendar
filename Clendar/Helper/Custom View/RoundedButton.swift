//
//  RoundedButton.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation

class Button: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        titleLabel?.font = FontConfig.mediumFontWithSize(20)
    }
}
