//
//  Not.swift
//
//
//  Created by Lewis Godowski on 4/15/26.
//

import Foundation

public struct Not: LabelExpressible {
    public let expression: String

    public init(@NotLabelExpressionBuilder _ content: () -> some LabelExpressible) {
        self.expression = content().expression
    }

    public init(_ component: some LabelExpressible) {
        self.expression = "!\(component.expression)"
    }
}
