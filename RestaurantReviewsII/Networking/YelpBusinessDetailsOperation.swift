//
//  YelpBusinessDetailsOperation.swift
//  RestaurantReviewsII
//
//  Created by Jeff Ripke on 1/11/18.
//  Copyright © 2018 Jeff Ripke. All rights reserved.
//

import Foundation

class YelpBusinessDetailsOperation: Operation {
    let business: YelpBusiness
    let client: YelpClient
    
    init(business: YelpBusiness, client: YelpClient) {
        self.business = business
        self.client = client
        super.init()
    }
    
    
}
