//
//  WidgetBackgroundView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 13/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct WidgetBackgroundView: View {
    @ViewBuilder
    var body: some View {
        switch widgetThemeFromFile {
        case WidgetTheme.system.localizedText:
            Color(.backgroundColor)
        case WidgetTheme.dark.localizedText:
            Color(.lavixA)
        case WidgetTheme.light.localizedText:
            Color(.hueC)
        case WidgetTheme.E4ECF5.localizedText:
            Color(hex: 0xE4ECF5)
        default:
            Color(.backgroundColor)
        }
    }

    private var widgetThemeFromFile: String {
        let url = FileManager.appGroupContainerURL.appendingPathComponent(FileManager.widgetTheme)
        guard let text = try? String(contentsOf: url, encoding: .utf8) else { return "" }
        return text
    }
}
