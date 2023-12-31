//
//  NetworkService.swift
//  Graphql-mutation
//
//  Created by Sachin Daingade on 31/12/23.
//

import Foundation
import Apollo

final class NetworkService {
    static let shared = NetworkService()
    private init() {}
    private(set) var apollo = ApolloClient(url: URL(string: "https://spacex-production.up.railway.app/")!)
}
