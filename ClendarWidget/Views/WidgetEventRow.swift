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
    let event: Event

    var body: some View {
        HStack(spacing: 5) {
            WidgetEventColorBar(event: event)
            WidgetEventRowLabel(event: event)
        }
    }
}

struct WidgetEventRowLabel: View {
    let event: Event

    var body: some View {
        let message = event.event?.title ?? "-"
        let title = event.event?.displayText(startDateOnly: true) ?? "-"
        let titleAndMessage = "[\(title)] \(message)"
        Text(titleAndMessage)
            .font(.system(size: 12, weight: .semibold, design: .rounded))
            .foregroundColor(Color(.gray))
            .lineLimit(2)
    }
}

struct WidgetEventColorBar: View {
    let event: Event

    var body: some View {
        RoundedRectangle(cornerRadius: 4, style: .continuous)
            .fill(Color(event.event?.calendar.cgColor ?? CGColor(gray: 1, alpha: 1)))
            .frame(width: 5, height: 20)
    }

}
