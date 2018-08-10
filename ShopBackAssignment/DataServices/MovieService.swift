//
//  MovieService.swift
//  ShopBackAssignment
//
//  Created by Sean Zeng on 2018/8/9.
//  Copyright © 2018 Sean Zeng. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import UIKit

class MovieService: NSObject {

    private static let key = "TMDbAPIKey"
    private static let secret: NSString? = {
        if let secret = Util.getSecret(key: key) {
            return secret
        }
        return nil
    }()
    
    static func getMovie(id: Int, completion: @escaping (Movie?) -> ()) {
        guard let secret = secret else {
            // FIXME: error handling
            return
        }
        
        Alamofire.request("https://api.themoviedb.org/3/movie/\(id)", parameters: ["api_key": secret]).responseObject { (response: DataResponse<Movie>) in
            completion(response.result.value)
        }
    }
    
    static func getMovies(sort: String, page: Int, completion: @escaping (Movies?) -> ()) {
        guard let secret = secret else {
            // FIXME: error handling
            return
        }
        
        Alamofire.request("https://api.themoviedb.org/3/discover/movie", parameters: ["api_key": secret, "sort_by": sort, "page": page]).responseObject { (response: DataResponse<Movies>) in
            completion(response.result.value)
        }
    }

}
