//
//  SearchUsersReactorSpec.swift
//  GithubGQLTests
//
//  Created by Rahul Katariya on 10/06/18.
//  Copyright © 2018 RahulKatariya. All rights reserved.
//

@testable import GithubGQL
import Foundation
import Quick
import Nimble
import RxSwift
import ReactorKit

class SearchUsersReactorSpec: QuickSpec {
    
    var reactor: SearchUsersReactor!
    var disposeBag: DisposeBag!
    
    override func spec() {
        super.spec()
        beforeEach {
            self.reactor = SearchUsersReactor(searchUsersService: MockSearchUsersService())
            self.disposeBag = DisposeBag()
        }
        
        describe("SearchUsersReactor") {
            it("should have nil initial state") {
                expect(self.reactor.currentState.query).to(beNil())
                expect(self.reactor.currentState.users).to(beEmpty())
            }
            
            it("should start with empty value") {
                self.reactor.action.onNext(.setQuery(""))
                expect(self.reactor.currentState.query).to(beEmpty())
                expect(self.reactor.currentState.users).to(beEmpty())
            }
            
            it("should start fetch users from query string") {
                self.reactor.action.onNext(.setQuery("R"))
                expect(self.reactor.currentState.query) == "R"
                expect(self.reactor.currentState.users.count) == 1
            }
            
            it("should fall back to empty when query is empty") {
                self.reactor.action.onNext(.setQuery("Rahul"))
                expect(self.reactor.currentState.query) == "Rahul"
                expect(self.reactor.currentState.users.count) == 5
                self.reactor.action.onNext(.setQuery(""))
                expect(self.reactor.currentState.query) == ""
                expect(self.reactor.currentState.users).to(beEmpty())
            }
        }
        
    }
    
    
}
