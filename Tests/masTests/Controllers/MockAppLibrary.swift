//
//  MockAppLibrary.swift
//  masTests
//
//  Created by Ben Chatelain on 12/27/18.
//  Copyright © 2018 mas-cli. All rights reserved.
//

@testable import mas

struct MockAppLibrary: AppLibrary {
    let installedApps: [SoftwareProduct]

    init(_ installedApps: SoftwareProduct...) {
        self.installedApps = installedApps
    }

    func uninstallApps(atPaths appPaths: [String]) throws {
        // Special case for testing where we pretend the trash command failed
        if appPaths.contains("/dev/null") {
            throw MASError.uninstallFailed(error: nil)
        }
    }
}
