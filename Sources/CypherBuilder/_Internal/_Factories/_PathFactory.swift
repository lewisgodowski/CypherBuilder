//
//  _PathFactory.swift
//  
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

package struct _PathFactory {
    static package func makePattern(
        origin: NodePatternExpressible,
        relationship: RelationshipPatternExpressible,
        destination: NodePatternExpressible
    ) -> String {
        let originString = origin.pattern.valueOrNil(shouldTrimWhitespaces: true)
        let relationshipString = relationship.pattern.valueOrNil(shouldTrimWhitespaces: true)
        let destinationString = destination.pattern.valueOrNil(shouldTrimWhitespaces: true)

        return [originString, relationshipString, destinationString].compactMap({ $0 }).joined()
    }
}
