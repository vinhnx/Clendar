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

final class SettingsNavigationController: UINavigationController {
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
		overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
	}
}

final class SettingsViewController: FormViewController {
	// MARK: Lifecycle

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	// MARK: Internal

	lazy var themes: SegmentedControlFormItem = {
		let proxy = SegmentedControlFormItem()
		proxy.title = NSLocalizedString("Themes", comment: "")
		proxy.items = Theme.titles
		proxy.selected = SettingsManager.darkModeActivated
			? Theme.dark.rawValue
			: Theme.light.rawValue
		proxy.valueDidChangeBlock = { index in
			let theme = Theme(rawValue: index)
			SettingsManager.darkModeActivated = theme == .dark
			UIApplication.shared.windows.first { $0.isKeyWindow }?.overrideUserInterfaceStyle = theme == .dark ? .dark : .light
			NotificationCenter.default.post(name: .didChangeUserInterfacePreferences, object: nil)
//
//            let url = FileManager.appGroupContainerURL.appendingPathComponent(FileManager.widgetTheme)
//            try? String(theme?.text ?? Theme.light.text).write(to: url, atomically: false, encoding: .utf8)
//            WidgetCenter.shared.reloadTimelines(ofKind: "DateInfoWidget")
		}
		return proxy
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
		instance.selectOptionWithTitle(SettingsManager.daySupplementaryType)
		instance.valueDidChange = { selected in
			SettingsManager.daySupplementaryType = selected?.title ?? DaySupplementaryType.defaultValue.rawValue
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
			NotificationCenter.default.post(name: .didChangeUseExperimentalCreateEventMode, object: nil)
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
        instance.selectOptionWithTitle(SettingsManager.widgetTheme)
        instance.valueDidChange = { selected in
            SettingsManager.widgetTheme = selected?.title ?? WidgetTheme.defaultValue.localizedText

            let url = FileManager.appGroupContainerURL.appendingPathComponent(FileManager.widgetTheme)
            try? String(SettingsManager.widgetTheme).write(to: url, atomically: false, encoding: .utf8)
            // reload widget center
            WidgetCenter.shared.reloadTimelines(ofKind: "DateInfoWidget")
        }
        return instance
    }()

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
		builder += enableHapticFeedback
		builder += ViewControllerFormItem().title(NSLocalizedString("Custom App Icon", comment: "")).viewController(AppIconChooserViewController.self)

		// Calendar
        // TODO: support in future versions..
        builder += SectionHeaderTitleFormItem().title(NSLocalizedString("Calendar View", comment: ""))
        // builder += calendarMode
        builder += showDaysOut
        builder += supplementaryViewMode
        builder += shouldAutoSelectDayOnCalendarChange
        builder += SectionFooterTitleFormItem().title(NSLocalizedString("Auto-select first day of month/week when calendar changes", comment: ""))

		// Quick Event
		builder += SectionHeaderTitleFormItem().title(NSLocalizedString("Quick Event", comment: ""))
		builder += defaultEventDuration
		builder += quickEventMode
		builder += SectionFooterTitleFormItem().title(NSLocalizedString("[Beta] You can choose to use experimental natural language parsing mode when create new event. This feature will be improved.", comment: ""))

		// Info
		builder += SectionHeaderTitleFormItem().title(NSLocalizedString("App info", comment: ""))
		builder += StaticTextFormItem().title(NSLocalizedString("Name", comment: "")).value(AppInfo.appName)
		builder += StaticTextFormItem().title(NSLocalizedString("Version", comment: "")).value(AppInfo.appVersionAndBuild)
	}
}
