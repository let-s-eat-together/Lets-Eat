//
//  ContentView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State var isLoading: Bool = true
    @State var isLoginSuccess: Bool = false
    @State var userId: String = ""
    
    var body: some View {
//        NavigationStack {
            ZStack {
                VStack {
                    PlanListView()
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
                        let deviceId = UIDevice.current.identifierForVendor!.uuidString
                        if login(deviceId) {
                            // login success
                            isLoginSuccess = true
                        }
                        isLoading.toggle()
                    }
                })
            }
//        }
    }
    
    private func login(_ deviceId: String) -> Bool{
        //디바이스 아이디로 로그인 요청
        //있으면 유저 아이디 받아옴 -> 로그인 성공
        //없으면 -1을 받음 -> 로그인 실패, 닉네임 생성(signUp)
        var isSuccessLogin: Bool = false
        let url = "https://abcd" //추후 url 수정
        let params = ["device_id":deviceId] as Dictionary
        AF.request(url,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: [])
        .validate(statusCode: 200..<300)
        .responseDecodable(of: Login.self) { response in
            userId = response.value?.loginResult ?? "fail"
        }
        if userId != "fail" {
            isSuccessLogin = true
        }
        return isSuccessLogin
    }
}

struct Login: Decodable {
    let loginResult: String? // 실패시에 -1이라서 따로 처리해줘야함
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
