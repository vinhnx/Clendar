//
//  UserDefaultsWrapper.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/23/20.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation

// reference: https://www.avanderlee.com/swift/property-wrappers/

@propertyWrapper
struct UserDefault<T> {
	// MARK: Lifecycle

	init(_ key: String, defaultValue: T) {
		self.key = key
		self.defaultValue = defaultValue
	}

	// MARK: Internal

	let key: String
	let defaultValue: T

	var wrappedValue: T {
		get {
			UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
		}
		set {
			UserDefaults.standard.set(newValue, forKey: key)
		}
	}
}
