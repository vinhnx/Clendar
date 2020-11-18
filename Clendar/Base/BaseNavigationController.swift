//
//  BaseNavigationController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 29/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
	// MARK: Internal

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
	}

	// MARK: Private

	private func setupView() {
		navigationBar.isTranslucent = false
		navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationBar.shadowImage = UIImage()
	}
}
