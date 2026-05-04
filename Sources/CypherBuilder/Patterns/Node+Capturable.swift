//
//  Node+Capturable.swift
//  CypherBuilder
//
//  Created by Lewis Godowski on 4/15/26.
//

import Foundation

extension Node: Capturable where C == String {
    public var capture: String {
        _capture
    }

    // MARK: - init

    private init(_capture: String, _labels: [String]) {
        self._capture = _capture
        self.pattern = _NodeFactory.makePattern(capture: .string(_capture), labels: .string(_labels), properties: [:])
    }

    private init(_capture: String, @LabelExpressionBuilder _labelBuilder: () -> [String]) {
        self._capture = _capture
        self.pattern = _NodeFactory.makePattern(
            capture: .string(_capture),
            labels: .string(_labelBuilder()),
            properties: [:]
        )
    }

    private init(_capture: String, _labels: [String], _properties: [String: Any]) {
        self._capture = _capture
        self.pattern = _NodeFactory.makePattern(
            capture: .string(_capture),
            labels: .string(_labels),
            properties: _properties
        )
    }

    private init(_capture: String, @LabelExpressionBuilder _labelBuilder: () -> [String], _properties: [String: Any]) {
        self._capture = _capture
        self.pattern = _NodeFactory.makePattern(
            capture: .string(_capture),
            labels: .string(_labelBuilder()),
            properties: _properties
        )
    }

    private init(_capture: String, _object: any Graphable) {
        self._capture = _capture
        self.pattern = _NodeFactory.makePattern(capture: .string(_capture), object: _object)
    }

    private init(_capturedObject _object: any Graphable) {
        self._capture = _object.capture
        self.pattern = _NodeFactory.makePattern(capture: .graphable(_object), object: _object)
    }


    // MARK: - "convenience" init

    public init(capture: String, labels: String...) {
        self.init(_capture: capture, _labels: labels)
    }

    public init(capture: String, @LabelExpressionBuilder labelBuilder: () -> [String]) {
        self.init(_capture: capture, _labelBuilder: labelBuilder)
    }

    public init(capture: String, labels: String..., properties: [String: Any]) {
        self.init(_capture: capture, _labels: labels, _properties: properties)
    }

    public init(capture: String, @LabelExpressionBuilder labelBuilder: () -> [String], properties: [String: Any]) {
        self.init(_capture: capture, _labelBuilder: labelBuilder, _properties: properties)
    }

    public init(capture: String, object: any Graphable) {
        self.init(_capture: capture, _object: object)
    }

    public init(capturedObject object: any Graphable) {
        self.init(_capturedObject: object)
    }
}
