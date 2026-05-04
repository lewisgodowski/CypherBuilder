//
//  _RelationshipFactory.swift
//  CypherBuilder
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

package struct _RelationshipFactory {
    static package func makePattern(
        direction: Direction,
        capture: _Capture,
        labels: _Label,
        depth: _Depth,
        properties dict: [String: Any]
    ) -> String {
        let leftArrowString = direction.leftValue?.valueOrNil(shouldTrimWhitespaces: true)
        let captureString = capture.value?.valueOrNil(shouldTrimWhitespaces: true)
        let labelsString = labels.value?.valueOrNil(shouldTrimWhitespaces: true)
        let depthString = depth.value?.valueOrNil(shouldTrimWhitespaces: true)
        let propertiesString = dict.propertiesString.valueOrNil(shouldTrimWhitespaces: true)
        let rightArrowString = direction.rightValue?.valueOrNil(shouldTrimWhitespaces: true)

        let leftBracketString = [captureString, labelsString, depthString, propertiesString].allSatisfy { $0 == nil }
            ? "-"
            : "-["
        let rightBracketString = [captureString, labelsString, depthString, propertiesString].allSatisfy { $0 == nil }
            ? "-"
            : "]-"

        return [
            leftArrowString,
            leftBracketString,
            [
                [
                    captureString,
                    labelsString,
                    depthString
                ].compactMap({ $0 }).joined(),
                propertiesString
            ].compactMap({ $0 }).joined(separator: " "),
            rightBracketString,
            rightArrowString,
        ].compactMap({ $0 }).joined()
    }
}
