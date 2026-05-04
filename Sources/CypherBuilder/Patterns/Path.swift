//
//  Path.swift
//  CypherBuilder
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

public struct Path<V>: Createable, Matchable, PatternExpressible {
    public let pattern: String
    package let _variable: String
}

extension Path where V == Never {
    // MARK: - init

    private init(
        _left: NodePatternExpressible,
        _relationship: RelationshipPatternExpressible,
        _right: NodePatternExpressible
    ) {
        self.pattern = _PathFactory.makePattern(
            variable: nil,
            origin: _left,
            relationship: _relationship,
            destination: _right
        )
        self._variable = ""
    }

    private init(@PathPatternBuilder _pathBuilder: () -> String) {
        self.pattern = _pathBuilder()
        self._variable = ""
    }

    // MARK: - "convenience" init

    public init(
        left: NodePatternExpressible,
        _ relationship: RelationshipPatternExpressible,
        right: NodePatternExpressible
    ) {
        self.init(_left: left, _relationship: relationship, _right: right)
    }

    public init(@PathPatternBuilder _ pathBuilder: () -> String) {
        self.init(_pathBuilder: pathBuilder)
    }
}
