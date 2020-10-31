//
//  ClendarError.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import EventKit

enum ClendarError: Error, LocalizedError {
    case mapFromError(Error)
    case unableToAccessCalendar
    case failedToAuthorizeEventPersmissson(EKAuthorizationStatus? = nil)

    var localizedDescription: String {
        switch self {
        case .mapFromError(let error): return error.localizedDescription
        case .unableToAccessCalendar: return "Unable to access celendar"
        case .failedToAuthorizeEventPersmissson(let status):
            if let status = status {
                return "Failed to authorize event persmissson, status: \(status)"
            } else {
                return "Failed to authorize event persmissson"
            }
        }
    }
}
