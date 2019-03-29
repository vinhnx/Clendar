//
//  SettingsViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 29/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation

final class SettingsNavigationController: BaseNavigationController {}

final class SettingsViewController: BaseViewController {

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }

    // MARK: - Override

    override func setupViews() {
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.didTapDismiss))
        self.title = "Settings"
    }


    // MARK: - Action

    @objc private func didTapDismiss() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
