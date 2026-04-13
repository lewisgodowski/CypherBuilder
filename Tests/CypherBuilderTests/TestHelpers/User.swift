import CypherBuilder
import Foundation

struct User: Graphable {
    let id: String
    let label: String

    init(id: String) {
        self.id = id
        self.label = "User"
    }

    var capture: String {
        label.lowercased() + id.lowercased() // TODO: strip non-alphanumeric characters
    }
}
