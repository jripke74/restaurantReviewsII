//
//  Result.swift
//  RestaurantReviewsII
//
//  Created by Jeff Ripke on 1/11/18.
//  Copyright © 2018 Jeff Ripke. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}
