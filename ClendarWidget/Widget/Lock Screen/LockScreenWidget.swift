//
//  LockScreenWidget.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 01/09/2022.
//  Copyright © 2022 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

struct LockScreenWidgetCounter: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: Constants.WidgetKind.lockScreenWidgetCounter.rawValue,
            provider: DateInfoWidgetTimelineProvider()
        ) { entry in buildContentView(entry) }
            .supportedFamilies(widgetFamilies)
    }

    private func buildContentView(_ entry: WidgetEntry) -> some View {
        if #available(iOSApplicationExtension 16.0, *) {
            return LockScreenWidgetView(entry: entry, style: .counter)
                .widgetAccentable()
        } else {
            return EmptyView()
        }
    }
}

struct LockScreenWidgetNextEvent: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: Constants.WidgetKind.lockScreenWidgetNextEvent.rawValue,
            provider: DateInfoWidgetTimelineProvider()
        ) { entry in buildContentView(entry) }
            .supportedFamilies(widgetFamilies)
    }

    private func buildContentView(_ entry: WidgetEntry) -> some View {
        if #available(iOSApplicationExtension 16.0, *) {
            return LockScreenWidgetView(entry: entry, style: .nextEvent)
                .widgetAccentable()
        } else {
            return EmptyView()
        }
    }
}

private var widgetFamilies: [WidgetFamily] {
    if #available(iOSApplicationExtension 16.0, *) {
        return [
            .accessoryInline,
            .accessoryCircular,
            .accessoryRectangular
        ]
    } else {
        return [
            .systemSmall,
            .systemMedium,
            .systemLarge,
            .systemExtraLarge
        ]
    }
}
