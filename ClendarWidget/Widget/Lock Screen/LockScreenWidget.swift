//
//  LockScreenWidget.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 01/09/2022.
//  Copyright © 2022 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

// NOTE: Closure containing control flow statement cannot be used with result builder 'WidgetBundleBuilder'

// Icon Next
struct LockScreenWidgetIconNextEvent: LockScreenWidgetable {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: Constants.WidgetKind.lockScreenWidgetIconNextEvent.rawValue,
            provider: DateInfoWidgetTimelineProvider(),
            content: buildContentView
        )
        .supportedFamilies(widgetFamilies)
        .configurationDisplayName(NSLocalizedString("Icon", comment: ""))
        .description(NSLocalizedString("With upcoming event", comment: ""))
    }

    private func buildContentView(_ entry: WidgetEntry) -> some View {
        if #available(iOSApplicationExtension 16.0, *) {
            return LockScreenWidgetView(
                entry: entry,
                generalStyle: .icon,
                contentStyle: .nextEvent
            )
            .widgetAccentable()
        } else {
            return EmptyView()
        }
    }
}

// Icon Counter
struct LockScreenWidgetIconCounter: LockScreenWidgetable {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: Constants.WidgetKind.lockScreenWidgetIconCounter.rawValue,
            provider: DateInfoWidgetTimelineProvider(),
            content: buildContentView
        )
        .supportedFamilies(widgetFamilies)
        .configurationDisplayName(NSLocalizedString("Icon", comment: ""))
        .description(NSLocalizedString("With total events counter for the day", comment: ""))
    }

    private func buildContentView(_ entry: WidgetEntry) -> some View {
        if #available(iOSApplicationExtension 16.0, *) {
            return LockScreenWidgetView(
                entry: entry,
                generalStyle: .icon,
                contentStyle: .counter
            )
            .widgetAccentable()
        } else {
            return EmptyView()
        }
    }
}

// TranslucentAllNextEvent
struct LockScreenWidgetTranslucentAllNextEvent: LockScreenWidgetable {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: Constants.WidgetKind.lockScreenWidgetTranslucentAllNextEvent.rawValue,
            provider: DateInfoWidgetTimelineProvider(),
            content: buildContentView
        )
        .supportedFamilies(widgetFamilies)
        .configurationDisplayName(NSLocalizedString("Translucent", comment: ""))
        .description(NSLocalizedString("With upcoming event", comment: ""))
    }

    private func buildContentView(_ entry: WidgetEntry) -> some View {
        if #available(iOSApplicationExtension 16.0, *) {
            return LockScreenWidgetView(
                entry: entry,
                generalStyle: .translucent(.all),
                contentStyle: .nextEvent
            )
            .widgetAccentable()
        } else {
            return EmptyView()
        }
    }
}

// TranslucentAllCounter
struct LockScreenWidgetTranslucentAllCounter: LockScreenWidgetable {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: Constants.WidgetKind.lockScreenWidgetTranslucentAllCounter.rawValue,
            provider: DateInfoWidgetTimelineProvider(),
            content: buildContentView
        )
        .supportedFamilies(widgetFamilies)
        .configurationDisplayName(NSLocalizedString("Translucent", comment: ""))
        .description(NSLocalizedString("With total events counter for the day", comment: ""))
    }

    private func buildContentView(_ entry: WidgetEntry) -> some View {
        if #available(iOSApplicationExtension 16.0, *) {
            return LockScreenWidgetView(
                entry: entry,
                generalStyle: .translucent(.all),
                contentStyle: .counter
            )
            .widgetAccentable()
        } else {
            return EmptyView()
        }
    }
}

// TranslucentContentNextEvent
struct LockScreenWidgetTranslucentContentNextEvent: LockScreenWidgetable {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: Constants.WidgetKind.lockScreenWidgetTranslucentContentNextEvent.rawValue,
            provider: DateInfoWidgetTimelineProvider(),
            content: buildContentView
        )
        .supportedFamilies(widgetFamilies)
        .configurationDisplayName(NSLocalizedString("Translucent", comment: ""))
        .description(NSLocalizedString("With upcoming event", comment: ""))
    }

    private func buildContentView(_ entry: WidgetEntry) -> some View {
        if #available(iOSApplicationExtension 16.0, *) {
            return LockScreenWidgetView(
                entry: entry,
                generalStyle: .translucent(.content),
                contentStyle: .nextEvent
            )
            .widgetAccentable()
        } else {
            return EmptyView()
        }
    }
}

// TranslucentContentCounter
struct LockScreenWidgetTranslucentContentCounter: LockScreenWidgetable {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: Constants.WidgetKind.lockScreenWidgetTranslucentContentCounter.rawValue,
            provider: DateInfoWidgetTimelineProvider(),
            content: buildContentView
        )
        .supportedFamilies(widgetFamilies)
        .configurationDisplayName(NSLocalizedString("Translucent", comment: ""))
        .description(NSLocalizedString("With total events counter for the day", comment: ""))
    }

    private func buildContentView(_ entry: WidgetEntry) -> some View {
        if #available(iOSApplicationExtension 16.0, *) {
            return LockScreenWidgetView(
                entry: entry,
                generalStyle: .translucent(.content),
                contentStyle: .counter
            )
            .widgetAccentable()
        } else {
            return EmptyView()
        }
    }
}

// MinimalLeadingNextEvent
struct LockScreenWidgetMinimalLeadingNextEvent: LockScreenWidgetable {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: Constants.WidgetKind.lockScreenWidgetMinimalLeadingNextEvent.rawValue,
            provider: DateInfoWidgetTimelineProvider(),
            content: buildContentView
        )
        .supportedFamilies(widgetFamilies)
        .configurationDisplayName(NSLocalizedString("Minimal", comment: ""))
        .description(NSLocalizedString("With upcoming event", comment: ""))
    }

    private func buildContentView(_ entry: WidgetEntry) -> some View {
        if #available(iOSApplicationExtension 16.0, *) {
            return LockScreenWidgetView(
                entry: entry,
                generalStyle: .minimal(.leading),
                contentStyle: .nextEvent
            )
            .widgetAccentable()
        } else {
            return EmptyView()
        }
    }
}

// MinimalTrailingNextEvent
struct LockScreenWidgetMinimalTrailingNextEvent: LockScreenWidgetable {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: Constants.WidgetKind.lockScreenWidgetMinimalTrailingNextEvent.rawValue,
            provider: DateInfoWidgetTimelineProvider(),
            content: buildContentView
        )
        .supportedFamilies(widgetFamilies)
        .configurationDisplayName(NSLocalizedString("Minimal", comment: ""))
        .description(NSLocalizedString("With upcoming event", comment: ""))
    }

    private func buildContentView(_ entry: WidgetEntry) -> some View {
        if #available(iOSApplicationExtension 16.0, *) {
            return LockScreenWidgetView(
                entry: entry,
                generalStyle: .minimal(.trailing),
                contentStyle: .nextEvent
            )
            .widgetAccentable()
        } else {
            return EmptyView()
        }
    }
}

// LeadingLineNextEvent
struct LockScreenWidgetLeadingLineNextEvent: LockScreenWidgetable {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: Constants.WidgetKind.lockScreenWidgetLeadingLineNextEvent.rawValue,
            provider: DateInfoWidgetTimelineProvider(),
            content: buildContentView
        )
        .supportedFamilies(widgetFamilies)
        .configurationDisplayName(NSLocalizedString("Vertical line", comment: ""))
        .description(NSLocalizedString("With upcoming event", comment: ""))
    }

    private func buildContentView(_ entry: WidgetEntry) -> some View {
        if #available(iOSApplicationExtension 16.0, *) {
            return LockScreenWidgetView(
                entry: entry,
                generalStyle: .line(.leading),
                contentStyle: .nextEvent
            )
            .widgetAccentable()
        } else {
            return EmptyView()
        }
    }
}

// TrailingLineNextEvent
struct LockScreenWidgetTrailingLineNextEvent: LockScreenWidgetable {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: Constants.WidgetKind.lockScreenWidgetTrailingLineNextEvent.rawValue,
            provider: DateInfoWidgetTimelineProvider(),
            content: buildContentView
        )
        .supportedFamilies(widgetFamilies)
        .configurationDisplayName(NSLocalizedString("Vertical line", comment: ""))
        .description(NSLocalizedString("With upcoming event", comment: ""))
    }

    private func buildContentView(_ entry: WidgetEntry) -> some View {
        if #available(iOSApplicationExtension 16.0, *) {
            return LockScreenWidgetView(
                entry: entry,
                generalStyle: .line(.trailing),
                contentStyle: .nextEvent
            )
            .widgetAccentable()
        } else {
            return EmptyView()
        }
    }
}
