//
//  AlertManager.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

extension UIAlertController {
    /// If top most controller is `UIAlertController`, then dismiss it and show.
    /// Else, we show the alert normally.
    func dismissAndShow() {
        func _present(_ controller: UIAlertController) {
            UINavigationController.topViewController?.present(controller, animated: true, completion: nil)
        }

        guard AlertManager.shouldShowAlert else { return }
        if let alert = UINavigationController.topViewController as? UIAlertController {
            alert.safeDismiss {
                _present(alert)
            }
        } else {
            _present(self)
        }
    }
}

final class AlertManager {

    /// Attempt not to show overlapped alert instances
    static var shouldShowAlert: Bool {
        return UINavigationController.topViewController is UIAlertController == false
    }

    // MARK: - System alert/action sheet

    /// Show action sheet
    ///
    /// - Parameters:
    ///   - title: the title string
    ///   - message: the message string
    ///   - actionTitle: the action title string
    ///   - okAction: the completion handler to execute when user tap on "OK"
    ///   - onCancel: the completion handler to execute when user tap on "Cancel"
    static func showActionSheet(title: String? = calendarName, message: String, actionTitle: String, okAction: VoidHandler? = nil, onCancel: VoidHandler? = nil) {
        DispatchQueue.main.async {
            guard shouldShowAlert else { return }
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                onCancel.flatMap { $0() }
            }

            alertController.addAction(cancelAction)
            let openAction = UIAlertAction(title: actionTitle, style: .default) { _ in
                okAction.flatMap { $0() }
            }
            alertController.addAction(openAction)

            UINavigationController.topViewController?.present(alertController, animated: true, completion: nil)
        }
    }

    /// Show action sheet
    ///
    /// - Parameters:
    ///   - title: the title string
    ///   - message: the message string
    ///   - actionTitle: the action title string
    ///   - okAction: the completion handler to execute when user tap on "OK"
    static func showActionSheet(title: String? = calendarName, message: String, actionTitle: String, okAction: VoidHandler? = nil) {
        self.showActionSheet(title: title, message: message, actionTitle: actionTitle, okAction: okAction, onCancel: nil)
    }

    /// Show OK only alert
    ///
    /// - Parameters:
    ///   - title: the title string
    ///   - message: the message string
    ///   - okAction: the completion handler to execute when user tap on "OK"
    static func showNoCancelAlertWithMessage(title: String? = calendarName, message: String, okAction: VoidHandler? = nil) {
        DispatchQueue.main.async {
            guard shouldShowAlert else { return }
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                okAction.flatMap { $0() }
            }

            alertController.addAction(okAction)
            alertController.dismissAndShow()
        }
    }

    /// General showing Settings alert constuctor
    ///
    /// - Parameters:
    ///   - title: the title string
    ///   - message: the message string
    ///   - onCancel: completion handler to be executed when user tap on cancel
    static func showSettingsAlert(title: String? = calendarName, message: String, onCancel: VoidHandler? = nil) {
        self.showActionSheet(title: title, message: message, actionTitle: "Settings", okAction: {
            _ = URL(string: UIApplication.openSettingsURLString).flatMap { UIApplication.shared.open($0, options: [:], completionHandler: nil) }
        }, onCancel: onCancel)
    }
}
