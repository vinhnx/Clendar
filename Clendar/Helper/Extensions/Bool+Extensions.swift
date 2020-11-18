//
//  Bool+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation

extension Bool {
	var asString: String {
		self ? NSLocalizedString("On", comment: "") : NSLocalizedString("Off", comment: "")
	}
}
