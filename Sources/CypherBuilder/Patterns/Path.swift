//
//  Path.swift
//  
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

public struct Path: Createable, Matchable, PatternExpressible {
    public let pattern: String

    // MARK: - init

    private init(
        _left: NodePatternExpressible,
        _relationship: RelationshipPatternExpressible,
        _right: NodePatternExpressible
    ) {
        self.pattern = _PathFactory.makePattern(origin: _left, relationship: _relationship, destination: _right)
    }

    private init(@PathPatternBuilder _pathBuilder: () -> String) {
        self.pattern = _pathBuilder()
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
