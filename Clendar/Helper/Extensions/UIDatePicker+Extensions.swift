//
//  UIDatePicker+Extensions.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 10/28/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import UIKit

extension UIDatePicker {

    func configurePreferredDatePickerStyle() {
        if #available(iOS 14.0, *) {
            preferredDatePickerStyle = .inline
        } else if #available(iOS 13.4, *) {
            preferredDatePickerStyle = .automatic
        }
    }

}
