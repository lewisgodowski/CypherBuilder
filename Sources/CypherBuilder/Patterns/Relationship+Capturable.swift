//
//  Relationship+Capturable.swift
//
//
//  Created by Lewis Godowski on 4/15/26.
//

import Foundation

extension Relationship: Capturable where C == String {
    public var capture: String {
        _capture
    }

    // MARK: - init

    private init(_direction: Direction, _capture: String, _depth: any _DepthProviding) {
        self._capture = _capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .string(_capture),
            label: .none,
            depth: .providing(_depth),
            properties: [:]
        )
    }

    private init(_direction: Direction, _capture: String, _label: String, _depth: any _DepthProviding) {
        self._capture = _capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .string(_capture),
            label: .string(_label),
            depth: .providing(_depth),
            properties: [:]
        )
    }

    private init(
        _direction: Direction,
        _capture: String,
        @LabelExpressionBuilder _labelBuilder: () -> String,
        _depth: any _DepthProviding
    ) {
        self._capture = _capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .string(_capture),
            label: .string(_labelBuilder()),
            depth: .providing(_depth),
            properties: [:]
        )
    }

    private init(_direction: Direction, _capture: String, _depth: any _DepthProviding, _properties: [String: Any]) {
        self._capture = _capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .string(_capture),
            label: .none,
            depth: .providing(_depth),
            properties: _properties
        )
    }

    private init(
        _direction: Direction,
        _capture: String,
        _label: String,
        _depth: any _DepthProviding,
        _properties: [String: Any]
    ) {
        self._capture = _capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .string(_capture),
            label: .string(_label),
            depth: .providing(_depth),
            properties: _properties
        )
    }

    private init(
        _direction: Direction,
        _capture: String,
        @LabelExpressionBuilder _labelBuilder: () -> String,
        _depth: any _DepthProviding,
        _properties: [String: Any]
    ) {
        self._capture = _capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .string(_capture),
            label: .string(_labelBuilder()),
            depth: .providing(_depth),
            properties: _properties
        )
    }

    // MARK: - "convenience" init

    public init(direction: Direction, capture: String) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            label: .none,
            depth: .none,
            properties: [:]
        )
    }

    public init(direction: Direction, capture: String, label: String) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            label: .string(label),
            depth: .none,
            properties: [:]
        )
    }

    public init(direction: Direction, capture: String, @LabelExpressionBuilder labelBuilder: () -> String) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            label: .string(labelBuilder()),
            depth: .none,
            properties: [:]
        )
    }

    public init(directionOfAnyDepth direction: Direction, capture: String) {
        self.init(_direction: direction, _capture: capture, _depth: AnyDepth())
    }

    public init(direction: Direction, capture: String, depth: Int) {
        self.init(_direction: direction, _capture: capture, _depth: depth)
    }

    public init(direction: Direction, capture: String, depth: PartialRangeFrom<Int>) {
        self.init(_direction: direction, _capture: capture, _depth: depth)
    }

    public init(direction: Direction, capture: String, depth: PartialRangeUpTo<Int>) {
        self.init(_direction: direction, _capture: capture, _depth: depth)
    }

    public init(direction: Direction, capture: String, depth: Range<Int>) {
        self.init(_direction: direction, _capture: capture, _depth: depth)
    }

    public init(directionOfAnyDepth direction: Direction, capture: String, label: String) {
        self.init(_direction: direction, _capture: capture, _label: label, _depth: AnyDepth())
    }

    public init(direction: Direction, capture: String, label: String, depth: Int) {
        self.init(_direction: direction, _capture: capture, _label: label, _depth: depth)
    }

    public init(direction: Direction, capture: String, label: String, depth: PartialRangeFrom<Int>) {
        self.init(_direction: direction, _capture: capture, _label: label, _depth: depth)
    }

    public init(direction: Direction, capture: String, label: String, depth: PartialRangeUpTo<Int>) {
        self.init(_direction: direction, _capture: capture, _label: label, _depth: depth)
    }

    public init(direction: Direction, capture: String, label: String, depth: Range<Int>) {
        self.init(_direction: direction, _capture: capture, _label: label, _depth: depth)
    }

    public init(
        directionOfAnyDepth direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> String
    ) {
        self.init(_direction: direction, _capture: capture, _labelBuilder: labelBuilder, _depth: AnyDepth())
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> String,
        depth: Int
    ) {
        self.init(_direction: direction, _capture: capture, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> String,
        depth: PartialRangeFrom<Int>
    ) {
        self.init(_direction: direction, _capture: capture, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> String,
        depth: PartialRangeUpTo<Int>
    ) {
        self.init(_direction: direction, _capture: capture, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> String,
        depth: Range<Int>
    ) {
        self.init(_direction: direction, _capture: capture, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(direction: Direction, capture: String, properties: [String: Any]) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            label: .none,
            depth: .none,
            properties: properties
        )
    }

    public init(direction: Direction, capture: String, label: String, properties: [String: Any]) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            label: .string(label),
            depth: .none,
            properties: properties
        )
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> String,
        properties: [String: Any]
    ) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            label: .string(labelBuilder()),
            depth: .none,
            properties: properties
        )
    }

    public init(directionOfAnyDepth direction: Direction, capture: String, properties: [String: Any]) {
        self.init(_direction: direction, _capture: capture, _depth: AnyDepth(), _properties: properties)
    }

    public init(direction: Direction, capture: String, depth: Int, properties: [String: Any]) {
        self.init(_direction: direction, _capture: capture, _depth: depth, _properties: properties)
    }

    public init(direction: Direction, capture: String, depth: PartialRangeFrom<Int>, properties: [String: Any]) {
        self.init(_direction: direction, _capture: capture, _depth: depth, _properties: properties)
    }

    public init(direction: Direction, capture: String, depth: PartialRangeUpTo<Int>, properties: [String: Any]) {
        self.init(_direction: direction, _capture: capture, _depth: depth, _properties: properties)
    }

    public init(direction: Direction, capture: String, depth: Range<Int>, properties: [String: Any]) {
        self.init(_direction: direction, _capture: capture, _depth: depth, _properties: properties)
    }

    public init(directionOfAnyDepth direction: Direction, capture: String, label: String, properties: [String: Any]) {
        self.init(_direction: direction, _capture: capture, _label: label, _depth: AnyDepth(), _properties: properties)
    }

    public init(direction: Direction, capture: String, label: String, depth: Int, properties: [String: Any]) {
        self.init(_direction: direction, _capture: capture, _label: label, _depth: depth, _properties: properties)
    }

    public init(
        direction: Direction,
        capture: String,
        label: String,
        depth: PartialRangeFrom<Int>,
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _capture: capture, _label: label, _depth: depth, _properties: properties)
    }

    public init(
        direction: Direction,
        capture: String,
        label: String,
        depth: PartialRangeUpTo<Int>,
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _capture: capture, _label: label, _depth: depth, _properties: properties)
    }

    public init(direction: Direction, capture: String, label: String, depth: Range<Int>, properties: [String: Any]) {
        self.init(_direction: direction, _capture: capture, _label: label, _depth: depth, _properties: properties)
    }

    public init(
        directionOfAnyDepth direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> String,
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
        @LabelExpressionBuilder labelBuilder: () -> String,
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
        @LabelExpressionBuilder labelBuilder: () -> String,
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
        @LabelExpressionBuilder labelBuilder: () -> String,
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
        @LabelExpressionBuilder labelBuilder: () -> String,
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
