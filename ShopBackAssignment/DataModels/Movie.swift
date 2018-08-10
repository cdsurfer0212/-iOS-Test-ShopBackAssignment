//
//  Movie.swift
//  ShopBackAssignment
//
//  Created by Sean Zeng on 2018/8/9.
//  Copyright © 2018 Sean Zeng. All rights reserved.
//

import ObjectMapper
import UIKit

class Movie: Mappable {
    
    var backdropPath: String?
    var genres: [Genre]?
    var id: Int?
    var spokenLanguages: [Language]?
    var overview: String?
    var popularity: Float?
    var posterPath: String?
    var runtime: Int?
    var title: String?
    
    required init?(map: Map) {
        // no-op
    }
    
    func mapping(map: Map) {
        backdropPath <- map["backdrop_path"]
        genres <- map["genres"]
        id <- map["id"]
        spokenLanguages <- map["spoken_languages"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        posterPath <- map["poster_path"]
        runtime <- map["runtime"]
        title <- map["title"]
    }

}
