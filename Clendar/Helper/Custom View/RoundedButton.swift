//
//  RoundedButton.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }

    // MARK: - Private

    func configure() {
        self.titleLabel?.font = UIFont.boldFontWithSize(20)
        self.applyCircle()
    }
}
