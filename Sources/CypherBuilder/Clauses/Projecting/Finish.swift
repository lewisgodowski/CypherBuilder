//
//  Finish.swift
//  CypherBuilder
//
//  Created by Lewis Godowski on 4/16/26.
//

import Foundation

/// For more information, see the Cypher [documentation](https://neo4j.com/docs/cypher-manual/current/clauses/finish/).
public struct Finish: PatternExpressible {
    public let pattern: String
}

extension Finish {
    // MARK: - init

    public init() {
        self.pattern = "FINISH"
    }
}
