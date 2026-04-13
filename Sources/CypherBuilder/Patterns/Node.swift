//
//  Node.swift
//  
//
//  Created by Lewis Godowski on 3/25/26.
//

import Foundation

public struct Node<C>: Createable, Matchable, NodePatternExpressible {
    private let _capture: String
    public let pattern: String
}

extension Node where C == Never {
    public init() {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, label: .none, properties: [:])
    }

    public init(label: String) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, label: .string(label), properties: [:])
    }

    public init(@LabelExpressionBuilder labelBuilder: () -> String) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, label: .string(labelBuilder()), properties: [:])
    }

    public init(properties: [String: Any]) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, label: .none, properties: properties)
    }

    public init(label: String, properties: [String: Any]) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, label: .string(label), properties: properties)
    }

    public init(@LabelExpressionBuilder labelBuilder: () -> String, properties: [String: Any]) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, label: .string(labelBuilder()), properties: properties)
    }

    public init(uncapturedObject object: any Graphable) {
        self._capture = ""
        self.pattern = _NodeFactory.makePattern(capture: .none, object: object)
    }
}

// MARK: - Capturable

extension Node: Capturable where C == String {
    public var capture: String {
        _capture
    }

    public init(capture: String) {
        self._capture = capture
        self.pattern = _NodeFactory.makePattern(capture: .string(capture), label: .none, properties: [:])
    }

    public init(capture: String, label: String) {
        self._capture = capture
        self.pattern = _NodeFactory.makePattern(capture: .string(capture), label: .string(label), properties: [:])
    }

    public init(capture: String, @LabelExpressionBuilder labelBuilder: () -> String) {
        self._capture = capture
        self.pattern = _NodeFactory.makePattern(
            capture: .string(capture),
            label: .string(labelBuilder()),
            properties: [:]
        )
    }

    public init(capture: String, properties: [String: Any]) {
        self._capture = capture
        self.pattern = _NodeFactory.makePattern(capture: .string(capture), label: .none, properties: properties)
    }

    public init(capture: String, label: String, properties: [String: Any]) {
        self._capture = capture
        self.pattern = _NodeFactory.makePattern(
            capture: .string(capture),
            label: .string(label),
            properties: properties
        )
    }

    public init(capture: String, @LabelExpressionBuilder labelBuilder: () -> String, properties: [String: Any]) {
        self._capture = capture
        self.pattern = _NodeFactory.makePattern(
            capture: .string(capture),
            label: .string(labelBuilder()),
            properties: properties
        )
    }

    public init(capture: String, object: any Graphable) {
        self._capture = capture
        self.pattern = _NodeFactory.makePattern(capture: .string(capture), object: object)
    }

    public init(capturedObject object: any Graphable) {
        self._capture = object.capture
        self.pattern = _NodeFactory.makePattern(capture: .graphable(object), object: object)
    }
}

// MARK: - Internal

private extension Node {
    init(_pattern: String) {
        self._capture = ""
        self.pattern = _pattern
    }

    init(_pattern: String, capture: String) {
        self._capture = capture
        self.pattern = _pattern
    }
}
