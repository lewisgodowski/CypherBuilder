//
//  _NodeFactory.swift
//  CypherBuilder
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

package struct _NodeFactory {
    static package func makePattern(capture: _Capture, labels: _Label, properties dict: [String: Any]) -> String {
        let captureString = capture.value?.valueOrNil(shouldTrimWhitespaces: true)
        let labelsString = labels.value?.valueOrNil(shouldTrimWhitespaces: true)
        let propertiesString = dict.propertiesString.valueOrNil(shouldTrimWhitespaces: true)

        return [
            "(",
            [
                [
                    captureString,
                    labelsString
                ].compactMap({ $0 }).joined().valueOrNil(shouldTrimWhitespaces: true),
                propertiesString
            ].compactMap({ $0 }).joined(separator: " "),
            ")",
        ].compactMap({ $0 }).joined()
    }

    static package func makePattern(capture: _Capture, object: any Graphable) -> String {
        let dict: [String: Any] = if let data = try? JSONEncoder().encode(object),
                                     let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            dict
        } else {
            [:]
        }
        return makePattern(capture: capture, labels: .string(object.label), properties: dict)
    }
}
