//
//  UIViewController+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

extension UIViewController {
    static func topViewController(_ baseViewController: UIViewController?) -> UIViewController? {
        if baseViewController is UINavigationController {
            return self.topViewController((baseViewController as? UINavigationController)?.visibleViewController)
        }

        if baseViewController is UITabBarController {
            return self.topViewController((baseViewController as? UITabBarController)?.selectedViewController)
        }

        if baseViewController is UISplitViewController {
            return self.topViewController((baseViewController as? UISplitViewController)?.viewControllers.first)
        }

        if baseViewController?.presentedViewController != nil {
            return self.topViewController(baseViewController?.presentedViewController)
        }

        return baseViewController
    }

    static var topViewController: UIViewController? {
        return UIViewController.topViewController(UIApplication.shared.keyWindow?.rootViewController)
    }

    /// Safe present view controller
    ///
    /// - Parameter completion: completion handler
    func safeDismiss(_ completion: @escaping VoidHandler) {
        guard self.isBeingDismissed else { return }
        self.dismiss(animated: true, completion: completion)
    }
}
