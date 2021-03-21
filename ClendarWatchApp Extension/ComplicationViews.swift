//
//  ComplicationViews.swift
//  ClendarWatchApp Extension
//
//  Created by Vinh Nguyen on 30/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import ClockKit


struct ComplicationViewCircular: View {
    let date: Date

    var body: some View {
        VStack(alignment: .center) {
            Text(date.toDayString)
                .gradientForeground(colors: [.red, .blue])
                .foregroundColor(.appRed)
            Text(date.toDateString)
                .font(.regularFontWithSize(20))
                .foregroundColor(Color(.moianesB))
        }
        .minimumScaleFactor(0.3)

    }
}

struct ComplicationViewRectangular: View {
    let event: ClendarEvent

    var body: some View {
        HStack(spacing: 10) {
            ComplicationViewCircular(date: event.event?.startDate ?? Date())

            VStack(alignment: .leading) {
                let duration = event.event?.durationText() ?? "-"
                let message = event.event?.title ?? "-"

                Text(duration)
                    .lineLimit(1)
                    .font(.boldFontWithSize(10))
                    .foregroundColor(event.calendarColor)

                Text(message)
                    .lineLimit(2)
                    .font(.semiboldFontWithSize(12))
                    .foregroundColor(.gray)
            }
            .minimumScaleFactor(0.3)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundColor(.white)
                .complicationForeground()
        )
    }
}

// previews

struct ComplicationViewCircular_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CLKComplicationTemplateGraphicCircularView(
                ComplicationViewCircular(date: Date())
            ).previewContext()
        }
    }
}
