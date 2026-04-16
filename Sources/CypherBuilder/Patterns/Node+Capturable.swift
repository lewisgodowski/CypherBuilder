//
//  Node+Capturable.swift
//
//
//  Created by Lewis Godowski on 4/15/26.
//

import Foundation

extension Node: Capturable where C == String {
    public var capture: String {
        _capture
    }

    // MARK: - init

    private init(_capture: String) {
        self._capture = _capture
        self.pattern = _NodeFactory.makePattern(capture: .string(_capture), label: .none, properties: [:])
    }

    private init(_capture: String, _label: String) {
        self._capture = _capture
        self.pattern = _NodeFactory.makePattern(capture: .string(_capture), label: .string(_label), properties: [:])
    }

    private init(_capture: String, @LabelExpressionBuilder _labelBuilder: () -> String) {
        self._capture = _capture
        self.pattern = _NodeFactory.makePattern(
            capture: .string(_capture),
            label: .string(_labelBuilder()),
            properties: [:]
        )
    }

    private init(_capture: String, _properties: [String: Any]) {
        self._capture = _capture
        self.pattern = _NodeFactory.makePattern(capture: .string(_capture), label: .none, properties: _properties)
    }

    private init(_capture: String, _label: String, _properties: [String: Any]) {
        self._capture = _capture
        self.pattern = _NodeFactory.makePattern(
            capture: .string(_capture),
            label: .string(_label),
            properties: _properties
        )
    }

    private init(_capture: String, @LabelExpressionBuilder _labelBuilder: () -> String, _properties: [String: Any]) {
        self._capture = _capture
        self.pattern = _NodeFactory.makePattern(
            capture: .string(_capture),
            label: .string(_labelBuilder()),
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

    public init(capture: String) {
        self.init(_capture: capture)
    }

    public init(capture: String, label: String) {
        self.init(_capture: capture, _label: label)
    }

    public init(capture: String, @LabelExpressionBuilder labelBuilder: () -> String) {
        self.init(_capture: capture, _labelBuilder: labelBuilder)
    }

    public init(capture: String, properties: [String: Any]) {
        self.init(_capture: capture, _properties: properties)
    }

    public init(capture: String, label: String, properties: [String: Any]) {
        self.init(_capture: capture, _label: label, _properties: properties)
    }

    public init(capture: String, @LabelExpressionBuilder labelBuilder: () -> String, properties: [String: Any]) {
        self.init(_capture: capture, _labelBuilder: labelBuilder, _properties: properties)
    }

    public init(capture: String, object: any Graphable) {
        self.init(_capture: capture, _object: object)
    }

    public init(capturedObject object: any Graphable) {
        self.init(_capturedObject: object)
    }
}
