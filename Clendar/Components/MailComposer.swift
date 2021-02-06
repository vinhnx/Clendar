//
//  MailComposerViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import UIKit
import MessageUI

class MailComposer: NSObject {

    // MARK: - Public

    func showFeedbackComposer() {
        guard MFMailComposeViewController.canSendMail() else { return }

        genLightHaptic()

        let mail = MFMailComposeViewController()
        mail.setToRecipients([Constants.supportEmail])
        mail.setSubject(NSLocalizedString("Feedback/Report Issue", comment: ""))
        mail.setMessageBody("""



                        ---
                        * Version: \(AppInfo.appVersion)
                        * Build: \(AppInfo.appBuild)
                        * Device: \(AppInfo.deviceName)
                        """, isHTML: false)
        mail.mailComposeDelegate = self
        UINavigationController.topViewController?.present(mail, animated: true, completion: nil)
    }
}

extension MailComposer: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            if result == .sent {
                genSuccessHaptic()
            }
        }
    }
}
