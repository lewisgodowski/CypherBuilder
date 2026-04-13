//
//  Dictionary+.swift
//  
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

private let ignoredKeys = ["label"]

public extension [String: Any] {
    var propertiesString: String {
        guard !isEmpty else { return "" }

        var propertyStrings = [String]()
        for (key, value) in self where !ignoredKeys.contains(key) {
            if let v = value as? String {
                propertyStrings.append("\(key): \"\(v)\"")
            } else {
                propertyStrings.append("\(key): \(value)")
            }
        }

        return "\(propertyStrings.isEmpty ? "" : "{ \(propertyStrings.joined(separator: ", ")) }")"
    }
}
