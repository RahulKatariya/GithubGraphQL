//
//  SearchUsersService.swift
//  GithubGQL
//
//  Created by Rahul Katariya on 09/06/18.
//  Copyright © 2018 RahulKatariya. All rights reserved.
//

import Foundation
import RxApollo
import RxSwift
import RxOptional

protocol SearchUsersServiceProtocol {
    func searchUsers(query: String?) -> Observable<[User]>
}

class GQLSearchUsersService: SearchUsersServiceProtocol {
    
    func searchUsers(query: String?) -> Observable<[User]> {
        if let query = query, query.trimmingCharacters(in: .whitespaces).count > 0 {
            let gqlQuery = SearchUsersQuery(q: query)
            let usersObservable = APIClient.default.apolloClient.rx.fetch(
                    query: gqlQuery,
                    cachePolicy: .fetchIgnoringCacheData,
                    queue: .main
                )
                .asObservable()
                .map { $0.search.edges }
                .filterNil()
                .map { $0.asUserModel() }
            return usersObservable
        } else {
            return Observable.just([])
        }
    }
    
}
