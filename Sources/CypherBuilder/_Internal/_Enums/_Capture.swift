//
//  _Capture.swift
//  
//
//  Created by Lewis Godowski on 3/25/26.
//

import Foundation

package enum _Capture {
    case string(String)
    case graphable(any Graphable)
    case none

    package var value: String? {
        switch self {
        case .string(let value): value
        case .graphable(let object): object.capture
        case .none: nil
        }
    }
}
