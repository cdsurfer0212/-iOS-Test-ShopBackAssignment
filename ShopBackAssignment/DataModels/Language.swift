//
//  Language.swift
//  ShopBackAssignment
//
//  Created by Sean Zeng on 2018/8/9.
//  Copyright © 2018 Sean Zeng. All rights reserved.
//

import ObjectMapper
import UIKit

class Language: Mappable {
    
    var name: String?
    
    required init?(map: Map) {
        // no-op
    }

    func mapping(map: Map) {
        name <- map["name"]
    }
    
}
