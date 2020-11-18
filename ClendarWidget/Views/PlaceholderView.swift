//
//  WidgetPlaceholderView.swift
//  ClendarWidgetExtension
//
//  Created by Vinh Nguyen on 10/31/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation
import SwiftUI

struct WidgetPlaceholderView: View {
	var body: some View {
		WidgetEntryView(entry: WidgetEntry(date: Date()))
	}
}
