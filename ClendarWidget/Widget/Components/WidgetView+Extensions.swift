//
//  WidgetView+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 28/10/2023.
//  Copyright © 2023 Vinh Nguyen. All rights reserved.
//

import SwiftUI

// https://stackoverflow.com/a/76842922/1477298
extension View {
    func widgetBackground(_ backgroundView: some View) -> some View {
        if #available(iOS 17, macCatalyst 17, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}
