//
//  LabelExpressionBuilder.swift
//  
//
//  Created by Lewis Godowski on 3/24/26.
//

import Foundation

// MARK: LabelExpressionBuilder

@resultBuilder
public enum LabelExpressionBuilder {
    public static func buildBlock(_ component: any LabelExpressible) -> String {
        component.expression
    }
}
