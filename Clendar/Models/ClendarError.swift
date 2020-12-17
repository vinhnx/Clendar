//
//  ClendarError.swift
//  Clendar
//
//  Created by Vinh Nguyen on 17/12/2020.
//  Copyright © 2020 Vinh Nguyen. All rights reserved.
//

import Foundation

public enum ClendarError: Error, LocalizedError {
    case mapFromError(Error)
}
