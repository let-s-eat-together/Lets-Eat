//
//  User.swift
//  LetsEat
//
//  Created by CNU on 2023/09/26.
//

import Foundation

struct User: Identifiable, Hashable, Codable {
    var id: Int
    var token: String
    var nickname: String
}
