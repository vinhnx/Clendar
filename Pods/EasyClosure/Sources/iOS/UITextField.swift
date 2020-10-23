//
//  EasyClosure
//
//  Created by khoa on 18/05/2019.
//  Copyright © 2019 Khoa Pham. All rights reserved.
//

import UIKit

public extension Container where Host: UITextField {
    func textChange(_ action: @escaping StringAction) {
        let target = TextFieldTarget(host: host, textAction: action)
        targets[TextFieldTarget.uniqueId] = target
    }
}

class TextFieldTarget: NSObject {
    var textAction: StringAction?

    required init(host: UITextField, textAction: @escaping StringAction) {
        super.init()

        self.textAction = textAction
        host.addTarget(self, action: #selector(handleTextChange(_:)), for: .editingChanged)
    }

    // MARK: - Action

    @objc func handleTextChange(_ textField: UITextField) {
        textAction?(textField.text ?? "")
    }
}
