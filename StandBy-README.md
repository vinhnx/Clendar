# StandBy support (issue #255)

Issue #255 asks for iOS 17 nightstand landscape mode. That is StandBy: the
full-screen landscape view iPhone shows while charging. Owner confirmed the
scope in the thread. Make the existing Home Screen widgets render correctly
in StandBy, starting from CalendarGridWidget and DateInfoWidget.

## Why widgets needed work for StandBy

Per WWDC23 "Bring widgets to new places" and Apple's WidgetKit docs:

- Widgets appear in StandBy automatically. No opt-in API exists.
- In StandBy the system strips the container background. A widget without
  the iOS 17 `containerBackground(for: .widget)` API shows a "Please adopt
  containerBackground API" placeholder instead of content.
- With the background stripped, dark text drawn for the Home Screen can
  vanish on the dark StandBy backdrop. Apple recommends reading
  `showsWidgetContainerBackground` and adapting foreground colors.
- StandBy keeps widgets on screen for hours, so the timeline must keep
  refreshing past midnight.
- The large size is wide in landscape, so it should use the extra width.

## What was already in place

- All four main widgets (grid, date info, event list, lunar) render through
  the `widgetBackground` helper, which uses `containerBackground(for:
  .widget)` on iOS 17 and falls back to `background` on iOS 15/16.
- All widgets support systemSmall, systemMedium and systemLarge.
- Medium and large layouts are HStack based, so they already fit landscape.
- Every widget uses DateInfoWidgetTimelineProvider, which refreshes every
  5 minutes. The date rolls over at midnight and events stay fresh
  overnight in StandBy.
- The background stays removable (default), which keeps the widgets in the
  StandBy gallery. Nothing sets `containerBackgroundRemovable(false)`.

## What this change does

1. Legible text without the container background.
   - New `standByAdaptiveForeground(normal:standBy:)` modifier in
     `ClendarWidget/Widget/Components/WidgetView+Extensions.swift`. It reads
     `showsWidgetContainerBackground` and picks the StandBy color when
     WidgetKit removed the background. On the Home Screen and on iOS 15/16
     the value is true, so the current look is unchanged.
   - Applied to the dark text that disappears on the StandBy backdrop:
     the big date in `DateInfoWidgetEntryView.swift` and
     `LunarSmallDateWidgetView.swift`, and the weekday headers in
     `CalendarGridWidgetView.swift`. Each uses white in StandBy and keeps
     `.appDark` everywhere else. Red and gray accents are readable on dark
     and were left alone.

2. Event list uses the landscape width.
   - New `EventListWidgetEntryView` in
     `ClendarWidget/Widget/Event List/EventListWidgetView.swift`. It reads
     `widgetFamily`: systemLarge and systemExtraLarge show the full list
     (up to 6 events), compact sizes keep the minimized 3-row version.
     Previously every size showed the minimized version, leaving the wide
     StandBy large widget mostly empty.

3. No truncation in compact StandBy rendering.
   - The lunar widget's 45pt date text now has `.minimumScaleFactor(0.5)`,
     matching the date info widget.

4. Previews for landscape verification.
   - `DateInfoWidgetEntryView` previews now cover small, medium and large,
     with the medium and large ones labeled for StandBy landscape.
   - New `CalendarGridWidgetView_Previews` with the same three sizes.

## Files touched

StandBy changes:
- `ClendarWidget/Widget/Components/WidgetView+Extensions.swift`
- `ClendarWidget/Widget/Date Info/DateInfoWidgetEntryView.swift`
- `ClendarWidget/Widget/Lunar/LunarSmallDateWidgetView.swift`
- `ClendarWidget/Widget/Calendar Grid/CalendarGridWidgetView.swift`
- `ClendarWidget/Widget/Event List/EventListWidgetView.swift`

Build fixes needed to compile with Xcode 27 (from the earlier build
repair session, kept because the StandBy work must build):
- `Podfile`: platform raised from iOS 13.0 to 15.0, post_install pins pod
  deployment targets to 15.0 instead of deleting the setting.
- `Clendar.xcodeproj/project.pbxproj`: SwiftLint phase uses the system
  swiftlint and never fails the build (the pod ships an Intel-only
  binary); Licenses phase skips the Intel-only license-plist binary the
  same way.
- Regenerated `Pods/` output, `Podfile.lock` (CocoaPods 1.13.0 to 1.17.0).

No changes to providers, bundle, or signing.

## How to test

1. Build scheme `Clendar` for an iPhone simulator on iOS 17 or later and
   install the app. Add the "Calendar grid view", "Date Info Widget" and
   "Event List Widget" widgets to the Home Screen first.
2. On a real device running iOS 17 or later: connect power, rotate to
   landscape, and StandBy starts. Long-press to add Clendar widgets and
   flip through small, medium and large.
3. Check night mode: wait for the red-tinted night clock, then tap the
   widget side. Text must stay readable.
4. Leave it charging past midnight. The date and event list must roll over
   without touching the phone.
5. In Xcode Previews, open the new small/medium/large previews for the
   date info and calendar grid views.

## Status

Changes are implemented and the widget extension target builds. Nothing is
committed or pushed. Awaiting review before push.
