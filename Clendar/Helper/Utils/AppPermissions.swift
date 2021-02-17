//
//  AppPermissions.swift
//  Clendar
//
//  Created by Vinh Nguyen on 10/02/2021.
//  Copyright © 2021 Vinh Nguyen. All rights reserved.
//

import Foundation
import Contacts
import CoreLocation

struct ContactsPermission {
    static var authorizationStatus: CNAuthorizationStatus {
        CNContactStore.authorizationStatus(for: .contacts)
    }

    static func request() {
        guard authorizationStatus != .authorized else { return }
        CNContactStore().requestAccess(for: .contacts) { (_, error) in
            if let error = error {
                logError(error)
                return
            }
        }
    }
}

struct LocationPermission {
    static var authorizationStatus: CLAuthorizationStatus {
        CLLocationManager().authorizationStatus
    }

    static var isAuthorized: Bool {
        authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways
    }

    static func request() {
        guard isAuthorized else { return }
        CLLocationManager().requestWhenInUseAuthorization()
    }
}

struct AppPermissions {
    static var isAllAuthorized: Bool {
        ContactsPermission.authorizationStatus == .authorized && LocationPermission.isAuthorized
    }

    static func request() {
        ContactsPermission.request()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            LocationPermission.request()
        }
    }
}
