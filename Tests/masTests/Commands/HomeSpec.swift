//
//  HomeSpec.swift
//  masTests
//
//  Created by Ben Chatelain on 2018-12-29.
//  Copyright © 2018 mas-cli. All rights reserved.
//

import Nimble
import Quick

@testable import mas

public final class HomeSpec: QuickSpec {
    override public func spec() {
        beforeSuite {
            MAS.initialize()
        }
        describe("home command") {
            it("can't find app with unknown ID") {
                expect {
                    try MAS.Home.parse(["999"]).run(searcher: MockAppStoreSearcher())
                }
                .to(throwError(MASError.unknownAppID(999)))
            }
        }
    }
}
