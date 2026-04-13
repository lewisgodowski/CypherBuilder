//
//  Create.swift
//  
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

public struct Create: Createable, PatternExpressible {
    public let pattern: String

    public init(_ node: NodePatternExpressible) {
        self.pattern = "CREATE \(node.pattern)"
    }

    public init(_ path: Path) {
        self.pattern = "CREATE \(path.pattern)"
    }
}
