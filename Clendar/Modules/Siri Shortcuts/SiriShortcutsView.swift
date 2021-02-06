//
//  SiriShortcutsView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 30/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct SiriShortcutsView: View {
    @Binding var showView: Bool

    var body: some View {
        VStack(spacing: 50) {

            Text(R.string.localizable.siriShortcuts())
                .font(.boldFontWithSize(20))
                .gradientForeground(colors: [.red, .blue])

            ScrollView {
                VStack(spacing: 50) {
                    VStack(spacing: 20) {
                        Text(R.string.localizable.createNewClendarEventS())
                        SiriButton(shortcut: ShortcutBuilder.addEventShortcut).frame(height: 30)
                    }

                    VStack(spacing: 20) {
                        Text(R.string.localizable.openSettings())
                        SiriButton(shortcut: ShortcutBuilder.openSettingsShortcut).frame(height: 30)
                    }

                    VStack(spacing: 20) {
                        Text(R.string.localizable.showSiriShortcutsView())
                        SiriButton(shortcut: ShortcutBuilder.openSiriShortcut).frame(height: 30)
                    }
                }
            }

            Button(
                action: {
                    genLightHaptic()
                    showView = false
                },
                label: {
                    Image(systemName: "chevron.down")
                        .font(.boldFontWithSize(20))
                        .accessibility(label: Text("Collapse this view"))
                }
            )
            .accentColor(.appRed)
            .keyboardShortcut(.escape)
            .hoverEffect()

        }
        .padding()
    }
}
