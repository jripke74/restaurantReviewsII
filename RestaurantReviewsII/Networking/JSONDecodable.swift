//
//  JSONDecodable.swift
//  RestaurantReviewsII
//
//  Created by Jeff Ripke on 12/23/17.
//  Copyright © 2017 Jeff Ripke. All rights reserved.
//

import Foundation

protocol JSONDecodable {
    /// Instantiates an instance of the conforming type with a JSON dictionary
    ///
    /// Returns 'nil' if the JSON dicitonary does not contain all the values
    /// needed for intantiation of the conforming type
    init?(json: [String: Any])
}
