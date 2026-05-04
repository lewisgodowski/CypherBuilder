//
//  _Path+.swift
//  CypherBuilder
//
//  Created by Lewis Godowski on 4/15/26.
//

import Foundation

package extension Path {
    init(_pattern: String) {
        self.pattern = _pattern
        self._variable = ""
    }
    init(_pattern: String, _variable: String) {
        self.pattern = _pattern
        self._variable = _variable
    }
}
