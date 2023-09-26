//
//  ContentView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading: Bool = true
    @State var isLoginSuccess: Bool = false
    
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
        let isFailApiLogin: Bool = false // true면 닉네임 생성, false면 로그인 성공
        if isFailApiLogin { // (apiLogin(deviceId)) == -1
            return false
        } else {
            // user id 받음.. 로그인 성공이므로 ... 로그인 성공시 어떻게 해야되는지(저장된 데이터들을 가져옴?)
            return true
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
