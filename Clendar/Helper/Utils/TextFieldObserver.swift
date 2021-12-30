//
//  TextFieldObserver.swift
//  Clendar
//
//  Created by Vinh Nguyen on 18/12/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import Foundation
import Combine

// reference https://stackoverflow.com/a/66165075/1477298
final class TextFieldObserver: ObservableObject {
    @Published var debouncedText = ""
    @Published var searchText = ""

    private var subscriptions = Set<AnyCancellable>()

    init() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink(receiveValue: { t in
                self.debouncedText = t
            })
            .store(in: &subscriptions)
    }
}
