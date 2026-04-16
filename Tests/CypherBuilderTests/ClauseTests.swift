@testable import CypherBuilder
import Testing

@Suite(.tags(.clauses))
struct ClauseTests {
    // MARK: - Tests

    @Test
    func `create node`() {
        #expect(Create(Node(capture: "u", object: User(id: "123"))).pattern == "CREATE (u:User { id: \"123\" })")
        #expect(Create(Node(capturedObject: User(id: "123"))).pattern == "CREATE (user123:User { id: \"123\" })")
        #expect(Create(Node(uncapturedObject: User(id: "123"))).pattern == "CREATE (:User { id: \"123\" })")
    }

    @Test
    func `match node`() {
        #expect(Match(Node(capture: "u", object: User(id: "123"))).pattern == "MATCH (u:User { id: \"123\" })")
        #expect(Match(Node(capturedObject: User(id: "123"))).pattern == "MATCH (user123:User { id: \"123\" })")
        #expect(Match(Node(uncapturedObject: User(id: "123"))).pattern == "MATCH (:User { id: \"123\" })")
    }
}
