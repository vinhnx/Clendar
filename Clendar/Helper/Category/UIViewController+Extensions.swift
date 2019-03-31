//
//  UIViewController+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

extension UIViewController {

    // MARK: - Container

    /// Add child view controller from container view
    ///
    /// - Parameters:
    ///   - childViewController: child view controller
    ///   - containerView: container view
    func addChildViewController(_ childViewController: UIViewController, containerView: UIView) {
        self.addChild(childViewController)
        containerView.addSubview(childViewController.view)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            childViewController.view.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            childViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            childViewController.view.rightAnchor.constraint(equalTo: containerView.rightAnchor)
            ])

        childViewController.didMove(toParent: self)
    }

    /// Remove self from parent view controller
    func removeFromParentViewController() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }

    /// Exchange/swap two controllers
    ///
    /// - Parameters:
    ///   - viewControllerA: the view controller to be exchanged
    ///   - viewControllerB: the view controller to exchange to
    ///   - containerView: container view to place viewControllerB
    ///   - rootViewController: the root view controller
    func exchangeViewControllerA(_ viewControllerA: UIViewController?, with viewControllerB: UIViewController?, containerView: UIView?, on rootViewController: UIViewController) {
        guard let viewControllerA = viewControllerA else { return }
        guard let viewControllerB = viewControllerB else { return }
        guard let containerView = containerView else { return }
        viewControllerA.removeFromParentViewController()
        rootViewController.addChildViewController(viewControllerB, containerView: containerView)
    }

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

    // MARK: - Banner

    func showBannerModal(iconText: String = "", title: String = AppName, message: String = "") {
        let alert = TransientAlertViewController()
        alert.configure(dateText: iconText, title: title, message: message)
        self.presentPanModal(alert)
    }
}
