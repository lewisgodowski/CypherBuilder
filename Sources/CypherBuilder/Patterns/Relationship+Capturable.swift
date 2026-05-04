//
//  Relationship+Capturable.swift
//  CypherBuilder
//
//  Created by Lewis Godowski on 4/15/26.
//

import Foundation

extension Relationship: Capturable where C == String {
    public var capture: String {
        _capture
    }

    // MARK: - init

    private init(_direction: Direction, _capture: String, _labels: [String], _depth: any _DepthProviding) {
        self._capture = _capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .string(_capture),
            labels: .string(_labels),
            depth: .providing(_depth),
            properties: [:]
        )
    }

    private init(
        _direction: Direction,
        _capture: String,
        @LabelExpressionBuilder _labelBuilder: () -> [String],
        _depth: any _DepthProviding
    ) {
        self._capture = _capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .string(_capture),
            labels: .string(_labelBuilder()),
            depth: .providing(_depth),
            properties: [:]
        )
    }

    private init(
        _direction: Direction,
        _capture: String,
        _labels: [String],
        _depth: any _DepthProviding,
        _properties: [String: Any]
    ) {
        self._capture = _capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .string(_capture),
            labels: .string(_labels),
            depth: .providing(_depth),
            properties: _properties
        )
    }

    private init(
        _direction: Direction,
        _capture: String,
        @LabelExpressionBuilder _labelBuilder: () -> [String],
        _depth: any _DepthProviding,
        _properties: [String: Any]
    ) {
        self._capture = _capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .string(_capture),
            labels: .string(_labelBuilder()),
            depth: .providing(_depth),
            properties: _properties
        )
    }

    // MARK: - "convenience" init

    public init(direction: Direction, capture: String, labels: String...) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            labels: .string(labels),
            depth: .none,
            properties: [:]
        )
    }

    public init(direction: Direction, capture: String, @LabelExpressionBuilder labelBuilder: () -> [String]) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            labels: .string(labelBuilder()),
            depth: .none,
            properties: [:]
        )
    }

    public init(directionOfAnyDepth direction: Direction, capture: String, labels: String...) {
        self.init(_direction: direction, _capture: capture, _labels: labels, _depth: AnyDepth())
    }

    public init(direction: Direction, capture: String, labels: String..., depth: Int) {
        self.init(_direction: direction, _capture: capture, _labels: labels, _depth: depth)
    }

    public init(direction: Direction, capture: String, labels: String..., depth: PartialRangeFrom<Int>) {
        self.init(_direction: direction, _capture: capture, _labels: labels, _depth: depth)
    }

    public init(direction: Direction, capture: String, labels: String..., depth: PartialRangeUpTo<Int>) {
        self.init(_direction: direction, _capture: capture, _labels: labels, _depth: depth)
    }

    public init(direction: Direction, capture: String, labels: String..., depth: Range<Int>) {
        self.init(_direction: direction, _capture: capture, _labels: labels, _depth: depth)
    }

    public init(
        directionOfAnyDepth direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> [String]
    ) {
        self.init(_direction: direction, _capture: capture, _labelBuilder: labelBuilder, _depth: AnyDepth())
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        depth: Int
    ) {
        self.init(_direction: direction, _capture: capture, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        depth: PartialRangeFrom<Int>
    ) {
        self.init(_direction: direction, _capture: capture, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        depth: PartialRangeUpTo<Int>
    ) {
        self.init(_direction: direction, _capture: capture, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        depth: Range<Int>
    ) {
        self.init(_direction: direction, _capture: capture, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(direction: Direction, capture: String, labels: String..., properties: [String: Any]) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            labels: .string(labels),
            depth: .none,
            properties: properties
        )
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        properties: [String: Any]
    ) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            labels: .string(labelBuilder()),
            depth: .none,
            properties: properties
        )
    }

    public init(
        directionOfAnyDepth direction: Direction,
        capture: String,
        labels: String...,
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _capture: capture, _labels: labels, _depth: AnyDepth(), _properties: properties)
    }

    public init(direction: Direction, capture: String, labels: String..., depth: Int, properties: [String: Any]) {
        self.init(_direction: direction, _capture: capture, _labels: labels, _depth: depth, _properties: properties)
    }

    public init(
        direction: Direction,
        capture: String,
        labels: String...,
        depth: PartialRangeFrom<Int>,
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _capture: capture, _labels: labels, _depth: depth, _properties: properties)
    }

    public init(
        direction: Direction,
        capture: String,
        labels: String...,
        depth: PartialRangeUpTo<Int>,
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _capture: capture, _labels: labels, _depth: depth, _properties: properties)
    }

    public init(
        direction: Direction,
        capture: String,
        labels: String...,
        depth: Range<Int>,
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _capture: capture, _labels: labels, _depth: depth, _properties: properties)
    }

    public init(
        directionOfAnyDepth direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        properties: [String: Any]
    ) {
        self.init(
            _direction: direction,
            _capture: capture,
            _labelBuilder: labelBuilder,
            _depth: AnyDepth(),
            _properties: properties
        )
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        depth: Int,
        properties: [String: Any]
    ) {
        self.init(
            _direction: direction,
            _capture: capture,
            _labelBuilder: labelBuilder,
            _depth: depth,
            _properties: properties
        )
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        depth: PartialRangeFrom<Int>,
        properties: [String: Any]
    ) {
        self.init(
            _direction: direction,
            _capture: capture,
            _labelBuilder: labelBuilder,
            _depth: depth,
            _properties: properties
        )
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        depth: PartialRangeUpTo<Int>,
        properties: [String: Any]
    ) {
        self.init(
            _direction: direction,
            _capture: capture,
            _labelBuilder: labelBuilder,
            _depth: depth,
            _properties: properties
        )
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        depth: Range<Int>,
        properties: [String: Any]
    ) {
        self.init(
            _direction: direction,
            _capture: capture,
            _labelBuilder: labelBuilder,
            _depth: depth,
            _properties: properties
        )
    }
}
