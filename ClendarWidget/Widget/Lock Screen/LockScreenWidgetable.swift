//
//  LockScreenWidgetable.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 03/09/2022.
//  Copyright © 2022 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

protocol LockScreenWidgetable where Self: Widget {
    var widgetFamilies: [WidgetFamily] { get }
}

extension LockScreenWidgetable {
    var widgetFamilies: [WidgetFamily] {
        if #available(iOSApplicationExtension 16.0, *) {
            return [
                .accessoryInline,
                .accessoryCircular,
                .accessoryRectangular
            ]
        } else {
            return []
        }
    }
}
