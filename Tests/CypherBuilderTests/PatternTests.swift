@testable import CypherBuilder
import Testing

@Suite(.tags(.patterns))
struct PatternTests {
    // MARK: - Node

    @Test
    func `node pattern`() {
        #expect(Node().pattern == "()")
        #expect(Node(capture: "u").pattern == "(u)")
        #expect(Node(label: "User").pattern == "(:User)")
        #expect(
            Node(
                labelBuilder: {
                    And {
                        "User"
                        Not("Business")
                    }
                }
            ).pattern == "(:(User&!Business))"
        )
        #expect(Node(capture: "u", label: "User").pattern == "(u:User)")
        #expect(
            Node(
                capture: "u",
                labelBuilder: {
                    And {
                        "User"
                        Not("Business")
                    }
                }
            ).pattern == "(u:(User&!Business))"
        )
        #expect(Node(properties: ["isVerified": true]).pattern == "({ isVerified: true })")
        #expect(Node(capture: "u", properties: ["isVerified": true]).pattern == "(u { isVerified: true })")
        #expect(Node(label: "User", properties: ["isVerified": true]).pattern == "(:User { isVerified: true })")
        #expect(
            Node(
                labelBuilder: {
                    And {
                        "User"
                        Not("Business")
                    }
                },
                properties: ["isVerified": true]
            ).pattern == "(:(User&!Business) { isVerified: true })"
        )
        #expect(
            Node(
                capture: "u",
                label: "User",
                properties: ["isVerified": true]
            ).pattern == "(u:User { isVerified: true })"
        )
        #expect(
            Node(
                capture: "u",
                labelBuilder: {
                    And {
                        "User"
                        Not("Business")
                    }
                },
                properties: ["isVerified": true]
            ).pattern == "(u:(User&!Business) { isVerified: true })"
        )
        #expect(Node(capture: "u", object: User(id: "123")).pattern == "(u:User { id: \"123\" })")
        #expect(Node(capturedObject: User(id: "123")).pattern == "(user123:User { id: \"123\" })")
        #expect(Node(uncapturedObject: User(id: "123")).pattern == "(:User { id: \"123\" })")
    }

    @Test
    func `capture node`() {
        #expect(Node(capture: "u").capture == "u")
        #expect(Node(capture: "u", label: "User").capture == "u")
        #expect(
            Node(
                capture: "u",
                labelBuilder: {
                    And {
                        "User"
                        Not("Business")
                    }
                }
            ).capture == "u"
        )
        #expect(Node(capture: "u", properties: ["isVerified": true]).capture == "u")
        #expect(Node(capture: "u", label: "User", properties: ["isVerified": true]).capture == "u")
        #expect(
            Node(
                capture: "u",
                labelBuilder: {
                    And {
                        "User"
                        Not("Business")
                    }
                },
                properties: ["isVerified": true]
            ).capture == "u"
        )
        #expect(Node(capture: "u", object: User(id: "123")).capture == "u")
        #expect(Node(capturedObject: User(id: "123")).capture == "user123")
    }

    // MARK: - Relationship

    @Test
    func `relationship pattern`() {
        #expect(Relationship(direction: .leftToRight).pattern == "-->")
        #expect(Relationship(direction: .none).pattern == "--")
        #expect(Relationship(direction: .rightToLeft).pattern == "<--")
        #expect(Relationship(direction: .leftToRight, capture: "r").pattern == "-[r]->")
        #expect(Relationship(direction: .none, capture: "r").pattern == "-[r]-")
        #expect(Relationship(direction: .rightToLeft, capture: "r").pattern == "<-[r]-")
        #expect(Relationship(direction: .leftToRight, label: "RECOMMENDS").pattern == "-[:RECOMMENDS]->")
        #expect(Relationship(direction: .none, label: "RECOMMENDS").pattern == "-[:RECOMMENDS]-")
        #expect(Relationship(direction: .rightToLeft, label: "RECOMMENDS").pattern == "<-[:RECOMMENDS]-")
        #expect(
            Relationship(
                direction: .leftToRight,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                }
            ).pattern == "-[:(!LIKES&!DISLIKES)]->"
        )
        #expect(
            Relationship(
                direction: .none,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                }
            ).pattern == "-[:(!LIKES&!DISLIKES)]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                }
            ).pattern == "<-[:(!LIKES&!DISLIKES)]-"
        )
        #expect(Relationship(direction: .leftToRight, capture: "r", label: "RECOMMENDS").pattern == "-[r:RECOMMENDS]->")
        #expect(Relationship(direction: .none, capture: "r", label: "RECOMMENDS").pattern == "-[r:RECOMMENDS]-")
        #expect(Relationship(direction: .rightToLeft, capture: "r", label: "RECOMMENDS").pattern == "<-[r:RECOMMENDS]-")
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                }
            ).pattern == "-[r:(!LIKES&!DISLIKES)]->"
        )
        #expect(Relationship(
            direction: .none,
            capture: "r",
            labelBuilder: {
                And {
                    Not("LIKES")
                    Not("DISLIKES")
                }
            }
        ).pattern == "-[r:(!LIKES&!DISLIKES)]-")
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                }
            ).pattern == "<-[r:(!LIKES&!DISLIKES)]-"
        )
        #expect(Relationship(direction: .leftToRight, depth: .any).pattern == "-[*]->")
        #expect(Relationship(direction: .none, depth: .any).pattern == "-[*]-")
        #expect(Relationship(direction: .rightToLeft, depth: .any).pattern == "<-[*]-")
        #expect(Relationship(direction: .leftToRight, depth: 1).pattern == "-[*1]->")
        #expect(Relationship(direction: .none, depth: 1).pattern == "-[*1]-")
        #expect(Relationship(direction: .rightToLeft, depth: 1).pattern == "<-[*1]-")
        #expect(Relationship(direction: .leftToRight, depth: 1...).pattern == "-[*1..]->")
        #expect(Relationship(direction: .none, depth: 1...).pattern == "-[*1..]-")
        #expect(Relationship(direction: .rightToLeft, depth: 1...).pattern == "<-[*1..]-")
        #expect(Relationship(direction: .leftToRight, depth: ..<23).pattern == "-[*..23]->")
        #expect(Relationship(direction: .none, depth: ..<23).pattern == "-[*..23]-")
        #expect(Relationship(direction: .rightToLeft, depth: ..<23).pattern == "<-[*..23]-")
        #expect(Relationship(direction: .leftToRight, depth: 1..<23).pattern == "-[*1..23]->")
        #expect(Relationship(direction: .none, depth: 1..<23).pattern == "-[*1..23]-")
        #expect(Relationship(direction: .rightToLeft, depth: 1..<23).pattern == "<-[*1..23]-")
        #expect(Relationship(direction: .leftToRight, capture: "r", depth: .any).pattern == "-[r*]->")
        #expect(Relationship(direction: .none, capture: "r", depth: .any).pattern == "-[r*]-")
        #expect(Relationship(direction: .rightToLeft, capture: "r", depth: .any).pattern == "<-[r*]-")
        #expect(Relationship(direction: .leftToRight, capture: "r", depth: 1).pattern == "-[r*1]->")
        #expect(Relationship(direction: .none, capture: "r", depth: 1).pattern == "-[r*1]-")
        #expect(Relationship(direction: .rightToLeft, capture: "r", depth: 1).pattern == "<-[r*1]-")
        #expect(Relationship(direction: .leftToRight, capture: "r", depth: 1...).pattern == "-[r*1..]->")
        #expect(Relationship(direction: .none, capture: "r", depth: 1...).pattern == "-[r*1..]-")
        #expect(Relationship(direction: .rightToLeft, capture: "r", depth: 1...).pattern == "<-[r*1..]-")
        #expect(Relationship(direction: .leftToRight, capture: "r", depth: ..<23).pattern == "-[r*..23]->")
        #expect(Relationship(direction: .none, capture: "r", depth: ..<23).pattern == "-[r*..23]-")
        #expect(Relationship(direction: .rightToLeft, capture: "r", depth: ..<23).pattern == "<-[r*..23]-")
        #expect(Relationship(direction: .leftToRight, capture: "r", depth: 1..<23).pattern == "-[r*1..23]->")
        #expect(Relationship(direction: .none, capture: "r", depth: 1..<23).pattern == "-[r*1..23]-")
        #expect(Relationship(direction: .rightToLeft, capture: "r", depth: 1..<23).pattern == "<-[r*1..23]-")
        #expect(Relationship(direction: .leftToRight, label: "RECOMMENDS", depth: .any).pattern == "-[:RECOMMENDS*]->")
        #expect(Relationship(direction: .none, label: "RECOMMENDS", depth: .any).pattern == "-[:RECOMMENDS*]-")
        #expect(Relationship(direction: .rightToLeft, label: "RECOMMENDS", depth: .any).pattern == "<-[:RECOMMENDS*]-")
        #expect(Relationship(direction: .leftToRight, label: "RECOMMENDS", depth: 1).pattern == "-[:RECOMMENDS*1]->")
        #expect(Relationship(direction: .none, label: "RECOMMENDS", depth: 1).pattern == "-[:RECOMMENDS*1]-")
        #expect(Relationship(direction: .rightToLeft, label: "RECOMMENDS", depth: 1).pattern == "<-[:RECOMMENDS*1]-")
        #expect(
            Relationship(direction: .leftToRight, label: "RECOMMENDS", depth: 1...).pattern == "-[:RECOMMENDS*1..]->"
        )
        #expect(Relationship(direction: .none, label: "RECOMMENDS", depth: 1...).pattern == "-[:RECOMMENDS*1..]-")
        #expect(
            Relationship(direction: .rightToLeft, label: "RECOMMENDS", depth: 1...).pattern == "<-[:RECOMMENDS*1..]-"
        )
        #expect(
            Relationship(direction: .leftToRight, label: "RECOMMENDS", depth: ..<23).pattern == "-[:RECOMMENDS*..23]->"
        )
        #expect(Relationship(direction: .none, label: "RECOMMENDS", depth: ..<23).pattern == "-[:RECOMMENDS*..23]-")
        #expect(
            Relationship(direction: .rightToLeft, label: "RECOMMENDS", depth: ..<23).pattern == "<-[:RECOMMENDS*..23]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                label: "RECOMMENDS",
                depth: 1..<23
            ).pattern == "-[:RECOMMENDS*1..23]->"
        )
        #expect(Relationship(direction: .none, label: "RECOMMENDS", depth: 1..<23).pattern == "-[:RECOMMENDS*1..23]-")
        #expect(
            Relationship(
                direction: .rightToLeft,
                label: "RECOMMENDS",
                depth: 1..<23
            ).pattern == "<-[:RECOMMENDS*1..23]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any
            ).pattern == "-[:(!LIKES&!DISLIKES)*]->"
        )
        #expect(
            Relationship(
                direction: .none,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any).pattern == "-[:(!LIKES&!DISLIKES)*]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any).pattern == "<-[:(!LIKES&!DISLIKES)*]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1).pattern == "-[:(!LIKES&!DISLIKES)*1]->"
        )
        #expect(
            Relationship(
                direction: .none,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1).pattern == "-[:(!LIKES&!DISLIKES)*1]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1).pattern == "<-[:(!LIKES&!DISLIKES)*1]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...).pattern == "-[:(!LIKES&!DISLIKES)*1..]->"
        )
        #expect(
            Relationship(
                direction: .none,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...).pattern == "-[:(!LIKES&!DISLIKES)*1..]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...).pattern == "<-[:(!LIKES&!DISLIKES)*1..]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23).pattern == "-[:(!LIKES&!DISLIKES)*..23]->"
        )
        #expect(
            Relationship(
                direction: .none,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23).pattern == "-[:(!LIKES&!DISLIKES)*..23]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23).pattern == "<-[:(!LIKES&!DISLIKES)*..23]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23).pattern == "-[:(!LIKES&!DISLIKES)*1..23]->"
        )
        #expect(
            Relationship(
                direction: .none,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23).pattern == "-[:(!LIKES&!DISLIKES)*1..23]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23).pattern == "<-[:(!LIKES&!DISLIKES)*1..23]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                depth: .any
            ).pattern == "-[r:RECOMMENDS*]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                depth: .any
            ).pattern == "-[r:RECOMMENDS*]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                depth: .any
            ).pattern == "<-[r:RECOMMENDS*]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1
            ).pattern == "-[r:RECOMMENDS*1]->"
        )
        #expect(
            Relationship(direction: .none, capture: "r", label: "RECOMMENDS", depth: 1).pattern == "-[r:RECOMMENDS*1]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1
            ).pattern == "<-[r:RECOMMENDS*1]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1...
            ).pattern == "-[r:RECOMMENDS*1..]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1...
            ).pattern == "-[r:RECOMMENDS*1..]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1...
            ).pattern == "<-[r:RECOMMENDS*1..]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                depth: ..<23
            ).pattern == "-[r:RECOMMENDS*..23]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                depth: ..<23
            ).pattern == "-[r:RECOMMENDS*..23]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                depth: ..<23
            ).pattern == "<-[r:RECOMMENDS*..23]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1..<23
            ).pattern == "-[r:RECOMMENDS*1..23]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1..<23
            ).pattern == "-[r:RECOMMENDS*1..23]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1..<23
            ).pattern == "<-[r:RECOMMENDS*1..23]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any).pattern == "-[r:(!LIKES&!DISLIKES)*]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any).pattern == "-[r:(!LIKES&!DISLIKES)*]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any).pattern == "<-[r:(!LIKES&!DISLIKES)*]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1).pattern == "-[r:(!LIKES&!DISLIKES)*1]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1).pattern == "-[r:(!LIKES&!DISLIKES)*1]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1).pattern == "<-[r:(!LIKES&!DISLIKES)*1]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...).pattern == "-[r:(!LIKES&!DISLIKES)*1..]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...).pattern == "-[r:(!LIKES&!DISLIKES)*1..]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...).pattern == "<-[r:(!LIKES&!DISLIKES)*1..]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23).pattern == "-[r:(!LIKES&!DISLIKES)*..23]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23).pattern == "-[r:(!LIKES&!DISLIKES)*..23]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23).pattern == "<-[r:(!LIKES&!DISLIKES)*..23]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23).pattern == "-[r:(!LIKES&!DISLIKES)*1..23]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23).pattern == "-[r:(!LIKES&!DISLIKES)*1..23]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23).pattern == "<-[r:(!LIKES&!DISLIKES)*1..23]-"
        )
        #expect(Relationship(direction: .leftToRight, properties: ["page": 116]).pattern == "-[ { page: 116 }]->")
        #expect(Relationship(direction: .none, properties: ["page": 116]).pattern == "-[ { page: 116 }]-")
        #expect(Relationship(direction: .rightToLeft, properties: ["page": 116]).pattern == "<-[ { page: 116 }]-")
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                properties: ["page": 116]
            ).pattern == "-[r { page: 116 }]->"
        )
        #expect(
            Relationship(direction: .none, capture: "r", properties: ["page": 116]).pattern == "-[r { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                properties: ["page": 116]
            ).pattern == "<-[r { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                label: "RECOMMENDS",
                properties: ["page": 116]
            ).pattern == "-[:RECOMMENDS { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                label: "RECOMMENDS",
                properties: ["page": 116]
            ).pattern == "-[:RECOMMENDS { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                label: "RECOMMENDS",
                properties: ["page": 116]
            ).pattern == "<-[:RECOMMENDS { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                properties: ["page": 116]).pattern == "-[:(!LIKES&!DISLIKES) { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                properties: ["page": 116]).pattern == "-[:(!LIKES&!DISLIKES) { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                properties: ["page": 116]).pattern == "<-[:(!LIKES&!DISLIKES) { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                properties: ["page": 116]
            ).pattern == "-[r:RECOMMENDS { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                properties: ["page": 116]
            ).pattern == "-[r:RECOMMENDS { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                properties: ["page": 116]
            ).pattern == "<-[r:RECOMMENDS { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                properties: ["page": 116]).pattern == "-[r:(!LIKES&!DISLIKES) { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                properties: ["page": 116]).pattern == "-[r:(!LIKES&!DISLIKES) { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                properties: ["page": 116]).pattern == "<-[r:(!LIKES&!DISLIKES) { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                depth: .any,
                properties: ["page": 116]
            ).pattern == "-[* { page: 116 }]->"
        )
        #expect(Relationship(direction: .none, depth: .any, properties: ["page": 116]).pattern == "-[* { page: 116 }]-")
        #expect(
            Relationship(
                direction: .rightToLeft,
                depth: .any,
                properties: ["page": 116]
            ).pattern == "<-[* { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                depth: 1,
                properties: ["page": 116]
            ).pattern == "-[*1 { page: 116 }]->"
        )
        #expect(Relationship(direction: .none, depth: 1, properties: ["page": 116]).pattern == "-[*1 { page: 116 }]-")
        #expect(
            Relationship(
                direction: .rightToLeft,
                depth: 1,
                properties: ["page": 116]
            ).pattern == "<-[*1 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                depth: 1...,
                properties: ["page": 116]
            ).pattern == "-[*1.. { page: 116 }]->"
        )
        #expect(
            Relationship(direction: .none, depth: 1..., properties: ["page": 116]).pattern == "-[*1.. { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                depth: 1...,
                properties: ["page": 116]
            ).pattern == "<-[*1.. { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                depth: ..<23,
                properties: ["page": 116]
            ).pattern == "-[*..23 { page: 116 }]->"
        )
        #expect(
            Relationship(direction: .none, depth: ..<23, properties: ["page": 116]).pattern == "-[*..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                depth: ..<23,
                properties: ["page": 116]
            ).pattern == "<-[*..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                depth: 1..<23,
                properties: ["page": 116]
            ).pattern == "-[*1..23 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                depth: 1..<23,
                properties: ["page": 116]
            ).pattern == "-[*1..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                depth: 1..<23,
                properties: ["page": 116]
            ).pattern == "<-[*1..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                depth: .any,
                properties: ["page": 116]
            ).pattern == "-[r* { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                depth: .any,
                properties: ["page": 116]
            ).pattern == "-[r* { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                depth: .any,
                properties: ["page": 116]
            ).pattern == "<-[r* { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                depth: 1,
                properties: ["page": 116]
            ).pattern == "-[r*1 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                depth: 1,
                properties: ["page": 116]
            ).pattern == "-[r*1 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                depth: 1,
                properties: ["page": 116]
            ).pattern == "<-[r*1 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                depth: 1...,
                properties: ["page": 116]
            ).pattern == "-[r*1.. { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                depth: 1...,
                properties: ["page": 116]
            ).pattern == "-[r*1.. { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                depth: 1...,
                properties: ["page": 116]
            ).pattern == "<-[r*1.. { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                depth: ..<23,
                properties: ["page": 116]
            ).pattern == "-[r*..23 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                depth: ..<23,
                properties: ["page": 116]
            ).pattern == "-[r*..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                depth: ..<23,
                properties: ["page": 116]
            ).pattern == "<-[r*..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                depth: 1..<23,
                properties: ["page": 116]
            ).pattern == "-[r*1..23 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                depth: 1..<23,
                properties: ["page": 116]
            ).pattern == "-[r*1..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                depth: 1..<23,
                properties: ["page": 116]
            ).pattern == "<-[r*1..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                label: "RECOMMENDS",
                depth: .any,
                properties: ["page": 116]
            ).pattern == "-[:RECOMMENDS* { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                label: "RECOMMENDS",
                depth: .any,
                properties: ["page": 116]
            ).pattern == "-[:RECOMMENDS* { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                label: "RECOMMENDS",
                depth: .any,
                properties: ["page": 116]
            ).pattern == "<-[:RECOMMENDS* { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                label: "RECOMMENDS",
                depth: 1,
                properties: ["page": 116]
            ).pattern == "-[:RECOMMENDS*1 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                label: "RECOMMENDS",
                depth: 1,
                properties: ["page": 116]
            ).pattern == "-[:RECOMMENDS*1 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                label: "RECOMMENDS",
                depth: 1,
                properties: ["page": 116]
            ).pattern == "<-[:RECOMMENDS*1 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                label: "RECOMMENDS",
                depth: 1...,
                properties: ["page": 116]
            ).pattern == "-[:RECOMMENDS*1.. { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                label: "RECOMMENDS",
                depth: 1...,
                properties: ["page": 116]
            ).pattern == "-[:RECOMMENDS*1.. { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                label: "RECOMMENDS",
                depth: 1...,
                properties: ["page": 116]
            ).pattern == "<-[:RECOMMENDS*1.. { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                label: "RECOMMENDS",
                depth: ..<23,
                properties: ["page": 116]
            ).pattern == "-[:RECOMMENDS*..23 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                label: "RECOMMENDS",
                depth: ..<23,
                properties: ["page": 116]
            ).pattern == "-[:RECOMMENDS*..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                label: "RECOMMENDS",
                depth: ..<23,
                properties: ["page": 116]
            ).pattern == "<-[:RECOMMENDS*..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                label: "RECOMMENDS",
                depth: 1..<23,
                properties: ["page": 116]
            ).pattern == "-[:RECOMMENDS*1..23 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                label: "RECOMMENDS",
                depth: 1..<23,
                properties: ["page": 116]
            ).pattern == "-[:RECOMMENDS*1..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                label: "RECOMMENDS",
                depth: 1..<23,
                properties: ["page": 116]
            ).pattern == "<-[:RECOMMENDS*1..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any,
                properties: ["page": 116]).pattern == "-[:(!LIKES&!DISLIKES)* { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any,
                properties: ["page": 116]).pattern == "-[:(!LIKES&!DISLIKES)* { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any,
                properties: ["page": 116]).pattern == "<-[:(!LIKES&!DISLIKES)* { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1,
                properties: ["page": 116]).pattern == "-[:(!LIKES&!DISLIKES)*1 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1,
                properties: ["page": 116]).pattern == "-[:(!LIKES&!DISLIKES)*1 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1,
                properties: ["page": 116]).pattern == "<-[:(!LIKES&!DISLIKES)*1 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...,
                properties: ["page": 116]).pattern == "-[:(!LIKES&!DISLIKES)*1.. { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...,
                properties: ["page": 116]).pattern == "-[:(!LIKES&!DISLIKES)*1.. { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...,
                properties: ["page": 116]).pattern == "<-[:(!LIKES&!DISLIKES)*1.. { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23,
                properties: ["page": 116]).pattern == "-[:(!LIKES&!DISLIKES)*..23 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23,
                properties: ["page": 116]).pattern == "-[:(!LIKES&!DISLIKES)*..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23,
                properties: ["page": 116]).pattern == "<-[:(!LIKES&!DISLIKES)*..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23,
                properties: ["page": 116]).pattern == "-[:(!LIKES&!DISLIKES)*1..23 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23,
                properties: ["page": 116]).pattern == "-[:(!LIKES&!DISLIKES)*1..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23,
                properties: ["page": 116]).pattern == "<-[:(!LIKES&!DISLIKES)*1..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                depth: .any,
                properties: ["page": 116]
            ).pattern == "-[r:RECOMMENDS* { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                depth: .any,
                properties: ["page": 116]
            ).pattern == "-[r:RECOMMENDS* { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                depth: .any,
                properties: ["page": 116]
            ).pattern == "<-[r:RECOMMENDS* { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1,
                properties: ["page": 116]
            ).pattern == "-[r:RECOMMENDS*1 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1,
                properties: ["page": 116]
            ).pattern == "-[r:RECOMMENDS*1 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1,
                properties: ["page": 116]
            ).pattern == "<-[r:RECOMMENDS*1 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1...,
                properties: ["page": 116]
            ).pattern == "-[r:RECOMMENDS*1.. { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1...,
                properties: ["page": 116]
            ).pattern == "-[r:RECOMMENDS*1.. { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1...,
                properties: ["page": 116]
            ).pattern == "<-[r:RECOMMENDS*1.. { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                depth: ..<23,
                properties: ["page": 116]
            ).pattern == "-[r:RECOMMENDS*..23 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                depth: ..<23,
                properties: ["page": 116]
            ).pattern == "-[r:RECOMMENDS*..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                depth: ..<23,
                properties: ["page": 116]
            ).pattern == "<-[r:RECOMMENDS*..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1..<23,
                properties: ["page": 116]
            ).pattern == "-[r:RECOMMENDS*1..23 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1..<23,
                properties: ["page": 116]
            ).pattern == "-[r:RECOMMENDS*1..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1..<23,
                properties: ["page": 116]
            ).pattern == "<-[r:RECOMMENDS*1..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any,
                properties: ["page": 116]).pattern == "-[r:(!LIKES&!DISLIKES)* { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any,
                properties: ["page": 116]).pattern == "-[r:(!LIKES&!DISLIKES)* { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any,
                properties: ["page": 116]).pattern == "<-[r:(!LIKES&!DISLIKES)* { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1,
                properties: ["page": 116]).pattern == "-[r:(!LIKES&!DISLIKES)*1 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1,
                properties: ["page": 116]).pattern == "-[r:(!LIKES&!DISLIKES)*1 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1,
                properties: ["page": 116]).pattern == "<-[r:(!LIKES&!DISLIKES)*1 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...,
                properties: ["page": 116]).pattern == "-[r:(!LIKES&!DISLIKES)*1.. { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...,
                properties: ["page": 116]).pattern == "-[r:(!LIKES&!DISLIKES)*1.. { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...,
                properties: ["page": 116]).pattern == "<-[r:(!LIKES&!DISLIKES)*1.. { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23,
                properties: ["page": 116]).pattern == "-[r:(!LIKES&!DISLIKES)*..23 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23,
                properties: ["page": 116]).pattern == "-[r:(!LIKES&!DISLIKES)*..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23,
                properties: ["page": 116]).pattern == "<-[r:(!LIKES&!DISLIKES)*..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23,
                properties: ["page": 116]).pattern == "-[r:(!LIKES&!DISLIKES)*1..23 { page: 116 }]->"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23,
                properties: ["page": 116]).pattern == "-[r:(!LIKES&!DISLIKES)*1..23 { page: 116 }]-"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23,
                properties: ["page": 116]).pattern == "<-[r:(!LIKES&!DISLIKES)*1..23 { page: 116 }]-"
        )
    }

    @Test
    func `capture relationship`() {
        #expect(Relationship(direction: .leftToRight, capture: "r").capture == "r")
        #expect(Relationship(direction: .none, capture: "r").capture == "r")
        #expect(Relationship(direction: .rightToLeft, capture: "r").capture == "r")
        #expect(Relationship(direction: .leftToRight, capture: "r", label: "RECOMMENDS").capture == "r")
        #expect(Relationship(direction: .none, capture: "r", label: "RECOMMENDS").capture == "r")
        #expect(Relationship(direction: .rightToLeft, capture: "r", label: "RECOMMENDS").capture == "r")
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                }
            ).capture == "r"
        )
        #expect(
            Relationship(
            direction: .none,
            capture: "r",
            labelBuilder: {
                And {
                    Not("LIKES")
                    Not("DISLIKES")
                }
            }
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                }
            ).capture == "r"
        )
        #expect(Relationship(direction: .leftToRight, capture: "r", depth: .any).capture == "r")
        #expect(Relationship(direction: .none, capture: "r", depth: .any).capture == "r")
        #expect(Relationship(direction: .rightToLeft, capture: "r", depth: .any).capture == "r")
        #expect(Relationship(direction: .leftToRight, capture: "r", depth: 1).capture == "r")
        #expect(Relationship(direction: .none, capture: "r", depth: 1).capture == "r")
        #expect(Relationship(direction: .rightToLeft, capture: "r", depth: 1).capture == "r")
        #expect(Relationship(direction: .leftToRight, capture: "r", depth: 1...).capture == "r")
        #expect(Relationship(direction: .none, capture: "r", depth: 1...).capture == "r")
        #expect(Relationship(direction: .rightToLeft, capture: "r", depth: 1...).capture == "r")
        #expect(Relationship(direction: .leftToRight, capture: "r", depth: ..<23).capture == "r")
        #expect(Relationship(direction: .none, capture: "r", depth: ..<23).capture == "r")
        #expect(Relationship(direction: .rightToLeft, capture: "r", depth: ..<23).capture == "r")
        #expect(Relationship(direction: .leftToRight, capture: "r", depth: 1..<23).capture == "r")
        #expect(Relationship(direction: .none, capture: "r", depth: 1..<23).capture == "r")
        #expect(Relationship(direction: .rightToLeft, capture: "r", depth: 1..<23).capture == "r")
        #expect(Relationship(direction: .leftToRight, capture: "r", label: "RECOMMENDS", depth: .any).capture == "r")
        #expect(Relationship(direction: .none, capture: "r", label: "RECOMMENDS", depth: .any).capture == "r")
        #expect(Relationship(direction: .rightToLeft, capture: "r", label: "RECOMMENDS", depth: .any).capture == "r")
        #expect(Relationship(direction: .leftToRight, capture: "r", label: "RECOMMENDS", depth: 1).capture == "r")
        #expect(Relationship(direction: .none, capture: "r", label: "RECOMMENDS", depth: 1).capture == "r")
        #expect(Relationship(direction: .rightToLeft, capture: "r", label: "RECOMMENDS", depth: 1).capture == "r")
        #expect(Relationship(direction: .leftToRight, capture: "r", label: "RECOMMENDS", depth: 1...).capture == "r")
        #expect(Relationship(direction: .none, capture: "r", label: "RECOMMENDS", depth: 1...).capture == "r")
        #expect(Relationship(direction: .rightToLeft, capture: "r", label: "RECOMMENDS", depth: 1...).capture == "r")
        #expect(Relationship(direction: .leftToRight, capture: "r", label: "RECOMMENDS", depth: ..<23).capture == "r")
        #expect(Relationship(direction: .none, capture: "r", label: "RECOMMENDS", depth: ..<23).capture == "r")
        #expect(Relationship(direction: .rightToLeft, capture: "r", label: "RECOMMENDS", depth: ..<23).capture == "r")
        #expect(Relationship(direction: .leftToRight, capture: "r", label: "RECOMMENDS", depth: 1..<23).capture == "r")
        #expect(Relationship(direction: .none, capture: "r", label: "RECOMMENDS", depth: 1..<23).capture == "r")
        #expect(Relationship(direction: .rightToLeft, capture: "r", label: "RECOMMENDS", depth: 1..<23).capture == "r")
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any).capture == "r"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1).capture == "r"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...).capture == "r"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23).capture == "r"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23).capture == "r"
        )
        #expect(Relationship(direction: .leftToRight, capture: "r", properties: ["page": 116]).capture == "r")
        #expect(Relationship(direction: .none, capture: "r", properties: ["page": 116]).capture == "r")
        #expect(Relationship(direction: .rightToLeft, capture: "r", properties: ["page": 116]).capture == "r")
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(direction: .leftToRight, capture: "r", depth: .any, properties: ["page": 116]).capture == "r"
        )
        #expect(Relationship(direction: .none, capture: "r", depth: .any, properties: ["page": 116]).capture == "r")
        #expect(
            Relationship(direction: .rightToLeft, capture: "r", depth: .any, properties: ["page": 116]).capture == "r"
        )
        #expect(Relationship(direction: .leftToRight, capture: "r", depth: 1, properties: ["page": 116]).capture == "r")
        #expect(Relationship(direction: .none, capture: "r", depth: 1, properties: ["page": 116]).capture == "r")
        #expect(Relationship(direction: .rightToLeft, capture: "r", depth: 1, properties: ["page": 116]).capture == "r")
        #expect(
            Relationship(direction: .leftToRight, capture: "r", depth: 1..., properties: ["page": 116]).capture == "r"
        )
        #expect(Relationship(direction: .none, capture: "r", depth: 1..., properties: ["page": 116]).capture == "r")
        #expect(
            Relationship(direction: .rightToLeft, capture: "r", depth: 1..., properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(direction: .leftToRight, capture: "r", depth: ..<23, properties: ["page": 116]).capture == "r"
        )
        #expect(Relationship(direction: .none, capture: "r", depth: ..<23, properties: ["page": 116]).capture == "r")
        #expect(
            Relationship(direction: .rightToLeft, capture: "r", depth: ..<23, properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(direction: .leftToRight, capture: "r", depth: 1..<23, properties: ["page": 116]).capture == "r"
        )
        #expect(Relationship(direction: .none, capture: "r", depth: 1..<23, properties: ["page": 116]).capture == "r")
        #expect(
            Relationship(direction: .rightToLeft, capture: "r", depth: 1..<23, properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                depth: .any,
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                depth: .any,
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                depth: .any,
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1,
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1,
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1,
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1...,
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1...,
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1...,
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                depth: ..<23,
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                depth: ..<23,
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                depth: ..<23,
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1..<23,
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1..<23,
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                label: "RECOMMENDS",
                depth: 1..<23,
                properties: ["page": 116]
            ).capture == "r"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any,
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any,
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: .any,
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1,
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1,
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1,
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...,
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...,
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1...,
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23,
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23,
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: ..<23,
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .leftToRight,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23,
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .none,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23,
                properties: ["page": 116]).capture == "r"
        )
        #expect(
            Relationship(
                direction: .rightToLeft,
                capture: "r",
                labelBuilder: {
                    And {
                        Not("LIKES")
                        Not("DISLIKES")
                    }
                },
                depth: 1..<23,
                properties: ["page": 116]).capture == "r"
        )
    }

    // MARK: - Path

    @Test
    func `path pattern`() {
        #expect(
            Path(
                left: Node(capture: "a"),
                Relationship(direction: .leftToRight, label: "CONTAINS"),
                right: Node(capture: "b")
            ).pattern == "(a)-[:CONTAINS]->(b)"
        )
        #expect(
            Path(
                left: Node(capture: "a"),
                Relationship(direction: .none, label: "CONTAINS"),
                right: Node(capture: "b")
            ).pattern == "(a)-[:CONTAINS]-(b)"
        )
        #expect(
            Path(
                left: Node(capture: "a"),
                Relationship(direction: .rightToLeft, label: "CONTAINS"),
                right: Node(capture: "b")
            ).pattern == "(a)<-[:CONTAINS]-(b)"
        )
        #expect(
            Path(
                left: Node(capture: "b"),
                Relationship(direction: .leftToRight, label: "CONTAINS"),
                right: Node(capture: "a")
            ).pattern == "(b)-[:CONTAINS]->(a)"
        )
        #expect(
            Path(
                left: Node(capture: "b"),
                Relationship(direction: .none, label: "CONTAINS"),
                right: Node(capture: "a")
            ).pattern == "(b)-[:CONTAINS]-(a)"
        )
        #expect(
            Path(
                left: Node(capture: "b"),
                Relationship(direction: .rightToLeft, label: "CONTAINS"),
                right: Node(capture: "a")
            ).pattern == "(b)<-[:CONTAINS]-(a)"
        )
        #expect(
            Path {
                Node(capture: "a", label: "Alcohol")
                Relationship(direction: .leftToRight, label: "MEMBER_OF")
                Node(label: "Taxonomy", properties: ["id": 123])
            }.pattern == "(a:Alcohol)-[:MEMBER_OF]->(:Taxonomy { id: 123 })"
        )
        #expect(
            Path {
                Node(label: "Taxonomy", properties: ["id": 123])
                Relationship(direction: .rightToLeft, label: "MEMBER_OF")
                Node(capture: "a", label: "Alcohol")
                Relationship(direction: .rightToLeft, label: "OWNS")
                Node(capture: "u", label: "User", properties: ["xid": "abc"])
            }.pattern == "(:Taxonomy { id: 123 })<-[:MEMBER_OF]-(a:Alcohol)<-[:OWNS]-(u:User { xid: \"abc\" })"
        )
        #expect(
            Path {
                Node(label: "Taxonomy", properties: ["id": 123])
                Relationship(direction: .rightToLeft, label: "MEMBER_OF")
                Node(capture: "a", label: "Alcohol")
                Relationship(direction: .rightToLeft, label: "OWNS")
                Node(capture: "u1", label: "User", properties: ["xid": "abc"])
                Relationship(direction: .leftToRight, label: "FOLLOWS")
                Node(capture: "u2", label: "User", properties: ["xid": "def"])
            }.pattern == "(:Taxonomy { id: 123 })<-[:MEMBER_OF]-(a:Alcohol)<-[:OWNS]-(u1:User { xid: \"abc\" })-[:FOLLOWS]->(u2:User { xid: \"def\" })"
        )
        #expect(
            Path {
                Node(label: "Taxonomy", properties: ["id": 123])
                Relationship(direction: .rightToLeft, label: "MEMBER_OF")
                Node(capture: "a", label: "Alcohol")
                Relationship(direction: .rightToLeft, label: "OWNS")
                Node(capture: "u1", label: "User", properties: ["xid": "abc"])
                Relationship(direction: .leftToRight, label: "FOLLOWS")
                Node(capture: "u2", label: "User", properties: ["xid": "def"])
                Relationship(direction: .leftToRight, label: "AUTHORED")
                Node(capture: "b", label: "Book", properties: ["xid": "ghi"])
            }.pattern == "(:Taxonomy { id: 123 })<-[:MEMBER_OF]-(a:Alcohol)<-[:OWNS]-(u1:User { xid: \"abc\" })-[:FOLLOWS]->(u2:User { xid: \"def\" })-[:AUTHORED]->(b:Book { xid: \"ghi\" })"
        )
    }
}
