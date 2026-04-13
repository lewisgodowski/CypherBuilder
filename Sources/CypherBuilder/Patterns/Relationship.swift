//
//  Relationship.swift
//  
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

public struct Relationship<C>: RelationshipPatternExpressible {
    private let _capture: String
    public let pattern: String
}

extension Relationship where C == Never {
    public init(direction: Direction) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .none,
            label: .none,
            depth: .none,
            properties: [:]
        )
    }

    public init(direction: Direction, label: String) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .none,
            label: .string(label),
            depth: .none,
            properties: [:]
        )
    }

    public init(direction: Direction, @LabelExpressionBuilder labelBuilder: () -> String) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .none,
            label: .string(labelBuilder()),
            depth: .none,
            properties: [:]
        )
    }

    public init(direction: Direction, depth: any DepthProviding) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .none,
            label: .none,
            depth: .providing(depth),
            properties: [:]
        )
    }

    public init(direction: Direction, label: String, depth: any DepthProviding) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .none,
            label: .string(label),
            depth: .providing(depth),
            properties: [:]
        )
    }

    public init(direction: Direction, @LabelExpressionBuilder labelBuilder: () -> String, depth: any DepthProviding) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .none,
            label: .string(labelBuilder()),
            depth: .providing(depth),
            properties: [:]
        )
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

    public init(direction: Direction, depth: any DepthProviding, properties: [String: Any]) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .none,
            label: .none,
            depth: .providing(depth),
            properties: properties
        )
    }

    public init(direction: Direction, label: String, depth: any DepthProviding, properties: [String: Any]) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .none,
            label: .string(label),
            depth: .providing(depth),
            properties: properties
        )
    }

    public init(
        direction: Direction,
        @LabelExpressionBuilder labelBuilder: () -> String,
        depth: any DepthProviding,
        properties: [String: Any]
    ) {
        self._capture = ""
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .none,
            label: .string(labelBuilder()),
            depth: .providing(depth),
            properties: properties
        )
    }
}

// MARK: - Capturable

extension Relationship: Capturable where C == String {
    public var capture: String {
        _capture
    }

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

    public init(direction: Direction, capture: String, depth: any DepthProviding) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            label: .none,
            depth: .providing(depth),
            properties: [:]
        )
    }

    public init(direction: Direction, capture: String, label: String, depth: any DepthProviding) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            label: .string(label),
            depth: .providing(depth),
            properties: [:]
        )
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> String,
        depth: any DepthProviding
    ) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            label: .string(labelBuilder()),
            depth: .providing(depth),
            properties: [:]
        )
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

    public init(direction: Direction, capture: String, depth: any DepthProviding, properties: [String: Any]) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            label: .none,
            depth: .providing(depth),
            properties: properties
        )
    }

    public init(
        direction: Direction,
        capture: String,
        label: String,
        depth: any DepthProviding,
        properties: [String: Any]
    ) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            label: .string(label),
            depth: .providing(depth),
            properties: properties
        )
    }

    public init(
        direction: Direction,
        capture: String,
        @LabelExpressionBuilder labelBuilder: () -> String,
        depth: any DepthProviding,
        properties: [String: Any]
    ) {
        self._capture = capture
        self.pattern = _RelationshipFactory.makePattern(
            direction: direction,
            capture: .string(capture),
            label: .string(labelBuilder()),
            depth: .providing(depth),
            properties: properties
        )
    }
}

// MARK: - Internal

private extension Relationship {
    init(_pattern: String, capture: String) {
        self._capture = capture
        self.pattern = _pattern
    }

    init(_pattern: String) {
        self._capture = ""
        self.pattern = _pattern
    }
}

