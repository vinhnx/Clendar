//
//  PurchaseButtonStyle.swift
//  Clendar
//
//  Created by Vinh Nguyen on 06/02/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct PurchaseButtonStyle: ButtonStyle {
    var imageName: String? = "giftcard.fill"
    var title: String?
    var titlefontSize: CGFloat = 20
    var price: String?
    var pricefontSize: CGFloat = 15
//    var backgroundColor: Color = Color(.moianesB)
//    var foregroundColor: Color = Color(.moianesA)
    var backgroundColor: Color = .blue
    var foregroundColor: Color = .white

    var cornerRadius: CGFloat = 10
    var animated = true

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Unwrap(imageName) { name in
                Image(systemName: name)
            }

            VStack(alignment: .leading) {
                Unwrap(price) { title in
                    Text(title)
                        .font(.boldFontWithSize(pricefontSize))
                }
                
                Unwrap(title) { title in
                    Text(title)
                        .font(.boldFontWithSize(titlefontSize))
                }
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
