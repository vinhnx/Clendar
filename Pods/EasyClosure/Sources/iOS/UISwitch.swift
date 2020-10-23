//
//  UISwitch.swift
//  EasyClosure-iOS
//
//  Created by khoa on 18/05/2019.
//  Copyright © 2019 Khoa Pham. All rights reserved.
//

import UIKit

public extension Container where Host: UISwitch {
    func valueChange(_ action: @escaping BoolAction) {
        let target = SwitchTarget(host: host, action: action)
        targets[SwitchTarget.uniqueId] = target
    }
}

class SwitchTarget: NSObject {
    var action: BoolAction?

    init(host: UISwitch, action: @escaping BoolAction) {
        super.init()

        self.action = action
        host.addTarget(self, action: #selector(handleChange(_:)), for: .valueChanged)
    }

    // MARK: - Action

    @objc func handleChange(_ uiSwitch: UISwitch) {
        action?(uiSwitch.isOn)
    }
}
