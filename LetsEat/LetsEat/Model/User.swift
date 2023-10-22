//
//  User.swift
//  LetsEat

import Foundation

struct User: Identifiable, Hashable, Codable {
    var id: Int
    var username: String
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case username = "name"
        case token = "token"
    }
}

struct Login: Decodable {
    let token: String
    let userId: Int
    let name: String
}

