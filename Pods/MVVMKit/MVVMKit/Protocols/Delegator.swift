/*
 Delegator.swift
 
 Copyright (c) 2019 Alfonso Grillo
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import Foundation

/// A protocol describing a generic delegator object.
public protocol Delegator: class { }

internal extension Delegator {
    var rawDelegate: Any? {
        get { return objc_getAssociatedObject(self, &AssociatedObjectKey.rawDelegate) }
        set { objc_setAssociatedObject(self, &AssociatedObjectKey.rawDelegate, newValue, .OBJC_ASSOCIATION_ASSIGN) }
    }
}

/**
 * A protocol describing a delagator object having a specific delegate protocol.
 * You can use this protocol to add a delegate protocol to reusable views (cell, headers, footers).
 * The actual delegate reference is backed by default by the `rawDelegate` internal property of `Delegator` protocol.
 */
public protocol CustomDelegator: Delegator {
    associatedtype Delegate
    var delegate: Delegate? { get set }
}

public extension CustomDelegator {
    var delegate: Delegate? {
        get { return rawDelegate as? Delegate }
        set { rawDelegate = newValue }
    }
}

private struct AssociatedObjectKey {
    static var rawDelegate: String = "rawDelegate"
}
