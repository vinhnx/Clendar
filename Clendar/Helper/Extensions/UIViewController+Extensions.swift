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
        addChild(childViewController)
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
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
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
            return topViewController((baseViewController as? UINavigationController)?.visibleViewController)
        }

        if baseViewController is UITabBarController {
            return topViewController((baseViewController as? UITabBarController)?.selectedViewController)
        }

        if baseViewController is UISplitViewController {
            return topViewController((baseViewController as? UISplitViewController)?.viewControllers.first)
        }

        if baseViewController?.presentedViewController != nil {
            return topViewController(baseViewController?.presentedViewController)
        }

        return baseViewController
    }

    static var topViewController: UIViewController? {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        return UIViewController.topViewController(window?.rootViewController)
    }

    /// Safe present view controller
    ///
    /// - Parameter completion: completion handler
    func safeDismiss(_ completion: @escaping VoidHandler) {
        guard isBeingDismissed else { return }
        dismiss(animated: true, completion: completion)
    }

    // MARK: - Banner

    func presentAlertModal(iconText: String = "", title: String = AppName, message: String = "") {
        if UINavigationController.topViewController is TransientAlertViewController {
            (UINavigationController.topViewController as? AlertViewController)?.dismiss(animated: true, completion: nil)
        }
        
        let alert = AlertViewController()
        alert.configure(dateText: iconText, title: title, message: message)
        presentPanModal(alert)
    }
}
