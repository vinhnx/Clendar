//
//  InfoView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 19/12/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    var title: String
    var titleImageName: String
    var subtitle: String

    var titleFontSize: CGFloat = 13
    var titleFontColor: Color = .primaryColor

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(title, systemImage: titleImageName)
                .modifier(BoldTextModifider(fontSize: titleFontSize, color: titleFontColor))
            Text(subtitle)
                .modifier(RegularTextModifider())
        }
    }
}
