//
//  And.swift
//
//
//  Created by Lewis Godowski on 4/15/26.
//

import Foundation

public struct And: LabelExpressible {
    public let expression: String

    public init(@AndLabelExpressionBuilder content: () -> some LabelExpressible) {
        self.expression = content().expression
    }
}
