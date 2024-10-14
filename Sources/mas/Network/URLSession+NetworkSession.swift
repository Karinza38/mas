//
//  URLSession+NetworkSession.swift
//  mas
//
//  Created by Ben Chatelain on 1/5/19.
//  Copyright © 2019 mas-cli. All rights reserved.
//

import Foundation
import PromiseKit

extension URLSession: NetworkSession {
    func loadData(from url: URL) -> Promise<Data> {
        Promise { seal in
            dataTask(with: url) { data, _, error in
                if let data {
                    seal.fulfill(data)
                } else if let error {
                    seal.reject(error)
                } else {
                    seal.reject(MASError.noData)
                }
            }
            .resume()
        }
    }
}
