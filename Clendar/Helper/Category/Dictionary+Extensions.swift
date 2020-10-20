//
//  Dictionary+Extensions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 25/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation

typealias TypedUserInfoKey<T> = (key: String, type: T.Type)

extension Dictionary where Key == String, Value == Any {
    subscript<T>(_ typedKey: TypedUserInfoKey<T>) -> T? {
        return self[typedKey.key] as? T
    }
}

// MARK: - Extensions
extension Dictionary where Key == String {

    // MARK: - Helper

    /// Find value for key in-sensitive search, eg: "FooBar","fooBar","FOOBAR","FoOBaR"...
    ///
    /// - Parameter key: key
    /// - Returns: value
    func valueForKeyInsensitive<T>(key: Key) -> T? {
        let foundKey = self.keys.first { $0.compare(key, options: .caseInsensitive) == .orderedSame } ?? key // IMPORTANT: fallback to original key if search failed
        return self[foundKey] as? T
    }

    /// Merge two dictionaries, reference: https://stackoverflow.com/a/26728685/1477298
    mutating func merge(dict: [Key: Value]) {
        for (k, v) in dict {
            updateValue(v, forKey: k)
        }
    }

    /// Array for key
    ///
    /// - Parameter key: key
    /// - Returns: value
    func arrayFor<T>(key: Key) -> [T] {
        return self.valueForKeyInsensitive(key: key) ?? [T]()
    }

    /// Dictionary for key
    ///
    /// - Parameter key: key
    /// - Returns: dictionary
    func dictionaryFor(key: Key) -> [String: Any] {
        return self.valueForKeyInsensitive(key: key) ?? [String: Any]()
    }

    /// Subscript
    ///
    /// - Parameter key: the key
    /// - Returns: value subscript
    func valueFor<T>(key: Key) -> T? {
        return self.valueForKeyInsensitive(key: key)
    }

    /// String subscript
    ///
    /// - Parameter key: the key
    /// - Returns: value subscript, cast as String
    func stringFor(key: Key) -> String {
        return self.valueForKeyInsensitive(key: key).orEmpty
    }

    /// String subscript
    ///
    /// - Parameter key: the key
    /// - Returns: value subscript, cast as Int
    func intFor(key: Key) -> Int {
        return self.valueForKeyInsensitive(key: key) ?? 0
    }

    /// Double for key
    ///
    /// - Parameter key: key
    /// - Returns: value
    func doubleFor(key: Key) -> Double {
        return self.valueForKeyInsensitive(key: key) ?? 0.0
    }

    /// Float for key
    ///
    /// - Parameter key: key
    /// - Returns: value
    func floatFor(key: Key) -> Float {
        return self.valueForKeyInsensitive(key: key) ?? 0.0
    }

    /// Pretty dictionary
    func prettyPrint() {
        do {
            let _serialized = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            log(String(data: _serialized, encoding: .utf8) ?? self.description)
        } catch {
            logError(error)
        }
    }

    /// Remove empty string from dictionary, useful for analytics
    ///
    /// - Returns: A filtered dictionary
    func filterEmptyStringValue() -> [Key: Value] {
        return self.filter { (_, value) -> Bool in
            if value is String {
                return ((value as? String) ?? "").isEmpty == false
            }

            return true
        }
    }

    var toData: Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            log("invalid json: \(self)")
            return nil
        }

        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        } catch {
            logError(error)
            return nil
        }
    }

    var toString: String {
        return self.description
    }
}
