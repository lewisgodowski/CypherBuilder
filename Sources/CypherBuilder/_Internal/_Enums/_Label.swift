//
//  _Label.swift
//  CypherBuilder
//
//  Created by Lewis Godowski on 3/25/26.
//

import Foundation

package enum _Label {
    case string([String])
    case none

    package var value: String? {
        switch self {
        case .string(let values):
            values
                .map { $0.valueOrNil(shouldTrimWhitespaces: true) }
                .compactMap(\.self)
                .map { ":\($0)" }
                .joined()
        case .none: nil
        }
    }

    static func string(_ values: String...) -> Self {
        .string(values)
    }
}
