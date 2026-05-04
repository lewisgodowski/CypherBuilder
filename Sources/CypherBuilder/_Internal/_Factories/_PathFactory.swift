//
//  _PathFactory.swift
//  CypherBuilder
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

package struct _PathFactory {
    // MARK: - init

    static private func _makePattern(@PathPatternBuilder _pathBuilder: () -> String, _variable: String?) -> String {
        let variableString: String? = if let variable = _variable?.valueOrNil(shouldTrimWhitespaces: true) {
            "\(variable) = "
        } else {
            nil
        }
        let pathBuilderString = _pathBuilder().valueOrNil(shouldTrimWhitespaces: true)

        return [variableString, pathBuilderString].compactMap(\.self).joined()
    }

    // MARK: - "convenience" init

    static package func makePattern(
        variable: String?,
        origin: NodePatternExpressible,
        relationship: RelationshipPatternExpressible,
        destination: NodePatternExpressible
    ) -> String {
        _makePattern(
            _pathBuilder: {
                origin
                relationship
                destination
            },
            _variable: variable
        )
    }
    
    static package func makePattern(variable: String?, @PathPatternBuilder pathBuilder: () -> String) -> String {
        _makePattern(_pathBuilder: pathBuilder, _variable: variable)
    }
}
