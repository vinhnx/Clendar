//
//  BaseNavigationController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 29/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        checkUIMode()

        NotificationCenter.default.addObserver(forName: .didChangeUserInterfacePreferences, object: nil, queue: .main) { _ in
            self.checkUIMode()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Private

    private func setupView() {
        navigationBar.isTranslucent = false
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }

    func checkUIMode() {
        overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
    }
}
