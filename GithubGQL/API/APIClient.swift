//
//  APIClient.swift
//  GithubGQL
//
//  Created by Rahul Katariya on 09/06/18.
//  Copyright © 2018 RahulKatariya. All rights reserved.
//

import Foundation
import Apollo

class APIClient {
    
    static let `default` = APIClient()
    
    struct Constants {
        static let endpoint = "https://api.github.com/graphql"
        static let headers: [String: String] = [
            "Authorization": "Bearer \(ProcessInfo.processInfo.environment["GITHUB_TOKEN"]!)"
        ]
    }
    
    let apolloClient: ApolloClient = {
        let url = URL(string: Constants.endpoint)!
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Constants.headers
        let networkTransport = HTTPNetworkTransport(url: url, configuration: configuration)
        return ApolloClient(networkTransport: networkTransport)
    }()
    
}
