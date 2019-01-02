//
//  Home.swift
//  mas-cli
//
//  Created by Ben Chatelain on 2018-12-29.
//  Copyright © 2016 mas-cli. All rights reserved.
//

import Commandant
import Result
import Foundation

/// Opens app page on MAS Preview. Uses the iTunes Lookup API:
/// https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api/#lookup
public struct HomeCommand: CommandProtocol {
    public let verb = "home"
    public let function = "Opens MAS Preview app page in a browser"

    private let storeSearch: StoreSearch

    /// Designated initializer.
    public init(storeSearch: StoreSearch = MasStoreSearch()) {
        self.storeSearch = storeSearch
    }

    /// Runs the command.
    public func run(_ options: HomeOptions) -> Result<(), MASError> {
        do {
            guard let result = try storeSearch.lookup(app: options.appId)
                else {
                    print("No results found")
                    return .failure(.noSearchResultsFound)
            }

            dump(result)
        }
        catch {
            return .failure(.searchFailed)
        }

        return .success(())
    }
}

public struct HomeOptions: OptionsProtocol {
    let appId: String

    static func create(_ appId: String) -> HomeOptions {
        return HomeOptions(appId: appId)
    }

    public static func evaluate(_ m: CommandMode) -> Result<HomeOptions, CommandantError<MASError>> {
        return create
            <*> m <| Argument(usage: "the app id to show Home")
    }
}
