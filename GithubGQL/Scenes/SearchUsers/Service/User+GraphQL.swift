//
//  User+GraphQL.swift
//  GithubGQL
//
//  Created by Rahul Katariya on 10/06/18.
//  Copyright © 2018 RahulKatariya. All rights reserved.
//

import Apollo

extension SearchUsersQuery.Data.Search.Node {
    
    func asUserModel() -> User? {
        guard let asUser = asUser else { return nil }
        return User(id: asUser.id, name: asUser.name)
    }
    
}

extension Array where Element == Optional<SearchUsersQuery.Data.Search.Node> {
    
    func asUserModel() -> [User] {
        return compactMap { $0 }
            .map { $0.asUserModel() }
            .compactMap { $0 }
    }
}
