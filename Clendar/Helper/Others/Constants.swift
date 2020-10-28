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
typealias EventCompletion = ((EKEvent) -> Void)
typealias EventsCompletion = (([EKEvent]) -> Void)

// constants
let dayTime: TimeInterval = 24 * 3600
