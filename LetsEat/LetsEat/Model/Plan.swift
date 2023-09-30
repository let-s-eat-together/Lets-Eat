//
//  Plan.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/11.
//

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
