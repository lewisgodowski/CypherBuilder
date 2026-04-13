//
//  LabelExpressionBuilder.swift
//  
//
//  Created by Lewis Godowski on 3/24/26.
//

import Foundation

// MARK: LabelExpressionBuilder

public protocol LabelExpressible {
    var expression: String { get }
}

@resultBuilder
public enum LabelExpressionBuilder {
    public static func buildBlock<L: LabelExpressible>(_ component: L) -> String {
        component.expression
    }
}

// MARK: - Wildcard

extension LabelExpressible where Self == String {
    public static var wildcard: String { "%" }
}

// MARK: - Not

@resultBuilder
enum NotLabelExpressionBuilder {
    public static func buildBlock<L: LabelExpressible>(_ component: L) -> String {
        "!\(component.expression)"
    }
}

public struct Not: LabelExpressible {
    public let expression: String

    public init(@NotLabelExpressionBuilder _ content: () -> some LabelExpressible) {
        self.expression = content().expression
    }

    public init(_ component: some LabelExpressible) {
        self.expression = "!\(component.expression)"
    }
}

// MARK: - And

@resultBuilder
public enum AndLabelExpressionBuilder {
    static let separator = "&"

    public static func buildBlock<C0: LabelExpressible, C1: LabelExpressible>(_ c0: C0, _ c1: C1,) -> String {
        "(\([c0.expression, c1.expression].joined(separator: separator)))"
    }

    public static func buildBlock<C0: LabelExpressible, C1: LabelExpressible, C2: LabelExpressible>(
        _ c0: C0,
        _ c1: C1,
        _ c2: C2,
    ) -> String {
        "(\([c0.expression, c1.expression, c2.expression].joined(separator: separator)))"
    }

    public static func buildBlock<
        C0: LabelExpressible,
        C1: LabelExpressible,
        C2: LabelExpressible,
        C3: LabelExpressible
    >(
        _ c0: C0,
        _ c1: C1,
        _ c2: C2,
        _ c3: C3,
    ) -> String {
        "(\([c0.expression, c1.expression, c2.expression, c3.expression].joined(separator: separator)))"
    }

    public static func buildBlock<
        C0: LabelExpressible,
        C1: LabelExpressible,
        C2: LabelExpressible,
        C3: LabelExpressible,
        C4: LabelExpressible
    >(
        _ c0: C0,
        _ c1: C1,
        _ c2: C2,
        _ c3: C3,
        _ c4: C4,
    ) -> String {
        "(\([c0.expression, c1.expression, c2.expression, c3.expression, c4.expression].joined(separator: separator)))"
    }
}

public struct And: LabelExpressible {
    public let expression: String

    public init(@AndLabelExpressionBuilder content: () -> some LabelExpressible) {
        self.expression = content().expression
    }
}

// MARK: - Or

@resultBuilder
public enum OrLabelExpressionBuilder {
    static let separator = "|"

    public static func buildBlock<C0: LabelExpressible, C1: LabelExpressible>(_ c0: C0, _ c1: C1,) -> String {
        "(\([c0.expression, c1.expression].joined(separator: separator)))"
    }

    public static func buildBlock<C0: LabelExpressible, C1: LabelExpressible, C2: LabelExpressible>(
        _ c0: C0,
        _ c1: C1,
        _ c2: C2,
    ) -> String {
        "(\([c0.expression, c1.expression, c2.expression].joined(separator: separator)))"
    }

    public static func buildBlock<
        C0: LabelExpressible,
        C1: LabelExpressible,
        C2: LabelExpressible,
        C3: LabelExpressible
    >(
        _ c0: C0,
        _ c1: C1,
        _ c2: C2,
        _ c3: C3,
    ) -> String {
        "(\([c0.expression, c1.expression, c2.expression, c3.expression].joined(separator: separator)))"
    }

    public static func buildBlock<
        C0: LabelExpressible,
        C1: LabelExpressible,
        C2: LabelExpressible,
        C3: LabelExpressible,
        C4: LabelExpressible
    >(
        _ c0: C0,
        _ c1: C1,
        _ c2: C2,
        _ c3: C3,
        _ c4: C4,
    ) -> String {
        "(\([c0.expression, c1.expression, c2.expression, c3.expression, c4.expression].joined(separator: separator)))"
    }
}

public struct Or: LabelExpressible {
    public let expression: String

    public init(@OrLabelExpressionBuilder _ content: () -> some LabelExpressible) {
        self.expression = content().expression
    }
}

// MARK: - Extensions

extension String: LabelExpressible {
    public var expression: String { self }
}
