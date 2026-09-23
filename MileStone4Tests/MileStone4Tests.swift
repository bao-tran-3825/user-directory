//
//  MileStone4Tests.swift
//  MileStone4Tests
//
//  Created by Gojo Satoru on 25/8/25.
//

import Testing
import Foundation
@testable import MileStone4

struct MileStone4Tests {

    // MARK: - Friend Tests

    @Test func friendInitStoresProperties() {
        let id = UUID()
        let friend = Friend(id: id, name: "Alice")
        #expect(friend.id == id)
        #expect(friend.name == "Alice")
    }

    @Test func friendCodableRoundTrip() throws {
        let original = Friend(id: UUID(), name: "Bob")
        let encoder = JSONEncoder()
        let data = try encoder.encode(original)
        let decoded = try JSONDecoder().decode(Friend.self, from: data)
        #expect(decoded.id == original.id)
        #expect(decoded.name == original.name)
    }

    @Test func friendDecodesFromJSON() throws {
        let id = UUID()
        let json = """
        {"id": "\(id.uuidString)", "name": "Carol"}
        """.data(using: .utf8)!
        let friend = try JSONDecoder().decode(Friend.self, from: json)
        #expect(friend.id == id)
        #expect(friend.name == "Carol")
    }

    // MARK: - User Tests

    @Test func userInitStoresAllProperties() {
        let id = UUID()
        let date = Date()
        let user = User(
            id: id, isActive: true, name: "Dave", age: 30,
            company: "Acme", email: "dave@example.com",
            address: "1 Main St", about: "A person.",
            registered: date, tags: ["swift", "ios"], friends: []
        )
        #expect(user.id == id)
        #expect(user.isActive == true)
        #expect(user.name == "Dave")
        #expect(user.age == 30)
        #expect(user.company == "Acme")
        #expect(user.email == "dave@example.com")
        #expect(user.address == "1 Main St")
        #expect(user.about == "A person.")
        #expect(user.registered == date)
        #expect(user.tags == ["swift", "ios"])
        #expect(user.friends.isEmpty)
    }

    @Test func userCodableRoundTrip() throws {
        let original = User.example
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(original)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(User.self, from: data)
        #expect(decoded.id == original.id)
        #expect(decoded.name == original.name)
        #expect(decoded.email == original.email)
        #expect(decoded.age == original.age)
        #expect(decoded.isActive == original.isActive)
        #expect(decoded.tags == original.tags)
    }

    @Test func userDecodesFromJSON() throws {
        let id = UUID()
        let json = """
        {
            "id": "\(id.uuidString)",
            "isActive": false,
            "name": "Eve",
            "age": 25,
            "company": "Globex",
            "email": "eve@globex.com",
            "address": "742 Evergreen Terrace",
            "about": "Works at Globex.",
            "registered": "2023-01-15T00:00:00Z",
            "tags": ["developer"],
            "friends": []
        }
        """.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let user = try decoder.decode(User.self, from: json)
        #expect(user.id == id)
        #expect(user.name == "Eve")
        #expect(user.isActive == false)
        #expect(user.age == 25)
        #expect(user.tags == ["developer"])
        #expect(user.friends.isEmpty)
    }

    @Test func userDecodesWithFriends() throws {
        let friendId = UUID()
        let userId = UUID()
        let json = """
        {
            "id": "\(userId.uuidString)",
            "isActive": true,
            "name": "Frank",
            "age": 40,
            "company": "Initech",
            "email": "frank@initech.com",
            "address": "99 Office Park",
            "about": "TPS reports.",
            "registered": "2020-06-01T00:00:00Z",
            "tags": [],
            "friends": [{"id": "\(friendId.uuidString)", "name": "Grace"}]
        }
        """.data(using: .utf8)!
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let user = try decoder.decode(User.self, from: json)
        #expect(user.friends.count == 1)
        #expect(user.friends[0].id == friendId)
        #expect(user.friends[0].name == "Grace")
    }

    @Test func userExampleIsValid() {
        let user = User.example
        #expect(!user.name.isEmpty)
        #expect(!user.email.isEmpty)
        #expect(user.age > 0)
    }
}
