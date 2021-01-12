//
//  EmptyView.swift
//  Clendar
//
//  Created by Vinh Nguyen on 12/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        Text("🎉 No events for today,\nenjoy your day!\n")
            .modifier(BoldTextModifider())
            .lineSpacing(10)
            .multilineTextAlignment(.center)
    }
}
