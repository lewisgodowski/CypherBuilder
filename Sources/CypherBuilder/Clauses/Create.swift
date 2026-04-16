//
//  Create.swift
//  
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

public struct Create: PatternExpressible {
    public let pattern: String

    public init(_ createable: Createable) {
        self.pattern = "CREATE \(createable.pattern)"
    }
}
