//
//  SessionManager.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/18.
//

import SwiftUI
import Alamofire

struct Test: Codable {
    let id: Int
    let connect: String
//    let name: String
//    let deviceId: String
//    let expirationDate: String
//    let senderId: String
}

struct SessionManager: View {
    @State var connect: String = "?"
//    @State var myId: String = "no id"
//    @State var name: String = "no Name"
//    @State var devicdId: String = "no device"

    
    var body: some View {
        VStack {
            Text(connect)
//            Text(myId)
//            Text(name)
//            Text(devicdId)
            
            Button {
//                let decoder : JSONDecoder = {
//                    let decoder = JSONDecoder()
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    return decoder
//                }()
//
//                AF.request("http://34.22.94.135:8080/test").response { response in
//                    debugPrint(response)
//                    connect = response.description
//                }
                
                AF.request("http://34.22.94.135:8000/test").responseDecodable(of: Test.self) { response in
                    connect = response.value?.connect ?? "fail"
                }
//                AF.request("http://34.22.94.135:8080/test")
//                    .responseDecodable(of: Test.self, decoder: decoder) { response in
//                        connect = response.value?.connect ?? "fail"
//                        connect = response.value?.connect ?? "fail"
//                        myId = String(response.value?.id ?? 0)
//                        name = response.value?.name ?? "fail"
//                        devicdId = response.value?.deviceId ?? "fail html"
//                        switch response.result {
//                        case .success(let user): break
//                        case .failure(let error): break
//                        }
//                    }
            } label: {
                Text("Request")
            }
            
            
        }
        .padding()
    }
}

struct SessionManager_Previews: PreviewProvider {
    static var previews: some View {
        SessionManager()
    }
}
