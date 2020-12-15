//
//  View+Extensions.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 11/19/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

// reference: https://github.com/onmyway133/blog/issues/604#issue-comment-box
extension View {
	// MARK: - Log

	func log(_ any: Any) -> Self {
		logInfo("\(any)")
		return self
	}
}
