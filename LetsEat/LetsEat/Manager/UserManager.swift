//
//  UserManager.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/29.
//

import Foundation
import Alamofire

class UserManager: ObservableObject {
    static let shared = UserManager()
    
    var userInfo: User = User(id: -1, token: "", nickname: "")
    
    func setInfo(id: Int, token: String, nickname: String) {
        userInfo.id = id
        userInfo.token = token
        userInfo.nickname = nickname
    }
}
