//
//  Login.swift
//  LetsEat

import Foundation

struct Login: Decodable {
    let token: String
    let userId: Int
    let name: String
}
