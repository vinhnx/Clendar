//
//  AppWideConstants.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import UIKit
import CVCalendar
import EventKit

// typealiasing
typealias VoidHandler = () -> Void
typealias DateUpdateHandler = (CVDate) -> Void
typealias EventCalendarHandler = (EKCalendar) -> Void
typealias SizeUpdateHandler = ((CGSize) -> Void)
typealias EventResult = Result<[EKEvent], EventError>
typealias EventResultHandler = (EventResult) -> Void

// constants
let AppName = Bundle.main.infoDictionary?.stringFor(key: "ProductName") ?? ""
let dayTime: TimeInterval = 24 * 3600

// notifications
let kDidAuthorizeCalendarAccess = Notification.Name(rawValue: "kDidAuthorizeCalendarAccess")
