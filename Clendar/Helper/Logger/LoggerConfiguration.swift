//
//  LoggerConfiguration.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import Logging

// Reference: https://nshipster.com/swift-log/

var logger = Logger(label: "com.Clendar.logger")

func log<T: CustomDebugStringConvertible>(_ thing: T) {
    #if DEBUG
	logger.debug("\(thing.debugDescription)")
    #endif
}

func logError<E: Error>(_ error: E) {
    #if DEBUG
	logger.error("\(error.localizedDescription)")
    #endif
}

func logInfo<T: CustomDebugStringConvertible>(_ thing: T) {
    #if DEBUG
	logger.info("\(thing.debugDescription)")
    #endif
}
