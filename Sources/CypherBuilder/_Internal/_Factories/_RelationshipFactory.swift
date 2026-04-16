//
//  _RelationshipFactory.swift
//  
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

package struct _RelationshipFactory {
    static package func makePattern(
        direction: Direction,
        capture: _Capture,
        label: _Label,
        depth: _Depth,
        properties dict: [String: Any]
    ) -> String {
        let leftArrowString = direction.leftValue?.valueOrNil(shouldTrimWhitespaces: true)
        let captureString = capture.value?.valueOrNil(shouldTrimWhitespaces: true)
        let labelString = label.value?.valueOrNil(shouldTrimWhitespaces: true)
        let depthString = depth.value?.valueOrNil(shouldTrimWhitespaces: true)
        let propertiesString = dict.propertiesString.valueOrNil(shouldTrimWhitespaces: true)
        let rightArrowString = direction.rightValue?.valueOrNil(shouldTrimWhitespaces: true)

        let leftBracketString = [captureString, labelString, depthString, propertiesString].allSatisfy { $0 == nil }
            ? "-"
            : "-["
        let rightBracketString = [captureString, labelString, depthString, propertiesString].allSatisfy { $0 == nil }
            ? "-"
            : "]-"

        return [
            leftArrowString,
            leftBracketString,
            [
                [
                    captureString,
                    labelString,
                    depthString
                ].compactMap({ $0 }).joined(),
                propertiesString
            ].compactMap({ $0 }).joined(separator: " "),
            rightBracketString,
            rightArrowString,
        ].compactMap({ $0 }).joined()
    }
}
