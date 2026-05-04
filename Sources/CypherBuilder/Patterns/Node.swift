//
//  Node.swift
//  CypherBuilder
//
//  Created by Lewis Godowski on 3/25/26.
//

import Foundation

public struct Node<C>: Createable, Matchable, NodePatternExpressible {
    package let _capture: String
    public let pattern: String
}

extension Node where C == Never {
    // MARK: - init

    private init(_labels: [String]) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, labels: .string(_labels), properties: [:])
    }

    private init(@LabelExpressionBuilder _labelBuilder: () -> [String]) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, labels: .string(_labelBuilder()), properties: [:])
    }

    private init(_labels: [String], _properties: [String: Any]) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, labels: .string(_labels), properties: _properties)
    }

    private init(@LabelExpressionBuilder _labelBuilder: () -> [String], _properties: [String: Any]) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, labels: .string(_labelBuilder()), properties: _properties)
    }

    private init(_uncapturedObject _object: any Graphable) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, object: _object)
    }

    // MARK: - "convenience" init

    public init(labels: String...) {
        self.init(_labels: labels)
    }

    public init(@LabelExpressionBuilder labelBuilder: () -> [String]) {
        self.init(_labelBuilder: labelBuilder)
    }

    public init(labels: String..., properties: [String: Any]) {
        self.init(_labels: labels, _properties: properties)
    }

    public init(@LabelExpressionBuilder labelBuilder: () -> [String], properties: [String: Any]) {
        self.init(_labelBuilder: labelBuilder, _properties: properties)
    }

    public init(uncapturedObject object: any Graphable) {
        self.init(_uncapturedObject: object)
    }
}
