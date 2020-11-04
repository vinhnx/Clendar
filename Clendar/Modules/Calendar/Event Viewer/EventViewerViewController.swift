//
//  EventViewerViewController.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 10/28/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import UIKit
import EventKitUI

class EventViewerNavigationController: UINavigationController {
    
    // MARK: - Life Cycle
    
    init(event: EKEvent, delegate: EKEventViewDelegate?) {
        let eventViewer = EventViewerViewController()
        eventViewer.allowsEditing = true
        eventViewer.event = event
        eventViewer.delegate = delegate
        super.init(rootViewController: eventViewer)
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

class EventViewerViewController: EKEventViewController {
    
    // MARK: - Life Cycle

    convenience init(event: EKEvent) {
        self.init()
        self.event = event
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
