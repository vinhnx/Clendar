//
//  MailComposerViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import UIKit

// ref: https://stuartbreckenridge.com/2021/01/the-diminishing-utility-of-mfmailcomposeviewcontroller/

final class MailComposer: NSObject {

    // MARK: - Public

    func showFeedbackComposer() {
        let subject = NSLocalizedString("Feedback/Report Issue", comment: "")
        let body = """



                        ---

                        * Version: \(AppInfo.appVersion)
                        * Build: \(AppInfo.appBuild)
                        * Device: \(AppInfo.deviceName)
                        """

        let mailto = "mailto:\(Constants.supportEmail)?subject=\(subject)&body=\(body)"

        guard let escapedMailto = mailto.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: escapedMailto) else { return }

        guard UIApplication.shared.canOpenURL(url) else {
            AlertManager.show(message: NSLocalizedString("Unable to determine email sending state", comment: ""))
            return
        }

        UIApplication.shared.open(url, options: [.universalLinksOnly : false]) { (success) in
            // Handle success/failure
            if !success {
                AlertManager.show(message: NSLocalizedString("Unable to determine email sending state", comment: ""))
            }
        }
    }
}
