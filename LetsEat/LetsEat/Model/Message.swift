//
//  Message.swift
//  LetsEat

import Foundation

struct Message: Hashable, Codable {
    var date = Date()
    var senderName: String
    var receiverName: String
    
    enum CodingKeys: String, CodingKey {
        case date = "now_date"
        case senderName = "sender_name"
        case receiverName = "receiver_name"
    }
}
