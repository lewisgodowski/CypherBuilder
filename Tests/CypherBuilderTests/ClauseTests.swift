@testable import CypherBuilder
import Testing

@Suite(.tags(.clauses))
struct ClauseTests {
    // MARK: - Tests

    @Test
    func `create node`() {
        #expect(Create(Node(capture: "u", object: User(id: "123"))).pattern == #"CREATE (u:User { id: "123" })"#)
        #expect(Create(Node(capturedObject: User(id: "123"))).pattern == #"CREATE (user123:User { id: "123" })"#)
        #expect(Create(Node(uncapturedObject: User(id: "123"))).pattern == #"CREATE (:User { id: "123" })"#)
    }

    @Test
    func `create path`() {
        #expect(
            Create(
                Path(
                    left: Node(capturedObject: User(id: "123")),
                    Relationship(direction: .leftToRight, labels: "FOLLOWS"),
                    right: Node(labels: "User", properties: ["id": "456"])
                )
            ).pattern == #"CREATE (user123:User { id: "123" })-[:FOLLOWS]->(:User { id: "456" })"#
        )
        #expect(
            Create(
                Path(
                    variable: "p",
                    left: Node(capturedObject: User(id: "123")),
                    Relationship(direction: .leftToRight, labels: "FOLLOWS"),
                    right: Node(labels: "User", properties: ["id": "456"])
                )
            ).pattern == #"CREATE p = (user123:User { id: "123" })-[:FOLLOWS]->(:User { id: "456" })"#
        )
    }

    @Test
    func `create multiple`() {
        #expect(
            Create(
                Node(capture: "u1", object: User(id: "123")),
                Node(capture: "u2", object: User(id: "456")),
            ).pattern == """
            CREATE (u1:User { id: "123" }),
            (u2:User { id: "456" })
            """
        )
        #expect(
            Create(
                Node(capturedObject: User(id: "123")),
                Path(
                    left: Node(capture: "user123"),
                    Relationship(direction: .leftToRight, labels: "FOLLOWS"),
                    right: Node(labels: "User", properties: ["id": "456"])
                ),
            ).pattern == """
            CREATE (user123:User { id: "123" }),
            (user123)-[:FOLLOWS]->(:User { id: "456" })
            """
        )
        #expect(
            Create(
                Path(
                    left: Node(capture: "user123"),
                    Relationship(direction: .leftToRight, labels: "FOLLOWS"),
                    right: Node(labels: "User", properties: ["id": "456"])
                ),
                Path(
                    left: Node(capture: "user123"),
                    Relationship(direction: .rightToLeft, labels: "FOLLOWS"),
                    right: Node(labels: "User", properties: ["id": "456"])
                ),
            ).pattern == """
            CREATE (user123)-[:FOLLOWS]->(:User { id: "456" }),
            (user123)<-[:FOLLOWS]-(:User { id: "456" })
            """
        )
        #expect(
            Create(
                Path(
                    left: Node(capture: "user123"),
                    Relationship(direction: .leftToRight, labels: "FOLLOWS"),
                    right: Node(labels: "User", properties: ["id": "456"])
                ),
                Path(
                    variable: "path",
                    left: Node(capture: "user123"),
                    Relationship(direction: .rightToLeft, labels: "FOLLOWS"),
                    right: Node(labels: "User", properties: ["id": "456"])
                ),
            ).pattern == """
            CREATE (user123)-[:FOLLOWS]->(:User { id: "456" }),
            path = (user123)<-[:FOLLOWS]-(:User { id: "456" })
            """
        )
    }

    @Test
    func `match node`() {
        #expect(Match(Node(capture: "u", object: User(id: "123"))).pattern == #"MATCH (u:User { id: "123" })"#)
        #expect(Match(Node(capturedObject: User(id: "123"))).pattern == #"MATCH (user123:User { id: "123" })"#)
        #expect(Match(Node(uncapturedObject: User(id: "123"))).pattern == #"MATCH (:User { id: "123" })"#)
    }
}
