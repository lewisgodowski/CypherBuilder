//
//  Relationship.swift
//  CypherBuilder
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

public struct Relationship<C>: RelationshipPatternExpressible {
    package let _capture: String
    public let pattern: String
}

extension Relationship where C == Never {
    // MARK: - init

    private init(_direction: Direction, _labels: [String]) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .none,
            labels: .string(_labels),
            depth: .none,
            properties: [:]
        )
    }

    private init(_direction: Direction, @LabelExpressionBuilder _labelBuilder: () -> [String]) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .none,
            labels: .string(_labelBuilder()),
            depth: .none,
            properties: [:]
        )
    }

    private init(_direction: Direction, _labels: [String], _depth: any _DepthProviding) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .none,
            labels: .string(_labels),
            depth: .providing(_depth),
            properties: [:]
        )
    }

    private init(
        _direction: Direction,
        @LabelExpressionBuilder _labelBuilder: () -> [String],
        _depth: any _DepthProviding
    ) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .none,
            labels: .string(_labelBuilder()),
            depth: .providing(_depth),
            properties: [:]
        )
    }

    private init(_direction: Direction, _labels: [String], _depth: any _DepthProviding, _properties: [String: Any]) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .none,
            labels: .string(_labels),
            depth: .providing(_depth),
            properties: _properties
        )
    }

    private init(
        _direction: Direction,
        @LabelExpressionBuilder _labelBuilder: () -> [String],
        _depth: any _DepthProviding,
        _properties: [String: Any]
    ) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .none,
            labels: .string(_labelBuilder()),
            depth: .providing(_depth),
            properties: _properties
        )
    }

    // MARK: - "convenience" init

    public init(direction: Direction, labels: String...) {
        self.init(_direction: direction, _labels: labels)
    }

    public init(direction: Direction, @LabelExpressionBuilder labelBuilder: () -> [String]) {
        self.init(_direction: direction, _labelBuilder: labelBuilder)
    }

    public init(directionOfAnyDepth direction: Direction, labels: String...) {
        self.init(_direction: direction, _labels: labels, _depth: AnyDepth())
    }

    public init(direction: Direction, labels: String..., depth: Int) {
        self.init(_direction: direction, _labels: labels, _depth: depth)
    }

    public init(direction: Direction, labels: String..., depth: PartialRangeFrom<Int>) {
        self.init(_direction: direction, _labels: labels, _depth: depth)
    }

    public init(direction: Direction, labels: String..., depth: PartialRangeUpTo<Int>) {
        self.init(_direction: direction, _labels: labels, _depth: depth)
    }

    public init(direction: Direction, labels: String..., depth: Range<Int>) {
        self.init(_direction: direction, _labels: labels, _depth: depth)
    }

    public init(
        directionOfAnyDepth direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> [String]
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: AnyDepth())
    }

    public init(direction: Direction, @LabelExpressionBuilder labelBuilder: () -> [String], depth: Int) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(
        direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        depth: PartialRangeFrom<Int>
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(
        direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        depth: PartialRangeUpTo<Int>
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(direction: Direction, @LabelExpressionBuilder labelBuilder: () -> [String], depth: Range<Int>) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(direction: Direction, labels: String..., properties: [String: Any]) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .none,
            labels: .string(labels),
            depth: .none,
            properties: properties
        )
    }

    public init(direction: Direction, @LabelExpressionBuilder labelBuilder: () -> [String], properties: [String: Any]) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .none,
            labels: .string(labelBuilder()),
            depth: .none,
            properties: properties
        )
    }

    public init(directionOfAnyDepth direction: Direction, labels: String..., properties: [String: Any]) {
        self.init(_direction: direction, _labels: labels, _depth: AnyDepth(), _properties: properties)
    }

    public init(direction: Direction, labels: String..., depth: Int, properties: [String: Any]) {
        self.init(_direction: direction, _labels: labels, _depth: depth, _properties: properties)
    }

    public init(direction: Direction, labels: String..., depth: PartialRangeFrom<Int>, properties: [String: Any]) {
        self.init(_direction: direction, _labels: labels, _depth: depth, _properties: properties)
    }

    public init(direction: Direction, labels: String..., depth: PartialRangeUpTo<Int>, properties: [String: Any]) {
        self.init(_direction: direction, _labels: labels, _depth: depth, _properties: properties)
    }

    public init(direction: Direction, labels: String..., depth: Range<Int>, properties: [String: Any]) {
        self.init(_direction: direction, _labels: labels, _depth: depth, _properties: properties)
    }

    public init(
        directionOfAnyDepth direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: AnyDepth(), _properties: properties)
    }

    public init(
        direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        depth: Int,
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth, _properties: properties)
    }

    public init(
        direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        depth: PartialRangeFrom<Int>,
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth, _properties: properties)
    }

    public init(
        direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        depth: PartialRangeUpTo<Int>,
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth, _properties: properties)
    }

    public init(
        direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> [String],
        depth: Range<Int>,
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth, _properties: properties)
    }
}
