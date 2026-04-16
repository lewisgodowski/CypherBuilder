//
//  Or.swift
//
//
//  Created by Lewis Godowski on 4/15/26.
//

import Foundation

public struct Or: LabelExpressible {
    public let expression: String

    public init(@OrLabelExpressionBuilder _ content: () -> some LabelExpressible) {
        self.expression = content().expression
    }
}
