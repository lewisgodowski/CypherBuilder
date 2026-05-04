//
//  Match.swift
//  CypherBuilder
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

/// For more information, see the Cypher [documentation](https://neo4j.com/docs/cypher-manual/current/clauses/match/).
public struct Match: PatternExpressible {
    public let pattern: String
}

extension Match {
    // MARK: - init

    private init<each M: Matchable>(_matchables: repeat each M) {
        var patterns = [String]()
        for matchable in repeat each _matchables {
            patterns.append(matchable.pattern)
        }
        self.pattern = "MATCH \(patterns.joined(separator: ",\n"))"
    }

    // MARK: - "convenience" init

    public init<each C: Matchable>(_ matchables: repeat each C) {
        self.init(_matchables: repeat each matchables)
    }
}
