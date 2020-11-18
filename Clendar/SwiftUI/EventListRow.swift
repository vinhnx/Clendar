//
//  EventListRow.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/11/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

#warning("// TODO: SwiftUI migration")
struct EventListItemRow: View {
    var event: Event

    var body: some View {
        HStack {
            if let event = event.event {
                GroupBox(label: Label(event.title, systemImage: "heart.fill").lineLimit(nil)
                            .foregroundColor(Color(event.calendar.cgColor)), content: {
                                Text(event.durationText()).font(.footnote)
                            })
            } else {
                EmptyView().redacted(reason: .placeholder)
            }
        }
    }
}
