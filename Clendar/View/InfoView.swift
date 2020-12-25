//
//  InfoView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 19/12/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct InfoWrapView<ContentView: View>: View {
    struct InfoViewConfig {
        var title: String
        var titleImageName: String
        var titleFontSize: CGFloat = 13
        var titleFontColor: Color = .primaryColor
    }

    let config: InfoViewConfig
    let contentBuilder: () -> ContentView

    init(config: InfoViewConfig, @ViewBuilder contentBuilder: @escaping () -> ContentView) {
        self.config = config
        self.contentBuilder = contentBuilder
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(config.title, systemImage: config.titleImageName)
                .modifier(BoldTextModifider(fontSize: config.titleFontSize, color: config.titleFontColor))
            contentBuilder()
        }
    }
}
