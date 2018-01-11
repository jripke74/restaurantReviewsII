//
//  YelpClient.swift
//  RestaurantReviewsII
//
//  Created by Jeff Ripke on 1/11/18.
//  Copyright © 2018 Jeff Ripke. All rights reserved.
//

import Foundation

class YelpClient: APIClient {
    
    let session: URLSession
    private let token: String
    
    init(configuration: URLSessionConfiguration, oauthToken: String) {
        self.session = URLSession(configuration: configuration)
        self.token = oauthToken
    }
    
    convenience init(oauthToken: String) {
        self.init(configuration: .default, oauthToken: oauthToken)
    }
    
    func search(withTerm term: String, at coordinate: Coordinate, categories: [YelpCategory] = [], radius: Int? = nil, limit: Int = 50, sortBy sortType: Yelp.YelpSortType = .rating, comletion: @escaping (Result<[YelpBusiness], APIError>) -> Void) {
        let endpoint = Yelp.search(term: term, coordinate: coordinate, radius: radius, categories: categories, limit: limit, sortBy: sortType)
        let request = endpoint.requestWithAuthorizationHeader(oauthToken: token)
        fetch(with: request, parse: { json -> [YelpBusiness] in
            guard let businesses = json["businesses"] as? [[String: Any]] else { return [] }
            return businesses.flatMap { YelpBusiness(json: $0) }
        }, completion: comletion)
    }
}
