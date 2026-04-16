//
//  PathPatternBuilder.swift
//  
//
//  Created by Lewis Godowski on 3/25/26.
//

import Foundation

@resultBuilder
public enum PathPatternBuilder {
    public static func buildBlock<
        C0: NodePatternExpressible,
        C1: RelationshipPatternExpressible,
        C2: NodePatternExpressible,
    >(
        _ c0: C0,
        _ c1: C1,
        _ c2: C2,
    ) -> String {
        [c0.pattern, c1.pattern, c2.pattern].joined()
    }

    public static func buildBlock<
        N0: NodePatternExpressible,
        R01: RelationshipPatternExpressible,
        N1: NodePatternExpressible,
        R12: RelationshipPatternExpressible,
        N2: NodePatternExpressible,
    >(
        _ n0: N0,
        _ r01: R01,
        _ n1: N1,
        _ r12: R12,
        _ n2: N2,
    ) -> String {
        [n0.pattern, r01.pattern, n1.pattern, r12.pattern, n2.pattern].joined()
    }

    public static func buildBlock<
        N0: NodePatternExpressible,
        R01: RelationshipPatternExpressible,
        N1: NodePatternExpressible,
        R12: RelationshipPatternExpressible,
        N2: NodePatternExpressible,
        R23: RelationshipPatternExpressible,
        N3: NodePatternExpressible,
    >(
        _ n0: N0,
        _ r01: R01,
        _ n1: N1,
        _ r12: R12,
        _ n2: N2,
        _ r23: R23,
        _ n3: N3,
    ) -> String {
        [n0.pattern, r01.pattern, n1.pattern, r12.pattern, n2.pattern, r23.pattern, n3.pattern].joined()
    }

    public static func buildBlock<
        N0: NodePatternExpressible,
        R01: RelationshipPatternExpressible,
        N1: NodePatternExpressible,
        R12: RelationshipPatternExpressible,
        N2: NodePatternExpressible,
        R23: RelationshipPatternExpressible,
        N3: NodePatternExpressible,
        R34: RelationshipPatternExpressible,
        N4: NodePatternExpressible,
    >(
        _ n0: N0,
        _ r01: R01,
        _ n1: N1,
        _ r12: R12,
        _ n2: N2,
        _ r23: R23,
        _ n3: N3,
        _ r34: R34,
        _ n4: N4,
    ) -> String {
        [
            n0.pattern,
            r01.pattern,
            n1.pattern,
            r12.pattern,
            n2.pattern,
            r23.pattern,
            n3.pattern,
            r34.pattern,
            n4.pattern
        ].joined()
    }
}
