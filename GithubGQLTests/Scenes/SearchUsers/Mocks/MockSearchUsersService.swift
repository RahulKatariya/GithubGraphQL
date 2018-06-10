//
//  MockSearchUsersService.swift
//  GithubGQLTests
//
//  Created by Rahul Katariya on 10/06/18.
//  Copyright © 2018 RahulKatariya. All rights reserved.
//

@testable import GithubGQL
import Foundation
import RxSwift
import Fakery

class MockSearchUsersService: SearchUsersServiceProtocol {
    
    func searchUsers(query: String?) -> Observable<[User]> {
        let count = query?.count ?? 0
        let faker = Faker()
        var users: [User] = []
        for _ in 0..<count {
            users.append(
                User(
                    id: UUID().uuidString,
                    name: faker.name.firstName() + faker.name.lastName()
                )!
            )
        }
        return Observable.just(users)
    }
    
}
