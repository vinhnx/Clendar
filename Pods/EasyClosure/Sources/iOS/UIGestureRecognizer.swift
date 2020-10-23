//
//  EasyClosure
//
//  Created by khoa on 18/05/2019.
//  Copyright © 2019 Khoa Pham. All rights reserved.
//

import UIKit

public extension Container where Host: UIGestureRecognizer {
    func occur(_ action: @escaping Action) {
        let target = GestureTarget(host: host, action: action)
        targets[GestureTarget.uniqueId] = target
    }
}

class GestureTarget: NSObject {
    var action: Action?

    init(host: UIGestureRecognizer, action: @escaping Action) {
        super.init()

        self.action = action
        host.addTarget(self, action: #selector(didOccur(_:)))
    }

    // MARK: - Action

    @objc func didOccur(_ gestureRecognizer: UIGestureRecognizer) {
        action?()
    }
}
