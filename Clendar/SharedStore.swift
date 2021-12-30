//
//  Store.swift
//  Clendar
//
//  Created by Vĩnh Nguyễn on 11/19/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import SwiftUI

final class SharedStore: ObservableObject {
    // events
    @Published var selectedDate = Date()
    @Published var appBackgroundColor = Color(.backgroundColor)

    // views presentation
    @Published var showCreateEventState = false
    @Published var showSettingsState = false
    @Published var showSiriShortcuts = false
}
