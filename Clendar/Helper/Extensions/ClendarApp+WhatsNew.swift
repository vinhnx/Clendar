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
                minor: 5,
                patch: 0
            ), // specify version here
            title: WhatsNew.Title(
                text: WhatsNew.Text(NSLocalizedString("What's new in Clendar", comment: "")),
                foregroundColor: .appRed
            ),
            features: [
                .init(
                    image: .init(
                        systemName: "wand.and.stars.inverse",
                        foregroundColor: .orange
                    ),
                    title: WhatsNew.Text("NEW"),
                    subtitle: WhatsNew.Text(NSLocalizedString("Fix wrong widget theme when changing different languages", comment: ""))
                ),
                .init(
                    image: .init(
                        systemName: "wand.and.stars.inverse",
                        foregroundColor: .indigo
                    ),
                    title: WhatsNew.Text("NEW"),
                    subtitle: WhatsNew.Text(NSLocalizedString("Fix localization", comment: ""))
                ),
                .init(
                    image: .init(
                        systemName: "wand.and.stars.inverse",
                        foregroundColor: .green
                    ),
                    title: WhatsNew.Text("NEW"),
                    subtitle: WhatsNew.Text(NSLocalizedString("Fix action sheet crash", comment: ""))
                ),
                .init(
                    image: .init(
                        systemName: "rectangle.portrait.inset.filled",
                        foregroundColor: .teal
                    ),
                    title: WhatsNew.Text("NEW"),
                    subtitle: WhatsNew.Text(NSLocalizedString("Support portrait mode on iPad", comment: ""))
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
