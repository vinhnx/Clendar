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
                minor: 8,
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
                        systemName: "globe",
                        foregroundColor: .orange
                    ),
                    title: WhatsNew.Text("New Translations"),
                    subtitle: WhatsNew.Text(NSLocalizedString("Clendar now include new Italian localization (Grazie!), and with langugage specific changes for the German localization (Danke!).\nHuge thanks to everyone contributed on GitHub!!!", comment: ""))
                ),
                .init(
                    image: .init(
                        systemName: "sparkles",
                        foregroundColor: .teal
                    ),
                    title: WhatsNew.Text("Bug fixes"),
                    subtitle: WhatsNew.Text(NSLocalizedString("Clendar is now even better every day, enjoy!", comment: ""))
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
