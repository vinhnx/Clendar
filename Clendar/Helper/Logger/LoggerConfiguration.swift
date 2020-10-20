//
//  LoggerConfiguration.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation

func log<T: CustomDebugStringConvertible>(_ thing: T) {
    #if DEBUG
    print("[DEBUG] \(thing.debugDescription)")
    #endif
}

func logError<E: Error>(_ error: E) {
    #if DEBUG
    print("[ERROR] \(error.localizedDescription)")
    #endif
}

func logInfo<T: CustomDebugStringConvertible>(_ thing: T) {
    #if DEBUG
    print("[INFO] \(thing.debugDescription)")
    #endif
}
