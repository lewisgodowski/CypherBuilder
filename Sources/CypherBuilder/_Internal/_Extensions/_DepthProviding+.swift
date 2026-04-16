//
//  _DepthProviding+.swift
//
//
//  Created by Lewis Godowski on 4/15/26.
//

import Foundation

extension Int: _DepthProviding {
    package var value: String {
        "*\(self)"
    }
}

extension PartialRangeFrom<Int>: _DepthProviding {
    package var value: String {
        "*\(lowerBound).."
    }
}

extension PartialRangeUpTo<Int>: _DepthProviding {
    package var value: String {
        "*..\(upperBound)"
    }
}

extension Range<Int>: _DepthProviding {
    package var value: String {
        "*\(lowerBound)..\(upperBound)"
    }
}
