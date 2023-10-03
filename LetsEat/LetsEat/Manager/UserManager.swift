//
//  UserManager.swift
//  LetsEat

import Foundation

class UserManager: ObservableObject {
    private let USER_KEY = "USER_KEY"
    static let shared = UserManager()
    
    func saveUser(_ user: User) {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: USER_KEY)
        }
    }
    
    func getUser() -> User? {
        if let userData = UserDefaults.standard.data(forKey: USER_KEY),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            return user
        }
        return nil
    }

    var userInfo: User = User(id: -1, username: "", token: "")
    
    func setInfo(id: Int, token: String) {
        userInfo.id = id
        userInfo.token = token
    }
    
    func setName(nickname: String) {
        userInfo.username = nickname
    }    
}

class TokenManager {
    static let shared = TokenManager()
    
    private var userToken: String?
    
    func saveToken(_ token: String) {
        userToken = token
    }
    
    func getToken() -> String? {
        return userToken
    }
}
