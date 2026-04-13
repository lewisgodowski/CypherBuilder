//
//  Path.swift
//  
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

public struct Path: Createable, Matchable, PatternExpressible {
    public let pattern: String

    public init(
        left: NodePatternExpressible,
        _ relationship: RelationshipPatternExpressible,
        right: NodePatternExpressible
    ) {
        self.pattern = _PathFactory.makePattern(origin: left, relationship: relationship, destination: right)
    }

    public init(@PathPatternBuilder _ pathBuilder: () -> String) {
        self.pattern = pathBuilder()
    }
}

private extension Path {
    init(_pattern: String) {
        self.pattern = _pattern
    }
}
