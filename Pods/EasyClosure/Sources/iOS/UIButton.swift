//
//  EasyClosure
//
//  Created by khoa on 18/05/2019.
//  Copyright © 2019 Khoa Pham. All rights reserved.
//

import UIKit

public extension Container where Host: UIButton {
    func tap(_ action: @escaping Action) {
        let target = ButtonTarget(host: host, action: action)
        targets[ButtonTarget.uniqueId] = target
    }
}

class ButtonTarget: NSObject {
    var action: Action?

    init(host: UIButton, action: @escaping Action) {
        super.init()

        self.action = action
        host.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }

    // MARK: - Action

    @objc func handleTap() {
        action?()
    }
}
