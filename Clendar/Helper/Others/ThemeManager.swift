//
//  ThemeManager.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation

struct ThemeManager {

    @UserDefault("darkModeActivated", defaultValue: isDarkMode)
    static var darkModeActivated: Bool

}
