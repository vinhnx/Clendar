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
                    Label(ekEvent.durationText().localizedUppercase, systemImage: "calendar")
                    .accessibility(label: Text("Event duration"))
                    .font(.boldFontWithSize(15))
                    .foregroundColor(Color(ekEvent.calendar.cgColor)),
                content: {
                    Text(ekEvent.title)
                        .accessibility(label: Text("Title of the event"))
                        .lineLimit(nil)
                        .font(.mediumFontWithSize(18))
                        .padding(.top, 5)
                        .foregroundColor(.appDark)
                }
            )
            .groupBoxStyle(CardGroupBoxStyle())
        }
        else {
            EmptyView().redacted(reason: .placeholder)
        }
    }
}
