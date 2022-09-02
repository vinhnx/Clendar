//
//  EventListRow.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 11/20/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

struct EventListRow: View {
    var id = UUID() // somehow this fix problem when row should be reload after changes. Reference: https://github.com/onmyway133/blog/issues/625
    var event: ClendarEvent?

    var body: some View {
        if let ekEvent = event?.event {
            GroupBox(
                label:
                    Text(ekEvent.durationText().localizedUppercase)
                    .accessibility(label: Text("Event duration"))
                    .font(.boldFontWithSize(15))
                    .foregroundColor(Color(ekEvent.calendar.cgColor)),
                content: {
                    Text(ekEvent.title)
                        .accessibility(label: Text("Title of the event"))
                        .lineLimit(2)
                        .font(.mediumFontWithSize(17))
                        .foregroundColor(.appDark)
                        .padding(.top, 5)
                }
            )
            .opacity(ekEvent.isExpired() ? 0.3 : 1.0) // gray out past events https://github.com/vinhnx/Clendar/issues/146
            .groupBoxStyle(CardGroupBoxStyle())
        }
        else {
            EmptyView().redacted(reason: .placeholder)
        }
    }
}
