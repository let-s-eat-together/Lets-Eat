//
//  Plan.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/11.
//

import Foundation

struct Plan: Identifiable, Hashable, Codable {
    var id = UUID()
    var creationDate: Date
    var expirationDate: Date
    var otherUserName: String
}
