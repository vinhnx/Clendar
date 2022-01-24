//
//  EmptyView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 12/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct EmptyView: View {
    var text: String = "No events for today,\nenjoy your day!\n🎉"

    var body: some View {
        VStack {
            Text(LocalizedStringKey(text))
                .minimumScaleFactor(0.5)
                .modifier(BoldTextModifider(fontSize: 13))
                .lineSpacing(5)
                .multilineTextAlignment(.center)
            Spacer()
        }.padding()
    }
}
