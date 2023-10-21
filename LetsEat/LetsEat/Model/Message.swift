//
//  Message.swift
//  LetsEat

import Foundation

struct Message: Identifiable, Codable {
    var id: Int
    var creationDate: String
    var otherUserName: String
    var countSting: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "plan_id"
        case creationDate = "creation_date"
        case otherUserName = "other_user_name"
        case countSting = "countSting"
    }
}
