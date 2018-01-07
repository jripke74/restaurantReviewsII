//
//  LocationManager.swift
//  RestaurantReviewsII
//
//  Created by Jeff Ripke on 1/7/18.
//  Copyright © 2018 Jeff Ripke. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationError: Error {
    case unkownError
    case disallowedByUser
    case unableToFindLocation
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocationAuthorization() throws {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus == .restricted || authorizationStatus == .denied {
            throw LocationError.disallowedByUser
        } else if authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else {
            return
        }
    }
}
