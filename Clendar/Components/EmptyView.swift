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
                .modifier(BoldTextModifider())
                .lineSpacing(10)
                .multilineTextAlignment(.center)
        }.padding()
    }
}
