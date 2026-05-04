//
//  OptionalMatch.swift
//  CypherBuilder
//
//  Created by Lewis Godowski on 4/16/26.
//

import Foundation

/// For more information, see the Cypher [documentation](https://neo4j.com/docs/cypher-manual/current/clauses/optional-match/).
public struct OptionalMatch: PatternExpressible {
    public let pattern: String
}

extension OptionalMatch {
    // MARK: - init

    private init<each M: Matchable>(_matchables: repeat each M) {
        self.pattern = "OPTIONAL \(Match(repeat each _matchables).pattern)"
    }

    // MARK: - "convenience" init

    public init<each C: Matchable>(_ matchables: repeat each C) {
        self.init(_matchables: repeat each matchables)
    }
}
