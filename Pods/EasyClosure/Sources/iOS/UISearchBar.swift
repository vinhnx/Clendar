//
//  EasyClosure
//
//  Created by khoa on 18/05/2019.
//  Copyright © 2019 Khoa Pham. All rights reserved.
//

import UIKit

public extension Container where Host: UISearchBar {
    func textChange(_ action: @escaping StringAction) {
        let target = SearchBarTarget(host: host, action: action)
        targets[SearchBarTarget.uniqueId] = target
    }
}

class SearchBarTarget: NSObject, UISearchBarDelegate {
    var action: StringAction?

    init(host: UISearchBar, action: @escaping StringAction) {
        super.init()

        self.action = action
        host.delegate = self
    }

    // MARK: - UISearchBarDelegate

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        action?(searchText)
    }
}
