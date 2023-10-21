//
//  SiriShortcutsView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 30/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct SiriShortcutsView: View {

    var viewModel = ModalWrapperView()

    var closeButton: some View {
        Button(
            action: {
                genLightHaptic()
                self.viewModel.closeAction()
            },
            label: {
                Image(systemName: "chevron.down")
                    .font(.boldFontWithSize(20))
                    .accessibility(label: Text("Collapse this view"))
            }
        )
        .accentColor(.appRed)
        .keyboardShortcut(.escape)
    }

    var titleLabel: some View {
        Text( NSLocalizedString("Siri Shortcuts", comment: ""))
            .font(.boldFontWithSize(20))
            .gradientForeground(colors: [.red, .blue])
    }

    var contentView: some View {
        ScrollView {
            VStack(spacing: 50) {
                Text("You can now quick shortcuts to Siri and Shortcuts app. Try adding one below")
                    .font(.mediumFontWithSize(15))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                VStack(spacing: 20) {
                    Text(NSLocalizedString("Create new Clendar event(s)", comment: ""))
                    SiriButton(shortcut: ShortcutBuilder.addEventShortcut).frame(height: 30)
                }

                VStack(spacing: 20) {
                    Text(NSLocalizedString("Open Settings", comment: ""))
                    SiriButton(shortcut: ShortcutBuilder.openSettingsShortcut).frame(height: 30)
                }
            }
        }
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: 50) {
            titleLabel
            contentView
            closeButton
        }
        .padding()
    }
}
