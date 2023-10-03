//
//  MessageManager.swift
//  LetsEat

import SwiftUI
import Alamofire
import Combine

class MessageManager: ObservableObject {
    static let shared = MessageManager()
    @State var userManager = UserManager.shared
    
    @Published var messageList: [Message] = []
    
    func fetchMessages() {
        let url = "http://34.22.94.135:8080/sting/\(userManager.userInfo.id)"
        
        let accessToken = userManager.userInfo.token
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        AF.request(url,
                   method: .get,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate(statusCode: 200..<600)
        .responseDecodable(of: [Message].self, decoder: JSONDecoder() ) { response in
            debugPrint(response)
            switch response.result {
            case .success:
                self.messageList = response.value!
            case .failure(let error):
                print(error)
            }
        }
    }
}
