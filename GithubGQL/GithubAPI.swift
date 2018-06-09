//  This file was automatically generated and should not be edited.

import Apollo

public final class SearchUsersQuery: GraphQLQuery {
  public static let operationString =
    "query SearchUsers($q: String!) {\n  search(first: 50, query: $q, type: USER) {\n    __typename\n    userCount\n  }\n}"

  public var q: String

  public init(q: String) {
    self.q = q
  }

  public var variables: GraphQLMap? {
    return ["q": q]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("search", arguments: ["first": 50, "query": GraphQLVariable("q"), "type": "USER"], type: .nonNull(.object(Search.selections))),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(search: Search) {
      self.init(snapshot: ["__typename": "Query", "search": search.snapshot])
    }

    /// Perform a search across resources.
    public var search: Search {
      get {
        return Search(snapshot: snapshot["search"]! as! Snapshot)
      }
      set {
        snapshot.updateValue(newValue.snapshot, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes = ["SearchResultItemConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("userCount", type: .nonNull(.scalar(Int.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(userCount: Int) {
        self.init(snapshot: ["__typename": "SearchResultItemConnection", "userCount": userCount])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The number of users that matched the search query.
      public var userCount: Int {
        get {
          return snapshot["userCount"]! as! Int
        }
        set {
          snapshot.updateValue(newValue, forKey: "userCount")
        }
      }
    }
  }
}