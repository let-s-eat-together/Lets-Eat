//
//  PlanManager.swift
//  LetsEat

import Combine
import SwiftUI
import Alamofire

class PlanManager: ObservableObject {
    static let shared = PlanManager()
    
    @State var userManager = UserManager.shared
    
    @Published var planList: [Plan] = []
    
    func fetchPlans() {
        let url = "http://34.22.94.135:8080/list"
        
        let accessToken = userManager.userInfo.token
        
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
            case .failure(let error):
                print(error)
            }
        }
    }
}
