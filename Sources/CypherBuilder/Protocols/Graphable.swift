//
//  Graphable.swift
//  
//
//  Created by Lewis Godowski on 4/12/26.
//

import Foundation

public protocol Graphable: Capturable, Codable, Identifiable, Sendable {
    var label: String { get }
}
