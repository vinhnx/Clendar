//
//  SettingsWrapperView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

#warning("// TODO: SwiftUI migration")

struct SettingsWrapperView: UIViewControllerRepresentable {
	func makeUIViewController(context _: Context) -> SettingsNavigationController {
		SettingsNavigationController()
	}

	func updateUIViewController(_: SettingsNavigationController, context _: Context) {}
}
