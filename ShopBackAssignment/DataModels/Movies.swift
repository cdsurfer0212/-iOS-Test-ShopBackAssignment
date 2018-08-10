//
//  Movies.swift
//  ShopBackAssignment
//
//  Created by Sean Zeng on 2018/8/10.
//  Copyright © 2018 Sean Zeng. All rights reserved.
//

import ObjectMapper
import UIKit

class Movies: Mappable {
    
    var page: Int?
    var results: [Movie]?
    var totalPages: Int?
    var totalResults: Int?
    
    required init?(map: Map) {
        // no-op
    }
    
    func mapping(map: Map) {
        page <- map["page"]
        results <- map["results"]
        totalPages <- map["total_pages"]
        totalResults <- map["total_results"]
    }
    
}
