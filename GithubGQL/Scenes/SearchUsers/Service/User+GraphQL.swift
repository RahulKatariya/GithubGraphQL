//
//  User+GraphQL.swift
//  GithubGQL
//
//  Created by Rahul Katariya on 10/06/18.
//  Copyright © 2018 RahulKatariya. All rights reserved.
//

import Apollo

extension SearchUsersQuery.Data.Search.Edge {
    
    func asUserModel() -> User? {
        guard let asUser = node?.asUser else { return nil }
        var user = User(id: asUser.id, name: asUser.name)
        user?.avatarUrl = asUser.avatarUrl
        return user
    }
    
}

extension Array where Element == Optional<SearchUsersQuery.Data.Search.Edge> {
    
    func asUserModel() -> [User] {
        return compactMap { $0 }
            .map { $0.asUserModel() }
            .compactMap { $0 }
    }
}
