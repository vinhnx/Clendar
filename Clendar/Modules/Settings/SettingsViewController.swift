//
//  SettingsViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 29/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import SwiftDate
import SwiftyFORM
import UIKit
import WidgetKit
import EventKitUI
import SwiftUI

final class SettingsNavigationController: BaseNavigationController {

    // MARK: Lifecycle

    init() {
        let settings = SettingsViewController(style: .insetGrouped)
        super.init(rootViewController: settings)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Internal

    override func viewDidLoad() {
        super.viewDidLoad()

        checkUIMode()

        NotificationCenter.default.addObserver(forName: .didChangeUserInterfacePreferences, object: nil, queue: .main) { _ in
            self.checkUIMode()
        }
    }

    func checkUIMode() {
        overrideUserInterfaceStyle = isDarkMode ? .dark : .light
    }
}

final class SettingsViewController: FormViewController {

    // MARK: Lifecycle

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Internal

    lazy var themes: OptionPickerFormItem = {
        let instance = OptionPickerFormItem()
        instance.title(NSLocalizedString("Themes", comment: ""))
        instance.append(AppTheme.titles)

        let title = AppTheme(rawValue: SettingsManager.currentAppTheme)?.localizedText ?? AppTheme.defaultValue.localizedText
        instance.selectOptionWithTitle(title)
        instance.valueDidChange = { selected in
            genLightHaptic()

            let type = AppTheme.mapFromText(selected?.title)
            SettingsManager.currentAppTheme = type.rawValue

            switch type {
            case .light, .trueLight, .E4ECF5:
                SettingsManager.darkModeActivated = false
                UIApplication.shared.windows.first { $0.isKeyWindow }?.overrideUserInterfaceStyle = .light
            case .dark, .trueDark:
                SettingsManager.darkModeActivated = true
                UIApplication.shared.windows.first { $0.isKeyWindow }?.overrideUserInterfaceStyle = .dark
            default:
                SettingsManager.darkModeActivated = isDarkMode
                UIApplication.shared.windows.first { $0.isKeyWindow }?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
            }

            NotificationCenter.default.post(name: .didChangeUserInterfacePreferences, object: nil)
        }
        return instance
    }()

    lazy var showDaysOut: SwitchFormItem = {
        let instance = SwitchFormItem()
        instance.title = NSLocalizedString("Show days out", comment: "")
        instance.value = SettingsManager.showDaysOut
        instance.switchDidChangeBlock = { activate in
            SettingsManager.showDaysOut = activate
            NotificationCenter.default.post(name: .didChangeShowDaysOutPreferences, object: nil)
        }
        return instance
    }()

    lazy var supplementaryViewMode: OptionPickerFormItem = {
        let instance = OptionPickerFormItem()
        instance.title(NSLocalizedString("Supplementary day view", comment: ""))
        instance.append(DaySupplementaryType.titles)

        let title = DaySupplementaryType(rawValue: SettingsManager.daySupplementaryType)?.localizedText ?? DaySupplementaryType.defaultValue.localizedText
        instance.selectOptionWithTitle(title)
        instance.valueDidChange = { selected in
            genLightHaptic()

            let type = DaySupplementaryType.mapFromText(selected?.title)
            SettingsManager.daySupplementaryType = type.rawValue

            NotificationCenter.default.post(name: .didChangeDaySupplementaryTypePreferences, object: nil)
        }
        return instance
    }()

    lazy var quickEventMode: SwitchFormItem = {
        let instance = SwitchFormItem()
        instance.title = NSLocalizedString("Quick Event", comment: "")
        instance.value = SettingsManager.useExperimentalCreateEventMode
        instance.switchDidChangeBlock = { activate in
            SettingsManager.useExperimentalCreateEventMode = activate
        }
        return instance
    }()

    lazy var shouldAutoSelectDayOnCalendarChange: SwitchFormItem = {
        let instance = SwitchFormItem()
        instance.title = NSLocalizedString("Auto-select day", comment: "")
        instance.value = SettingsManager.shouldAutoSelectDayOnCalendarChange
        instance.switchDidChangeBlock = { activate in
            SettingsManager.shouldAutoSelectDayOnCalendarChange = activate
            NotificationCenter.default.post(name: .justReloadCalendar, object: nil)
        }
        return instance
    }()

    lazy var defaultEventDuration: OptionPickerFormItem = {
        let instance = OptionPickerFormItem()
        instance.title(NSLocalizedString("Default event duration", comment: ""))
        let minutesText = NSLocalizedString("minutes", comment: "")
        instance.append(DefaultEventDurations.map { minute in "\(minute)" + " " + minutesText })
        instance.selectOptionWithTitle("\(SettingsManager.defaultEventDuration)" + " " + minutesText)
        instance.valueDidChange = { selected in
            guard let title = selected?.title else { return }
            guard let duration = title.parseInt() else { return }
            genLightHaptic()
            SettingsManager.defaultEventDuration = duration
            NotificationCenter.default.post(name: .didChangeDefaultEventDurationPreferences, object: nil)
        }
        return instance
    }()

    lazy var enableHapticFeedback: SwitchFormItem = {
        let instance = SwitchFormItem()
        instance.title = NSLocalizedString("Haptic feedback", comment: "")
        instance.value = SettingsManager.enableHapticFeedback
        instance.switchDidChangeBlock = { activate in
            SettingsManager.enableHapticFeedback = activate
        }
        return instance
    }()

    lazy var widgetTheme: OptionPickerFormItem = {
        let instance = OptionPickerFormItem()
        instance.title(NSLocalizedString("Widget theme", comment: ""))
        instance.append(WidgetTheme.titles)

        let title = WidgetTheme(rawValue: SettingsManager.widgetTheme)?.localizedText ?? WidgetTheme.defaultValue.localizedText
        instance.selectOptionWithTitle(title)
        instance.valueDidChange = { selected in
            guard let selected = selected else { return }

            genLightHaptic()

            // decode selected theme
            let theme = WidgetTheme.mapFromText(selected.title)
            SettingsManager.widgetTheme = theme.rawValue

            // save widget config to app group container file
            let url = FileManager.appGroupContainerURL.appendingPathComponent(FileManager.widgetTheme)
            try? String(theme.localizedText).write(to: url, atomically: false, encoding: .utf8)

            // reload widget center
            Constants.WidgetKind.allCases.forEach { kind in
                WidgetCenter.shared.reloadTimelines(ofKind: kind.rawValue)
            }
        }
        return instance
    }()

    lazy var writeReviewButton: ButtonFormItem = {
        let instance = ButtonFormItem()
        instance.title = "⭐️ " + NSLocalizedString("Rate Clendar", comment: "")
        instance.action = { [weak self] in
            genLightHaptic()
            RatingManager().requestReview()
            if let writeReviewURL = URL(string: Constants.AppStore.reviewURL) {
                UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
            }
        }
        return instance
    }()

    lazy var shareAppButton: ButtonFormItem = {
        let instance = ButtonFormItem()
        instance.title = "🕊 " + NSLocalizedString("Share Clendar", comment: "")
        instance.action = { [weak self] in
            genLightHaptic()
            // swiftlint:disable:next force_unwrapping
            let activity = UIActivityViewController(activityItems: [URL(string: Constants.AppStore.url)!], applicationActivities: nil)
            self?.present(activity, animated: true, completion: nil)
        }
        return instance
    }()

    lazy var feedbackMailButton: ButtonFormItem = {
        let instance = ButtonFormItem()
        instance.title = "📨 " + NSLocalizedString("Feedback/Report Issue", comment: "")
        instance.action = {
            MailComposer().showFeedbackComposer()
        }
        return instance
    }()

    lazy var calendarView: SegmentedControlFormItem = {
        let proxy = SegmentedControlFormItem()
        proxy.title = NSLocalizedString("Calendar View", comment: "")
        proxy.items = CalendarViewMode.titles
        proxy.selected = SettingsManager.isOnMonthViewSettings
            ? CalendarViewMode.month.rawValue
            : CalendarViewMode.week.rawValue
        proxy.valueDidChangeBlock = { index in
            genLightHaptic()

            let type = CalendarViewMode(rawValue: index)
            SettingsManager.calendarViewMode = type?.rawValue ?? CalendarViewMode.defaultValue.rawValue

            NotificationCenter.default.post(name: .didChangeMonthViewCalendarModePreferences, object: nil)
        }
        return proxy
    }()

    lazy var tipJarButton: ButtonFormItem = {
        let instance = ButtonFormItem()
        instance.title = "☕️ " + NSLocalizedString("Tip Jar", comment: "")
        instance.action = {
            let viewModel = ModalWrapperView()
            let swiftUIView = ClendarPlusView(viewModel: viewModel)
            let hostingController = UIHostingController(rootView: swiftUIView)
            viewModel.closeAction = {
                hostingController.dismiss(animated: true, completion: nil)
            }

            self.present(hostingController, animated: true, completion: nil)
        }

        return instance
    }()

    lazy var siriShortcutButton: ButtonFormItem = {
        let instance = ButtonFormItem()
        instance.title = "🪄 " + R.string.localizable.siriShortcuts()
        instance.action = {
            let viewModel = ModalWrapperView()
            let swiftUIView = SiriShortcutsView(viewModel: viewModel)
            let hostingController = UIHostingController(rootView: swiftUIView)
            viewModel.closeAction = {
                hostingController.dismiss(animated: true, completion: nil)
            }
            self.present(hostingController, animated: true, completion: nil)
        }

        return instance
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        hidesBottomBarWhenPushed = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .done, target: self, action: #selector(dimissModal))

        checkUIMode()

        NotificationCenter.default.addObserver(forName: .didChangeUserInterfacePreferences, object: nil, queue: .main) { _ in
            self.checkUIMode()
        }
    }

    func checkUIMode() {
        overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
    }

    override func populate(_ builder: FormBuilder) {
        builder.navigationTitle = NSLocalizedString("Settings", comment: "")

        // General
        builder += SectionHeaderTitleFormItem().title(NSLocalizedString("General", comment: ""))
        builder += themes
        builder += widgetTheme
        builder += ViewControllerFormItem().title(NSLocalizedString("Keyboard shortcuts", comment: "")).viewController(KeyboardShortcutsViewController.self)

        #if !targetEnvironment(macCatalyst)
        builder += enableHapticFeedback
        builder += ViewControllerFormItem().title(NSLocalizedString("Custom App Icon", comment: "")).viewController(AppIconChooserViewController.self)
        builder += siriShortcutButton
        #endif

        // Calendar
        builder += SectionHeaderTitleFormItem().title(NSLocalizedString("Calendar", comment: ""))
        builder += calendarView
        builder += ViewControllerFormItem().title(NSLocalizedString("Calendars Visibility", comment: "")).viewController(CalendarChooserViewController.self)
        builder += supplementaryViewMode
        builder += showDaysOut
        builder += shouldAutoSelectDayOnCalendarChange
        builder += SectionFooterTitleFormItem().title(NSLocalizedString("Auto-select first day of month/week when calendar changes", comment: ""))

        // Quick Event
        builder += SectionHeaderTitleFormItem().title(NSLocalizedString("Quick Event", comment: ""))
        builder += quickEventMode
        builder += defaultEventDuration
        builder += SectionFooterTitleFormItem().title(NSLocalizedString("[Beta] You can choose to use experimental natural language parsing mode when create new event. This feature will be improved.", comment: ""))

        // Sharing
        builder += SectionHeaderTitleFormItem().title(NSLocalizedString("Support", comment: ""))
        builder += tipJarButton
        builder += writeReviewButton
        builder += shareAppButton
        builder += feedbackMailButton

        // Info
        builder += SectionHeaderTitleFormItem().title(NSLocalizedString("App info", comment: ""))
        builder += StaticTextFormItem().title(NSLocalizedString("Name", comment: "")).value(AppInfo.appName)
        builder += StaticTextFormItem().title(NSLocalizedString("Version", comment: "")).value(AppInfo.appVersionAndBuild)
    }
}
