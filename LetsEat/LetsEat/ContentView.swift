//
//  ContentView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI
import Alamofire

var user: User = User(id: -1, token: "", nickname: "")

struct ContentView: View {
    @State private var isLoading: Bool = true
    @State private var isLoginSuccess: Bool = false
    @State var token: String = ""
    @State var userId: Int = -1
//    let deviceId = KeychainManager().getDeviceID()
    let deviceId = "device_id2"
    @ObservedObject var appState = AppState()
    
    var body: some View {
        ZStack {
            VStack {
                PlanListView()
                    .id(appState.rootViewId)
                    .environmentObject(appState)
                    .scrollContentBackground(.hidden)
            }
            .zIndex(0)
            if isLoading {
                LaunchScreenView()
                    .transition(.opacity)
                    .zIndex(1)
            } else if !isLoginSuccess {
                GenerateNicknameView() {
                    isLoginSuccess = true
                }
                .zIndex(1)
            }
        }
        .onAppear {
            login(deviceId) { tk, uid in
                isLoginSuccess = false
                if uid == -1 {
                    print("sign up 진행")
                } else if uid == -2 {
                    print("login: data error")
                } else { // login success
                    print(tk)
                    print(uid)
                    user = User(id: uid, token: tk, nickname: "닉네임")
                    isLoginSuccess = true
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                withAnimation {
                    isLoading.toggle()
                }
            })
        }
    }
    
    private func login(_ deviceId: String, completion: @escaping (String, Int)->Void) {
        //디바이스 아이디로 로그인 요청
        //있으면 유저 아이디 받아옴 -> 로그인 성공
        //없으면 -1을 받음 -> 로그인 실패, 닉네임 생성(signUp)
        let url = "http://34.22.94.135:8080/login"
        let params: Parameters = ["device_id":deviceId]
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        let decoder : JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: header)
        .validate(statusCode: 200..<300)
//        .responseData { response in
//            switch response.result {
//            case .success:
//                print("성공")
//            case .failure:
//                print(response.error.debugDescription)
//            }
//        }
        .responseDecodable(of: Login.self, decoder: decoder) { response in
            token = response.value?.token ?? "fail"
            userId = response.value?.userId ?? -2
            completion(token, userId)
        }
    }
}

struct Login: Decodable {
    let token: String
    let userId: Int
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
