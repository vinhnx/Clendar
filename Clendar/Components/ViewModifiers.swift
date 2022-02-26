//
//  ViewModifier.swift
//  Clendar
//
//  Created by Vinh Nguyen on 15/12/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import ClendarTheme

#if os(iOS)
import UIKit
#endif

struct BoldTextModifider: ViewModifier {
    var fontSize: CGFloat = 15
    var color: Color = .appGray
    
    func body(content: Content) -> some View {
        content
            .font(.boldFontWithSize(fontSize))
            .foregroundColor(color)
    }
}

struct MediumTextModifider: ViewModifier {
    var fontSize: CGFloat = 15
    var color: Color = .appGray

    func body(content: Content) -> some View {
        content
            .font(.mediumFontWithSize(fontSize))
            .foregroundColor(color)
    }
}

struct RegularTextModifider: ViewModifier {
    var fontSize: CGFloat = 15
    var color: Color = .appGray

    func body(content: Content) -> some View {
        content
            .font(.regularFontWithSize(fontSize))
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

struct HideNavigationBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}
