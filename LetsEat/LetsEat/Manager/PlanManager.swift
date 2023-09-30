//
//  PlanManager.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/19.
//

import Combine
import SwiftUI
import Alamofire

class PlanManager: ObservableObject {
    static let PLAN_DATA_KEY = "PLAN_DATA_KEY"
    static let shared = PlanManager()
    @State var userManager = UserManager.shared
    
    //    let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2OTU5ODQ3NzYsImV4cCI6MTY5NTk4NjU3NiwiaWQiOjF9.pn_ABhiejVG7k8J5qWKVS-wP_lUVxNV_0BfAR0JZRGo"
    
    @Published var planList: [Plan] = []
    
    //    init() {
    //        let url = "http://34.22.94.135:8080/list"
    //
    //        //        if let accessToken = userManager.userInfo.token, !accessToken.isEmpty {
    //        let accessToken = userManager.userInfo.token
    //        //        let accessToken = ContentView().token
    //        let headers: HTTPHeaders = [
    //            "Authorization": "Bearer \(accessToken)",
    //            "Content-Type": "application/json"
    //        ]
    //
    //        AF.request(url,
    //                   method: .get,
    //                   encoding: JSONEncoding.default,
    //                   headers: headers)
    //        .validate(statusCode: 200..<600)
    //        .responseDecodable(of: [Plan].self, decoder: JSONDecoder() ) { response in
    ////            debugPrint(response)
    //            do {
    //                let listItem = try JSONDecoder().decode([Plan].self, from: response.data!)
    //                self.planList = listItem
    //
    //            } catch(let error) {
    //                print(error)
    //            }
    //        }
    //    }
    
    func fetchPlans() {
        let url = "http://34.22.94.135:8080/list"
        
        //        if let accessToken = userManager.userInfo.token, !accessToken.isEmpty {
        let accessToken = userManager.userInfo.token
        //        let accessToken = ContentView().token
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate(statusCode: 200..<600)
        .responseDecodable(of: [Plan].self, decoder: JSONDecoder() ) { response in
            debugPrint(response)
            switch response.result {
            case .success:
                self.planList = response.value!
                //                let listItem = try JSONDecoder().decode([Plan].self, from: response.data!)
                //                self.planList = listItem
            case .failure(let error):
                print(error)
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
