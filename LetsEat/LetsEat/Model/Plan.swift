//
//  Plan.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/11.
//

import Foundation

class Plan: Identifiable, Codable {
    var id: Int
    var creationDate: Date
    var expirationDate: Date
    var otherUserName: String
    
    var planList: [Plan]
    let saveKey = "SavedData"
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([Plan].self, from: data) {
                planList = decoded
                return
            }
        }
        
        // no saved data!
        planList = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(planList) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
}
