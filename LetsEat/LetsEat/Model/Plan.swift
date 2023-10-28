//
//  Plan.swift
//  LetsEat

import Foundation

struct Plan: Identifiable, Codable {
    var id: Int
    var creationDate: String
    var expirationDate: String
    var otherUserName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "plan_id"
        case creationDate = "creation_date"
        case expirationDate = "expiration_date"
        case otherUserName = "other_user_name"
    }
}
