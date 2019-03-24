//
//  CalendarViewModel.swift
//  Clendar
//
//  Created by Vinh Nguyen on 24/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import MVVMKit

class CalendarViewModel: BaseViewModel {
    var weakBinder: WeakReference<Binder>?

    struct Model {}
    private var model: Model? {
        didSet { self.binder?.bind(viewModel: self) }
    }

    init(model: Model) {
        self.model = model
    }
}
