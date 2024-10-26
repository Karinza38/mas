//
//  OpenSpec.swift
//  masTests
//
//  Created by Ben Chatelain on 2019-01-03.
//  Copyright © 2019 mas-cli. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import mas

public class OpenSpec: QuickSpec {
    override public func spec() {
        let searcher = MockAppStoreSearcher()
        let openCommand = MockOpenSystemCommand()

        beforeSuite {
            MAS.initialize()
        }
        describe("open command") {
            beforeEach {
                searcher.reset()
            }
            it("fails to open app with invalid ID") {
                expect {
                    try MAS.Open.parse(["--", "-999"]).run(searcher: searcher, openCommand: openCommand)
                }
                .to(throwError())
            }
            it("can't find app with unknown ID") {
                expect {
                    try MAS.Open.parse(["999"]).run(searcher: searcher, openCommand: openCommand)
                }
                .to(throwError(MASError.noSearchResultsFound))
            }
            it("opens app in MAS") {
                let mockResult = SearchResult(
                    trackId: 1111,
                    trackViewUrl: "fakescheme://some/url",
                    version: "0.0"
                )
                searcher.apps[mockResult.trackId] = mockResult
                expect {
                    try MAS.Open.parse([mockResult.trackId.description])
                        .run(searcher: searcher, openCommand: openCommand)
                    return openCommand.arguments
                }
                    == ["macappstore://some/url"]
            }
            it("just opens MAS if no app specified") {
                expect {
                    try MAS.Open.parse([]).run(searcher: searcher, openCommand: openCommand)
                    return openCommand.arguments
                }
                    == ["macappstore://"]
            }
        }
    }
}
