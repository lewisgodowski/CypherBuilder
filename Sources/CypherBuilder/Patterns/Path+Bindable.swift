//
//  Path+Bindable.swift
//  CypherBuilder
//
//  Created by Lewis Godowski on 4/20/26.
//

import Foundation

extension Path: Bindable where V == String {
    public var variable: String {
        _variable
    }

    // MARK: - init

    private init(
        _left: NodePatternExpressible,
        _relationship: RelationshipPatternExpressible,
        _right: NodePatternExpressible,
        _variable: String
    ) {
        self.pattern = _PathFactory.makePattern(
            variable: _variable,
            origin: _left,
            relationship: _relationship,
            destination: _right
        )
        self._variable = _variable
    }

    private init(@PathPatternBuilder _pathBuilder: () -> String, _variable: String) {
        self.pattern = _PathFactory.makePattern(variable: _variable, pathBuilder: _pathBuilder)
        self._variable = _variable
    }

    // MARK: - "convenience" init

    public init(
        variable: String,
        left: NodePatternExpressible,
        _ relationship: RelationshipPatternExpressible,
        right: NodePatternExpressible
    ) {
        self.init(_left: left, _relationship: relationship, _right: right, _variable: variable)
    }

    public init(variable: String, @PathPatternBuilder _ pathBuilder: () -> String) {
        self.init(_pathBuilder: pathBuilder, _variable: variable)
    }
}
