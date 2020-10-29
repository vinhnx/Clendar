//
//  SettingsViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 29/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit
import SwiftyFORM
import SwiftDate

final class SettingsNavigationController: UINavigationController {

    // MARK: - Life Cycle

    init() {
        let settings = SettingsViewController(style: .insetGrouped)
        super.init(rootViewController: settings)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        checkUIMode()

        NotificationCenter.default.addObserver(forName: .didChangeUserInterfacePreferences, object: nil, queue: .main) { (_) in
            self.checkUIMode()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Private

    func checkUIMode() {
        overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
    }

}

final class SettingsViewController: FormViewController {

    // MARK: - Components

    lazy var themes: SegmentedControlFormItem = {
        let proxy = SegmentedControlFormItem()
        proxy.title = "Themes"
        proxy.items = Theme.titles
        proxy.selected = SettingsManager.darkModeActivated
            ? Theme.dark.rawValue
            : Theme.light.rawValue
        proxy.valueDidChangeBlock = { index in
            let theme = Theme(rawValue: index)
            SettingsManager.darkModeActivated = theme == .dark
            UIApplication.shared.windows.first { $0.isKeyWindow }?.overrideUserInterfaceStyle = theme == .dark ? .dark : .light
            NotificationCenter.default.post(name: .didChangeUserInterfacePreferences, object: nil)
        }
        return proxy
    }()

    lazy var calendarMode: SegmentedControlFormItem = {
        let proxy = SegmentedControlFormItem()
        proxy.title = "Calendar mode"
        proxy.items = CalendarViewMode.titles
        proxy.selected = SettingsManager.monthViewCalendarMode
            ? CalendarViewMode.month.rawValue
            : CalendarViewMode.week.rawValue
        proxy.valueDidChangeBlock = { index in
            let mode = CalendarViewMode(rawValue: index)
            SettingsManager.monthViewCalendarMode = mode == .month
            NotificationCenter.default.post(name: .didChangeMonthViewCalendarModePreferences, object: nil)
        }
        return proxy
    }()

    lazy var showDaysOut: SwitchFormItem = {
        let instance = SwitchFormItem()
        instance.title = "Show days out"
        instance.value = SettingsManager.showDaysOut
        instance.switchDidChangeBlock = { activate in
            SettingsManager.showDaysOut = activate
            NotificationCenter.default.post(name: .didChangeShowDaysOutPreferences, object: nil)
        }
        return instance
    }()

    lazy var supplementaryViewMode: OptionPickerFormItem = {
        let instance = OptionPickerFormItem()
        instance.title("Supplementary day view")
        instance.append(DaySupplementaryType.titles)
        instance.selectOptionWithTitle(SettingsManager.daySupplementaryType)
        instance.valueDidChange = { selected in
            SettingsManager.daySupplementaryType = selected?.title ?? DaySupplementaryType.defaultValue.rawValue
            NotificationCenter.default.post(name: .didChangeDaySupplementaryTypePreferences, object: nil)
        }
        return instance
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        checkUIMode()

        NotificationCenter.default.addObserver(forName: .didChangeUserInterfacePreferences, object: nil, queue: .main) { (_) in
            self.checkUIMode()
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Private

    func checkUIMode() {
        overrideUserInterfaceStyle = SettingsManager.darkModeActivated ? .dark : .light
    }

    // MARK: - Form

    override func populate(_ builder: FormBuilder) {
        builder.navigationTitle = "Settings"

        builder += ViewControllerFormItem()
            .title("Calendars")
            .viewController(CalendarsChooserViewController.self)

        // UI
        builder += SectionHeaderTitleFormItem().title("User Interface")
        builder += themes

        // Calendar
        builder += SectionHeaderTitleFormItem().title("Calendar View")
        builder += showDaysOut
        builder += supplementaryViewMode
        builder += calendarMode

        // Info
        builder += SectionHeaderTitleFormItem().title("App info")
        builder += StaticTextFormItem().title("Name").value(AppInfo.appName)
        builder += StaticTextFormItem().title("Version").value(AppInfo.appVersionAndBuild)
    }

}
