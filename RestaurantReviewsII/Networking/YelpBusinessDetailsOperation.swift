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
    
    private var _finished = false
    
    override private(set) var isFinished: Bool {
        get {
            return _finished
        }
        set {
            _finished = newValue
        }
    }
    
    override func start() {
        if isCancelled {
            isFinished = true
            return
        }
    }
}
