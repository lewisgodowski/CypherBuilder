//
//  _Depth.swift
//  
//
//  Created by Lewis Godowski on 3/25/26.
//

import Foundation

package enum _Depth {
    case providing(any _DepthProviding)
    case none

    package var value: String? {
        switch self {
        case .providing(let depthProviding): depthProviding.value
        case .none: nil
        }
    }
}
