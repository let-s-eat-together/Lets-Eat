//
//  UserManager.swift
//  LetsEat

import Foundation
import Combine

class UserManager: ObservableObject {
    private let USER_KEY = "USER_KEY"
    static let shared = UserManager()
    
    @Published var userInfo: User = User(id: -1, username: "", token: "")
    
    //    var userInfo: User = User(
    
    //    func saveUser(_ user: User) {
    //        if let data = try? JSONEncoder().encode(user) {
    //            UserDefaults.standard.set(data, forKey: USER_KEY)
    //        }
    //    }
    //
    func getUser() -> User? {
        if let userData = UserDefaults.standard.data(forKey: USER_KEY),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            return user
        }
        return nil
    }
    
    func setInfo(id: Int, username: String, token: String) {
        userInfo.id = id
        userInfo.username = username
        userInfo.token = token
    }
    
    func setName(name username: String) {
        userInfo.username = username
    }
    
    func getName() -> String {
        return userInfo.username
    }
}

