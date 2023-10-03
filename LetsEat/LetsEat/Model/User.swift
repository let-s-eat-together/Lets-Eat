//
//  User.swift
//  LetsEat

import Foundation

struct User: Identifiable, Hashable, Codable {
    var id: Int
    var username: String
    var token: String
}

struct Login: Decodable {
    let token: String
    let userId: Int
}

