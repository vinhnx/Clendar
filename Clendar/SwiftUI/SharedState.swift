//
//  SharedState.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 11/19/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

class SharedState: ObservableObject {
	@Published var selectedDate = Date()
	@Published var backgroundColor = Color(.backgroundColor)
}
