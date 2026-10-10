//
//  WidgetView+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 28/10/2023.
//  Copyright © 2023 Vinh Nguyen. All rights reserved.
//

import SwiftUI

// https://stackoverflow.com/a/76842922/1477298
extension View {
    func widgetBackground(_ backgroundView: some View) -> some View {
        if #available(iOS 17, macCatalyst 17, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}

// MARK: - StandBy support (iOS 17 nightstand landscape mode, issue #255)
//
// In StandBy, WidgetKit strips the container background, so content renders
// directly on the StandBy backdrop (dark at night). Views must stay legible
// without their custom background. `showsWidgetContainerBackground` is the
// Apple-sanctioned proxy for this (WWDC23 "Bring widgets to new places"):
// it is true on the Home Screen and on iOS 15/16, false in StandBy.
extension View {
    /// Uses `normal` where the container background is present (Home Screen,
    /// iOS 15/16) and `standBy` where WidgetKit removed it (StandBy).
    func standByAdaptiveForeground(normal: Color, standBy: Color) -> some View {
        modifier(StandByAdaptiveForeground(normal: normal, standBy: standBy))
    }
}

private struct StandByAdaptiveForeground: ViewModifier {
    @Environment(\.showsWidgetContainerBackground) var showsBackground

    let normal: Color
    let standBy: Color

    func body(content: Content) -> some View {
        content.foregroundColor(showsBackground ? normal : standBy)
    }
}
