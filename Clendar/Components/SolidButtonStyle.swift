//
//  ButtonStyle.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/12/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct SolidButtonStyle: ButtonStyle {
    var imageName: String?
    var title: String?
    var titlefontSize: CGFloat = 15
    var backgroundColor = Color.appRed
    var foregroundColor = Color.white
    var cornerRadius: CGFloat = 10
    var animated = true

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Unwrap(imageName) { name in
                Image(systemName: name)
            }

            Unwrap(title) { title in
                Text(LocalizedStringKey(title))
                    .font(.mediumFontWithSize(titlefontSize))
            }
        }
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        .foregroundColor(foregroundColor)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .opacity(configuration.isPressed ? 0.7 : 1)
        .scaleEffect(animated ? (configuration.isPressed ? 0.8 : 1) : 1)
        .animation(animated ? .easeInOut(duration: 0.2) : .none)
    }
}
