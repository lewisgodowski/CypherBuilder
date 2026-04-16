//
//  Node.swift
//  
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

    private init(_label: String) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, label: .string(_label), properties: [:])
    }

    private init(@LabelExpressionBuilder _labelBuilder: () -> String) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, label: .string(_labelBuilder()), properties: [:])
    }

    private init(_properties: [String: Any]) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, label: .none, properties: _properties)
    }

    private init(_label: String, _properties: [String: Any]) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, label: .string(_label), properties: _properties)
    }

    private init(@LabelExpressionBuilder _labelBuilder: () -> String, _properties: [String: Any]) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, label: .string(_labelBuilder()), properties: _properties)
    }

    private init(_uncapturedObject _object: any Graphable) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, object: _object)
    }

    // MARK: - "convenience" init

    public init() {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, label: .none, properties: [:])
    }

    public init(label: String) {
        self.init(_label: label)
    }

    public init(@LabelExpressionBuilder labelBuilder: () -> String) {
        self.init(_labelBuilder: labelBuilder)
    }

    public init(properties: [String: Any]) {
        self.init(_properties: properties)
    }

    public init(label: String, properties: [String: Any]) {
        self.init(_label: label, _properties: properties)
    }

    public init(@LabelExpressionBuilder labelBuilder: () -> String, properties: [String: Any]) {
        self.init(_labelBuilder: labelBuilder, _properties: properties)
    }

    public init(uncapturedObject object: any Graphable) {
        self.init(_uncapturedObject: object)
    }
}
