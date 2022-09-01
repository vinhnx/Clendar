//
//  File.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 01/09/2022.
//  Copyright © 2022 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

enum LockScreenWidgetViewStyle {
    case nextEvent
    case counter
}

struct LockScreenWidgetView: View {
    @Environment(\.widgetFamily) private var widgetFamily

    let entry: WidgetEntry
    let style: LockScreenWidgetViewStyle

    var body: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            ViewThatFits {
                switch widgetFamily {
                case .accessoryCircular:
                    ViewThatFits(in: .vertical) {
                        VStack(alignment: .center) {
                            Text(DateFormatter.asString(entry.date, format: "MMM").localizedUppercase)
                                .font(.boldFontWithSize(15))
                            Text(entry.date.toFullDayString())
                                .font(.regularFontWithSize(13))
                        }
                    }
                    .widgetAccentable()

                case .accessoryRectangular:
                    ViewThatFits(in: .vertical) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(entry.date.toFullDateString().localizedUppercase)
                                .font(.boldFontWithSize(12))
                            
                            Text(entry.events.isEmpty ? "🎉" : message)
                                .lineLimit(2)
                                .font(.mediumFontWithSize(12))
                        }
                    }
                default:
                    Text(entry.date.toMonthString().localizedUppercase)
                        .font(.boldFontWithSize(15))
                    Text(entry.date.toFullDayString())
                        .font(.regularFontWithSize(13))

                }

            }
            .widgetAccentable()
        } else {
            Text(entry.date.toFullDayString())
                .font(.boldFontWithSize(15))
        }
    }

    private var message: String {
        switch style {
        case .nextEvent: return entry.events.first?.event?.title ?? ""
        case .counter: return "\(entry.events.count) \(NSLocalizedString("Events", comment: ""))"
        }
    }
}
