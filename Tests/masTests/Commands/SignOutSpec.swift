//
//  SignOutSpec.swift
//  masTests
//
//  Created by Ben Chatelain on 2018-12-28.
//  Copyright © 2018 mas-cli. All rights reserved.
//

import Nimble
import Quick

@testable import mas

public final class SignOutSpec: QuickSpec {
    override public func spec() {
        beforeSuite {
            MAS.initialize()
        }
        describe("signout command") {
            it("signs out") {
                expect {
                    try MAS.SignOut.parse([]).run()
                }
                .toNot(throwError())
            }
        }
    }
}
