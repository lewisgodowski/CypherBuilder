//
//  OrLabelExpressionBuilder.swift
//
//
//  Created by Lewis Godowski on 4/15/26.
//

import Foundation

@resultBuilder
package enum OrLabelExpressionBuilder {
    static private let separator = "|"

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
