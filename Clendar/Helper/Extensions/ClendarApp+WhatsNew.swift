//
//  ClendarApp+WhatsNew.swift
//  Clendar
//
//  Created by Vinh Nguyen on 12/02/2022.
//  Copyright © 2022 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WhatsNewKit

extension ClendarApp: WhatsNewCollectionProvider {

    /// A WhatsNewCollection
    var whatsNewCollection: WhatsNewCollection {
        WhatsNew(
            version: WhatsNew.Version(
                major: 3,
                minor: 2,
                patch: 0
            ), // specify version here
            title: WhatsNew.Title(
                text: WhatsNew.Text(NSLocalizedString("What's new in Clendar", comment: "")),
                foregroundColor: .appRed
            ),
            features: [
                .init(
                    image: .init(
                        systemName: "clock",
                        foregroundColor: .orange
                    ),
                    title: WhatsNew.Text(NSLocalizedString("12 or 24 hour date setting", comment: "")),
                    subtitle: WhatsNew.Text(NSLocalizedString("You can now choose 12 or 24 hour format, from the settings menu.", comment: ""))
                ),
                .init(
                    image: .init(
                        systemName: "arrow.left.arrow.right",
                        foregroundColor: .cyan
                    ),
                    title: WhatsNew.Text(NSLocalizedString("Quick date switcher button", comment: "")),
                    subtitle: WhatsNew.Text(NSLocalizedString("Quickly toggle between dates.", comment: ""))
                ),
                .init(
                    image: .init(
                        systemName: "heart",
                        foregroundColor: .red
                    ),
                    title: WhatsNew.Text(NSLocalizedString("Thanks for using Clendar!", comment: "")),
                    subtitle: WhatsNew.Text(NSLocalizedString("Have a nice day!", comment: ""))
                )
            ],
            primaryAction: .init(
                title: WhatsNew.Text(NSLocalizedString("Continue", comment: "")),
                hapticFeedback: {
#if os(iOS)
                    .notification(.success)
#else
                    nil
#endif
                }()
            )
        )
    }

}
