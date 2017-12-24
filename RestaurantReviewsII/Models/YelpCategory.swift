//
//  YelpCategory.swift
//  RestaurantReviewsII
//
//  Created by Jeff Ripke on 12/23/17.
//  Copyright © 2017 Jeff Ripke. All rights reserved.
//

import Foundation

struct YelpCategory {
    let alias: String
    let title: String
}


extension YelpCategory: JSONDecodable {
    init?(json: [String : Any]) {
        guard let aliasValue = json["alias"] as? String, let titleValue = json["title"] as? String else { return nil }
        self.alias = aliasValue
        self.title = titleValue
    }
}
