//
//  WidgetEventRow.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftUI

struct WidgetEventRow: View {
    @Environment(\.isFocused) var isFocused

	var id = UUID()
	let event: ClendarEvent

	var body: some View {
		HStack(spacing: 5) {
			WidgetEventColorBar(event: event)
			WidgetEventRowLabel(event: event)
		}
        .scaleEffect(isFocused ? 1.2 : 1)
        .animation(.easeInOut, value: isFocused)
	}
}

struct WidgetEventRowLabel: View {
	let event: ClendarEvent

	var body: some View {
        VStack(alignment: .leading) {
            let message = event.event?.title ?? "-"
            let title = event.event?.durationText(startDateOnly: true) ?? "-"
            let titleAndMessage = "[\(title)] \(message)"
            Text(titleAndMessage)
                .font(.semiboldFontWithSize(12))
                .foregroundColor(Color(.gray))
                .lineLimit(2)
        }
	}
}

struct WidgetEventColorBar: View {
	let event: ClendarEvent

	var body: some View {
        Capsule(style: .circular)
            .fill(event.calendarColor)
			.frame(width: 3)
	}
}
