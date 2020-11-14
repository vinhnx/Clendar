//
//  DateInfoWidgetPlaceholder.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftUI

struct DateInfoWidgetPlaceholder: View {
    var body: some View {
        DateInfoWidgetEntryView(entry: WidgetEntry(date: Date()))
    }
}
