//
//  Calendar+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/20/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation

extension Calendar {

    static func makeGregorianCalendar(
        localeIdentifier: LocaleIdentifer = .Vietnam
    ) -> Calendar {
        var proxy = Calendar(identifier: .gregorian)
        proxy.locale = Locale(identifier: localeIdentifier.rawValue)
        return proxy
    }

}
