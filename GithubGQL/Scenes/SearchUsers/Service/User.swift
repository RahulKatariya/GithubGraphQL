//
//  User.swift
//  GithubGQL
//
//  Created by Rahul Katariya on 09/06/18.
//  Copyright © 2018 RahulKatariya. All rights reserved.
//

import Foundation

struct User {
    let id: String
    var name: String?
    var avatarUrl: String?
    
    init?(id: String?, name: String?) {
        guard let id = id, let name = name else { return nil }
        guard name.trimmingCharacters(in: .whitespaces).count > 0 else { return nil }
        self.id = id
        self.name = name
    }
}
