//
//  Extensions.swift
//  
//
//  Created by Lewis Godowski on 3/25/26.
//

import Foundation

public extension String {
    func valueOrNil(shouldTrimWhitespaces: Bool = false) -> String? {
        var string = self
        if shouldTrimWhitespaces {
            string = string.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return string.isEmpty ? nil : string
    }
}
