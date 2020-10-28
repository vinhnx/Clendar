//
//  Reusable.swift
//  Clendar
//
//  Created by Vinh Nguyen on 23/3/19.
//  Copyright © 2019 Vinh Nguyen. All rights reserved.
//

import UIKit

/// Provide generic interfaces for resuable views (plain view, collection view cell, table view cell)
protocol ReusableView: class {
    /// Reuse identifer of the view
    static var reuseIdentifier: String { get }

    /// Nib instance to load the view from
    static var nib: UINib? { get }
}

// MARK: - Default implementation

extension ReusableView {
    /// Reuse ID
    static var reuseIdentifier: String { String(describing: self) }
    /// Nib instance
    static var nib: UINib? { nil }
}
