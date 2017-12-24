//
//  YelpTransaction.swift
//  RestaurantReviewsII
//
//  Created by Jeff Ripke on 12/23/17.
//  Copyright © 2017 Jeff Ripke. All rights reserved.
//

import Foundation

enum YelpTransaction {
    case pickup, delivery, restaurantReservation
}

extension YelpTransaction {
    init?(rawValue: String) {
        switch rawValue {
        case "pickup": self = .pickup
        case "delivery": self = .delivery
        case "restaurant_reservation": self = .restaurantReservation
        default: return nil
        }
    }
}
