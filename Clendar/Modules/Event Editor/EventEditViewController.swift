//
//  EventEditViewController.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 10/28/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import EventKitUI
import UIKit
import Shift

class EventEditViewController: EKEventEditViewController {
    // MARK: Lifecycle

    init(
        eventStore: EKEventStore = Shift.shared.eventStore,
        delegate: EKEventEditViewDelegate?
    ) {
        super.init(nibName: nil, bundle: nil)
        self.eventStore = eventStore
        editViewDelegate = delegate
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
