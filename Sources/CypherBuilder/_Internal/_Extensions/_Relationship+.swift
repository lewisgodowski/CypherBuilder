//
//  _Relationship+.swift
//
//
//  Created by Lewis Godowski on 4/15/26.
//

import Foundation

package extension Relationship {
    init(_pattern: String) {
        self._capture = ""
        self.pattern = _pattern
    }

    init(_pattern: String, _capture: String) {
        self._capture = _capture
        self.pattern = _pattern
    }
}
