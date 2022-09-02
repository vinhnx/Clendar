//
//  LockScreenWidgetView.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 01/09/2022.
//  Copyright © 2022 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

enum LockScreenWidgetTranslucentStyle {
    case all
    case content
}

enum LockScreenWidgetAlignment {
    case leading
    case trailing
}

enum LockScreenWidgetStyle {
    case translucent(LockScreenWidgetTranslucentStyle)
    case minimal(LockScreenWidgetAlignment)
    case line(LockScreenWidgetAlignment)
    case icon

}

enum LockScreenWidgetContentStyle {
    case nextEvent
    case counter
}

struct LockScreenWidgetView: View {
    @Environment(\.widgetFamily) private var widgetFamily

    let entry: WidgetEntry

    let generalStyle: LockScreenWidgetStyle
    let contentStyle: LockScreenWidgetContentStyle

    var body: some View {
        if #available(iOSApplicationExtension 16.0, *) {
            ViewThatFits {
                switch widgetFamily {
                case .accessoryCircular:
                        VStack(alignment: .center) {
                            Text(DateFormatter.asString(entry.date, format: "MMM").localizedUppercase)
                                .font(.boldFontWithSize(12))
                            Text(entry.date.toDayString())
                                .font(.boldFontWithSize(14))
                            Text(entry.date.toShortDateString())
                                .font(.regularFontWithSize(13))
                        }
                    .widgetAccentable()

                case .accessoryRectangular:

                    switch generalStyle {
                    case .icon:
                            VStack(alignment: .leading, spacing: 3) {
                                HStack(spacing: 3) {
                                    buildCalendarIcon()
                                    buildEventTitle()
                                }

                                buildEventContent()
                            }

                    case .line(let alignment):
                        switch alignment {
                        case .leading:
                                HStack(spacing: 5) {
                                    buildHorizontalLine()
                                    buildEventCard()
                                }

                        case .trailing:
                                HStack(spacing: 5) {
                                    buildEventCard(alignment: .trailing)
                                    buildHorizontalLine()
                                }

                        }

                    case .minimal(let alignment):
                        switch alignment {
                        case .leading:
                                buildEventCard()

                        case .trailing:
                                buildEventCard(alignment: .trailing)

                        }

                    case .translucent(let translucentStyle):
                        switch translucentStyle {
                        case .all:
                            ZStack {
                                buildBlurBackground()

                                ViewThatFits(in: .vertical) {
                                    VStack(alignment: .leading, spacing: 3) {
                                        buildIconLabel()
                                        buildEventContent()
                                    }
                                }
                                .padding([.leading, .trailing], 3)
                            }

                        case .content:
                            ViewThatFits(in: .vertical) {
                                VStack(alignment: .leading, spacing: 3) {
                                    buildIconLabel()

                                    ZStack {
                                        buildBlurBackground()
                                        buildEventContent()
                                    }
                                }
                            }

                        }
                    }

                case .accessoryInline:
                    buildEventContent()

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

    // MARK: - View Builder

    private func buildBlurBackground() -> some View {
        if #available(iOSApplicationExtension 16.0, *) {
            return AccessoryWidgetBackground().cornerRadius(3)
        } else {
            return EmptyView()
        }
    }

    private func buildIconLabel() -> some View {
        HStack(spacing: 3) {
            buildCalendarIcon()
            buildEventTitle()
        }
    }

    private func buildCalendarIcon() -> some View {
        Image(systemName: "calendar")
    }

    private func buildLine() -> some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
    }

    private func buildHorizontalLine() -> some View {
        buildLine().frame(width: 3)
    }

    private func buildEventCard(alignment: HorizontalAlignment = .leading) -> some View {
        VStack(alignment: alignment, spacing: 3) {
            buildEventTitle()
            buildEventContent()
        }
    }

    private func buildEventContent() -> some View {
        Text(eventContent)
            .lineLimit(2)
            .font(.regularFontWithSize(14))
    }

    private func buildEventTitle() -> some View {
        Text(eventTitle)
            .accessibility(label: Text("Event duration"))
            .font(.boldFontWithSize(12))
    }

    // MARK: - Private

    private var eventContent: String {
        let events = entry.events
        if events.isEmpty { return "" }

        switch contentStyle {
        case .nextEvent: return events.first?.event?.title ?? ""
        case .counter: return "\(events.count) \(NSLocalizedString("Events", comment: ""))"
        }
    }

    private var eventTitle: String {
        (entry.events.first?.event?.durationText() ?? entry.date.toFullDateString()).localizedUppercase
    }
}
