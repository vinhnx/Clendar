//
//  MailComposerViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import UIKit
import MessageUI

class MailComposer: MFMailComposeViewController {
    
    // MARK: Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
        self.mailComposeDelegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Internal

    override func viewDidLoad() {
        super.viewDidLoad()

        checkUIMode()

        NotificationCenter.default.addObserver(forName: .didChangeUserInterfacePreferences, object: nil, queue: .main) { _ in
            self.checkUIMode()
        }
    }

    // MARK: - Private

    private func checkUIMode() {
        overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
    }

    // MARK: - Public

    func showFeedbackComposer() {
        guard MFMailComposeViewController.canSendMail() else { return }

        genLightHaptic()

        setToRecipients([Constants.supportEmail])
        setSubject(NSLocalizedString("Feedback/Report Issue", comment: ""))
        setMessageBody("""



                        ---
                        * Version: \(AppInfo.appVersion)
                        * Build: \(AppInfo.appBuild)
                        * Device: \(AppInfo.deviceName)
                        """, isHTML: false)

        UINavigationController.topViewController?.present(self, animated: true, completion: nil)
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
