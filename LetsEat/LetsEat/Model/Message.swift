//
//  Message.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import Foundation

//enum Tag: String, Codable {
//    case sting = "콕 찌르기"
//    case request = "친구 요청"
//    case accept = "친구 수락"
//    case extend = "기한 연장"
//}

struct Message: Identifiable, Hashable, Codable {
    var id = UUID()
    var date = Date()
    var senderName: String
    var receiverName: String
//    var tag: Tag
}
