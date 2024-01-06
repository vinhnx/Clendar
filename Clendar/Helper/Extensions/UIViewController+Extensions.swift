//
//  UIViewController+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

var window: UIWindow? {
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    return windowScene?.windows.first
}

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
        UIViewController.topViewController(window?.rootViewController)
	}

	/// Safe present view controller
	///
	/// - Parameter completion: completion handler
	func safeDismiss(_ completion: @escaping VoidBlock) {
		guard isBeingDismissed else { return }
		dismiss(animated: true, completion: completion)
	}

	// MARK: - Others

	func dismissKeyboard() {
		view.endEditing(true)
	}

	@objc func dimissModal() {
		view.endEditing(true)
		dismiss(animated: true)
	}
}
