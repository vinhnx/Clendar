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
	var event: Event?

	var body: some View {
		if let ekEvent = event?.event {
			GroupBox(
				label:
				Label(ekEvent.durationText(), systemImage: "calendar")
					.font(.mediumFontWithSize(12))
					.foregroundColor(Color(ekEvent.calendar.cgColor)),
				content: {
					Text(ekEvent.title)
						.lineLimit(nil)
						.font(.regularFontWithSize(15))
						.padding(.top, 5)
				}
			)
			.groupBoxStyle(CardGroupBoxStyle())
		}
		else {
			EmptyView().redacted(reason: .placeholder)
		}
	}
}
