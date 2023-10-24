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
        let url = "http://34.22.94.135:8080/sting"
        
        let accessToken = userManager.userInfo.token
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate(statusCode: 200..<600)
        .responseDecodable(of: [Message].self, decoder: JSONDecoder() ) { response in
            debugPrint(response)
            switch response.result {
            case .success:
                if var messages = response.value {
                    
                    for index in 0..<messages.count {
                        let orgDate = messages[index].creationDate
                        let formattedDate = dateFormatter.date(from: orgDate)
                        messages[index].creationDate = formattedDate?.toString() ?? Date.now.description
                    }
                    self.messageList = messages
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
