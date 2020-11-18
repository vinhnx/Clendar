//
//  ClendarError.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import EventKit
import Foundation

enum ClendarError: Error, LocalizedError {
	case mapFromError(Error)
	case unableToAccessCalendar
	case failedToAuthorizeEventPersmissson(EKAuthorizationStatus? = nil)

	// MARK: Internal

	var localizedDescription: String {
		switch self {
		case let .mapFromError(error): return error.localizedDescription
		case .unableToAccessCalendar: return "Unable to access celendar"
		case let .failedToAuthorizeEventPersmissson(status):
			if let status = status {
				return "Failed to authorize event persmissson, status: \(status)"
			} else {
				return "Failed to authorize event persmissson"
			}
		}
	}
}
