//
//  View+Extensions.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 11/19/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

extension View {
	/// Fix safe area background color
	/// - Parameter backgroundColor: color
	/// - Returns: View
	func styleModalBackground(_ backgroundColor: Color) -> some View {
		preferredColorScheme(appColorScheme)
			.background(backgroundColor.edgesIgnoringSafeArea(.all))
	}
}

// reference: https://github.com/onmyway133/blog/issues/604#issue-comment-box
extension View {
	// MARK: - Log

	func log(_ any: Any) -> Self {
		logInfo("\(any)")
		return self
	}
}
