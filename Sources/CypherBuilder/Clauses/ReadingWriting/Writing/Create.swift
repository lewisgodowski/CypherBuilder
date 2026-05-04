//
//  Create.swift
//  CypherBuilder
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

/// For more information, see the Cypher [documentation](https://neo4j.com/docs/cypher-manual/current/clauses/create/).
public struct Create: PatternExpressible {
    public let pattern: String
}

extension Create {
    // MARK: - init

    private init<each C: Createable>(_createables: repeat each C) {
        var patterns = [String]()
        for createable in repeat each _createables {
            patterns.append(createable.pattern)
        }
        self.pattern = "CREATE \(patterns.joined(separator: ",\n"))"
    }

    // MARK: - "convenience" init

    public init<each C: Createable>(_ createables: repeat each C) {
        self.init(_createables: repeat each createables)
    }
}
