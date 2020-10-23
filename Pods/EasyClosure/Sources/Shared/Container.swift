//
//  EasyClosure
//
//  Created by khoa on 18/05/2019.
//  Copyright © 2019 Khoa Pham. All rights reserved.
//

import Foundation

public class Container<Host: AnyObject>: NSObject {
    public unowned let host: Host
    
    public init(host: Host) {
        self.host = host
    }
    
    // Keep all targets alive
    public var targets = [String: NSObject]()
}
