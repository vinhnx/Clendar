//
//  EasyClosure
//
//  Created by khoa on 18/05/2019.
//  Copyright © 2019 Khoa Pham. All rights reserved.
//

import UIKit

public extension Container where Host: UIBarButtonItem {
    func tap(_ action: @escaping Action) {
        let target = BarButtonItemTarget(host: host, action: action)
        targets[BarButtonItemTarget.uniqueId] = target
    }
}

class BarButtonItemTarget: NSObject {
    var action: Action?

    init(host: UIBarButtonItem, action: @escaping Action) {
        super.init()

        self.action = action
        host.target = self
        host.action = #selector(handleTap)
    }

    // MARK: - Action

    @objc func handleTap() {
        action?()
    }
}
