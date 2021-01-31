//
//  KeyboardShortcutsViewController.swift
//  Clendar
//
//  Created by Vinh Nguyen on 29/01/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import UIKit
import SwiftyFORM

// TODO: consider this is a premium/unlockable feature

class KeyboardShortcutsViewController: FormViewController {
    override func populate(_ builder: FormBuilder) {
        builder.navigationTitle = NSLocalizedString("Keyboard shortcuts", comment: "")
        builder.demo_showInfo(NSLocalizedString("Productivity, increased! 🚀", comment: ""))

        // unicode keys code
        // \u{2318}: command
        // \u{21E7}: shift
        // \u{001B}: escape
        // \u{0009}: tab
        builder += SectionHeaderTitleFormItem().title(NSLocalizedString("Events", comment: ""))
        builder += StaticTextFormItem().title(NSLocalizedString("Create new event", comment: "")).value("\u{2318} N")
        builder += StaticTextFormItem().title(NSLocalizedString("Edit Event", comment: "")).value("\u{2318} \u{21E7} E")
        builder += StaticTextFormItem().title(NSLocalizedString("Dismiss view", comment: "")).value("\u{2318} ESC")
        builder += StaticTextFormItem().title(NSLocalizedString("Save event", comment: "")).value("\u{2318} \u{21E7} S")
        builder += StaticTextFormItem().title(NSLocalizedString("Toggle all day switch", comment: "")).value("\u{2318} TAB")

        builder += SectionHeaderTitleFormItem().title(NSLocalizedString("Calendar", comment: ""))
        builder += StaticTextFormItem().title(NSLocalizedString("Switch to current date", comment: "")).value("\u{2318} \u{21E7} H")

        builder += SectionHeaderTitleFormItem().title(NSLocalizedString("General", comment: ""))
        builder += StaticTextFormItem().title(NSLocalizedString("Preferences", comment: "")).value("\u{2318} ,")
        builder += StaticTextFormItem().title(R.string.localizable.showSiriShortcutsView()).value("\u{2318} \u{21E7} O")
    }
}
