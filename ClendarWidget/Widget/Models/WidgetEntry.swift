//
//  WidgetEntry.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI
import WidgetKit

struct WidgetEntry: TimelineEntry {
	var date: Date
	var events: [ClendarEvent] = []
}
