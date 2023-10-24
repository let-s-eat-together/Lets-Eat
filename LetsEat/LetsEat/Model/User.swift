//
//  User.swift
//  LetsEat

import Foundation

struct User: Codable {
    var id: Int
    var username: String
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case username = "name"
        case token = "token"
    }
}

