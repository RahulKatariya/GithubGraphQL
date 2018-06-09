//
//  SearchUsersReactor.swift
//  GithubGQL
//
//  Created by Rahul Katariya on 09/06/18.
//  Copyright © 2018 RahulKatariya. All rights reserved.
//

import RxSwift
import RxCocoa
import ReactorKit

final class SearchUsersReactor: Reactor {
    
    struct State {
        var query: String?
        var users: [User] = []
    }
    
    enum Action {
        case setQuery(String?)
    }
    
    enum Mutation {
        case setQuery(String?)
        case setUsers([User])
    }
    
    var initialState = State()
    let searchUsersService: SearchUsersServiceProtocol
    
    init(searchUsersService: SearchUsersServiceProtocol) {
        self.searchUsersService = searchUsersService
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        switch mutation {
        case let .setQuery(query):
            var newState = state
            newState.query = query
            return newState
            
        case let .setUsers(users):
            var newState = state
            newState.users = users
            return newState
        }
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .setQuery(query):
            return Observable.concat(
                Observable.just(Mutation.setQuery(query)),
                searchUsersService.searchUsers(query: query)
                    .takeUntil(self.action)
                    .map { Mutation.setUsers($0) }
                )
        }
    }
    
}
