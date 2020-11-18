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

var logger = Logger(label: "com.\(AppInfo.appName).logger")

func log<T: CustomDebugStringConvertible>(_ thing: T) {
	logger.debug("\(thing.debugDescription)")
}

func logError<E: Error>(_ error: E) {
	logger.error("\(error.localizedDescription)")
}

func logInfo<T: CustomDebugStringConvertible>(_ thing: T) {
	logger.info("\(thing.debugDescription)")
}
