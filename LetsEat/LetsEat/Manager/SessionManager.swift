//
//  SessionManager.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/18.
//


// 받아올 데이터를 모델로 선언
// 뷰에서 AF.request().responseDecodable를 통해 데이터 획득
// trailing closure로 데이터 대입
import SwiftUI
import Alamofire

struct Test: Codable {
    let login: String
    let id: Int
    let htmlUrl: String
}

struct SessionManager: View {
    @State var name: String = "no Name"
    @State var myId: String = "no id"
    @State var htmlUrl: String = "no html"

    
    var body: some View {
        VStack {
            Text(name)
            Text(myId)
            Text(htmlUrl)
            
            Button {
                let decoder : JSONDecoder = {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    return decoder
                }()
                
                AF.request("http://34.22.94.135:8080/test").responseDecodable(of: Test.self, decoder: decoder) { response in
                    name = response.value?.login ?? "fail"
                    myId = String(response.value?.id ?? 0)
                    htmlUrl = response.value?.htmlUrl ?? "fail html"
                }
            } label: {
                Text("Request")
            }
        }
    }
}

struct SessionManager_Previews: PreviewProvider {
    static var previews: some View {
        SessionManager()
    }
}
