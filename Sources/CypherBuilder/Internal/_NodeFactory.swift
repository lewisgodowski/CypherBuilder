//
//  _NodeFactory.swift
//  
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

public struct _NodeFactory {
    public static func makePattern(capture: _Capture, label: _Label, properties dict: [String: Any]) -> String {
        let captureString = capture.value?.valueOrNil(shouldTrimWhitespaces: true)
        let labelString = label.value?.valueOrNil(shouldTrimWhitespaces: true)
        let propertiesString = dict.propertiesString.valueOrNil(shouldTrimWhitespaces: true)

        return [
            "(",
            [
                [
                    captureString,
                    labelString
                ].compactMap({ $0 }).joined().valueOrNil(shouldTrimWhitespaces: true),
                propertiesString
            ].compactMap({ $0 }).joined(separator: " "),
            ")",
        ].compactMap({ $0 }).joined()
    }

    public static func makePattern(capture: _Capture, object: any Graphable) -> String {
        let dict: [String: Any] = if let data = try? JSONEncoder().encode(object),
                                     let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            dict
        } else {
            [:]
        }
        return makePattern(capture: capture, label: .string(object.label), properties: dict)
    }
}
