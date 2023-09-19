//
//  PlanManager.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/19.
//

import Foundation

class PlanManager: ObservableObject {
    static let PLAN_DATA_KEY = "PLAN_DATA_KEY"
    static let share = PlanManager()
    
    @Published var planList: [Plan] = []
    
    
    init() {
        if let data = UserDefaults.standard.value(forKey: PlanManager.PLAN_DATA_KEY) as? Data {
            let Item = try? PropertyListDecoder().decode([Plan].self, from: data)
            if let list = Item {
                planList = list
            }
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(planList) {
            UserDefaults.standard.set(encoded, forKey: PlanManager.PLAN_DATA_KEY)
        }
    }
    
    func add(_ plan: Plan) {
        planList.append(plan)
        save()
    }
}
