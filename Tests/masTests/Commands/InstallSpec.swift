//
//  InstallSpec.swift
//  masTests
//
//  Created by Ben Chatelain on 2018-12-28.
//  Copyright © 2018 mas-cli. All rights reserved.
//

import Nimble
import Quick

@testable import mas

public final class InstallSpec: QuickSpec {
    override public func spec() {
        beforeSuite {
            MAS.initialize()
        }
        xdescribe("install command") {
            xit("installs apps") {
                expect {
                    try MAS.Install.parse([]).run(appLibrary: MockAppLibrary(), searcher: MockAppStoreSearcher())
                }
                .toNot(throwError())
            }
        }
    }
}
