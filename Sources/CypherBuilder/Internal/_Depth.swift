//
//  _Depth.swift
//  
//
//  Created by Lewis Godowski on 3/25/26.
//

import Foundation

public protocol DepthProviding {
    var value: String { get }
}

public enum _Depth {
    case providing(any DepthProviding)
    case none

    public var value: String? {
        switch self {
        case .providing(let depthProviding): depthProviding.value
        case .none: nil
        }
    }
}

extension DepthProviding where Self == AnyDepth {
    public static var any: Self { .init() }
}

public struct AnyDepth: DepthProviding {
    public var value: String { "*" }
}


extension Int: DepthProviding {
    public var value: String {
        "*\(self)"
    }
}

extension PartialRangeFrom<Int>: DepthProviding {
    public var value: String {
        "*\(lowerBound).."
    }
}

extension PartialRangeUpTo<Int>: DepthProviding {
    public var value: String {
        "*..\(upperBound)"
    }
}

extension Range<Int>: DepthProviding {
    public var value: String {
        "*\(lowerBound)..\(upperBound)"
    }
}
