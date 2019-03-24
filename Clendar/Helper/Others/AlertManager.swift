//
//  AlertManager.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

final class AlertManager {

    // MARK: - Alert

    class func showAlertWithMessage(_ message: String, actions: [UIAlertAction], onViewController viewController: UIViewController?) {
        DispatchQueue.main.async {
            var controllerToPresent = viewController
            if viewController == nil {
                UINavigationController.topViewController.flatMap { controllerToPresent = $0 }
            }

            guard let controller = controllerToPresent else { return }
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertController.popoverPresentationController?.sourceView = controller.view
            alertController.popoverPresentationController?.sourceRect = CGRect(x: controller.view.frame.size.width, y: 100, width: 1, height: 1)

            for action in actions {
                alertController.addAction(action)
            }

            controller.present(alertController, animated: true, completion: nil)
        }
    }

    class func showAlertWithMessage(_ message: String) {
        self.showAlertWithMessage(message,
                                  actions: [UIAlertAction(title: "OK", style: .cancel, handler: nil)],
                                  onViewController: nil)
    }
}
