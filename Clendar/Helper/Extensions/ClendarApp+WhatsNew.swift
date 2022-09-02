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
                minor: 6,
                patch: 0
            ), // specify version here
            title: WhatsNew.Title(
                text: WhatsNew.Text(
                    NSLocalizedString("What's new in Clendar", comment: "")
                )
            ),
            features: [
                .init(
                    image: .init(
                        systemName: "apps.iphone",
                        foregroundColor: .orange
                    ),
                    title: WhatsNew.Text("All-new Lock Screen Widget"),
                    subtitle: WhatsNew.Text(NSLocalizedString("Find your next favorite Widget. It's so beautiful, check it out on the lock screen!", comment: ""))
                ),
                .init(
                    image: .init(
                        systemName: "sparkles",
                        foregroundColor: .teal
                    ),
                    title: WhatsNew.Text("All-new redesigned"),
                    subtitle: WhatsNew.Text(NSLocalizedString("Improve accessibility and user experience!", comment: ""))
                ),
                .init(
                    image: .init(
                        systemName: "heart.fill",
                        foregroundColor: .red
                    ),
                    title: WhatsNew.Text(NSLocalizedString("Thanks for using Clendar!", comment: "")),
                    subtitle: WhatsNew.Text(NSLocalizedString("Have a nice day!", comment: ""))
                )
            ],
            primaryAction: .init(
                title: WhatsNew.Text(NSLocalizedString("Continue", comment: "")),
                backgroundColor: .appRed,
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
