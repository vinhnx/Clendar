//
//  Calendar+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/20/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftDate

extension Calendar {

    static func shared() -> Calendar {
        var proxy = Calendar.autoupdatingCurrent
        proxy.locale = Region.local.locale
        return proxy
    }

}
