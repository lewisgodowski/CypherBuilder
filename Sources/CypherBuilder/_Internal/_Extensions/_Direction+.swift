//
//  _Direction+.swift
//
//
//  Created by Lewis Godowski on 4/15/26.
//

import Foundation

package extension Direction {
    var leftValue: String? {
        switch self {
        case .leftToRight: nil
        case .rightToLeft: "<"
        case .none: nil
        }
    }

    var rightValue: String? {
        switch self {
        case .leftToRight: ">"
        case .rightToLeft: nil
        case .none: nil
        }
    }
}
