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
        case WidgetTheme.dark.localizedText:
            Color(.lavixA)
        case WidgetTheme.light.localizedText:
            Color(.hueC)
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
