//  This file was automatically generated and should not be edited.

import Apollo

public final class SearchUsersQuery: GraphQLQuery {
  public static let operationString =
    "query SearchUsers($q: String!) {\n  search(first: 100, query: $q, type: USER) {\n    __typename\n    nodes {\n      __typename\n      ... on User {\n        id\n        name\n      }\n    }\n  }\n}"

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
      GraphQLField("search", arguments: ["first": 100, "query": GraphQLVariable("q"), "type": "USER"], type: .nonNull(.object(Search.selections))),
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
        GraphQLField("nodes", type: .list(.object(Node.selections))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(nodes: [Node?]? = nil) {
        self.init(snapshot: ["__typename": "SearchResultItemConnection", "nodes": nodes.flatMap { $0.map { $0.flatMap { $0.snapshot } } }])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of nodes.
      public var nodes: [Node?]? {
        get {
          return (snapshot["nodes"] as? [Snapshot?]).flatMap { $0.map { $0.flatMap { Node(snapshot: $0) } } }
        }
        set {
          snapshot.updateValue(newValue.flatMap { $0.map { $0.flatMap { $0.snapshot } } }, forKey: "nodes")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes = ["Issue", "PullRequest", "Repository", "User", "Organization", "MarketplaceListing"]

        public static let selections: [GraphQLSelection] = [
          GraphQLTypeCase(
            variants: ["User": AsUser.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]

        public var snapshot: Snapshot

        public init(snapshot: Snapshot) {
          self.snapshot = snapshot
        }

        public static func makeIssue() -> Node {
          return Node(snapshot: ["__typename": "Issue"])
        }

        public static func makePullRequest() -> Node {
          return Node(snapshot: ["__typename": "PullRequest"])
        }

        public static func makeRepository() -> Node {
          return Node(snapshot: ["__typename": "Repository"])
        }

        public static func makeOrganization() -> Node {
          return Node(snapshot: ["__typename": "Organization"])
        }

        public static func makeMarketplaceListing() -> Node {
          return Node(snapshot: ["__typename": "MarketplaceListing"])
        }

        public static func makeUser(id: GraphQLID, name: String? = nil) -> Node {
          return Node(snapshot: ["__typename": "User", "id": id, "name": name])
        }

        public var __typename: String {
          get {
            return snapshot["__typename"]! as! String
          }
          set {
            snapshot.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asUser: AsUser? {
          get {
            if !AsUser.possibleTypes.contains(__typename) { return nil }
            return AsUser(snapshot: snapshot)
          }
          set {
            guard let newValue = newValue else { return }
            snapshot = newValue.snapshot
          }
        }

        public struct AsUser: GraphQLSelectionSet {
          public static let possibleTypes = ["User"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .scalar(String.self)),
          ]

          public var snapshot: Snapshot

          public init(snapshot: Snapshot) {
            self.snapshot = snapshot
          }

          public init(id: GraphQLID, name: String? = nil) {
            self.init(snapshot: ["__typename": "User", "id": id, "name": name])
          }

          public var __typename: String {
            get {
              return snapshot["__typename"]! as! String
            }
            set {
              snapshot.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID {
            get {
              return snapshot["id"]! as! GraphQLID
            }
            set {
              snapshot.updateValue(newValue, forKey: "id")
            }
          }

          /// The user's public profile name.
          public var name: String? {
            get {
              return snapshot["name"] as? String
            }
            set {
              snapshot.updateValue(newValue, forKey: "name")
            }
          }
        }
      }
    }
  }
}