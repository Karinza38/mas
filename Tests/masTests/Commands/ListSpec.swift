//
//  ListSpec.swift
//  masTests
//
//  Created by Ben Chatelain on 2018-12-27.
//  Copyright © 2018 mas-cli. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import mas

public class ListSpec: QuickSpec {
    override public func spec() {
        beforeSuite {
            MAS.initialize()
        }
        describe("list command") {
            it("lists apps") {
                expect {
                    try captureStream(stderr) {
                        try MAS.List.parse([]).run(appLibrary: MockAppLibrary())
                    }
                }
                    == "Error: No installed apps found\n"
            }
        }
    }
}
