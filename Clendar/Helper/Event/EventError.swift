//
//  ClendarError.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import EventKit
import Foundation

typealias ErrorLocalized = Error & LocalizedError

enum ClendarError: ErrorLocalized {
	case failedToAuthorizeEventPersmissson(EKAuthorizationStatus? = nil)

	// MARK: Internal

	//

	var localizedDescription: String {
		switch self {
		case let .failedToAuthorizeEventPersmissson(status):
			if let status = status {
				return "Failed to authorize event persmissson, status: \(status)"
			} else {
				return "Failed to authorize event persmissson"
			}
		}
	}
}
