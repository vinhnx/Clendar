//
//  RestoreButtonStyle.swift
//  Clendar
//
//  Created by Vinh Nguyen on 15/01/2022.
//  Copyright © 2022 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct RestoreButtonStyle: ButtonStyle {
    var titlefontSize: CGFloat = 20
    var backgroundColor: Color = .appRed
    var foregroundColor: Color = .white
    var cornerRadius: CGFloat = 10
    var animated = true

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Text("Restore Purchases")
                .font(.boldFontWithSize(titlefontSize))
        }
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        .foregroundColor(foregroundColor)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .opacity(configuration.isPressed ? 0.7 : 1)
        .scaleEffect(animated ? (configuration.isPressed ? 0.8 : 1) : 1)
    }
}
