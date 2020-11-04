//
//  EventEditViewController.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 10/28/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import UIKit
import EventKitUI

class EventEditViewController: EKEventEditViewController {
    
    // MARK: - Life Cycle
    
    init(eventStore: EKEventStore = EventKitWrapper.shared.eventStore, delegate: EKEventEditViewDelegate?) {
        super.init(nibName: nil, bundle: nil)
        self.eventStore = eventStore
        self.editViewDelegate = delegate
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
