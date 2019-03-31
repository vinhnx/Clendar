//
//  LoggerConfiguration.swift
//  Clendar
//
//  Created by Vinh Nguyen on 31/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import Foundation
import Logging

let logger = Logger(label: "\(AppName).logger")

func log<T: CustomDebugStringConvertible>(_ thing: T) {
    logger.debug("\(thing.debugDescription)")
}

func logError<E: Error & LocalizedError>(_ error: E) {
    logger.error("\(error.localizedDescription)")
}

func logInfo<T: CustomDebugStringConvertible>(_ thing: T) {
    logger.info("\(thing.debugDescription)")
}
