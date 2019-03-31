//
//  EventError.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation

typealias ErrorLocalized = Error & LocalizedError
enum EventError: ErrorLocalized {
    case failedToAuthorizeEventPersmissson

    var localizedDescription: String {
        switch self {
        case .failedToAuthorizeEventPersmissson:
            return "Failed to authorize event persmissson"
        @unknown default:
            return ""
        }
    }
}
