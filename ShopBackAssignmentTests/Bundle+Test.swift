//
//  UtilStub.swift
//  ShopBackAssignmentTests
//
//  Created by Sean Zeng on 2018/8/16.
//  Copyright © 2018 Sean Zeng. All rights reserved.
//

@testable import ShopBackAssignment

import Foundation

extension Bundle
{
    @objc class func swizzledGetMain() -> Bundle {
        return Bundle(for: ShopBackAssignmentTests.self)
    }
    
    class func swizzle() {
        let originalSelector = #selector(getter: main)
        let swizzledSelector = #selector(swizzledGetMain)
        let originalMethod = class_getClassMethod(self, originalSelector)!
        let swizzledMethod = class_getClassMethod(self, swizzledSelector)!
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}
