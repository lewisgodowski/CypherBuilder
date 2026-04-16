//
//  Match.swift
//  
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

public struct Match: PatternExpressible {
    public let pattern: String

    public init(_ matchable: Matchable) {
        self.pattern = "MATCH \(matchable.pattern)"
    }
}
