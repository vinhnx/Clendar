//
//  LoafWrapper.swift
//  Clendar
//
//  Created by Vinh Nguyen on 06/02/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import UIKit
import Loaf

class Popup {
    static func showErrorMessage(_ message: String, on viewController: UIViewController? = UIViewController.topViewController) {
        show(message, type: Loaf.State.error)
    }

    static func showError(_ error: Error, on viewController: UIViewController? = UIViewController.topViewController) {
        showErrorMessage(error.localizedDescription)
    }

    static func showInfo(_ message: String, on viewController: UIViewController? = UIViewController.topViewController) {
        show(message, type: Loaf.State.info)
    }

    static func showSuccess(_ message: String, on viewController: UIViewController? = UIViewController.topViewController) {
        show(message, type: Loaf.State.success)
    }

    static func showWarning(_ message: String, on viewController: UIViewController? = UIViewController.topViewController) {
        show(message, type: Loaf.State.warning)
    }

    static func show(_ message: String, type: Loaf.State, on viewController: UIViewController? = UIViewController.topViewController) {
        guard let top = viewController else { return }
        Loaf(message, state: type, sender: top)
            .show()
    }
}
