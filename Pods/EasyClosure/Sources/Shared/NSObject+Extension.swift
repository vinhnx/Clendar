//
//  NSObject+Extension.swift
//  EasyClosure-macOS
//
//  Created by khoa on 18/05/2019.
//  Copyright © 2019 Khoa Pham. All rights reserved.
//

import Foundation

extension NSObject {
    static var uniqueId: String {
        return String(describing: self)
    }
}

