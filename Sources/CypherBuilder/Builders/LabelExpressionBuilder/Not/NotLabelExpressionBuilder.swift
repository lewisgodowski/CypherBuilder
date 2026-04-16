//
//  NotLabelExpressionBuilder.swift
//
//
//  Created by Lewis Godowski on 4/15/26.
//

import Foundation

@resultBuilder
package enum NotLabelExpressionBuilder {
    public static func buildBlock(_ component: any LabelExpressible) -> String {
        "!\(component.expression)"
    }
}
