//
//  UserModel.swift
//  Bubbles
//
//  Created by Bing Hang on 18/1/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    var name: String
    var email: String
    var friends: [UUID] // Array of friend IDs
    var lastShowerDate: Date?
}

class UserManager {
    private let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("users.json")

    // Save users
    func saveUsers(_ users: [User]) {
        if let encoded = try? JSONEncoder().encode(users) {
            try? encoded.write(to: fileURL)
        }
    }

    // Load users
    func loadUsers() -> [User] {
        if let data = try? Data(contentsOf: fileURL),
           let users = try? JSONDecoder().decode([User].self, from: data) {
            return users
        }
        return []
    }
}
