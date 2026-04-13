//
//  Direction.swift
//  
//
//  Created by Lewis Godowski on 3/25/26.
//

import Foundation

public enum Direction {
    case leftToRight
    case rightToLeft
    case none

    public var leftValue: String? {
        switch self {
        case .leftToRight: nil
        case .rightToLeft: "<"
        case .none: nil
        }
    }

    public var rightValue: String? {
        switch self {
        case .leftToRight: ">"
        case .rightToLeft: nil
        case .none: nil
        }
    }
}
