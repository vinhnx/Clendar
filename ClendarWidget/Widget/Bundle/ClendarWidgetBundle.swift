//
//  ClendarWidgetBundle.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 11/1/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

@main
struct ClendarWidgetBundle: WidgetBundle {
    var body: some Widget {
        NormalWidgetsBundle().body
    }
}

//struct PremiumWidgetsBundle: WidgetBundle {
//    var body: some Widget {
//        PreviewWidget()
//    }
//}

struct NormalWidgetsBundle: WidgetBundle {
    var body: some Widget {
        ClendarWidget()
    }
}
