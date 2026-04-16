//
//  Relationship.swift
//  
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

    private init(_direction: Direction) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .none,
            label: .none,
            depth: .none,
            properties: [:]
        )
    }

    private init(_direction: Direction, _label: String) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .none,
            label: .string(_label),
            depth: .none,
            properties: [:]
        )
    }

    private init(_direction: Direction, @LabelExpressionBuilder _labelBuilder: () -> String) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .none,
            label: .string(_labelBuilder()),
            depth: .none,
            properties: [:]
        )
    }

    private init(_direction: Direction, _depth: any _DepthProviding) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .none,
            label: .none,
            depth: .providing(_depth),
            properties: [:]
        )
    }

    private init(_direction: Direction, _label: String, _depth: any _DepthProviding) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .none,
            label: .string(_label),
            depth: .providing(_depth),
            properties: [:]
        )
    }

    private init(
        _direction: Direction,
        @LabelExpressionBuilder _labelBuilder: () -> String,
        _depth: any _DepthProviding
    ) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .none,
            label: .string(_labelBuilder()),
            depth: .providing(_depth),
            properties: [:]
        )
    }

    private init(_direction: Direction, _depth: any _DepthProviding, _properties: [String: Any]) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .none,
            label: .none,
            depth: .providing(_depth),
            properties: _properties
        )
    }

    private init(_direction: Direction, _label: String, _depth: any _DepthProviding, _properties: [String: Any]) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .none,
            label: .string(_label),
            depth: .providing(_depth),
            properties: _properties
        )
    }

    private init(
        _direction: Direction,
        @LabelExpressionBuilder _labelBuilder: () -> String,
        _depth: any _DepthProviding,
        _properties: [String: Any]
    ) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: _direction,
            capture: .none,
            label: .string(_labelBuilder()),
            depth: .providing(_depth),
            properties: _properties
        )
    }

    // MARK: - "convenience" init

    public init(direction: Direction) {
        self.init(_direction: direction)
    }

    public init(direction: Direction, label: String) {
        self.init(_direction: direction, _label: label)
    }

    public init(direction: Direction, @LabelExpressionBuilder labelBuilder: () -> String) {
        self.init(_direction: direction, _labelBuilder: labelBuilder)
    }

    public init(directionOfAnyDepth direction: Direction) {
        self.init(_direction: direction, _depth: AnyDepth())
    }

    public init(direction: Direction, depth: Int) {
        self.init(_direction: direction, _depth: depth)
    }

    public init(direction: Direction, depth: PartialRangeFrom<Int>) {
        self.init(_direction: direction, _depth: depth)
    }

    public init(direction: Direction, depth: PartialRangeUpTo<Int>) {
        self.init(_direction: direction, _depth: depth)
    }

    public init(direction: Direction, depth: Range<Int>) {
        self.init(_direction: direction, _depth: depth)
    }

    public init(directionOfAnyDepth direction: Direction, label: String) {
        self.init(_direction: direction, _label: label, _depth: AnyDepth())
    }

    public init(direction: Direction, label: String, depth: Int) {
        self.init(_direction: direction, _label: label, _depth: depth)
    }

    public init(direction: Direction, label: String, depth: PartialRangeFrom<Int>) {
        self.init(_direction: direction, _label: label, _depth: depth)
    }

    public init(direction: Direction, label: String, depth: PartialRangeUpTo<Int>) {
        self.init(_direction: direction, _label: label, _depth: depth)
    }

    public init(direction: Direction, label: String, depth: Range<Int>) {
        self.init(_direction: direction, _label: label, _depth: depth)
    }

    public init(
        directionOfAnyDepth direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> String
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: AnyDepth())
    }

    public init(direction: Direction, @LabelExpressionBuilder labelBuilder: () -> String, depth: Int) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(
        direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> String,
        depth: PartialRangeFrom<Int>
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(
        direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> String,
        depth: PartialRangeUpTo<Int>
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(direction: Direction, @LabelExpressionBuilder labelBuilder: () -> String, depth: Range<Int>) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth)
    }

    public init(direction: Direction, properties: [String: Any]) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .none,
            label: .none,
            depth: .none,
            properties: properties
        )
    }

    public init(direction: Direction, label: String, properties: [String: Any]) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .none,
            label: .string(label),
            depth: .none,
            properties: properties
        )
    }

    public init(direction: Direction, @LabelExpressionBuilder labelBuilder: () -> String, properties: [String: Any]) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .none,
            label: .string(labelBuilder()),
            depth: .none,
            properties: properties
        )
    }

    public init(directionOfAnyDepth direction: Direction, properties: [String: Any]) {
        self.init(_direction: direction, _depth: AnyDepth(), _properties: properties)
    }

    public init(direction: Direction, depth: Int, properties: [String: Any]) {
        self.init(_direction: direction, _depth: depth, _properties: properties)
    }

    public init(direction: Direction, depth: PartialRangeFrom<Int>, properties: [String: Any]) {
        self.init(_direction: direction, _depth: depth, _properties: properties)
    }

    public init(direction: Direction, depth: PartialRangeUpTo<Int>, properties: [String: Any]) {
        self.init(_direction: direction, _depth: depth, _properties: properties)
    }

    public init(direction: Direction, depth: Range<Int>, properties: [String: Any]) {
        self.init(_direction: direction, _depth: depth, _properties: properties)
    }

    public init(directionOfAnyDepth direction: Direction, label: String, properties: [String: Any]) {
        self.init(_direction: direction, _label: label, _depth: AnyDepth(), _properties: properties)
    }

    public init(direction: Direction, label: String, depth: Int, properties: [String: Any]) {
        self.init(_direction: direction, _label: label, _depth: depth, _properties: properties)
    }

    public init(direction: Direction, label: String, depth: PartialRangeFrom<Int>, properties: [String: Any]) {
        self.init(_direction: direction, _label: label, _depth: depth, _properties: properties)
    }

    public init(direction: Direction, label: String, depth: PartialRangeUpTo<Int>, properties: [String: Any]) {
        self.init(_direction: direction, _label: label, _depth: depth, _properties: properties)
    }

    public init(direction: Direction, label: String, depth: Range<Int>, properties: [String: Any]) {
        self.init(_direction: direction, _label: label, _depth: depth, _properties: properties)
    }

    public init(
        directionOfAnyDepth direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> String,
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: AnyDepth(), _properties: properties)
    }

    public init(
        direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> String,
        depth: Int,
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth, _properties: properties)
    }

    public init(
        direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> String,
        depth: PartialRangeFrom<Int>,
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth, _properties: properties)
    }

    public init(
        direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> String,
        depth: PartialRangeUpTo<Int>,
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth, _properties: properties)
    }

    public init(
        direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> String,
        depth: Range<Int>,
        properties: [String: Any]
    ) {
        self.init(_direction: direction, _labelBuilder: labelBuilder, _depth: depth, _properties: properties)
    }
}
