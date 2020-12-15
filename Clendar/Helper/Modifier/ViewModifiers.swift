//
//  ViewModifier.swift
//  Clendar
//
//  Created by Vinh Nguyen on 15/12/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct TextModifider: ViewModifier {
    var fontSize: CGFloat = 15
    var color: Color = .appGray

    func body(content: Content) -> some View {
        content
            .font(.boldFontWithSize(fontSize))
            .foregroundColor(color)
    }
}

struct ModalBackgroundModifier: ViewModifier {
    var backgroundColor: Color = .clear

    func body(content: Content) -> some View {
        content
            .preferredColorScheme(appColorScheme)
            .background(backgroundColor.edgesIgnoringSafeArea(.all))
    }
}

