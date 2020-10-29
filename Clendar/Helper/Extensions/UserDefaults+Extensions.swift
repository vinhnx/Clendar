//
//  UserDefaults+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/29/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import EventKit

extension UserDefaults {

    @UserDefault("savedCalendarIDs", defaultValue: [])
    static var savedCalendarIDs: [String]

}
