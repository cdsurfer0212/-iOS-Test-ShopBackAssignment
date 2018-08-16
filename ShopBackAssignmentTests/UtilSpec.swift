//
//  UtilSpec.swift
//  ShopBackAssignmentTests
//
//  Created by Sean Zeng on 2018/8/16.
//  Copyright © 2018 Sean Zeng. All rights reserved.
//

@testable import ShopBackAssignment

import Nimble
import Quick

class UtilSpec: QuickSpec {
    override func spec() {
        describe("getSecret") {
            context("when key is not empty", {
                it("result should be correct") {
                    Bundle.swizzle()
                    expect(Util.getSecret(key: "TMDbAPIKey")).to(equal("aaa"))
                }
            })
        }
    }
}
