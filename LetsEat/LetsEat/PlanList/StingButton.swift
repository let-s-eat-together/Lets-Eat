//
//  StingButton.swift
//  LetsEat

import SwiftUI
import Alamofire

struct StingButton: View {
    @State var userManager = UserManager.shared
    @State private var isSting: Bool = false
    
    var otherUserName: String
    var planId: Int
    
    var body: some View {
        Button {
            isSting.toggle()
        } label: {
            Image(systemName: "hand.point.left.fill")
                .foregroundColor(.primary)
        }
        .alert(isPresented: $isSting) { // 마지막 이름 나오는 버그 고치기
            Alert(title: Text("콕 찔러보기"),
                  message: Text("\(otherUserName)님을 콕 찌르시겠습니까?"),
                  primaryButton: Alert.Button.default(Text("네")) {
                sendMessage(to: otherUserName)
            },
            secondaryButton: Alert.Button.destructive(Text("아니요")))
        }
    }
    
    func sendMessage(to who: String) { // 실패시 에러처리
        let url = "http://34.22.94.135:8080/sting/"
        
        let accessToken = userManager.userInfo.token
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        AF.request(url,
                   method: .post,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate(statusCode: 200..<600)
        .responseDecodable(of: [Message].self, decoder: JSONDecoder() ) { response in
            debugPrint(response)
            switch response.result {
            case .success:
                print("send to \(who) 콕!")
            case .failure(let error):
                print(error)
            }
        }

    }
}

struct StingButton_Previews: PreviewProvider {
    static var previews: some View {
        StingButton(otherUserName: "default", planId: 1)
    }
}
