//
//  _Label.swift
//  
//
//  Created by Lewis Godowski on 3/25/26.
//

import Foundation

package enum _Label {
    case string(String)
    case none

    package var value: String? {
        switch self {
        case .string(let value): if let v = value.valueOrNil(shouldTrimWhitespaces: true) { ":\(v)" } else { nil }
        case .none: nil
        }
    }
}
