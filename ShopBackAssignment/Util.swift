//
//  Util.swift
//  ShopBackAssignment
//
//  Created by Sean Zeng on 2018/8/10.
//  Copyright © 2018 Sean Zeng. All rights reserved.
//

import UIKit

class Util: NSObject {
    
    private static let secrets: NSDictionary? = {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        return nil
    }()
    
    static func getSecret(key: String) -> NSString? {
        if let secrets = secrets {
            return secrets.object(forKey: key) as? NSString
        }
        return nil
    }
    
}
