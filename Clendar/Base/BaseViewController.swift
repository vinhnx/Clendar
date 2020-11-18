//
//  BaseViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 23/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
	// MARK: Lifecycle

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	// MARK: Internal

	override func viewDidLoad() {
		super.viewDidLoad()

		checkUIMode()

		NotificationCenter.default.addObserver(forName: .didChangeUserInterfacePreferences, object: nil, queue: .main) { _ in
			self.checkUIMode()
		}
	}

	func checkUIMode() {
		overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
	}
}
