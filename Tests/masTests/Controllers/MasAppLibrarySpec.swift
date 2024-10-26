//
//  MasAppLibrarySpec.swift
//  masTests
//
//  Created by Ben Chatelain on 3/1/20.
//  Copyright © 2020 mas-cli. All rights reserved.
//

import Nimble
import Quick

@testable import mas

public class MasAppLibrarySpec: QuickSpec {
    override public func spec() {
        let library = MasAppLibrary(softwareMap: SoftwareMapMock(products: apps))

        beforeSuite {
            Mas.initialize()
        }
        describe("mas app library") {
            it("contains all installed apps") {
                expect(library.installedApps).to(haveCount(apps.count))
                expect(library.installedApps.first!.appName) == myApp.appName
            }
            it("can locate an app by bundle id") {
                expect(library.installedApp(forBundleID: "com.example")!.bundleIdentifier) == myApp.bundleIdentifier
            }
        }
    }
}

// MARK: - Test Data
let myApp = SoftwareProductMock(
    appName: "MyApp",
    bundleIdentifier: "com.example",
    bundlePath: "/Applications/MyApp.app",
    bundleVersion: "1.0.0",
    itemIdentifier: 1234
)

var apps: [SoftwareProduct] = [myApp]

// MARK: - SoftwareMapMock
struct SoftwareMapMock: SoftwareMap {
    var products: [SoftwareProduct] = []

    func allSoftwareProducts() -> [SoftwareProduct] {
        products
    }

    func product(for bundleIdentifier: String) -> SoftwareProduct? {
        for product in products where product.bundleIdentifier == bundleIdentifier {
            return product
        }
        return nil
    }
}
