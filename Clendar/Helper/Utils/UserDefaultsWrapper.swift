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
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = UserDefaults.groupUserDefaults

    var wrappedValue: Value {
        get {
            container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }

    var projectedValue: UserDefault<Value> {
        self
    }
}
