//
//  ContactsPermission.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/02/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import Foundation
import Contacts

struct ContactsPermission {
    static func request() {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized,
             .restricted,
             .denied:
            break
        case .notDetermined:
            CNContactStore().requestAccess(for: .contacts) { (_, error) in
                if let error = error {
                    logError(error)
                    return
                }
            }
        @unknown default:
            break
        }
    }
}
