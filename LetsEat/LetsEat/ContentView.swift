//
//  ContentView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State private var isLoading: Bool = true
    @State private var isLoginSuccess: Bool = false
    @State private var userId: Int = -1
    private let deviceId = KeychainManager().getDeviceID()
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                withAnimation {
                    print(deviceId)
                    if login(deviceId) {
                        // login success
                        isLoginSuccess = true
                    }
                    isLoading.toggle()
                }
            })
        }
    }
    
    private func login(_ deviceId: String) -> Bool{
        //디바이스 아이디로 로그인 요청
        //있으면 유저 아이디 받아옴 -> 로그인 성공
        //없으면 -1을 받음 -> 로그인 실패, 닉네임 생성(signUp)
        let url = "http://34.22.94.135:8080/login" //추후 url 수정
        let params = ["device_id":deviceId] as Dictionary
        let decoder : JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        AF.request(url,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: [])
        .validate(statusCode: 200..<300)
        .responseDecodable(of: Login.self, decoder: decoder) { response in
            userId = response.value?.userId ?? -1
            print(response.value?.userId)
        }
        if userId != -1 {
            return true
        } else {
            return false
        }
    }
}

struct Login: Decodable {
    let token: String?
    let userId: Int?
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
